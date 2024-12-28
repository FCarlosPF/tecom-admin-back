from django.db import models
from recursos_humanos.models import Empleados
from proyectos.models import Proyectos
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
    proyecto = models.ForeignKey(Proyectos, models.DO_NOTHING, blank=True, null=True, related_name='tareas')

    class Meta:
        managed = True
        db_table = '"tareas"."tareas"'
        
class AsignacionesTareas(models.Model):
    asignacion_id = models.AutoField(primary_key=True)
    tarea = models.ForeignKey('Tareas', models.DO_NOTHING, blank=True, null=True)
    empleado = models.ForeignKey(Empleados, models.DO_NOTHING, blank=True, null=True, related_name='asignaciones_empleado')
    asignador = models.ForeignKey(Empleados, models.DO_NOTHING, blank=True, null=True, related_name='asignaciones_asignador')

    class Meta:
        managed = True
        db_table = '"tareas"."asignaciones_tareas"'

class VistaEmpleadosTareas(models.Model):
    id_empleado = models.IntegerField(primary_key=True)
    nombre_empleado = models.CharField(max_length=255)
    apellido_empleado = models.CharField(max_length=255)
    tarea_id = models.IntegerField()
    titulo_tarea = models.CharField(max_length=255)
    descripcion_tarea = models.TextField()
    fecha_inicio = models.DateTimeField()
    fecha_estimada_fin = models.DateTimeField()
    fecha_real_fin = models.DateTimeField(blank=True, null=True)
    estado_tarea = models.CharField(max_length=50)

    class Meta:
        managed = False  # No permitir a Django gestionar esta tabla
        db_table = '"tareas"."vista_empleados_tareas"'

class ObservacionTarea(models.Model):
    observacion_id = models.AutoField(primary_key=True)  # Especificar la clave primaria
    tarea = models.ForeignKey('tareas.Tareas', on_delete=models.CASCADE, db_column='tarea_id', related_name="observaciones")
    empleado = models.ForeignKey('recursos_humanos.Empleados', on_delete=models.SET_NULL, null=True, db_column='empleado_id')
    fecha = models.DateTimeField(auto_now_add=True)
    observacion = models.TextField()

    class Meta:
        managed = False  # No permitir a Django gestionar esta tabla
        db_table = '"tareas"."observaciones_tareas"'