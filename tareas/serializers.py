from rest_framework import serializers
from .models import Tareas, AsignacionesTareas
from django.utils.timezone import now
from datetime import datetime


class TareasSerializer(serializers.ModelSerializer):
    dias_restantes = serializers.SerializerMethodField()

    class Meta:
        model = Tareas
        fields = [
            'tarea_id',
            'titulo',
            'descripcion',
            'fecha_inicio',
            'fecha_estimada_fin',
            'fecha_real_fin',
            'prioridad',
            'estado',
            'dias_restantes',
        ]

    def get_dias_restantes(self, obj):
        if obj.fecha_estimada_fin and obj.fecha_inicio:
            delta = obj.fecha_estimada_fin - obj.fecha_inicio
            return max(delta.days, 0)  # Devuelve 0 si ya pasó la fecha
        return None  

class AsignacionesTareasSerializer(serializers.ModelSerializer):
    tarea = TareasSerializer()

    class Meta:
        model = AsignacionesTareas
        fields = '__all__'