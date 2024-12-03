from django.db import models

# Create your models here.
class EvaluacionesDesempenio(models.Model):
    evaluacion_id = models.AutoField(primary_key=True)
    empleado_id = models.IntegerField(blank=True, null=True)
    fecha_evaluacion = models.DateField()
    comentarios = models.TextField(blank=True, null=True)
    puntuacion = models.DecimalField(max_digits=5, decimal_places=2)
    evaluador_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'evaluaciones_desempenio'