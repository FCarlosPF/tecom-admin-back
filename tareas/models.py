from django.db import models
from recursos_humanos.models import Empleados
# Create your models here.
class Tareas(models.Model):
    tarea_id = models.AutoField(primary_key=True)
    titulo = models.CharField(max_length=100)
    descripcion = models.TextField(blank=True, null=True)
    fecha_inicio = models.DateTimeField()  # Cambiado a DateTimeField
    fecha_estimada_fin = models.DateTimeField(blank=True, null=True)
    fecha_real_fin = models.DateTimeField(blank=True, null=True)
    prioridad = models.CharField(max_length=20, blank=True, null=True)
    estado = models.CharField(max_length=20, blank=True, null=True)
    tiempo_restante_paralizado = models.JSONField(blank=True, null=True)  # Nuevo campo para almacenar el tiempo restante paralizado
    tiempo_pasado_paralizado = models.JSONField(blank=True, null=True)    # Nuevo campo para almacenar el tiempo pasado paralizado
    complejidad = models.IntegerField(default=1)
    puntos = models.IntegerField(default=1)
    # Relación jerárquica para subtareas
    tarea_padre = models.ForeignKey(
        'self', 
        null=True, 
        blank=True, 
        on_delete=models.CASCADE, 
        related_name='subtareas',
        db_column='tarea_padre'  # Este será el nombre en la base de datos

    )

    class Meta:
        managed = True
        db_table = 'tareas'
        
class AsignacionesTareas(models.Model):
    asignacion_id = models.AutoField(primary_key=True)
    tarea = models.ForeignKey('Tareas', models.DO_NOTHING, blank=True, null=True)
    empleado = models.ForeignKey(Empleados, models.DO_NOTHING, blank=True, null=True, related_name='asignaciones_empleado')
    asignador = models.ForeignKey(Empleados, models.DO_NOTHING, blank=True, null=True, related_name='asignaciones_asignador')

    class Meta:
        managed = True
        db_table = 'asignaciones_tareas'