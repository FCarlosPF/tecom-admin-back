from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework import generics
from .serializers import  PasswordResetRequestSerializer,EmpleadosTareasPendientesSerializer,VistaEmpleadosTareasSerializer, LoginSerializer, EmpleadosSerializer,RolesSerializer,AreasReadSerializer, AreasWriteSerializer, OficinaSerializer
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
from django.core.mail import send_mail
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from django.contrib.auth.tokens import default_token_generator
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.conf import settings

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


class PasswordResetRequestView(APIView):
    def post(self, request):
        serializer = PasswordResetRequestSerializer(data=request.data)
        if serializer.is_valid():
            email = serializer.validated_data['email']
            user = Empleados.objects.get(email=email)
            token = default_token_generator.make_token(user)
            uid = urlsafe_base64_encode(force_bytes(user.pk))
            # Cambia la URL para que apunte a tu aplicación Next.js
            reset_url = f"http://localhost:3000/reset-password/{uid}/{token}/"
            # URL del logo
            logo_url = request.build_absolute_uri(f"{settings.STATIC_URL}images/logo.jpg")
            # Renderizar la plantilla HTML
            html_message = render_to_string('django/password_reset_email.html', {
                'user': user,
                'reset_url': reset_url,
                'logo_url': logo_url,
            })
            # Convertir el mensaje HTML a texto plano
            plain_message = strip_tags(html_message)
            send_mail(
                'Password Reset Request',
                plain_message,
                'carlos.paucar@tecomsg.com.pe',
                [email],
                fail_silently=False,
                html_message=html_message,
            )
            return Response({"detail": "Password reset email sent."}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class PasswordResetConfirmView(APIView):
    def post(self, request):
        uidb64 = request.data.get('uid')
        token = request.data.get('token')
        new_password = request.data.get('password')
        
        try:
            uid = force_str(urlsafe_base64_decode(uidb64))
            user = Empleados.objects.get(pk=uid)
        except (TypeError, ValueError, OverflowError, Empleados.DoesNotExist):
            user = None

        if user is not None and default_token_generator.check_token(user, token):
            user.set_password(new_password)
            user.save()
            return Response({"detail": "Password has been reset."}, status=status.HTTP_200_OK)
        return Response({"detail": "Invalid token or user ID."}, status=status.HTTP_400_BAD_REQUEST)