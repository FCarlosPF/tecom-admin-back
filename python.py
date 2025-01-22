import os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'administracion_tecom_back.settings')

from django.contrib.auth.hashers import make_password

nueva_contrasena_hash = make_password("yEnDfHggjF")
print(nueva_contrasena_hash)