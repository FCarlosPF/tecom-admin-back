from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework import generics
from .serializers import ChangePasswordSerializer, EmpleadosTareasPendientesSerializer,VistaEmpleadosTareasSerializer, LoginSerializer, EmpleadosSerializer,RolesSerializer,AreasReadSerializer, AreasWriteSerializer, OficinaSerializer
from .models import Empleados, Areas, Roles, Oficina, VistaEmpleadosTareas, EmpleadosTareasPendientes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework_simplejwt.authentication import JWTAuthentication
from django.http import JsonResponse
from rest_framework import viewsets
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenRefreshView
from django.db import IntegrityError
from django.views.generic import TemplateView
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.permissions import IsAuthenticated, IsAdminUser

class LoginView(TokenObtainPairView):
    serializer_class = LoginSerializer

class Index(TemplateView):
    methods = ['get']
    template_name = "recursos_humanos/index.html"

class Panel(TemplateView):
    methods = ['get']
    template_name = "recursos_humanos/panel.html"

class EmpleadosViewSet(viewsets.ModelViewSet):
    queryset = Empleados.objects.all()
    serializer_class = EmpleadosSerializer
    permission_classes = [IsAuthenticated]  # Cambia según tus necesidades

    def perform_create(self, serializer):
        """Sobrescribe para agregar lógica adicional al crear"""
        # Ejemplo: Asignar un rol por defecto al crear un nuevo empleado
        # Puede personalizarse según tu lógica
        instance = serializer.save()
        # ejemplo: instance.rol = 'rol predeterminado'
        instance.save()

    def get_permissions(self):
        """Se puede sobrecargar para definir diferentes permisos"""
        if self.action in ['create', 'update', 'destroy']:
            self.permission_classes = [IsAdminUser]  # Solo administradores
        return super().get_permissions()

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
    
    def delete(self, request, *args, **kwargs):
        area = self.get_object()
        empleados_referenciados = Empleados.objects.filter(area_id=area.area_id)
        
        # Actualizar empleados para que ya no referencien el área
        empleados_referenciados.update(area_id=None)
        
        try:
            return super().delete(request, *args, **kwargs)
        except IntegrityError:
            return Response(
                {"detail": "No se puede eliminar el área porque está referenciada por empleados."},
                status=status.HTTP_400_BAD_REQUEST
            )
        

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
            contraseña_antigua = serializer.validated_data['contraseña_antigua']
            nueva_contraseña = serializer.validated_data['nueva_contraseña']

            # Verificar la contraseña actual
            if not empleado.check_password(contraseña_antigua):
                return Response(
                    {"contraseña_antigua": "Contraseña incorrecta."},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            # Actualizar la contraseña
            empleado.set_password(nueva_contraseña)
            empleado.save()
            return Response(
                {"detail": "Contraseña cambiada exitosamente."},
                status=status.HTTP_200_OK,
            )

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)