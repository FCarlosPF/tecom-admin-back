from django.db import models
from rest_framework_simplejwt.tokens import RefreshToken

class Areas(models.Model):
    area_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    supervisor = models.ForeignKey('Empleados', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        db_table = 'areas'

class Roles(models.Model):
    id_rol = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    describcion = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        db_table = 'roles'

class Empleados(models.Model):
    id_empleado = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    apellidos = models.CharField(max_length=100)
    correo = models.CharField(unique=True, max_length=100)
    especialidad = models.CharField(max_length=50, blank=True, null=True)
    sueldo = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    activo = models.BooleanField(blank=True, null=True)
    foto = models.CharField(max_length=100, blank=True, null=True)
    nombre_usuario = models.CharField(max_length=100)
    contrasenia = models.TextField()
    fecha_contratacion = models.DateField()
    area = models.ForeignKey(Areas, models.DO_NOTHING, blank=True, null=True)
    rol = models.ForeignKey(Roles, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        db_table = 'empleados'
    
    def get_tokens(self):
        """
        Generar tokens JWT personalizados usando id_empleado.
        """
        refresh = RefreshToken()
        refresh['id_empleado'] = self.id_empleado
        refresh['nombre_usuario'] = self.nombre_usuario

        return {
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        }