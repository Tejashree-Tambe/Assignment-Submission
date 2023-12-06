from django.shortcuts import get_object_or_404, render, redirect
from django.contrib.auth import authenticate, logout
from django.contrib import messages
from .models import Assignment, Course
from django.contrib.auth.models import User, auth
from django.contrib.auth.models import Group
from django.contrib.auth import login as auth_login
from django.urls import reverse
import requests
from bs4 import BeautifulSoup
from django.contrib.auth.decorators import user_passes_test, login_required

def is_staff(user):
    return user.is_staff

def get_top_links(query, num_links=5):
    search_url = f'https://www.google.com/search?q={query}'
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    
    try:
        response = requests.get(search_url, headers=headers)
        response.raise_for_status()
    except requests.exceptions.HTTPError as errh:
        print(f"HTTP Error: {errh}")
        return []
    except requests.exceptions.ConnectionError as errc:
        print(f"Error Connecting: {errc}")
        return []
    except requests.exceptions.Timeout as errt:
        print(f"Timeout Error: {errt}")
        return []
    except requests.exceptions.RequestException as err:
        print(f"Something went wrong: {err}")
        return []

    soup = BeautifulSoup(response.text, 'html.parser')
    links = []

    for i, result in enumerate(soup.select('a'), start=1):
        link = result.get('href')
        if link and link.startswith('http'):
            links.append(link)
            print(f"Link {i}: {link}")
            if i == num_links:
                break

    return links

def home(request):
	current_user = request.user

	if current_user.is_authenticated:
		return redirect('dashboard')

	return render(request, "index.html")
	

def login(request):

	if request.method == 'POST':
		email = request.POST['email']
		password = request.POST['password']

		user = authenticate(username=email, password=password)
		if user is not None:
			auth_login(request, user)
			return redirect('dashboard')
			
		else:
			print(request, "Invalid Credentials")
			return redirect('login')
		
		
	return render(request, 'login.html')


def logout(request):
	auth.logout(request)
	return redirect('/')


def signup(request):
	students = User.objects.filter(is_staff=False)
	courses = Course.objects.all()

	if request.method == 'POST':
		name = request.POST['name']
		email = request.POST['email']
		password1 = request.POST['password1']
		password2 = request.POST['password2']
		id_num = request.POST['id_num']
		usertype = request.POST['usertype']
		# department= request.POST['department']

		if password1 == password2:
			if User.objects.filter(email=email).exists():
				print(request, 'Email id already exists')
				return redirect('signup')

			else:
				is_staff = 0
				if usertype == "professor":
					is_staff = 1

				user = User.objects.create_user(username=name, email=email, password=password1, id=id_num, is_staff=is_staff)
				user.save()
				
			return redirect('dashboard')

		else:
			print("not matching passwords")
			return redirect('signup')

	else:
		return render(request, 'signup.html')

	
@login_required
def dashboard(request):
	students = User.objects.filter(is_staff=False)
	current_user = request.user
	role = ""

	if current_user.is_staff:
		courses = Course.objects.filter(prof=current_user)
		course_count = Course.objects.filter(prof=current_user).count()
		role = "Professor"
	
	else:
		courses = Course.objects.filter(student=current_user)
		course_count = Course.objects.filter(student=current_user).count
		role = "Student"


	return render(request, 'dashboard.html', {"students":students, "courses": courses, "course_count": course_count, "role": role})


@login_required
@user_passes_test(is_staff)
def add_courses(request):
	if request.method == 'POST':
		students = User.objects.filter(is_staff=False)

		name = request.POST['name']
		course_id = request.POST['id']

		if Course.objects.filter(course_id=course_id).exists():
			print(request, 'Course already exists')
			return redirect('add_courses')
		else:
			current_user = request.user
			course = Course.objects.create(prof=current_user, course_id=course_id, name=name)
			course.save()

			return redirect('dashboard')

	return render(request, 'add_courses.html')

@login_required
def course_details(request, id):
	course_id = id
	course = Course.objects.get(course_id=id)
	course_name = course.name

	return render(request, 'course_details.html', {"course_id": course_id, "course_name": course_name})


@login_required
@user_passes_test(is_staff)
def add_students(request, id):
    course_id = id
    students = User.objects.filter(is_staff=False)
    course = Course.objects.get(course_id=id)
    course_name = course.name

    if request.method == 'POST':
        print("student id recieved")
        student_id = request.POST['user']
        student = User.objects.get(id=student_id)

		# Check if the student is already in the course
        if student in course.student.all():
            print(request, f"{student.username} is already in the course.")
        else:
            course.student.add(student)
            print(request, f"{student.username} added successfully to the course.")

        
        redirect_url = reverse('add_students', args=[course_id])
        return redirect(redirect_url)  

    return render(request, 'add_students.html', {"students": students, "course_id": course_id, "course_name": course_name})

@login_required
@user_passes_test(is_staff)
def assignment_add(request, id):
	course_id = id
	students = []
	courses = Course.objects.all()
	# for course in courses:
	# 	if course.course_id == id:
	# 		students.append(course.student)

	course = get_object_or_404(Course, course_id=course_id)
	students = course.student.all()
		
	if request.method == 'POST':
		name = request.POST['name']
		assign_id = request.POST['assign_id']
		desc = request.POST['desc']
		dos = request.POST['dos']
		assign_prof = request.user
		course = Course.objects.get(course_id=course_id)
		if Assignment.objects.filter(assign_id=assign_id).exists():
			print(request, 'Assignment already exists')
			return redirect('course_details', id)  
		
		else:
			for student in students:
				Assignment.objects.create(name=name, assign_id=assign_id, description=desc, date_of_submission=dos,course_id=course, assign_prof=assign_prof, assign_student=student)
			
			return redirect('dashboard')
		
	return render(request, 'add_assignments.html', {"course_id": course_id})


@login_required
def view_assign(request, id):
    course_id = id
    course = Course.objects.get(course_id=id)

    assignments = Assignment.objects.filter(course_id=course)
    if request.user.is_staff:
        assignments = Assignment.objects.filter(course_id=course, assign_prof=request.user)
    else:
        assignments = Assignment.objects.filter(course_id=course, assign_student=request.user)

    assignment_links = []
    for assignment in assignments:
        description = assignment.name
        links = get_top_links(description, num_links=5)
        assignment_links.append((assignment, links))
  
    return render(request, 'view_assignments.html', {"assignments": assignments, "course_id": course_id, "assignment_links": assignment_links,})


@login_required
@user_passes_test(is_staff)
def update_grades(request, id):
	course_id = id
	if request.method == "POST":
		grade = request.POST['grade']
		feedback = request.POST['feedback']
		assign_id = request.POST['assign_id']
		assignment = Assignment.objects.filter(assign_id=assign_id).first()
		if assignment:
			assignment.grade = grade
			assignment.feedback = feedback
			assignment.save()
		return redirect("dashboard")


@login_required
def upload_file(request):
	print("hi")
	if request.method == 'POST' and request.FILES['file']:
		uploaded_file = request.FILES['file']
		assign_id = request.POST['assign_id']
		assignment = Assignment.objects.filter(assign_id=assign_id).first()
		if assignment:
			print("assignment gotten")
			assignment.file = uploaded_file
			assignment.save()
			print("saved")
			return redirect('dashboard')  
		
	return render(request, 'upload_file.html')