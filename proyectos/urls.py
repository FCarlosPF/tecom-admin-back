from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ProyectosViewSet, CostosViewSet, FacturasViewSet, OrdenescompraViewSet, PagosViewSet, ProveedoresViewSet

router = DefaultRouter()
router.register(r'proyectos', ProyectosViewSet)
router.register(r'costos', CostosViewSet)
router.register(r'facturas', FacturasViewSet)
router.register(r'ordenescompra', OrdenescompraViewSet)
router.register(r'pagos', PagosViewSet)
router.register(r'proveedores', ProveedoresViewSet)

urlpatterns = [
    path('', include(router.urls)),
]