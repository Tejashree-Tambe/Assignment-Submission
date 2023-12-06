from django.urls import path
from . import views


urlpatterns = [
    path('', views.home, name='home'),
    path('home/', views.home, name='home'),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('signup/', views.signup, name='signup'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('add_courses/', views.add_courses, name='add_courses'),
    path('course_details/<int:id>', views.course_details, name='course_details'),
    path('add_students/<int:id>', views.add_students, name='add_students'),
    path('assignment_add/<int:id>', views.assignment_add, name='assignment_add'),
    path('view_assign/<int:id>', views.view_assign, name='view_assign'),
    path('update_grades/<int:id>', views.update_grades, name='update_grades'),
    path('upload_file/', views.upload_file, name='upload_file'),

]
