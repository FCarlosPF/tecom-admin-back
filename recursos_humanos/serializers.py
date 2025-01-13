from rest_framework import serializers
from .models import EmpleadosTareasPendientes, Empleados, Areas, Roles, Oficina, VistaEmpleadosTareas
from django.contrib.auth.hashers import check_password
from rest_framework import generics
from rest_framework_gis.serializers import GeoFeatureModelSerializer
from django.contrib.auth.models import User
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer

from django.contrib.auth.hashers import check_password
from rest_framework import serializers
from .models import Empleados

class EmpleadosSerializer(serializers.ModelSerializer):
    class Meta:
        model = Empleados
        fields = ['id_empleado', 'nombre', 'apellidos', 'correo', 'especialidad', 'sueldo', 'activo', 'foto', 'nombre_usuario', 'contrasenia', 'fecha_contratacion', 'area', 'rol','geom']
        extra_kwargs = {'contrasenia': {'write_only': True}}
        geo_field = "geom"

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
        data['empleado'] = {
            'id_empleado': user.id_empleado,
            'username': user.username,
            'email': user.email,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'nombre': user.nombre,
            'apellidos': user.apellidos,
            'especialidad': user.especialidad,
            'activo': user.activo,
        }
        return data


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name', 'password']
        extra_kwargs = {'password': {'write_only': True, 'required': False}}

class EmpleadoSerializer(serializers.ModelSerializer):
    area = serializers.SerializerMethodField()
    user = UserSerializer()

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

    def create(self, validated_data):
        user_data = validated_data.pop('user')
        password = user_data.pop('password', None)
        user = User.objects.create(**user_data)
        if password:
            user.set_password(password)
            user.save()
        empleado = Empleados.objects.create(user=user, **validated_data)
        return empleado

    def update(self, instance, validated_data):
        user_data = validated_data.pop('user', None)
        if user_data:
            user = instance.user
            for attr, value in user_data.items():
                if attr == 'username' and User.objects.filter(username=value).exclude(pk=user.pk).exists():
                    raise serializers.ValidationError({"username": "A user with that username already exists."})
                if attr == 'password':
                    user.set_password(value)
                else:
                    setattr(user, attr, value)
            user.save()
        return super().update(instance, validated_data)

class AreasReadSerializer(serializers.ModelSerializer):
    supervisor = EmpleadoSerializer()

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