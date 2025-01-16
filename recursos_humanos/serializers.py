from rest_framework import serializers
from .models import EmpleadosTareasPendientes, Empleados, Areas, Roles, Oficina, VistaEmpleadosTareas
from django.contrib.auth.hashers import check_password
from rest_framework import generics
from rest_framework_gis.serializers import GeoFeatureModelSerializer
from django.contrib.auth.models import User,Group, Permission
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth.hashers import make_password

from django.contrib.auth.hashers import check_password
from rest_framework import serializers
from .models import Empleados

class EmpleadosSerializer(serializers.ModelSerializer):
    # Usamos un PrimaryKeyRelatedField para POST/UPDATE (permite el id del área)
    area = serializers.PrimaryKeyRelatedField(queryset=Areas.objects.all(), write_only=True, required=False)
    
    # Usamos un StringRelatedField para GET (muestra el nombre del área)
    area_nombre = serializers.StringRelatedField(source='area.nombre', read_only=True)

    groups = serializers.PrimaryKeyRelatedField(queryset=Group.objects.all(), many=True, required=False)
    user_permissions = serializers.PrimaryKeyRelatedField(queryset=Permission.objects.all(), many=True, required=False)

    class Meta:
        model = Empleados
        fields = [
            'id_empleado', 'username', 'first_name', 'last_name', 'email',
            'password', 'is_staff', 'is_active', 'date_joined', 'especialidad',
            'sueldo', 'foto', 'fecha_contratacion', 'area', 'area_nombre', 'rol', 'geom',
            'groups', 'user_permissions'
        ]
        read_only_fields = ['id_empleado', 'date_joined', 'area_nombre']
        extra_kwargs = {
            'password': {'required': False, 'allow_blank': True},  # Hacer que no sea obligatorio al actualizar
            'first_name': {'required': False, 'allow_blank': True},
            'last_name': {'required': False, 'allow_blank': True},
            'email': {'required': False, 'allow_blank': True},
            'area': {'required': False, 'allow_null': True}
        }

    def create(self, validated_data):
        groups_data = validated_data.pop('groups', [])
        user_permissions_data = validated_data.pop('user_permissions', [])
        area = validated_data.pop('area', None)
        password = validated_data.pop('password', None)
        
        # Creamos el empleado
        empleado = Empleados.objects.create(**validated_data)
        if password:
            empleado.password = make_password(password)
        empleado.save()
        
        # Asignamos el área si se proporcionó
        if area:
            empleado.area = area
            empleado.save()

        empleado.groups.set(groups_data)
        empleado.user_permissions.set(user_permissions_data)
        return empleado

    def update(self, instance, validated_data):
        groups_data = validated_data.pop('groups', [])
        user_permissions_data = validated_data.pop('user_permissions', [])
        area = validated_data.pop('area', None)
        password = validated_data.pop('password', None)

        # Actualiza otros campos del empleado
        for attr, value in validated_data.items():
            setattr(instance, attr, value)

        # Si se proporciona un password, lo actualizamos
        if password:
            instance.password = make_password(password)

        # Asignamos el área si se proporciona
        if area:
            instance.area = area

        instance.save()

        # Actualizamos los grupos y permisos
        instance.groups.set(groups_data)
        instance.user_permissions.set(user_permissions_data)

        return instance

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        
        # No mostramos el campo 'area' en la representación, solo 'area_nombre'
        representation['area'] = instance.area.area_id if instance.area else None
        
        return representation

class LoginSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)

        # Agrega campos adicionales al token si es necesario
        token['username'] = user.username
        token['email'] = user.email

        return token

    def validate(self, attrs):
        data = super().validate(attrs)
        
        # Agrega los datos del usuario al response
        user = self.user
        
        geom = None
        if user.geom:
            geom = [user.geom.x, user.geom.y]
            
            
        area = None
        if user.area:
            area = {
                'id': user.area.area_id,
                'nombre': user.area.nombre
            }
        
        rol = None
        if user.rol:
            rol = {
                'id': user.rol.id_rol,
                'nombre': user.rol.nombre
            }    

        data['empleado'] = {
            'id_empleado': user.id_empleado,
            'username': user.username,
            'email': user.email,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'especialidad': user.especialidad,
            'foto': user.foto,
            'activo': user.is_active,
            'fecha_contratacion': user.fecha_contratacion,
            'area': area,
            'rol': rol,
            'geom': geom
        }
        return data

class AreasReadSerializer(serializers.ModelSerializer):
    supervisor = EmpleadosSerializer()

    class Meta:
        geo_field = "geom"
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


class ChangePasswordSerializer(serializers.Serializer):
    contraseña_antigua = serializers.CharField(required=True, label="Contraseña antigua")
    nueva_contraseña = serializers.CharField(required=True, label="Nueva contraseña")
    repetir_nueva_contraseña = serializers.CharField(required=True, label="Repetir nueva contraseña")

    def validate(self, data):
        if data['nueva_contraseña'] != data['repetir_nueva_contraseña']:
            raise serializers.ValidationError({"repetir_nueva_contraseña": "Las contraseñas no coinciden."})
        return data