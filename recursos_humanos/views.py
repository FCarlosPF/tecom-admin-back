from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework import generics
from .serializers import VistaEmpleadosTareasSerializer, LoginSerializer, EmpleadoSerializer,RolesSerializer,AreasReadSerializer, AreasWriteSerializer, OficinaSerializer
from .models import Empleados, Areas, Roles, Oficina, VistaEmpleadosTareas
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from django.http import JsonResponse
from rest_framework import viewsets
                                                                                                                                 
class LoginView(APIView):
    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        empleado = serializer.validated_data

        # Generar los tokens usando el método get_tokens del modelo
        tokens = empleado.get_tokens()

        # Serializar la información del empleado
        empleado_data = {
            "id_empleado": empleado.id_empleado,
            "nombre": empleado.nombre,
            "apellidos": empleado.apellidos,
            "correo": empleado.correo,
            "especialidad": empleado.especialidad,
            "sueldo": empleado.sueldo,
            "activo": empleado.activo,
            "foto": empleado.foto,
            "nombre_usuario": empleado.nombre_usuario,
            "fecha_contratacion": empleado.fecha_contratacion,
            "area": empleado.area.area_id if empleado.area else None,
            "rol": empleado.rol.id_rol if empleado.rol else None,
        }

        response_data = {
            "tokens": tokens,
            "empleado": empleado_data
        }

        return Response(response_data, status=status.HTTP_200_OK)
        


class EmpleadoListCreateView(generics.ListCreateAPIView):
    queryset = Empleados.objects.all()
    serializer_class = EmpleadoSerializer


class EmpleadoRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Empleados.objects.all()
    serializer_class = EmpleadoSerializer
    lookup_field = 'id_empleado'
    
def healthcheck(request):
    return JsonResponse({"status": "ok"})    

class AreasListCreateView(generics.ListCreateAPIView):
    queryset = Areas.objects.all()

    def get_serializer_class(self):
        if self.request.method in ['POST', 'PUT', 'PATCH']:
            return AreasWriteSerializer
        return AreasReadSerializer

class RolesListCreateView(generics.ListCreateAPIView):
    queryset = Roles.objects.all()
    serializer_class = RolesSerializer

class RolesRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Roles.objects.all()
    serializer_class = RolesSerializer      

class AreasRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Areas.objects.all()

    def get_serializer_class(self):
        if self.request.method in ['PUT', 'PATCH']:
            return AreasWriteSerializer
        return AreasReadSerializer    
    
class OficinaViewSet(viewsets.ModelViewSet):
    queryset = Oficina.objects.all()
    serializer_class = OficinaSerializer

class VistaEmpleadosTareasListView(generics.ListAPIView):
    queryset = VistaEmpleadosTareas.objects.all()
    serializer_class = VistaEmpleadosTareasSerializer