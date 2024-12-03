from django.db import models
from recursos_humanos.models import Empleados

class Proyectos(models.Model):
    proyecto_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=200)
    descripcion = models.TextField(blank=True, null=True)
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField(blank=True, null=True)
    estado = models.CharField(max_length=50, blank=True, null=True)
    presupuesto = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    responsable_id = models.IntegerField(Empleados, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'proyectos'

class Costos(models.Model):
    costo_id = models.AutoField(primary_key=True)
    descripcion = models.TextField()
    monto = models.DecimalField(max_digits=15, decimal_places=2)
    fecha = models.DateField()
    categoria = models.CharField(max_length=100, blank=True, null=True)
    tipo = models.CharField(max_length=50, blank=True, null=True)
    proyecto = models.ForeignKey('Proyectos', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'costos'


class Facturas(models.Model):
    id_factura = models.AutoField(primary_key=True)
    id_orden = models.ForeignKey('Ordenescompra', models.DO_NOTHING, db_column='id_orden', blank=True, null=True)
    numero_factura = models.CharField(unique=True, max_length=50)
    fecha_emision = models.DateField(blank=True, null=True)
    monto = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    estado_pago = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'facturas'

class Ordenescompra(models.Model):
    id_orden = models.AutoField(primary_key=True)
    id_proyecto = models.ForeignKey('Proyectos', models.DO_NOTHING, db_column='id_proyecto', blank=True, null=True)
    id_proveedor = models.ForeignKey('Proveedores', models.DO_NOTHING, db_column='id_proveedor', blank=True, null=True)
    monto = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    fecha = models.DateField(blank=True, null=True)
    estado = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ordenescompra'

class Pagos(models.Model):
    id_pago = models.AutoField(primary_key=True)
    id_factura = models.ForeignKey(Facturas, models.DO_NOTHING, db_column='id_factura', blank=True, null=True)
    monto = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    fecha_pago = models.DateField(blank=True, null=True)
    metodo_pago = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'pagos'

class Proveedores(models.Model):
    id_proveedor = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=255, blank=True, null=True)
    direccion = models.CharField(max_length=255, blank=True, null=True)
    telefono = models.CharField(max_length=20, blank=True, null=True)
    correo = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'proveedores'