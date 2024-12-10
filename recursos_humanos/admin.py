from django.contrib import admin
from .models import Empleados

class EmpleadosAdmin(admin.ModelAdmin):
    list_display = ('id_empleado', 'nombre', 'apellidos', 'correo', 'especialidad', 'sueldo', 'activo', 'foto', 'nombre_usuario', 'fecha_contratacion')
    list_filter = ('activo', 'area_id', 'rol_id')

admin.site.register(Empleados, EmpleadosAdmin)