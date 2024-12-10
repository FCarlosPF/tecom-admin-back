from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import AsistenciasViewSet

router = DefaultRouter()
router.register(r'asistencias', AsistenciasViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
