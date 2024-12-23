from rest_framework import serializers
from .models import EmpleadosTareasPendientes, Empleados, Areas, Roles, Oficina, VistaEmpleadosTareas
from django.contrib.auth.hashers import check_password
from rest_framework import generics
from rest_framework_gis.serializers import GeoFeatureModelSerializer

class EmpleadosSerializer(serializers.ModelSerializer):
    class Meta:
        model = Empleados
        fields = ['id_empleado', 'nombre', 'apellidos', 'correo', 'especialidad', 'sueldo', 'activo', 'foto', 'nombre_usuario', 'contrasenia', 'fecha_contratacion', 'area', 'rol','geom']
        extra_kwargs = {'contrasenia': {'write_only': True}}
        geo_field = "geom"

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
    area = serializers.SerializerMethodField()

    class Meta:
        model = Empleados
        fields = '__all__'

    def get_area(self, obj):
        if obj.area:
            return {
                'area_id': obj.area.area_id,
                'nombre': obj.area.nombre,
                'supervisor_id': obj.area.supervisor_id
            }
        return None   

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
        

class VistaEmpleadosTareasSerializer(serializers.ModelSerializer):
    class Meta:
        model = VistaEmpleadosTareas
        geo_field = "geom"
        fields = '__all__'

class EmpleadosTareasPendientesSerializer(serializers.ModelSerializer):
    class Meta:
        model = EmpleadosTareasPendientes
        fields = '__all__'


