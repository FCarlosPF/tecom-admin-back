from django.contrib import admin
from .models import Empleados

class EmpleadosAdmin(admin.ModelAdmin):
    list_display = ('id_empleado','especialidad', 'sueldo', 'foto', 'fecha_contratacion')
    list_filter = ('area_id', 'rol_id')

admin.site.register(Empleados, EmpleadosAdmin)