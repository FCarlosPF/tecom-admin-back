# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Areas(models.Model):
    area_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    supervisor = models.ForeignKey('Empleados', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'areas'


class AsignacionesTareas(models.Model):
    asignacion_id = models.AutoField(primary_key=True)
    tarea = models.ForeignKey('Tareas', models.DO_NOTHING, blank=True, null=True)
    empleado_id = models.IntegerField(blank=True, null=True)
    asignador_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'asignaciones_tareas'


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


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


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
    rol = models.ForeignKey('Roles', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'empleados'


class EvaluacionesDesempenio(models.Model):
    evaluacion_id = models.AutoField(primary_key=True)
    empleado_id = models.IntegerField(blank=True, null=True)
    fecha_evaluacion = models.DateField()
    comentarios = models.TextField(blank=True, null=True)
    puntuacion = models.DecimalField(max_digits=5, decimal_places=2)
    evaluador_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'evaluaciones_desempenio'


class Roles(models.Model):
    id_rol = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    describcion = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'roles'


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
        managed = False
        db_table = 'solicitudes_permiso'


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


class TokenBlacklistBlacklistedtoken(models.Model):
    id = models.BigAutoField(primary_key=True)
    blacklisted_at = models.DateTimeField()
    token = models.OneToOneField('TokenBlacklistOutstandingtoken', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'token_blacklist_blacklistedtoken'


class TokenBlacklistOutstandingtoken(models.Model):
    id = models.BigAutoField(primary_key=True)
    token = models.TextField()
    created_at = models.DateTimeField(blank=True, null=True)
    expires_at = models.DateTimeField()
    user_id = models.IntegerField(blank=True, null=True)
    jti = models.CharField(unique=True, max_length=255)

    class Meta:
        managed = False
        db_table = 'token_blacklist_outstandingtoken'
