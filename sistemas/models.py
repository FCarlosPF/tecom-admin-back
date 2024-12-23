from django.db import models
from recursos_humanos.models import Empleados,Areas,Roles

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
        db_table = '"sistemas"."asistencias"'
        unique_together = ('empleado', 'fecha')  # Un empleado solo puede tener un registro por día


class Notificaciones(models.Model):
    id_notificacion = models.AutoField(primary_key=True)
    titulo = models.CharField(max_length=100)
    descripcion = models.TextField()
    fecha_creacion = models.DateTimeField(blank=True, null=True, auto_now_add=True)
    fecha_evento = models.DateTimeField()
    tipo = models.CharField(max_length=50, blank=True, null=True)
    estado = models.CharField(max_length=20, blank=True, null=True, default='Activa')
    para = models.CharField(max_length=20, choices=[('Personalizado', 'Personalizado'), ('Área', 'Área'), ('Rol', 'Rol'), ('Empleado', 'Empleado'), ('Todos', 'Todos')])

    class Meta:
        managed = False
        db_table = '"sistemas"."notificaciones"'

    def enviar_notificacion(self, area_id=None, rol_id=None, empleados_ids=None):
        destinatarios = []

        if self.para == 'Área' and area_id:
            empleados_area = Empleados.objects.filter(area_id=area_id)
            destinatarios.extend(empleados_area)

        if self.para == 'Rol' and rol_id:
            empleados_rol = Empleados.objects.filter(rol_id=rol_id)
            destinatarios.extend(empleados_rol)

        if self.para == 'Empleado' and empleados_ids:
            empleados_personalizados = Empleados.objects.filter(id_empleado__in=empleados_ids)
            destinatarios.extend(empleados_personalizados)

        if self.para == 'Todos':
            todos_empleados = Empleados.objects.all()
            destinatarios.extend(todos_empleados)

        # Eliminar duplicados
        destinatarios = list(set(destinatarios))

        for empleado in destinatarios:
            area_instance = empleado.area_id if hasattr(empleado, 'area_id') else None
            rol_instance = empleado.rol_id if hasattr(empleado, 'rol_id') else None

            if area_instance and not isinstance(area_instance, Areas):
                area_instance = Areas.objects.get(pk=area_instance)
            if rol_instance and not isinstance(rol_instance, Roles):
                rol_instance = Roles.objects.get(pk=rol_instance)

            NotificacionesDestinatarios.objects.create(
                id_notificacion=self,
                empleado_id=empleado,
                area_id=area_instance,
                rol_id=rol_instance
            )

class NotificacionesDestinatarios(models.Model):
    id_destinatario = models.AutoField(primary_key=True)
    id_notificacion = models.ForeignKey(Notificaciones, models.DO_NOTHING, db_column='id_notificacion')
    empleado_id = models.ForeignKey(Empleados, related_name='notificaciones_asistencias', on_delete=models.DO_NOTHING, blank=True, null=True, db_column='empleado_id')
    area_id = models.ForeignKey(Areas, related_name='notificaciones_asistencias', on_delete=models.DO_NOTHING, blank=True, null=True,db_column='area_id')
    rol_id = models.ForeignKey(Roles, related_name='notificaciones_asistencias', on_delete=models.DO_NOTHING, blank=True, null=True, db_column='rol_id')

    class Meta:
        managed = False
        db_table = '"sistemas"."notificaciones_destinatarios"'