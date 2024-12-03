from rest_framework import viewsets
from .models import Proyectos, Costos, Facturas, Ordenescompra, Pagos, Proveedores
from .serializers import ProyectosSerializer, CostosSerializer, FacturasSerializer, OrdenescompraSerializer, PagosSerializer, ProveedoresSerializer

class ProyectosViewSet(viewsets.ModelViewSet):
    queryset = Proyectos.objects.all()
    serializer_class = ProyectosSerializer

class CostosViewSet(viewsets.ModelViewSet):
    queryset = Costos.objects.all()
    serializer_class = CostosSerializer

class FacturasViewSet(viewsets.ModelViewSet):
    queryset = Facturas.objects.all()
    serializer_class = FacturasSerializer

class OrdenescompraViewSet(viewsets.ModelViewSet):
    queryset = Ordenescompra.objects.all()
    serializer_class = OrdenescompraSerializer

class PagosViewSet(viewsets.ModelViewSet):
    queryset = Pagos.objects.all()
    serializer_class = PagosSerializer

class ProveedoresViewSet(viewsets.ModelViewSet):
    queryset = Proveedores.objects.all()
    serializer_class = ProveedoresSerializer