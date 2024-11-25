from django.urls import path
from .views import TareasListCreateView, TareasRetrieveUpdateDestroyView, AsignacionesTareasListCreateView, AsignacionesTareasRetrieveUpdateDestroyView,TareasPorEmpleadoView


urlpatterns = [
    path('tareas/', TareasListCreateView.as_view(), name='tareas-list-create'),
    path('tareas/<int:pk>/', TareasRetrieveUpdateDestroyView.as_view(), name='tareas-detail'),
    path('asignacionestareas/', AsignacionesTareasListCreateView.as_view(), name='asignacionestareas-list-create'),
    path('asignacionestareas/<int:pk>/', AsignacionesTareasRetrieveUpdateDestroyView.as_view(), name='asignacionestareas-detail'),
    path('tareas/empleado/<int:empleado_id>/', TareasPorEmpleadoView.as_view(), name='tareas-por-empleado'),

]