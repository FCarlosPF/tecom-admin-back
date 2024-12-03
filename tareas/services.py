from django.db.models import F, Avg, Count, Q, ExpressionWrapper, DurationField, Sum
from django.db.models.functions import ExtractDay, Extract
from .models import AsignacionesTareas, Tareas
from datetime import datetime, timedelta

def calcular_metricas_por_empleado(empleado_id):
    tareas_totales = AsignacionesTareas.objects.filter(empleado_id=empleado_id).count()
    
    # Tareas completadas a tiempo
    tareas_completadas_a_tiempo = AsignacionesTareas.objects.filter(
        empleado_id=empleado_id,
        tarea__estado="Completada",
        tarea__fecha_real_fin__lte=F('tarea__fecha_estimada_fin')
    ).count()

    porcentaje_tareas_completadas_a_tiempo = (tareas_completadas_a_tiempo / tareas_totales) * 100 if tareas_totales > 0 else 0

    # Promedio de tiempo de retraso (en horas)
    retrasos = AsignacionesTareas.objects.filter(
        empleado_id=empleado_id,
        tarea__estado="Completada",
        tarea__fecha_real_fin__gt=F('tarea__fecha_estimada_fin')
    ).annotate(
        retraso=ExpressionWrapper(
            F('tarea__fecha_real_fin') - F('tarea__fecha_estimada_fin'),
            output_field=DurationField()
        )
    ).annotate(
        retraso_horas=Extract('retraso', 'epoch') / 3600.0
    ).aggregate(promedio_retraso=Avg('retraso_horas'))['promedio_retraso'] or 0

    # Carga de trabajo actual
    carga_trabajo_actual = AsignacionesTareas.objects.filter(
        Q(tarea__estado="En Progreso") | Q(tarea__estado="Pendiente"),
        empleado_id=empleado_id
    ).count()

    # Complejidad promedio por tarea
    complejidad_promedio = AsignacionesTareas.objects.filter(
        empleado_id=empleado_id
    ).aggregate(promedio_complejidad=Avg('tarea__complejidad'))['promedio_complejidad'] or 0

    # Puntaje de productividad (puede ser una métrica personalizada, aquí se usa la suma de puntos de tareas completadas)
    puntaje_productividad = AsignacionesTareas.objects.filter(
        empleado_id=empleado_id,
        tarea__estado="Completada"
    ).aggregate(total_puntos=Sum('tarea__puntos'))['total_puntos'] or 0

    # Índice de eficiencia (puede ser una métrica personalizada, aquí se usa el porcentaje de tareas completadas a tiempo)
    indice_eficiencia = porcentaje_tareas_completadas_a_tiempo

    # Número de tareas en progreso
    tareas_en_progreso = AsignacionesTareas.objects.filter(
        empleado_id=empleado_id,
        tarea__estado="En Progreso"
    ).count()

    # Número de tareas pendientes
    tareas_pendientes = AsignacionesTareas.objects.filter(
        empleado_id=empleado_id,
        tarea__estado="Pendiente"
    ).count()

    tareas_completadas = AsignacionesTareas.objects.filter(
        empleado_id=empleado_id,
        tarea__estado="Completada"
    ).count()

    # Promedio de duración de las tareas completadas (en horas)
    duracion_promedio_tareas_completadas = AsignacionesTareas.objects.filter(
        empleado_id=empleado_id,
        tarea__estado="Completada"
    ).annotate(
        duracion=ExpressionWrapper(
            F('tarea__fecha_real_fin') - F('tarea__fecha_inicio'),
            output_field=DurationField()
        )
    ).annotate(
        duracion_horas=Extract('duracion', 'epoch') / 3600.0
    ).aggregate(promedio_duracion=Avg('duracion_horas'))['promedio_duracion'] or 0

    # Número de tareas completadas en el último mes
    ultimo_mes = datetime.now() - timedelta(days=30)
    tareas_completadas_ultimo_mes = AsignacionesTareas.objects.filter(
        empleado_id=empleado_id,
        tarea__estado="Completada",
        tarea__fecha_real_fin__gte=ultimo_mes
    ).count()

    # Número de tareas completadas por día en el último mes
    tareas_completadas_por_dia = AsignacionesTareas.objects.filter(
        empleado_id=empleado_id,
        tarea__estado="Completada",
        tarea__fecha_real_fin__gte=ultimo_mes
    ).annotate(
        dia=ExtractDay('tarea__fecha_real_fin')
    ).values('dia').annotate(
        count=Count('asignacion_id')
    ).order_by('dia')

    # Datos para gráficos
    datos_grafico_barras = {
        "tareas_completadas": tareas_completadas_a_tiempo,
        "tareas_en_progreso": tareas_en_progreso,
        "tareas_pendientes": tareas_pendientes
    }

    datos_grafico_linea_tiempo = {
        "tareas_completadas_por_dia": list(tareas_completadas_por_dia)
    }

    datos_grafico_torta = {
        "completadas_a_tiempo": porcentaje_tareas_completadas_a_tiempo,
        "no_completadas_a_tiempo": 100 - porcentaje_tareas_completadas_a_tiempo
    }

    return {
        "tareas_totales": tareas_totales,
        "porcentaje_tareas_completadas_a_tiempo": round(porcentaje_tareas_completadas_a_tiempo, 2),
        "promedio_retraso_horas": round(retrasos, 2),
        "carga_trabajo_actual": carga_trabajo_actual,
        "complejidad_promedio": round(complejidad_promedio, 2),
        "puntaje_productividad": puntaje_productividad,
        "indice_eficiencia": round(indice_eficiencia, 2),
        "tareas_en_progreso": tareas_en_progreso,
        "tareas_pendientes": tareas_pendientes,
        "promedio_duracion_tareas_completadas": round(duracion_promedio_tareas_completadas, 2),
        "tareas_completadas_ultimo_mes": tareas_completadas_ultimo_mes,
        "datos_grafico_barras": datos_grafico_barras,
        "datos_grafico_linea_tiempo": datos_grafico_linea_tiempo,
        "datos_grafico_torta": datos_grafico_torta,
        "tareas_completadas": tareas_completadas
    }