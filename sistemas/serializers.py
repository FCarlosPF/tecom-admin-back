from rest_framework import serializers
from .models import Asistencias,Notificaciones, VistaNotificacionesEmpleados
from recursos_humanos.serializers import EmpleadoSerializer

class AsistenciasSerializer(serializers.ModelSerializer):
    empleado = EmpleadoSerializer(read_only=True)  # Incluimos detalles del empleado

    class Meta:
        model = Asistencias
        fields = [
            'asistencia_id', 
            'empleado', 
            'fecha', 
            'hora_entrada', 
            'hora_salida', 
            'estado', 
            'comentarios'
        ]

class NotificacionesSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Notificaciones
        fields = [
            'id_notificacion',
            'titulo',
            'descripcion',
            'fecha_creacion',
            'fecha_evento',
            'tipo',
            'estado',
            'para'
        ]


class VistaNotificacionesEmpleadosSerializer(serializers.ModelSerializer):
    class Meta:
        model = VistaNotificacionesEmpleados
        fields = [
            'id_empleado',
            'nombre_empleado',
            'apellido_empleado',
            'id_notificacion',
            'titulo_notificacion',
            'descripcion_notificacion',
            'fecha_creacion',
            'fecha_evento',
            'tipo_notificacion',
            'estado_notificacion'
        ]