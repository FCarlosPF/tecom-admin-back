from django.db import models

# Create your models here.
class Tareas(models.Model):
    tarea_id = models.AutoField(primary_key=True)
    titulo = models.CharField(max_length=100)
    descripcion = models.TextField(blank=True, null=True)
    fecha_inicio = models.DateField()
    fecha_estimada_fin = models.DateField(blank=True, null=True)
    fecha_real_fin = models.DateField(blank=True, null=True)
    prioridad = models.CharField(max_length=20, blank=True, null=True)
    estado = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tareas'
        
class AsignacionesTareas(models.Model):
    asignacion_id = models.AutoField(primary_key=True)
    tarea = models.ForeignKey('Tareas', models.DO_NOTHING, blank=True, null=True)
    empleado_id = models.IntegerField(blank=True, null=True)
    asignador_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'asignaciones_tareas'