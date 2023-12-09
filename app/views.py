from datetime import datetime, timezone
from django.shortcuts import get_object_or_404, render, redirect
from django.contrib.auth import authenticate, logout
from django.contrib import messages
from .models import Assignment, Course, StudentRequest
from django.contrib.auth.models import User, auth
from django.contrib.auth import login as auth_login
from django.urls import reverse
import requests
from bs4 import BeautifulSoup
from django.contrib.auth.decorators import user_passes_test, login_required
from django.db import transaction
from django.db.models import Q



def is_staff(user):
    return user.is_staff

def is_student(user):
    if not user.is_staff:
        return True


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
			messages.success(request, 'Login Succesful.')
			return redirect('dashboard')
			
		else:
			print(request, "")
			messages.error(request, 'Invalid Credentials, Try Again!')
			return redirect('login')
		
		
	return render(request, 'login.html')


def logout(request):
	auth.logout(request)
	messages.success(request, 'User Logout Succesful.')
	return redirect('/')


def signup(request):
	if request.method == 'POST':
		name = request.POST['name']
		email = request.POST['email']
		password1 = request.POST['password1']
		password2 = request.POST['password2']
		id_num = request.POST['id_num']

		if password1 == password2:
			if User.objects.filter(email=email).exists():
				messages.error(request, 'Email id Already Exists.')
				return redirect('signup')

			else:
				is_staff = 0
				user = User.objects.create_user(username=name, email=email, password=password1, id=id_num, is_staff=is_staff)
				messages.success(request, 'User Registered.')
				user.save()
    
			user = authenticate(request, username=name, password=password1)
			if user is not None:
				auth_login(request, user)
				messages.success(request, 'Login Successful.')
				return redirect('home') 
			else:
				messages.error(request, 'Invalid Credentials, Try again!')
				return redirect("signup")

		else:
			messages.error(request, 'Not Matching Passwords.')
			return redirect("signup")
	
	return render(request, 'signup.html')

	
def dashboard(request):
	students = User.objects.filter(is_staff=False)
	current_user = request.user
	role = ""

	if current_user.is_staff:
		courses = Course.objects.filter(prof=current_user).order_by('course_id')
		course_count = Course.objects.filter(prof=current_user).count()
		role = "Professor"
	
	else:
		courses = Course.objects.filter(student=current_user).order_by('course_id')
		course_count = Course.objects.filter(student=current_user).count()
		role = "Student"


	return render(request, 'dashboard.html', {"students":students, "courses": courses, "course_count": course_count, "role": role})


@login_required
@user_passes_test(is_staff)
def add_courses(request):
	if request.method == 'POST':
		students = User.objects.filter(is_staff=False)

		name = request.POST['name']
		course_id = request.POST['id']
		semester = request.POST['semester']

		if Course.objects.filter(course_id=course_id).exists():
			messages.error(request, 'Course Already Exists.')
			return redirect('add_courses')
		else:
			current_user = request.user
			course = Course.objects.create(prof=current_user, course_id=course_id, name=name, semester=semester)
			course.save()

			messages.success(request, f'Course {name} Added Succesfully!.')
			return redirect('dashboard')

	return render(request, 'add_courses.html')


@login_required
def edit_profile(request):
	if request.method == 'POST':
		current_user = request.user
		new_email = request.POST['new_email']
		new_password = request.POST['new_password']

		user = User.objects.get(id=current_user.id)
		if new_email != "":
			user.email = new_email
			messages.success(request, 'Email Updated Successfully.')

		if new_password:
			user.set_password(new_password)
			messages.success(request, 'Password Updated Successfully.')
		
		user.save()
		
		if new_password:
			user1 = authenticate(request, username=current_user.username, password=new_password)
			auth_login(request, user1)
			messages.success(request, 'Login Successful.')

	return redirect('dashboard')


@login_required
@user_passes_test(is_staff)
def delete_course(request):
	courses = Course.objects.filter(prof=request.user)

	if request.method == 'POST':
		course_id = request.POST['course']
		print("course id recieved")
		course = Course.objects.get(id=course_id)
		course_name = course.name

		course.delete()
		messages.success(request, f'Course {course_name} Deleted Successfully.')
		return redirect('dashboard') 

	return render(request, 'delete_course.html', {"courses": courses})


@login_required
def course_details(request, id):
	course_id = id
	course = Course.objects.get(course_id=id)
	course_name = course.name
	course_semester = course.semester

	return render(request, 'course_details.html', {"course_id": course_id, "course_name": course_name, "course_semester":course_semester})


