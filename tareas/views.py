from rest_framework import generics
from .models import Tareas, AsignacionesTareas
from .serializers import TareasSerializer, AsignacionesTareasReadSerializer,AsignacionesTareasCreateSerializer,AsignacionesTareasUpdateSerializer
from rest_framework.views import APIView

# Vistas para Tareas
class TareasListCreateView(generics.ListCreateAPIView):
    queryset = Tareas.objects.all()
    serializer_class = TareasSerializer

class TareasRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Tareas.objects.all()
    serializer_class = TareasSerializer

# Vistas para AsignacionesTareas
class AsignacionesTareasListCreateView(generics.ListCreateAPIView):
    queryset = AsignacionesTareas.objects.all()

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return AsignacionesTareasCreateSerializer
        return AsignacionesTareasReadSerializer

class AsignacionesTareasRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = AsignacionesTareas.objects.all()

    def get_serializer_class(self):
        if self.request.method in ['PUT', 'PATCH']:
            return AsignacionesTareasUpdateSerializer
        return AsignacionesTareasReadSerializer
    
class TareasPorEmpleadoView(generics.ListCreateAPIView):
    serializer_class = AsignacionesTareasReadSerializer

    def get_queryset(self):
        empleado_id = self.kwargs['empleado_id']
        return AsignacionesTareas.objects.filter(empleado_id=empleado_id)

