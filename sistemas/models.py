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