@login_required
@user_passes_test(is_staff)
def add_students(request, id):
    course_id = id
    course = get_object_or_404(Course, course_id=id)
    students = User.objects.filter(is_staff=False)
    course_name = course.name
    
    requested_students = StudentRequest.objects.filter(course=course, status='pending').values('student')
    requested_users = User.objects.filter(id__in=[student['student'] for student in requested_students])
    total_requests = requested_users.count()

    students_not_in_course = []

    for student in students:
        if student not in course.student.all() and student not in requested_users:
            students_not_in_course.append(student)
    
    assignments = Assignment.objects.filter(course_id=course)

    if request.method == 'POST':
        print("student id recieved")
        student_id = request.POST['user']
        
        student = User.objects.get(id=student_id)
        if student in requested_users:
            with transaction.atomic():
                StudentRequest.objects.filter(student=student, course=course).update(status='approved')
                course.student.add(student)
            messages.success(request, f'{student.username} Added Successfully to {course_name}.')
        
        else:
            course.student.add(student)
            for assignment in assignments:
                    Assignment.objects.create(
                        name=assignment.name,
                        assign_id=assignment.assign_id,
                        description=assignment.description,
                        date_of_submission=assignment.date_of_submission,
                        course_id=course,
                        assign_prof=assignment.assign_prof,
                        assign_student=student,
                        description_file=assignment.description_file
                    )
            messages.success(request, f'{student.username} Added Successfully to {course_name}.')
            
        redirect_url = reverse('add_students', args=[course_id])
        return redirect(redirect_url) 
     
    return render(request, 'add_students.html', {"students": students_not_in_course, "course_id": course_id, "course_name": course_name, "requested_students": requested_users, "total_requests": total_requests})


@login_required
@user_passes_test(is_staff)
def assignment_add(request, id):
	course_id = id
	students = []
	course = get_object_or_404(Course, course_id=course_id)
	course_name = course.name

	students = course.student.all()
		
	if request.method == 'POST':
		name = request.POST['name']
		assign_id = request.POST['assign_id']
		desc = request.POST['desc']
		dos = request.POST['dos']
		assign_prof = request.user
		description_file = request.FILES.get('description_file', None)

		course = Course.objects.get(course_id=course_id)
		if Assignment.objects.filter(assign_id=assign_id).exists():
			print(request, 'Assignment already exists')
			messages.error(request, f'Assignment No: {assign_id} Already Exists.')
			return redirect('course_details', id)  
		
		else:
			for student in students:
				Assignment.objects.create(name=name, assign_id=assign_id, description=desc, date_of_submission=dos,course_id=course, assign_prof=assign_prof, assign_student=student, description_file=description_file)
			
			messages.success(request, f'Assignment No: {assign_id} Added Successfully.')
			redirect_url = reverse('course_details', args=[course_id])
			return redirect(redirect_url)  
		
	return render(request, 'add_assignments.html', {"course_id": course_id, "course_name": course_name})


@login_required
def view_assign(request, id):
    course_id = id
    course = Course.objects.get(course_id=id)
    course_name = course.name

    assignments = Assignment.objects.filter(course_id=course)
    if request.user.is_staff:
        assignments = Assignment.objects.filter(course_id=course, assign_prof=request.user).order_by("date_of_submission")
    else:
        assignments = Assignment.objects.filter(course_id=course, assign_student=request.user).order_by("date_of_submission")

    assignment_links = []
    for assignment in assignments:
        description = assignment.name
        links = get_top_links(description, num_links=5)
        assignment_links.append((assignment, links))
  
    return render(request, 'view_assignments.html', {"assignments": assignments, "course_id": course_id, "assignment_links": assignment_links, "course_name": course_name})



@login_required
@user_passes_test(is_staff)
def update_grades(request, id):
	course_id = id
	course = Course.objects.get(course_id=course_id)
	if request.method == "POST":
		grade = request.POST['grade']
		feedback = request.POST['feedback']
		assign_id = request.POST['assign_id']
		student_id = request.POST['student_id']
		student = User.objects.get(id=student_id)
		print(student)
		assignment = Assignment.objects.filter(assign_student=student,assign_id=assign_id, course_id=course).first()
  
		if assignment:
			assignment.finished = True
			assignment.grade = grade
			assignment.feedback = feedback
			assignment.save()
			messages.success(request, f'Grades Updated Successfully.')
		return redirect("dashboard")



