from django.db import models
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.gis.db import models
from django.contrib.postgres.fields import ArrayField
from django.contrib.auth.hashers import make_password, check_password
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin, Group, Permission

class Areas(models.Model):

    area_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    supervisor = models.ForeignKey('Empleados', models.DO_NOTHING, blank=True, null=True)
    geom = models.GeometryField(blank=True, null=True)

    class Meta:
        db_table = '"recursos_humanos"."areas"'
        managed = True

class Roles(models.Model):
    id_rol = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    describcion = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        db_table = '"recursos_humanos"."roles"'
        managed = True

class EmpleadoManager(BaseUserManager):
    def create_user(self, username, password=None, **extra_fields):
        if not username:
            raise ValueError('El campo username es obligatorio')
        user = self.model(username=username, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(username, password, **extra_fields)

class Empleados(AbstractBaseUser, PermissionsMixin):
    id_empleado = models.AutoField(primary_key=True)
    username = models.CharField(max_length=150, unique=True)
    first_name = models.CharField(max_length=150, default="")
    last_name = models.CharField(max_length=150, default="")
    email = models.EmailField(max_length=254, unique=True, default="")
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    date_joined = models.DateTimeField(auto_now_add=True)

    especialidad = models.CharField(max_length=50, blank=True, null=True)
    sueldo = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    foto = models.CharField(max_length=100, blank=True, null=True)
    fecha_contratacion = models.DateField(blank=True, null=True)
    area = models.ForeignKey(Areas, models.DO_NOTHING, blank=True, null=True)
    rol = models.ForeignKey(Roles, models.DO_NOTHING, blank=True, null=True)
    geom = models.GeometryField(blank=True, null=True)

    groups = models.ManyToManyField(
        Group,
        related_name='empleados_set',
        related_query_name='empleado',
        blank=True,
    )

    user_permissions = models.ManyToManyField(
        Permission,
        related_name='empleados_set',
        related_query_name='empleado',
        blank=True,
    )

    objects = EmpleadoManager()

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email']


    def __str__(self):
        return self.username
    
    class Meta:
        db_table = '"recursos_humanos"."empleados"'
        managed = True

class TokenBlacklistOutstandingtoken(models.Model):
    id = models.BigAutoField(primary_key=True)
    jti = models.CharField(unique=True, max_length=255)
    token = models.TextField()
    created_at = models.DateTimeField(blank=True, null=True)
    expires_at = models.DateTimeField()
    user = models.ForeignKey(Empleados, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = '"recursos_humanos"."token_blacklist_outstandingtoken"'

    
class Oficina(models.Model):
    nombre = models.CharField(max_length=50, blank=True, null=True)
    geom = models.GeometryField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = '"recursos_humanos"."oficina"'

class VistaEmpleadosTareas(models.Model):
    id_empleado = models.IntegerField(primary_key=True)
    nombre = models.CharField(max_length=150)  # Cambiado a first_name con max_length 150
    apellidos = models.CharField(max_length=150)  # Cambiado a last_name con max_length 150
    correo = models.EmailField(max_length=254)  # Cambiado a email con max_length 254
    especialidad = models.CharField(max_length=50, blank=True, null=True)  # Sin cambios
    sueldo = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    activo = models.BooleanField(default=True)  # Cambiado a is_active
    foto = models.CharField(max_length=100, blank=True, null=True)
    nombre_usuario = models.CharField(max_length=150, unique=True)  # Cambiado a username con max_length 150
    contrasenia = models.CharField(max_length=128)  # Cambiado a password con max_length 128
    fecha_contratacion = models.DateField()
    area_id = models.IntegerField(blank=True, null=True)
    rol_id = models.IntegerField(blank=True, null=True)
    geom = models.GeometryField(blank=True, null=True)
    proyectos_ids = ArrayField(models.IntegerField(), blank=True, null=True)  # Sin cambios
    cantidad_tareas_pendientes_o_en_progreso = models.IntegerField()

    class Meta:
        managed = False  # No permitir a Django gestionar esta tabla
        db_table = '"recursos_humanos"."vista_empleados_tareas"'

class EmpleadosTareasPendientes(models.Model):
    id_empleado = models.IntegerField(primary_key=True)
    nombre = models.CharField(max_length=255)
    apellidos = models.CharField(max_length=255)
    correo = models.EmailField()
    tarea_id = models.IntegerField()
    tarea_titulo = models.CharField(max_length=255)
    tarea_descripcion = models.TextField()
    tarea_fecha_inicio = models.DateTimeField()
    tarea_fecha_estimada_fin = models.DateTimeField()
    tarea_estado = models.CharField(max_length=50)

    class Meta:
        managed = False  # No permitir a Django gestionar esta tabla
        db_table = '"recursos_humanos"."empleados_tareas_pendientes"'