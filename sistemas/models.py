from django.db import models
from recursos_humanos.models import Empleados

class Asistencias(models.Model):
    EMPLEADO_ESTADOS = [
        ('P', 'Presente'),
        ('A', 'Ausente'),
        ('T', 'Tardanza'),
        ('F', 'Feriado'),
    ]
    
    asistencia_id = models.AutoField(primary_key=True)
    empleado = models.ForeignKey(Empleados, related_name='asistencias', on_delete=models.DO_NOTHING, blank=True, null=True)
    fecha = models.DateField()
    hora_entrada = models.TimeField(blank=True, null=True)
    hora_salida = models.TimeField(blank=True, null=True)
    estado = models.CharField(max_length=1, choices=EMPLEADO_ESTADOS, blank=True, null=True)
    comentarios = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"Asistencia de {self.empleado} el {self.fecha}"

    class Meta:
        managed = True
        db_table = 'asistencias'
        unique_together = ('empleado', 'fecha')  # Un empleado solo puede tener un registro por día


class Notificaciones(models.Model):
    notificacion_id = models.AutoField(primary_key=True)
    empleado = models.ForeignKey(Empleados, related_name='notificaciones', on_delete=models.DO_NOTHING, blank=True, null=True)
    tipo_notificacion = models.CharField(max_length=50)
    mensaje = models.TextField()
    fecha_notificacion = models.DateField()
    hora_inicio = models.TimeField(blank=True, null=True)
    hora_fin = models.TimeField(blank=True, null=True)
    creada_en = models.DateTimeField(blank=True, null=True)
    leida = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'notificaciones'