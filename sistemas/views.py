from rest_framework import viewsets, status, generics
from rest_framework.response import Response
from .models import Asistencias,Notificaciones, VistaNotificacionesEmpleados
from .serializers import AsistenciasSerializer,NotificacionesSerializer, VistaNotificacionesEmpleadosSerializer
from recursos_humanos.models import Empleados
from rest_framework.decorators import action

class AsistenciasViewSet(viewsets.ModelViewSet):
    queryset = Asistencias.objects.all()
    serializer_class = AsistenciasSerializer

    def create(self, request, *args, **kwargs):
        """
        Sobreescribir la creación para manejar datos relacionados con empleados.
        """
        empleado_id = request.data.get('id_empleado')
        try:
            empleado = Empleados.objects.get(pk=empleado_id)
        except Empleados.DoesNotExist:
            return Response({'error': 'Empleado no encontrado'}, status=status.HTTP_404_NOT_FOUND)

        asistencia = Asistencias.objects.create(
            empleado=empleado,
            fecha=request.data.get('fecha'),
            hora_entrada=request.data.get('hora_entrada'),
            hora_salida=request.data.get('hora_salida'),
            estado=request.data.get('estado'),
            comentarios=request.data.get('comentarios'),
        )

        serializer = self.get_serializer(asistencia)
        return Response(serializer.data, status=status.HTTP_201_CREATED)


class NotificacionesViewSet(viewsets.ModelViewSet):
    queryset = Notificaciones.objects.all()
    serializer_class = NotificacionesSerializer

    @action(detail=True, methods=['post'])
    def enviar(self, request, pk=None):
        notificacion = self.get_object()
        area_id = request.data.get('area_id')
        rol_id = request.data.get('rol_id')
        empleados_ids = request.data.get('empleados_ids', [])

        notificacion.enviar_notificacion(area_id=area_id, rol_id=rol_id, empleados_ids=empleados_ids)
        return Response({'status': 'Notificaciones enviadas'}, status=status.HTTP_200_OK)
    

class NotificacionesPorEmpleadoView(generics.ListAPIView):
    serializer_class = VistaNotificacionesEmpleadosSerializer

    def get_queryset(self):
        id_empleado = self.kwargs['id_empleado']
        return VistaNotificacionesEmpleados.objects.filter(id_empleado=id_empleado)