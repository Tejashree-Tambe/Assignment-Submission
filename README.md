# Assignment-Submission

An Assignment Submission System to help professors and students keep track of their assignments and their dues. It also scrapes the web to provide students with reference links to the topic on which the assignment is based.

<hr>

<h1>Prerequisites</h1>

Python (3.11+) <br>
Any IDE (Depends on preference. We used VSCode) <br>
MySQL (Server and Workbench)<br>

<hr>

<h1>Technology Installation</h1>

<b>Backend:</b><br>
1. Download Python (3.11+) executable file from <a href="https://www.python.org/downloads/">link</a>. On opening the .exe file, the installation process will be initiated and setup will be complete once you Click Run.<br>
2. Download MySQL Server .msi file from <a href="https://dev.mysql.com/downloads/installer/">link</a> and MySQL Workbench .msi file from <a href="https://dev.mysql.com/downloads/workbench/">link</a>. On opening the .msi file, the installation process will be initiated. Click next until setup is complete.<br>
3. Upon downloading the MySQL Server, go to start and type MySQL Installer - Community. Following .exe file will open. <br>
   a. Click on Add as highlighted.

![image](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/a8d21e34-975d-42bc-bd28-d5d4b51f14ed)

<br>
  b. Extend the MySQL Connectors menu, then extend the Connector/Python. Under that menu, extend Connector/Python 8.0 and select the first connector and then send it to the Products to be installed box by clicking the -> arrow key. Then click Next.
  
![image](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/a4ca685e-2bd3-47cf-befa-0d0b8a7691de)

<br>

  c. Click Next and Execute until installation is complete.

<b>Frontend:</b><br>
1. HTML<br>
2. CSS <br>
3. JavaScript <br>

<hr>

<h1>Libraries Used:</h1>
beautifulsoup4==4.12.2<br>
decorator==5.1.1<br>
Django==5.0<br>
Jinja2==3.1.2<br>
mysql-connector-python==8.2.0<br>
mysql-connector-python-rf==2.2.2<br>
mysqlclient==2.2.0<br>
requests==2.31.0<br>
sqlparse==0.4.<br>

<hr>

<h1>Getting started</h1>

<b>1. Following are the steps to run the application.</b>

Go to project/settings.py on line 78 and edit username, password to be that of your MySQL username and password. Update hostname and port if it's different.<br>
DATABASES = { <br>
    'default': { <br>
        'ENGINE': 'django.db.backends.mysql', <br>
        'NAME': 'assignment', <br>
        'USER': 'username', <br>
        'PASSWORD': 'password', <br>
        'HOST': 'localhost', <br>
        'PORT': '3306', <br>
    }
}
    
Install project dependencies:

    $ pip install -r requirements.txt

Create a Database:

    $ python mydb.py 
   
Move to the project directory:

   $ cd project

Apply the migrations:

    $ python manage.py makemigrations
    
    $ python manage.py migrate
    
Run the development server:

    $ python manage.py runserver

<b>2. Following are the steps to add professors to the portal.</b>

We will first create a superuser to access the admin portal.

    $ python manage.py createsuperuser
        enter username, emailid and password.

Now, go to http://127.0.0.1:8000/admin and enter the username and password of the superuser you just created.

On logging in, you will find the following page, select +Add on the Users Model, as highlighted in the picture.
![Web capture_12-12-2023_104834_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/297fc9cc-1486-407c-9549-b006edc03725)

Enter the username and password for your professor. Select Save and continue editing as shown in the picture below.
![Web capture_12-12-2023_104815_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/f06620f0-2b3b-496a-b1f4-077997428828)

Enter the email id of the professor and make sure the user is added as a staff by checking on the Staff Status box as shown in the picture. Go ahead and save the user.
![Web capture_12-12-2023_104740_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/fdc0e0eb-1ac1-48e7-8123-9f13863712b4)


<hr>

<h1>Database Usage</h1>
<b>1. Django Built-In User Model auth_user</b><br><br>
<b>2. Course Model</b><br>
Fields: <br>
prof = models.ForeignKey(User, on_delete=models.CASCADE, related_name="course_prof_id")<br> 
student = models.ManyToManyField(User, related_name="course_stud_id", blank=True, null=True)<br> 
name = models.CharField(max_length=255)<br> 
course_id = models.IntegerField()<br> 
semester = models.CharField(max_length=20, default="I") <br><br>    

