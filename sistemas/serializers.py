from rest_framework import serializers
from .models import Asistencias
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
