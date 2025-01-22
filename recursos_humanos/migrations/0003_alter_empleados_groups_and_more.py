# Generated by Django 5.1.3 on 2025-01-13 22:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
        ('recursos_humanos', '0002_tokenblacklistoutstandingtoken'),
    ]

    operations = [
        migrations.AlterField(
            model_name='empleados',
            name='groups',
            field=models.ManyToManyField(blank=True, related_name='empleados_set', related_query_name='empleado', to='auth.group'),
        ),
        migrations.AlterField(
            model_name='empleados',
            name='user_permissions',
            field=models.ManyToManyField(blank=True, related_name='empleados_set', related_query_name='empleado', to='auth.permission'),
        ),
    ]
