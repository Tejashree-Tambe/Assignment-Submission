# Generated by Django 5.0 on 2023-12-08 10:51

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='assignment',
            name='assign_prof',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, related_name='assignments_prof', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='assignment',
            name='assign_student',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='assignments_stuf', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='assignment',
            name='description_file',
            field=models.FileField(blank=True, null=True, upload_to=''),
        ),
        migrations.AddField(
            model_name='assignment',
            name='submission_status',
            field=models.CharField(blank=True, max_length=100),
        ),
        migrations.AddField(
            model_name='assignment',
            name='submitted_on',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='course',
            name='semester',
            field=models.CharField(default='I', max_length=20),
        ),
        migrations.AlterField(
            model_name='assignment',
            name='feedback',
            field=models.CharField(blank=True, max_length=512, null=True),
        ),
        migrations.AlterField(
            model_name='assignment',
            name='file',
            field=models.FileField(blank=True, null=True, upload_to=''),
        ),
        migrations.AlterField(
            model_name='assignment',
            name='finished',
            field=models.BooleanField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='assignment',
            name='grade',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='assignment',
            name='pending',
            field=models.BooleanField(blank=True, null=True),
        ),
        migrations.RemoveField(
            model_name='course',
            name='student',
        ),
        migrations.CreateModel(
            name='StudentRequest',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('status', models.CharField(default='pending', max_length=20)),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.course')),
                ('student', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='stud_request_id', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.AddField(
            model_name='course',
            name='student',
            field=models.ManyToManyField(blank=True, null=True, related_name='course_stud_id', to=settings.AUTH_USER_MODEL),
        ),
    ]
