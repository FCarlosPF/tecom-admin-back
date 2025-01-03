from django.urls import path, include
from .views import ChangePasswordView,EmpleadosTareasPendientesListView, VistaEmpleadosTareasListView, LoginView, EmpleadoListCreateView, EmpleadoRetrieveUpdateDestroyView, healthcheck, AreasListCreateView, RolesListCreateView, RolesRetrieveUpdateDestroyView, AreasRetrieveUpdateDestroyView, OficinaViewSet
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenRefreshView

router = DefaultRouter()
router.register(r'oficinas', OficinaViewSet)


urlpatterns = [
    path('login/', LoginView.as_view(), name='login'),
    path('empleados/', EmpleadoListCreateView.as_view(), name='empleado-list-create'),
    path('empleados/<int:id_empleado>/', EmpleadoRetrieveUpdateDestroyView.as_view(), name='empleado-detail'),
    path("healthcheck", healthcheck, name="healthcheck"),
    path('areas/', AreasListCreateView.as_view(), name='areas-list-create'),
    path('areas/<int:pk>/', AreasRetrieveUpdateDestroyView.as_view(), name='areas-retrieve-update-destroy'),
    path('roles/', RolesListCreateView.as_view(), name='roles-list-create'),
    path('roles/<int:pk>/', RolesRetrieveUpdateDestroyView.as_view(), name='roles-retrieve-update-destroy'),
    path('vista-empleados-tareas/', VistaEmpleadosTareasListView.as_view(), name='vista-empleados-tareas-list'),
    path('tareas-pendientes/<int:id_empleado>/', EmpleadosTareasPendientesListView.as_view(), name='tareas-pendientes'),
    path('change-password/', ChangePasswordView.as_view(), name='change-password'),
    path('', include(router.urls)),

]