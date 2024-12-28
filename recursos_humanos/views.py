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
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenRefreshView

class LoginView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        empleado = serializer.validated_data['empleado']

        # Generar los tokens usando el modelo User
        refresh = RefreshToken.for_user(user)
        tokens = {
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        }

        # Serializar la información del empleado
        empleado_data = EmpleadoSerializer(empleado).data

        response_data = {
            "tokens": tokens,
            "empleado": empleado_data
        }

        return Response(response_data, status=status.HTTP_200_OK)

class EmpleadoListCreateView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated]  # Solo usuarios autenticados pueden acceder a esta vista
    queryset = Empleados.objects.all()
    serializer_class = EmpleadoSerializer


class EmpleadoRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    queryset = Empleados.objects.select_related('area', 'rol', 'user').all()
    serializer_class = EmpleadoSerializer
    lookup_field = 'id_empleado'
    
def healthcheck(request):
    return JsonResponse({"status": "ok"})    

class AreasListCreateView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated]  # Solo usuarios autenticados pueden acceder a esta vista
    queryset = Areas.objects.all()

    def get_serializer_class(self):
        if self.request.method in ['POST', 'PUT', 'PATCH']:
            return AreasWriteSerializer
        return AreasReadSerializer

class RolesListCreateView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated]  # Solo usuarios autenticados pueden acceder a esta vista
   
    queryset = Roles.objects.all()
    serializer_class = RolesSerializer

class RolesRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]  # Solo usuarios autenticados pueden acceder a esta vista

    queryset = Roles.objects.all()
    serializer_class = RolesSerializer      

class AreasRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]  # Solo usuarios autenticados pueden acceder a esta vista

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
