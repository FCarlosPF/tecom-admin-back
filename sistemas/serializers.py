from rest_framework import serializers
from .models import Asistencias,Notificaciones
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
            'notificacion_id',
            'empleado_id',
            'tipo_notificacion',
            'mensaje',
            'fecha_notificacion',
            'hora_inicio',
            'hora_fin',
            'creada_en',
            'leida'
        ]