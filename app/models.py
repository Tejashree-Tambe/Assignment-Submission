from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

class Course(models.Model):
    prof = models.ForeignKey(User, on_delete=models.CASCADE, related_name="prof_id")
    student = models.ManyToManyField(User, related_name="stud_id", blank=True, null=True)
    name = models.CharField(max_length=255)
    course_id = models.IntegerField()

class Assignment(models.Model):
	name = models.CharField(max_length=255)
	assign_id = models.IntegerField()
	grade = models.IntegerField(blank=True, null=True)
	description = models.CharField(max_length=512)
	feedback = models.CharField(max_length=512, blank=True, null=True)
	file = models.FileField(blank=True, null=True)
	date_of_submission = models.DateTimeField()
	course_id = models.ForeignKey(Course, on_delete=models.CASCADE)
	pending = models.BooleanField(blank=True, null=True)
	finished = models.BooleanField(blank=True, null=True)
	assign_prof = models.ForeignKey(User, on_delete=models.CASCADE, related_name="assign_prof_id", default=1)
	assign_student = models.ForeignKey(User, on_delete=models.CASCADE, related_name="assign_stud_id", blank=True, null=True)


@receiver(post_save, sender=Assignment)
def update_assignment_status(sender, instance, **kwargs):
    if instance.file:
        instance.pending = False
        instance.save()

    if not instance.pending and instance.grade is not None and instance.feedback:
        instance.finished = True
        instance.save()

	


