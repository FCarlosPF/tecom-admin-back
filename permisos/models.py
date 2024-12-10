from django.db import models

# Create your models here.
class SolicitudesPermiso(models.Model):
    permiso_id = models.AutoField(primary_key=True)
    empleado_id = models.IntegerField(blank=True, null=True)
    tipo_permiso = models.IntegerField()
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField()
    estado = models.CharField(max_length=20, blank=True, null=True)
    aprobado_por = models.IntegerField(blank=True, null=True)
    comentarios = models.TextField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'solicitudes_permiso'