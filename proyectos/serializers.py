from rest_framework import serializers
from .models import Proyectos, Costos, Facturas, Ordenescompra, Pagos, Proveedores

class ProyectosSerializer(serializers.ModelSerializer):
    class Meta:
        model = Proyectos
        fields = '__all__'

class CostosSerializer(serializers.ModelSerializer):
    class Meta:
        model = Costos
        fields = '__all__'

class FacturasSerializer(serializers.ModelSerializer):
    class Meta:
        model = Facturas
        fields = '__all__'

class OrdenescompraSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ordenescompra
        fields = '__all__'

class PagosSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pagos
        fields = '__all__'

class ProveedoresSerializer(serializers.ModelSerializer):
    class Meta:
        model = Proveedores
        fields = '__all__'