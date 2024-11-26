from rest_framework import serializers
from .models import Tareas, AsignacionesTareas
from django.utils.timezone import now
from datetime import datetime
from django.utils import timezone

class TareasSerializer(serializers.ModelSerializer):
    dias_restantes = serializers.SerializerMethodField()
    dias_pasados = serializers.SerializerMethodField()

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
            'dias_pasados',

        ]

    def get_dias_restantes(self, obj):
        if obj.fecha_estimada_fin:
            delta = obj.fecha_estimada_fin - timezone.now().date()
            return max(delta.days, 0)  # Devuelve 0 si ya pasó la fecha
        return None

    def get_dias_pasados(self, obj):
        if obj.fecha_estimada_fin:
            delta = timezone.now().date() - obj.fecha_estimada_fin
            return max(delta.days, 0)  # Devuelve 0 si aún no ha pasado la fecha
        return None

class AsignacionesTareasSerializer(serializers.ModelSerializer):
    tarea = TareasSerializer()

    class Meta:
        model = AsignacionesTareas
        fields = '__all__'