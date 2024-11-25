# Generated by Django 5.1.3 on 2024-11-25 14:28

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Tareas',
            fields=[
                ('tarea_id', models.AutoField(primary_key=True, serialize=False)),
                ('titulo', models.CharField(max_length=100)),
                ('descripcion', models.TextField(blank=True, null=True)),
                ('fecha_inicio', models.DateField()),
                ('fecha_estimada_fin', models.DateField(blank=True, null=True)),
                ('fecha_real_fin', models.DateField(blank=True, null=True)),
                ('prioridad', models.CharField(blank=True, max_length=20, null=True)),
                ('estado', models.CharField(blank=True, max_length=20, null=True)),
            ],
            options={
                'db_table': 'tareas',
            },
        ),
        migrations.CreateModel(
            name='AsignacionesTareas',
            fields=[
                ('asignacion_id', models.AutoField(primary_key=True, serialize=False)),
                ('empleado_id', models.IntegerField(blank=True, null=True)),
                ('asignador_id', models.IntegerField(blank=True, null=True)),
                ('tarea', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='tareas.tareas')),
            ],
            options={
                'db_table': 'asignaciones_tareas',
            },
        ),
    ]
