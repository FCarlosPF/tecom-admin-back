from rest_framework import serializers
from .models import Empleados
from django.contrib.auth.hashers import check_password

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