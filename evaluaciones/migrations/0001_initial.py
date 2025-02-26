# Generated by Django 5.1.3 on 2025-01-13 17:49

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='EvaluacionesDesempenio',
            fields=[
                ('evaluacion_id', models.AutoField(primary_key=True, serialize=False)),
                ('empleado_id', models.IntegerField(blank=True, null=True)),
                ('fecha_evaluacion', models.DateField()),
                ('comentarios', models.TextField(blank=True, null=True)),
                ('puntuacion', models.DecimalField(decimal_places=2, max_digits=5)),
                ('evaluador_id', models.IntegerField(blank=True, null=True)),
            ],
            options={
                'db_table': 'evaluaciones_desempenio',
                'managed': True,
            },
        ),
    ]
