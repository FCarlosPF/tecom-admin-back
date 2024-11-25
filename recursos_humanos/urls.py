from django.urls import path
from .views import LoginView, EmpleadoListCreateView, EmpleadoRetrieveUpdateDestroyView, healthcheck

urlpatterns = [
    path('login/', LoginView.as_view(), name='login'),
    path('empleados/', EmpleadoListCreateView.as_view(), name='empleado-list-create'),
    path('empleados/<int:id_empleado>/', EmpleadoRetrieveUpdateDestroyView.as_view(), name='empleado-detail'),
    path("healthcheck", healthcheck, name="healthcheck"),

]