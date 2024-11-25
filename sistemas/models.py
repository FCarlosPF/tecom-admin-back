from django.db import models

# Create your models here.
class Asistencias(models.Model):
    asistencia_id = models.AutoField(primary_key=True)
    empleado_id = models.IntegerField(blank=True, null=True)
    fecha = models.DateField()
    hora_entrada = models.TimeField(blank=True, null=True)
    hora_salida = models.TimeField(blank=True, null=True)
    estado = models.CharField(max_length=20, blank=True, null=True)
    comentarios = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'asistencias'