@login_required
def upload_file(request):
	current_user = request.user
	if request.method == 'POST' and request.FILES['file']:
		uploaded_file = request.FILES['file']
		assign_id = request.POST['assign_id']
  
		if uploaded_file:
			submitted_on = datetime.now(timezone.utc)
		assignment = Assignment.objects.filter(assign_id=assign_id, assign_student=current_user).first()
		
		if assignment:
			print("assignment gotten")
			assignment.file = uploaded_file
			assignment.pending = False
			assignment.submitted_on = submitted_on
   
			if submitted_on <= assignment.date_of_submission:
				assignment.submission_status = "On Time"
			else:
				messages.error(request, f'Assignment Will Be Graded as Late.')
				assignment.submission_status= "Late"
    
			assignment.save()
			messages.success(request, f'Assignment File Uploaded Successfully.')
			return redirect('dashboard')  
		
	return render(request, 'upload_file.html')


@login_required
@user_passes_test(is_staff)
def delete_student(request, id):
    course = get_object_or_404(Course, course_id=id)
    students = User.objects.filter(is_staff=False)
    course_name = course.name
    course_id = id
    
    students_in_course = []
    for student in students:
        if student in course.student.all():
            students_in_course.append(student)
    
    
    if request.method == 'POST':
        student_id = request.POST['student_id']
        student_name = User.objects.get(id=student_id).username
        course = Course.objects.get(course_id=course_id)
        assignments_to_remove = Assignment.objects.filter(course_id=course, assign_student=student_id)

        with transaction.atomic():
            assignments_to_remove.delete()
            course.student.remove(student_id)
            
        messages.success(request, f'{student_name} Removed Successfully.')
        StudentRequest.objects.filter(student_id=student_id, course=course).delete()
        
        redirect_url = reverse('course_details', args=[id])
        return redirect(redirect_url) 
        
    
    return render(request, 'delete_student.html', {"students": students_in_course, "course_name": course_name, "course_id": course_id})


@login_required
@user_passes_test(is_staff)
def search_students(request, id):
    if 'search_id' in request.GET:
        search_id = request.GET['search_id']
        students = User.objects.filter(is_staff=False, id=search_id).first()
    else:
        students = User.objects.filter(is_staff=False)
        
    course = Course.objects.get(course_id=id)
    course_name = course.name
    
    additional_context = {"student": students, "course_id": id, "course_name": course_name}
    return render(request, "searched_students.html", additional_context)
    

@login_required
@user_passes_test(is_student)
def register_for_course(request, id):
    student = get_object_or_404(User, id=id)

    existing_courses = Course.objects.exclude(Q(student=student) | Q(studentrequest__student=student, studentrequest__status='pending'))

    if request.method == 'POST':
        selected_course_id = request.POST['selected_course']
        print(selected_course_id)
        selected_course = get_object_or_404(Course, course_id=selected_course_id)

        if StudentRequest.objects.filter(student=student, course=selected_course).exists():
            messages.warning(request, 'You have already requested to join this course.')
            print("registered already")
        else:
            print("HI")
            student_request = StudentRequest.objects.create(student=student, course=selected_course, status='pending')
            # student_request.course.set([selected_course])
            print("Hello")
            student_request.save()
            print("registered for course")

            messages.success(request, 'Registration request for course submitted successfully.\n Check Courses Status to see if they are approved.')

        return redirect('dashboard')
    return render(request, "register_course.html", {"existing_courses": existing_courses})
    

@login_required
def view_courses(request):
    current_user = request.user
    courses = Course.objects.filter(student=current_user).order_by('course_id')
    course_count = Course.objects.filter(student=current_user).count()
    role = "Student"
    
    return render(request, 'courses.html', {"courses": courses, "course_count": course_count, "role": role})
    
    
@login_required
@user_passes_test(is_staff)
def dos_update(request, id):
    if request.method=="POST":
        new_dos = request.POST['new_dos']
        assign_id = request.POST['assign_id']
        
        assignment = Assignment.objects.filter(assign_id=assign_id)
        if assignment.submitted_on <= new_dos:
            assignment.submission_status = "On Time"
        else:
            messages.error(request, f'Assignment Will Be Graded as Late.')
            assignment.submission_status= "Late"

        Assignment.objects.filter(assign_id=assign_id).update(date_of_submission=new_dos)
        messages.success(request, f'Assignment No {assign_id} Updated Successfully.')

        redirect_url = reverse('view_assign', args=[id])
        return redirect(redirect_url)
 
	
@login_required
@user_passes_test(is_student)
def course_status(request):
    current_user = request.user
    courses = Course.objects.filter(student=current_user)

    course_assignments = []

    for course in courses:
        assignments = Assignment.objects.filter(course_id=course, assign_student=current_user)
        requested_by_user = StudentRequest.objects.filter(course=course, student=current_user, status='pending').exists()

        course_assignments.append({
            'course': course,
            'assignments': assignments,
            'requested_by_user': requested_by_user,
        })

    return render(request, 'course_status.html', {"course_assignments": course_assignments}) 