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

class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()
    empleado = EmpleadosSerializer(read_only=True)

    def validate(self, data):
        username = data.get('username')
        password = data.get('password')

        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            raise serializers.ValidationError("Usuario no encontrado.")

        # Verificar la contraseña usando check_password
        if not user.check_password(password):
            raise serializers.ValidationError("Contraseña incorrecta.")

        try:
            empleado = Empleados.objects.get(user=user)
        except Empleados.DoesNotExist:
            raise serializers.ValidationError("Empleado no encontrado.")

        data['empleado'] = empleado
        data['user'] = user  # Asegúrate de incluir esto
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
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)