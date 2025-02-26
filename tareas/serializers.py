from rest_framework import serializers
from .models import Tareas, AsignacionesTareas, ObservacionTarea
from recursos_humanos.models import Empleados
from django.utils.timezone import now, make_aware
from datetime import datetime
from django.utils import timezone
from recursos_humanos.serializers import EmpleadosSerializer
from datetime import timedelta
from proyectos.serializers import ProyectosSerializer
from proyectos.models import Proyectos
from django.utils import timezone

class TareasSerializer(serializers.ModelSerializer):
    tiempo_restante = serializers.SerializerMethodField()
    tiempo_pasado = serializers.SerializerMethodField()
    proyecto = ProyectosSerializer(read_only=True)
    proyecto_id = serializers.PrimaryKeyRelatedField(
        queryset=Proyectos.objects.all(), source='proyecto', write_only=True
    )

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
            'tiempo_restante',
            'tiempo_pasado',
            'tarea_padre',
            'proyecto',
            'proyecto_id'
        ]

    def get_tiempo_restante(self, obj):
        if obj.estado == "Completada" and obj.tiempo_restante_paralizado:
            return obj.tiempo_restante_paralizado  # Usar el tiempo paralizado si la tarea está completada
        if obj.fecha_estimada_fin:
            delta = obj.fecha_estimada_fin - timezone.now()
            if delta.total_seconds() > 0:
                dias = delta.days
                horas = (delta.seconds // 3600)
                minutos = (delta.seconds % 3600) // 60
                return {'dias': dias, 'horas': horas, 'minutos': minutos}
        return {'dias': 0, 'horas': 0, 'minutos': 0}

    def get_tiempo_pasado(self, obj):
        if obj.estado == "Completada" and obj.tiempo_pasado_paralizado:
            return obj.tiempo_pasado_paralizado  # Usar el tiempo paralizado si la tarea está completada
        if obj.fecha_estimada_fin:
            delta = timezone.now() - obj.fecha_estimada_fin
            if delta.total_seconds() > 0:
                dias = delta.days
                horas = (delta.seconds // 3600)
                minutos = (delta.seconds % 3600) // 60
                return {'dias': dias, 'horas': horas, 'minutos': minutos}
        return {'dias': 0, 'horas': 0, 'minutos': 0}

    def update(self, instance, validated_data):
        previous_estado = instance.estado
        instance = super().update(instance, validated_data)
        if previous_estado != "Completada" and instance.estado == "Completada":
            instance.fecha_real_fin = timezone.now()
            instance.tiempo_restante_paralizado = self.get_tiempo_restante(instance)
            instance.tiempo_pasado_paralizado = self.get_tiempo_pasado(instance)
            instance.save()
        return instance
    
class AsignacionesTareasReadSerializer(serializers.ModelSerializer):
    tarea = TareasSerializer()
    empleado = EmpleadosSerializer()
    asignador = EmpleadosSerializer()
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


class ObservacionTareaSerializer(serializers.ModelSerializer):
    
    empleado = EmpleadosSerializer(read_only=True)
    empleado_id = serializers.PrimaryKeyRelatedField(queryset=Empleados.objects.all(), write_only=True)

    class Meta:
        model = ObservacionTarea
        fields = '__all__'
        
    def create(self, validated_data):
        empleado_id = validated_data.pop('empleado_id')
        observacion_tarea = ObservacionTarea.objects.create(empleado_id=empleado_id.id_empleado, **validated_data)
        return observacion_tarea

    def update(self, instance, validated_data):
        empleado_id = validated_data.pop('empleado_id', None)
        if empleado_id:
            instance.empleado_id = empleado_id.id_empleado
        return super().update(instance, validated_data)