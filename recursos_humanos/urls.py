from django.urls import path, include
from .views import PasswordResetRequestView,PasswordResetConfirmView,EmpleadosViewSet,EmpleadosTareasPendientesListView, VistaEmpleadosTareasListView, LoginView, AreasListCreateView, RolesListCreateView, RolesRetrieveUpdateDestroyView, AreasRetrieveUpdateDestroyView, OficinaViewSet
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenRefreshView

router = DefaultRouter()
router.register(r'oficinas', OficinaViewSet)
router.register(r'empleados', EmpleadosViewSet)


urlpatterns = [
    path('login/', LoginView.as_view(), name='login'),
    path('areas/', AreasListCreateView.as_view(), name='areas-list-create'),
    path('areas/<int:pk>/', AreasRetrieveUpdateDestroyView.as_view(), name='areas-retrieve-update-destroy'),
    path('roles/', RolesListCreateView.as_view(), name='roles-list-create'),
    path('roles/<int:pk>/', RolesRetrieveUpdateDestroyView.as_view(), name='roles-retrieve-update-destroy'),
    path('vista-empleados-tareas/', VistaEmpleadosTareasListView.as_view(), name='vista-empleados-tareas-list'),
    path('tareas-pendientes/<int:id_empleado>/', EmpleadosTareasPendientesListView.as_view(), name='tareas-pendientes'),
    path('password-reset/', PasswordResetRequestView.as_view(), name='password-reset-request'),
    path('reset-password/', PasswordResetConfirmView.as_view(), name='password-reset-confirm'),
    path('', include(router.urls)),
    path('', include(router.urls)),

]