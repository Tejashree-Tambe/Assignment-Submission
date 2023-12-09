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
    path('edit_profile/', views.edit_profile, name='edit_profile'),
    path('delete_course/', views.delete_course, name='delete_course'),
    path('delete_student/<int:id>', views.delete_student, name='delete_student'),
    path('search_students/<int:id>', views.search_students, name='search_students'),
    
    path('register_for_course/<int:id>', views.register_for_course, name='register_for_course'),
    path('view_courses/', views.view_courses, name='view_courses'),
    path('dos_update/<int:id>', views.dos_update, name='dos_update'),
    path('course_status/', views.course_status, name='course_status'),
    
]
