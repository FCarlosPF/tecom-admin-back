# Generated by Django 5.1.3 on 2025-01-13 17:49

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Notificaciones',
            fields=[
                ('id_notificacion', models.AutoField(primary_key=True, serialize=False)),
                ('titulo', models.CharField(max_length=100)),
                ('descripcion', models.TextField()),
                ('fecha_creacion', models.DateTimeField(auto_now_add=True, null=True)),
                ('fecha_evento', models.DateTimeField()),
                ('tipo', models.CharField(blank=True, max_length=50, null=True)),
                ('estado', models.CharField(blank=True, default='Activa', max_length=20, null=True)),
                ('para', models.CharField(choices=[('Personalizado', 'Personalizado'), ('Área', 'Área'), ('Rol', 'Rol'), ('Empleado', 'Empleado'), ('Todos', 'Todos')], max_length=20)),
            ],
            options={
                'db_table': '"sistemas"."notificaciones"',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='NotificacionesDestinatarios',
            fields=[
                ('id_destinatario', models.AutoField(primary_key=True, serialize=False)),
            ],
            options={
                'db_table': '"sistemas"."notificaciones_destinatarios"',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='VistaNotificacionesEmpleados',
            fields=[
                ('id_empleado', models.IntegerField(primary_key=True, serialize=False)),
                ('nombre_empleado', models.CharField(max_length=255)),
                ('apellido_empleado', models.CharField(max_length=255)),
                ('id_notificacion', models.IntegerField()),
                ('titulo_notificacion', models.CharField(max_length=255)),
                ('descripcion_notificacion', models.TextField()),
                ('fecha_creacion', models.DateTimeField()),
                ('fecha_evento', models.DateTimeField()),
                ('tipo_notificacion', models.CharField(max_length=50)),
                ('estado_notificacion', models.CharField(max_length=20)),
            ],
            options={
                'db_table': '"sistemas"."vista_notificaciones_empleados"',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Asistencias',
            fields=[
                ('asistencia_id', models.AutoField(primary_key=True, serialize=False)),
                ('fecha', models.DateField()),
                ('hora_entrada', models.TimeField(blank=True, null=True)),
                ('hora_salida', models.TimeField(blank=True, null=True)),
                ('estado', models.CharField(blank=True, choices=[('P', 'Presente'), ('A', 'Ausente'), ('T', 'Tardanza'), ('F', 'Feriado')], max_length=1, null=True)),
                ('comentarios', models.TextField(blank=True, null=True)),
                ('empleado', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='asistencias', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': '"sistemas"."asistencias"',
                'managed': True,
                'unique_together': {('empleado', 'fecha')},
            },
        ),
    ]
