# Generated by Django 5.1.3 on 2024-11-24 06:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('recursos_humanos', '0003_empleados_area_empleados_rol_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='empleados',
            name='contrasenia',
            field=models.TextField(default='pbkdf2_sha256$870000$xed7qsRjbafpEnF9fWNlHd$HueCbVnQUkaFGxbzviqPOzguWkO1YUnytNvRRA+rDG8='),
        ),
    ]
