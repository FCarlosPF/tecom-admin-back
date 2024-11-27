from rest_framework import serializers
from .models import Tareas, AsignacionesTareas
from django.utils.timezone import now
from datetime import datetime
from django.utils import timezone
from recursos_humanos.serializers import EmpleadoSerializer

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

class AsignacionesTareasReadSerializer(serializers.ModelSerializer):
    tarea = TareasSerializer()

    class Meta:
        model = AsignacionesTareas
        fields = '__all__'

class AsignacionesTareasCreateSerializer(serializers.ModelSerializer):
    tarea = serializers.PrimaryKeyRelatedField(queryset=Tareas.objects.all())

    class Meta:
        model = AsignacionesTareas
        fields = '__all__'

    def create(self, validated_data):
        return AsignacionesTareas.objects.create(**validated_data)

class AsignacionesTareasUpdateSerializer(serializers.ModelSerializer):
    tarea = TareasSerializer()

    class Meta:
        model = AsignacionesTareas
        fields = '__all__'

    def update(self, instance, validated_data):
        tarea_data = validated_data.pop('tarea')
        tarea = instance.tarea

        instance.empleado_id = validated_data.get('empleado_id', instance.empleado_id)
        instance.asignador_id = validated_data.get('asignador_id', instance.asignador_id)
        instance.save()

        tarea.titulo = tarea_data.get('titulo', tarea.titulo)
        tarea.descripcion = tarea_data.get('descripcion', tarea.descripcion)
        tarea.fecha_inicio = tarea_data.get('fecha_inicio', tarea.fecha_inicio)
        tarea.fecha_estimada_fin = tarea_data.get('fecha_estimada_fin', tarea.fecha_estimada_fin)
        tarea.fecha_real_fin = tarea_data.get('fecha_real_fin', tarea.fecha_real_fin)
        tarea.prioridad = tarea_data.get('prioridad', tarea.prioridad)
        tarea.estado = tarea_data.get('estado', tarea.estado)
        tarea.save()

        return instance