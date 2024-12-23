from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import AsistenciasViewSet,NotificacionesViewSet, NotificacionesPorEmpleadoView

router = DefaultRouter()
router.register(r'asistencias', AsistenciasViewSet)
router.register(r'notificaciones', NotificacionesViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('notificaciones/empleado/<int:id_empleado>/', NotificacionesPorEmpleadoView.as_view(), name='notificaciones-por-empleado'),

]
