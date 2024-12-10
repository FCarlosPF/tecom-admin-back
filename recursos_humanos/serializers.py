from rest_framework import serializers
from .models import Empleados, Areas, Roles, Oficina
from django.contrib.auth.hashers import check_password
from rest_framework import generics
from rest_framework_gis.serializers import GeoFeatureModelSerializer

class EmpleadosSerializer(serializers.ModelSerializer):
    class Meta:
        model = Empleados
        fields = ['id_empleado', 'nombre', 'apellidos', 'correo', 'especialidad', 'sueldo', 'activo', 'foto', 'nombre_usuario', 'contrasenia', 'fecha_contratacion', 'area', 'rol']
        extra_kwargs = {'contrasenia': {'write_only': True}}
        
class LoginSerializer(serializers.Serializer):
    nombre_usuario = serializers.CharField()
    contrasenia = serializers.CharField()

    def validate(self, data):
        nombre_usuario = data.get('nombre_usuario')
        contrasenia = data.get('contrasenia')

        try:
            empleado = Empleados.objects.get(nombre_usuario=nombre_usuario)
        except Empleados.DoesNotExist:
            raise serializers.ValidationError("Usuario no encontrado.")

        # Verificar la contraseña
        if contrasenia != empleado.contrasenia:
            raise serializers.ValidationError("Contraseña incorrecta.")

        return empleado        
    
    
class EmpleadoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Empleados
        fields = '__all__'    

class AreasReadSerializer(serializers.ModelSerializer):
    supervisor = EmpleadoSerializer()

    class Meta:
        model = Areas
        fields = '__all__'

class RolesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Roles
        fields = '__all__'

class AreasWriteSerializer(serializers.ModelSerializer):
    supervisor = serializers.PrimaryKeyRelatedField(queryset=Empleados.objects.all(), required=False, allow_null=True)

    class Meta:
        model = Areas
        fields = '__all__'  

class OficinaSerializer(GeoFeatureModelSerializer):
    class Meta:
        model = Oficina
        geo_field = "geom"
        fields = ('id', 'nombre', 'geom')