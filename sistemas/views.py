from rest_framework import viewsets, status
from rest_framework.response import Response
from .models import Asistencias
from .serializers import AsistenciasSerializer
from recursos_humanos.models import Empleados

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
