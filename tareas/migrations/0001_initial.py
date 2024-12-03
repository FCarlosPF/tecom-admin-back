# Generated by Django 5.1.3 on 2024-12-02 15:53

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('recursos_humanos', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Tareas',
            fields=[
                ('tarea_id', models.AutoField(primary_key=True, serialize=False)),
                ('titulo', models.CharField(max_length=100)),
                ('descripcion', models.TextField(blank=True, null=True)),
                ('fecha_inicio', models.DateTimeField()),
                ('fecha_estimada_fin', models.DateTimeField(blank=True, null=True)),
                ('fecha_real_fin', models.DateTimeField(blank=True, null=True)),
                ('prioridad', models.CharField(blank=True, max_length=20, null=True)),
                ('estado', models.CharField(blank=True, max_length=20, null=True)),
            ],
            options={
                'db_table': 'tareas',
                'managed': True,
            },
        ),
        migrations.CreateModel(
            name='AsignacionesTareas',
            fields=[
                ('asignacion_id', models.AutoField(primary_key=True, serialize=False)),
                ('asignador', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='asignaciones_asignador', to='recursos_humanos.empleados')),
                ('empleado', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='asignaciones_empleado', to='recursos_humanos.empleados')),
                ('tarea', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='tareas.tareas')),
            ],
            options={
                'db_table': 'asignaciones_tareas',
                'managed': True,
            },
        ),
    ]
