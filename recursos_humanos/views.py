from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework import generics
from .serializers import ChangePasswordSerializer, EmpleadosTareasPendientesSerializer,VistaEmpleadosTareasSerializer, LoginSerializer, EmpleadoSerializer,RolesSerializer,AreasReadSerializer, AreasWriteSerializer, OficinaSerializer
from .models import Empleados, Areas, Roles, Oficina, VistaEmpleadosTareas, EmpleadosTareasPendientes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework_simplejwt.authentication import JWTAuthentication
from django.http import JsonResponse
from rest_framework import viewsets
                                                                                                                                 
class LoginView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        empleado = serializer.validated_data['empleado']

        try:
            # Generar los tokens usando el método get_tokens del modelo
            tokens = empleado.get_tokens()
        except Exception as e:
            return Response(
                {"detail": "Error generando los tokens.", "error": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

        # Serializar la información del empleado
        empleado_data = EmpleadoSerializer(empleado).data

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

class EmpleadosTareasPendientesListView(generics.ListAPIView):
    serializer_class = EmpleadosTareasPendientesSerializer

    def get_queryset(self):
        id_empleado = self.kwargs['id_empleado']
        return EmpleadosTareasPendientes.objects.filter(id_empleado=id_empleado)
    


class ChangePasswordView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def post(self, request):
        # Buscar al empleado relacionado
        try:
            empleado = Empleados.objects.get(correo=request.user.email)
        except Empleados.DoesNotExist:
            return Response(
                {"detail": "No se encontró al empleado relacionado con este usuario."},
                status=status.HTTP_404_NOT_FOUND,
            )

        # Validar los datos enviados
        serializer = ChangePasswordSerializer(data=request.data)
        if serializer.is_valid():
            old_password = serializer.validated_data['old_password']
            new_password = serializer.validated_data['new_password']

            # Verificar la contraseña actual
            if not empleado.check_password(old_password):
                return Response(
                    {"old_password": "Contraseña incorrecta."},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            # Actualizar la contraseña
            empleado.set_password(new_password)
            empleado.save()
            return Response(
                {"detail": "Contraseña cambiada exitosamente."},
                status=status.HTTP_200_OK,
            )

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
