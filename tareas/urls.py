from django.urls import path
from .views import ReporteTareasNoEntregadasATiempoView, ReporteTareasExcelView,TareasListCreateView, TareasRetrieveUpdateDestroyView, AsignacionesTareasListCreateView, AsignacionesTareasRetrieveUpdateDestroyView,TareasPorEmpleadoView,MetricasPorEmpleadoView


urlpatterns = [
    path('tareas/', TareasListCreateView.as_view(), name='tareas-list-create'),
    path('tareas/<int:pk>/', TareasRetrieveUpdateDestroyView.as_view(), name='tareas-detail'),
    path('asignacionestareas/', AsignacionesTareasListCreateView.as_view(), name='asignacionestareas-list-create'),
    path('asignacionestareas/<int:pk>/', AsignacionesTareasRetrieveUpdateDestroyView.as_view(), name='asignacionestareas-detail'),
    path('tareas/empleado/<int:empleado_id>/', TareasPorEmpleadoView.as_view(), name='tareas-por-empleado'),
    path('metricas-empleado/<int:empleado_id>/', MetricasPorEmpleadoView.as_view(), name='metricas-empleado'),
    path('reporte-tareas/', ReporteTareasExcelView.as_view(), name='reporte-tareas'),
    path('reporte-tareas-no-entregadas-a-tiempo/', ReporteTareasNoEntregadasATiempoView.as_view(), name='reporte-tareas-no-entregadas-a-tiempo'),

]