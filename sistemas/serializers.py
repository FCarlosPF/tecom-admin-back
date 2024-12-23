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
            'id_notificacion',
            'titulo',
            'descripcion',
            'fecha_creacion',
            'fecha_evento',
            'tipo',
            'estado',
            'para'
        ]