"""
URL configuration for administracion_tecom_back project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.shortcuts import render
from django.conf import settings
from django.http import HttpResponse
import os
from django.conf.urls.static import static

def index(request):
    with open(os.path.join(settings.BASE_DIR, 'templates/.next/server/app/index.html'), 'r') as f:
        return HttpResponse(f.read())

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('recursos_humanos.urls')),  # Incluye las URLs de tu aplicación
    path('api/', include('tareas.urls')),  # Incluye las URLs de tu aplicación
    path('api/', include('sistemas.urls')),  # Incluye las URLs de tu aplicación
    path('api/', include('proyectos.urls')),  # Incluye las URLs de tu aplicación
    path('', index, name='index'),  # Sirve la aplicación React como la raíz

]+ static(settings.STATIC_URL, document_root=os.path.join(settings.BASE_DIR, 'templates/.next/static'))