<b>3. Assignment Model</b><br>
Fields: <br>
name = models.CharField(max_length=255)<br> 
assign_id = models.IntegerField()<br> 
grade = models.IntegerField(blank=True, null=True)<br> 
description = models.CharField(max_length=512)<br> 
feedback = models.CharField(max_length=512, blank=True, null=True)<br> 
file = models.FileField(blank=True, null=True)<br> 
date_of_submission = models.DateTimeField()<br> 
course_id = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="assign_course_id")<br> 
pending = models.BooleanField(blank=True, null=True)<br> 
finished = models.BooleanField(blank=True, null=True)<br> 
assign_prof = models.ForeignKey(User, on_delete=models.CASCADE, related_name="assignments_prof", default=1)<br> 
assign_student = models.ForeignKey(User, on_delete=models.CASCADE, related_name="assignments_stuf", blank=True, null=True)<br> 
description_file = models.FileField(blank=True, null=True)<br> 
submitted_on = models.DateTimeField(blank=True, null=True)<br> 
submission_status = models.CharField(max_length=100, blank=True)<br> 
<br>

<b>4. StudentRequest</b><br>
Fields: <br>
student = models.ForeignKey(User, on_delete=models.CASCADE, related_name="stud_request_id")<br> 
course = models.ForeignKey(Course, on_delete=models.CASCADE)<br> 
status = models.CharField(max_length=20, default='pending')<br> 
<br><br>

<!--<h1>Working:</h1>

![Web capture_9-12-2023_32656_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/0a52aa55-e7a5-4f63-b718-6840134592b6)
<b>1. Homepage</b><br>

![Web capture_9-12-2023_3279_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/c0fc8051-96e3-42bf-877b-b97575e610d7)
<b>2. Signup</b><br>
The professors are registered via the Django admin portal and later have the option to change/update their email and password. The only users that sign up are the Students.

![Web capture_9-12-2023_32722_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/3867e083-0c12-4ed1-aeae-74493fbbb527)
<b>3. Login</b>

![Web capture_9-12-2023_33234_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/e006ba10-d8ff-4960-b986-1c1971697233)
<b>4.a Dashboard for professor</b><br>
One can get success and error messages as shown above.

![Web capture_9-12-2023_33452_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/2cd5627e-fff7-4a2f-acdb-f9e40dc6fc63)
<b>4.a.a Dashboard for professor when editing profile details</b><br>

![Web capture_9-12-2023_3365_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/eb70d2bd-ebce-4981-8182-6305684c0fd7)
<b>4.b Add Course</b>


![Web capture_9-12-2023_33639_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/c88a524b-f08d-4cbe-ad8c-7aae43e48e0d)
<b>4.c Delete Courses</b>

![Web capture_9-12-2023_33847_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/19d46519-5e41-4e28-b50e-3eb47ac6d062)
<b>4.d Course Details</b>

![Web capture_9-12-2023_33924_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/fc6f15b4-3ef5-4474-8264-f5fc512b671b)
<b>4.d.a.a Add Students</b>

![Web capture_9-12-2023_32512_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/ff704dd5-ce7f-49cb-af1f-369ad99015b3)
<b>4.d.a.b Add Students when a student requests to be registered to a course</b>

![Web capture_9-12-2023_3220_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/3998b1cc-9e89-4f16-8eac-2bb2a21c2581)
<b>4.d.b Add Assignments</b>

![Web capture_9-12-2023_32237_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/8efa8033-9990-41e3-ac46-c4dc30ef507b)
<b>4.d.c View Assignments</b>

![Web capture_9-12-2023_34540_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/d0d23d09-7713-40d2-8c09-252dfefee1e0)
<b>4.d.d Remove Students</b>


![Web capture_9-12-2023_31911_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/291b7ad5-e644-4998-a12c-40fd60e97e8a)
<b>5.a Dashboard for students</b>

![Web capture_9-12-2023_31957_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/b0b5f22a-02ef-4839-897b-35566d8b77be)
<b>5.b View Courses</b>

![Web capture_9-12-2023_32015_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/69b57a30-524e-4780-8350-0b2edcbd458c)
<b>5.b.a Assignments based on the course chosen</b>

![Web capture_9-12-2023_32043_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/e3141ad9-894d-4cab-9805-afcf50ba5958)
<b>5.c Register for a Course</b>

![Web capture_9-12-2023_3215_127 0 0 1](https://github.com/Tejashree-Tambe/Assignment-Submission/assets/68728212/37e633d9-a4b0-4700-9943-1e1b8e2fa777)
<b>5.d Check Course Status</b>

--->
