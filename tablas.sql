--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Ubuntu 17.2-1.pgdg24.04+1)
-- Dumped by pg_dump version 17.2 (Ubuntu 17.2-1.pgdg24.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: evaluaciones; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA evaluaciones;


ALTER SCHEMA evaluaciones OWNER TO postgres;

--
-- Name: permisos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA permisos;


ALTER SCHEMA permisos OWNER TO postgres;

--
-- Name: proyectos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA proyectos;


ALTER SCHEMA proyectos OWNER TO postgres;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: recursos_humanos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA recursos_humanos;


ALTER SCHEMA recursos_humanos OWNER TO postgres;

--
-- Name: sistemas; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sistemas;


ALTER SCHEMA sistemas OWNER TO postgres;

--
-- Name: tareas; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tareas;


ALTER SCHEMA tareas OWNER TO postgres;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: evaluaciones_desempeño; Type: TABLE; Schema: evaluaciones; Owner: postgres
--

CREATE TABLE evaluaciones."evaluaciones_desempeño" (
    evaluacion_id integer NOT NULL,
    empleado_id integer,
    fecha_evaluacion date NOT NULL,
    comentarios text,
    puntuacion numeric(5,2) NOT NULL,
    evaluador_id integer
);


ALTER TABLE evaluaciones."evaluaciones_desempeño" OWNER TO postgres;

--
-- Name: evaluaciones_desempeño_evaluacion_id_seq; Type: SEQUENCE; Schema: evaluaciones; Owner: postgres
--

CREATE SEQUENCE evaluaciones."evaluaciones_desempeño_evaluacion_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE evaluaciones."evaluaciones_desempeño_evaluacion_id_seq" OWNER TO postgres;

--
-- Name: evaluaciones_desempeño_evaluacion_id_seq; Type: SEQUENCE OWNED BY; Schema: evaluaciones; Owner: postgres
--

ALTER SEQUENCE evaluaciones."evaluaciones_desempeño_evaluacion_id_seq" OWNED BY evaluaciones."evaluaciones_desempeño".evaluacion_id;


--
-- Name: solicitudes_permiso; Type: TABLE; Schema: permisos; Owner: postgres
--

CREATE TABLE permisos.solicitudes_permiso (
    permiso_id integer NOT NULL,
    empleado_id integer,
    tipo_permiso integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    estado character varying(20),
    aprobado_por integer,
    comentarios text
);


ALTER TABLE permisos.solicitudes_permiso OWNER TO postgres;

--
-- Name: solicitudes_permiso_permiso_id_seq; Type: SEQUENCE; Schema: permisos; Owner: postgres
--

CREATE SEQUENCE permisos.solicitudes_permiso_permiso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE permisos.solicitudes_permiso_permiso_id_seq OWNER TO postgres;

--
-- Name: solicitudes_permiso_permiso_id_seq; Type: SEQUENCE OWNED BY; Schema: permisos; Owner: postgres
--

ALTER SEQUENCE permisos.solicitudes_permiso_permiso_id_seq OWNED BY permisos.solicitudes_permiso.permiso_id;


--
-- Name: costos; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.costos (
    costo_id integer NOT NULL,
    descripcion text NOT NULL,
    monto numeric(15,2) NOT NULL,
    fecha date NOT NULL,
    categoria character varying(100),
    tipo character varying(50),
    proyecto_id integer,
    proveedor_id integer
);


ALTER TABLE proyectos.costos OWNER TO postgres;

--
-- Name: costos_costo_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.costos_costo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE proyectos.costos_costo_id_seq OWNER TO postgres;

--
-- Name: costos_costo_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.costos_costo_id_seq OWNED BY proyectos.costos.costo_id;


--
-- Name: facturas; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.facturas (
    id_factura integer NOT NULL,
    id_orden integer,
    numero_factura character varying(50) NOT NULL,
    fecha_emision date,
    monto numeric(15,2),
    estado_pago character varying(20) DEFAULT 'Pendiente'::character varying,
    CONSTRAINT facturas_estado_pago_check CHECK (((estado_pago)::text = ANY (ARRAY[('Pendiente'::character varying)::text, ('Pagado'::character varying)::text, ('Parcial'::character varying)::text])))
);


ALTER TABLE proyectos.facturas OWNER TO postgres;

--
-- Name: facturas_id_factura_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.facturas_id_factura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE proyectos.facturas_id_factura_seq OWNER TO postgres;

--
-- Name: facturas_id_factura_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.facturas_id_factura_seq OWNED BY proyectos.facturas.id_factura;


--
-- Name: ordenescompra; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.ordenescompra (
    id_orden integer NOT NULL,
    id_proyecto integer,
    id_proveedor integer,
    monto numeric(15,2),
    fecha date,
    estado character varying(20) DEFAULT 'Pendiente'::character varying,
    CONSTRAINT ordenescompra_estado_check CHECK (((estado)::text = ANY (ARRAY[('Pendiente'::character varying)::text, ('Completado'::character varying)::text, ('Cancelado'::character varying)::text])))
);


ALTER TABLE proyectos.ordenescompra OWNER TO postgres;

--
-- Name: ordenescompra_id_orden_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.ordenescompra_id_orden_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE proyectos.ordenescompra_id_orden_seq OWNER TO postgres;

--
-- Name: ordenescompra_id_orden_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.ordenescompra_id_orden_seq OWNED BY proyectos.ordenescompra.id_orden;


--
-- Name: pagos; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.pagos (
    id_pago integer NOT NULL,
    id_factura integer,
    monto numeric(15,2),
    fecha_pago date,
    metodo_pago character varying(50),
    CONSTRAINT pagos_metodo_pago_check CHECK (((metodo_pago)::text = ANY (ARRAY[('Transferencia'::character varying)::text, ('Efectivo'::character varying)::text, ('Tarjeta'::character varying)::text, ('Cheque'::character varying)::text])))
);


ALTER TABLE proyectos.pagos OWNER TO postgres;

--
-- Name: pagos_id_pago_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.pagos_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE proyectos.pagos_id_pago_seq OWNER TO postgres;

--
-- Name: pagos_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.pagos_id_pago_seq OWNED BY proyectos.pagos.id_pago;


--
-- Name: proveedores; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.proveedores (
    id_proveedor integer NOT NULL,
    nombre character varying(255),
    direccion character varying(255),
    telefono character varying(20),
    correo character varying(255)
);


ALTER TABLE proyectos.proveedores OWNER TO postgres;

--
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.proveedores_id_proveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE proyectos.proveedores_id_proveedor_seq OWNER TO postgres;

--
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.proveedores_id_proveedor_seq OWNED BY proyectos.proveedores.id_proveedor;


--
-- Name: proyectos; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.proyectos (
    proyecto_id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    descripcion text,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    estado character varying(50) DEFAULT 'Activo'::character varying,
    presupuesto numeric(15,2),
    responsable_id integer
);


ALTER TABLE proyectos.proyectos OWNER TO postgres;

--
-- Name: proyectos_proyecto_id_seq; Type: SEQUENCE; Schema: proyectos; Owner: postgres
--

CREATE SEQUENCE proyectos.proyectos_proyecto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE proyectos.proyectos_proyecto_id_seq OWNER TO postgres;

--
-- Name: proyectos_proyecto_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.proyectos_proyecto_id_seq OWNED BY proyectos.proyectos.proyecto_id;


--
-- Name: areas; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.areas (
    area_id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    supervisor_id integer,
    geom public.geometry(Polygon)
);


ALTER TABLE recursos_humanos.areas OWNER TO postgres;

--
-- Name: areas_area_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

CREATE SEQUENCE recursos_humanos.areas_area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE recursos_humanos.areas_area_id_seq OWNER TO postgres;

--
-- Name: areas_area_id_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.areas_area_id_seq OWNED BY recursos_humanos.areas.area_id;


--
-- Name: auth_group; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE recursos_humanos.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE recursos_humanos.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME recursos_humanos.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE recursos_humanos.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE recursos_humanos.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME recursos_humanos.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE recursos_humanos.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE recursos_humanos.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME recursos_humanos.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE recursos_humanos.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE recursos_humanos.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE recursos_humanos.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME recursos_humanos.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE recursos_humanos.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME recursos_humanos.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE recursos_humanos.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE recursos_humanos.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME recursos_humanos.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE recursos_humanos.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE recursos_humanos.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME recursos_humanos.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE recursos_humanos.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE recursos_humanos.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME recursos_humanos.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE recursos_humanos.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE recursos_humanos.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME recursos_humanos.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: empleados; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.empleados (
    id_empleado integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellidos character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    especialidad character varying(50),
    sueldo numeric(10,2),
    activo boolean DEFAULT true,
    foto character varying(100),
    nombre_usuario character varying(100),
    contrasenia text,
    fecha_contratacion date,
    area_id integer,
    rol_id integer,
    geom public.geometry(Point)
);


ALTER TABLE recursos_humanos.empleados OWNER TO postgres;

--
-- Name: empleados_id_empleado_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

CREATE SEQUENCE recursos_humanos.empleados_id_empleado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE recursos_humanos.empleados_id_empleado_seq OWNER TO postgres;

--
-- Name: empleados_id_empleado_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.empleados_id_empleado_seq OWNED BY recursos_humanos.empleados.id_empleado;


--
-- Name: asignaciones_tareas; Type: TABLE; Schema: tareas; Owner: postgres
--

CREATE TABLE tareas.asignaciones_tareas (
    asignacion_id integer NOT NULL,
    tarea_id integer,
    empleado_id integer,
    asignador_id integer
);


ALTER TABLE tareas.asignaciones_tareas OWNER TO postgres;

--
-- Name: tareas; Type: TABLE; Schema: tareas; Owner: postgres
--

CREATE TABLE tareas.tareas (
    tarea_id integer NOT NULL,
    titulo character varying(100) NOT NULL,
    descripcion text,
    fecha_inicio timestamp with time zone NOT NULL,
    fecha_estimada_fin timestamp with time zone,
    fecha_real_fin timestamp with time zone,
    prioridad character varying(20),
    estado character varying(20),
    tiempo_restante_paralizado jsonb,
    tiempo_pasado_paralizado jsonb,
    tarea_padre integer,
    complejidad integer,
    puntos integer,
    proyecto_id integer
);


ALTER TABLE tareas.tareas OWNER TO postgres;

--
-- Name: empleados_tareas_pendientes; Type: VIEW; Schema: recursos_humanos; Owner: postgres
--

CREATE VIEW recursos_humanos.empleados_tareas_pendientes AS
 SELECT e.id_empleado,
    e.nombre,
    e.apellidos,
    e.correo,
    t.tarea_id,
    t.titulo AS tarea_titulo,
    t.descripcion AS tarea_descripcion,
    t.fecha_inicio AS tarea_fecha_inicio,
    t.fecha_estimada_fin AS tarea_fecha_estimada_fin,
    t.estado AS tarea_estado
   FROM ((recursos_humanos.empleados e
     JOIN tareas.asignaciones_tareas at ON ((e.id_empleado = at.empleado_id)))
     JOIN tareas.tareas t ON ((at.tarea_id = t.tarea_id)))
  WHERE ((t.estado)::text = ANY ((ARRAY['Pendiente'::character varying, 'En Progreso'::character varying])::text[]));


ALTER VIEW recursos_humanos.empleados_tareas_pendientes OWNER TO postgres;

--
-- Name: oficina; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.oficina (
    id integer NOT NULL,
    nombre character varying(50),
    geom public.geometry(MultiLineString)
);


ALTER TABLE recursos_humanos.oficina OWNER TO postgres;

--
-- Name: oficina_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

CREATE SEQUENCE recursos_humanos.oficina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE recursos_humanos.oficina_id_seq OWNER TO postgres;

--
-- Name: oficina_id_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.oficina_id_seq OWNED BY recursos_humanos.oficina.id;


--
-- Name: roles; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.roles (
    id_rol integer NOT NULL,
    nombre character varying(50) NOT NULL,
    describcion character varying(500)
);


ALTER TABLE recursos_humanos.roles OWNER TO postgres;

--
-- Name: roles_id_rol_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

CREATE SEQUENCE recursos_humanos.roles_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE recursos_humanos.roles_id_rol_seq OWNER TO postgres;

--
-- Name: roles_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.roles_id_rol_seq OWNED BY recursos_humanos.roles.id_rol;


--
-- Name: solicitudes_permiso; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.solicitudes_permiso (
    permiso_id integer NOT NULL,
    empleado_id integer,
    tipo_permiso integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    estado character varying(20),
    aprobado_por integer,
    comentarios text
);


ALTER TABLE recursos_humanos.solicitudes_permiso OWNER TO postgres;

--
-- Name: solicitudes_permiso_permiso_id_seq; Type: SEQUENCE; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE recursos_humanos.solicitudes_permiso ALTER COLUMN permiso_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME recursos_humanos.solicitudes_permiso_permiso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vista_empleados_tareas; Type: VIEW; Schema: recursos_humanos; Owner: postgres
--

CREATE VIEW recursos_humanos.vista_empleados_tareas AS
 SELECT e.id_empleado,
    e.nombre,
    e.apellidos,
    e.correo,
    e.especialidad,
    e.sueldo,
    e.activo,
    e.foto,
    e.nombre_usuario,
    e.contrasenia,
    e.fecha_contratacion,
    e.area_id,
    e.rol_id,
    e.geom,
    array_agg(DISTINCT p.proyecto_id) AS proyectos_ids,
    count(t.tarea_id) FILTER (WHERE ((t.estado)::text = ANY ((ARRAY['Pendiente'::character varying, 'En Progreso'::character varying])::text[]))) AS cantidad_tareas_pendientes_o_en_progreso
   FROM (((recursos_humanos.empleados e
     LEFT JOIN tareas.asignaciones_tareas at ON ((e.id_empleado = at.empleado_id)))
     LEFT JOIN tareas.tareas t ON ((at.tarea_id = t.tarea_id)))
     LEFT JOIN proyectos.proyectos p ON ((t.proyecto_id = p.proyecto_id)))
  GROUP BY e.id_empleado, e.nombre, e.apellidos, e.correo, e.especialidad, e.sueldo, e.activo, e.foto, e.nombre_usuario, e.contrasenia, e.fecha_contratacion, e.area_id, e.rol_id, e.geom;


ALTER VIEW recursos_humanos.vista_empleados_tareas OWNER TO postgres;

--
-- Name: asistencias; Type: TABLE; Schema: sistemas; Owner: postgres
--

CREATE TABLE sistemas.asistencias (
    asistencia_id integer NOT NULL,
    empleado_id integer,
    fecha date NOT NULL,
    hora_entrada time without time zone,
    hora_salida time without time zone,
    estado character varying(20),
    comentarios text
);


ALTER TABLE sistemas.asistencias OWNER TO postgres;

--
-- Name: asistencias_asistencia_id_seq; Type: SEQUENCE; Schema: sistemas; Owner: postgres
--

CREATE SEQUENCE sistemas.asistencias_asistencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sistemas.asistencias_asistencia_id_seq OWNER TO postgres;

--
-- Name: asistencias_asistencia_id_seq; Type: SEQUENCE OWNED BY; Schema: sistemas; Owner: postgres
--

ALTER SEQUENCE sistemas.asistencias_asistencia_id_seq OWNED BY sistemas.asistencias.asistencia_id;


--
-- Name: asignaciones_tareas_asignacion_id_seq; Type: SEQUENCE; Schema: tareas; Owner: postgres
--

CREATE SEQUENCE tareas.asignaciones_tareas_asignacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE tareas.asignaciones_tareas_asignacion_id_seq OWNER TO postgres;

--
-- Name: asignaciones_tareas_asignacion_id_seq; Type: SEQUENCE OWNED BY; Schema: tareas; Owner: postgres
--

ALTER SEQUENCE tareas.asignaciones_tareas_asignacion_id_seq OWNED BY tareas.asignaciones_tareas.asignacion_id;


--
-- Name: tareas_tarea_id_seq; Type: SEQUENCE; Schema: tareas; Owner: postgres
--

CREATE SEQUENCE tareas.tareas_tarea_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE tareas.tareas_tarea_id_seq OWNER TO postgres;

--
-- Name: tareas_tarea_id_seq; Type: SEQUENCE OWNED BY; Schema: tareas; Owner: postgres
--

ALTER SEQUENCE tareas.tareas_tarea_id_seq OWNED BY tareas.tareas.tarea_id;


--
-- Name: vista_empleados_tareas; Type: VIEW; Schema: tareas; Owner: postgres
--

CREATE VIEW tareas.vista_empleados_tareas AS
 SELECT e.id_empleado,
    e.nombre AS nombre_empleado,
    e.apellidos AS apellido_empleado,
    t.tarea_id,
    t.titulo AS titulo_tarea,
    t.descripcion AS descripcion_tarea,
    t.fecha_inicio,
    t.fecha_estimada_fin,
    t.fecha_real_fin,
    t.estado AS estado_tarea
   FROM ((recursos_humanos.empleados e
     LEFT JOIN tareas.asignaciones_tareas at ON ((e.id_empleado = at.empleado_id)))
     LEFT JOIN tareas.tareas t ON ((at.tarea_id = t.tarea_id)));


ALTER VIEW tareas.vista_empleados_tareas OWNER TO postgres;

--
-- Name: evaluaciones_desempeño evaluacion_id; Type: DEFAULT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño" ALTER COLUMN evaluacion_id SET DEFAULT nextval('evaluaciones."evaluaciones_desempeño_evaluacion_id_seq"'::regclass);


--
-- Name: solicitudes_permiso permiso_id; Type: DEFAULT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso ALTER COLUMN permiso_id SET DEFAULT nextval('permisos.solicitudes_permiso_permiso_id_seq'::regclass);


--
-- Name: costos costo_id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos ALTER COLUMN costo_id SET DEFAULT nextval('proyectos.costos_costo_id_seq'::regclass);


--
-- Name: facturas id_factura; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas ALTER COLUMN id_factura SET DEFAULT nextval('proyectos.facturas_id_factura_seq'::regclass);


--
-- Name: ordenescompra id_orden; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra ALTER COLUMN id_orden SET DEFAULT nextval('proyectos.ordenescompra_id_orden_seq'::regclass);


--
-- Name: pagos id_pago; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.pagos ALTER COLUMN id_pago SET DEFAULT nextval('proyectos.pagos_id_pago_seq'::regclass);


--
-- Name: proveedores id_proveedor; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proveedores ALTER COLUMN id_proveedor SET DEFAULT nextval('proyectos.proveedores_id_proveedor_seq'::regclass);


--
-- Name: proyectos proyecto_id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos ALTER COLUMN proyecto_id SET DEFAULT nextval('proyectos.proyectos_proyecto_id_seq'::regclass);


--
-- Name: areas area_id; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.areas ALTER COLUMN area_id SET DEFAULT nextval('recursos_humanos.areas_area_id_seq'::regclass);


--
-- Name: empleados id_empleado; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados ALTER COLUMN id_empleado SET DEFAULT nextval('recursos_humanos.empleados_id_empleado_seq'::regclass);


--
-- Name: oficina id; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.oficina ALTER COLUMN id SET DEFAULT nextval('recursos_humanos.oficina_id_seq'::regclass);


--
-- Name: roles id_rol; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.roles ALTER COLUMN id_rol SET DEFAULT nextval('recursos_humanos.roles_id_rol_seq'::regclass);


--
-- Name: asistencias asistencia_id; Type: DEFAULT; Schema: sistemas; Owner: postgres
--

ALTER TABLE ONLY sistemas.asistencias ALTER COLUMN asistencia_id SET DEFAULT nextval('sistemas.asistencias_asistencia_id_seq'::regclass);


--
-- Name: asignaciones_tareas asignacion_id; Type: DEFAULT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas ALTER COLUMN asignacion_id SET DEFAULT nextval('tareas.asignaciones_tareas_asignacion_id_seq'::regclass);


--
-- Name: tareas tarea_id; Type: DEFAULT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.tareas ALTER COLUMN tarea_id SET DEFAULT nextval('tareas.tareas_tarea_id_seq'::regclass);


--
-- Name: evaluaciones_desempeño evaluaciones_desempeño_pkey; Type: CONSTRAINT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño"
    ADD CONSTRAINT "evaluaciones_desempeño_pkey" PRIMARY KEY (evaluacion_id);


--
-- Name: solicitudes_permiso solicitudes_permiso_pkey; Type: CONSTRAINT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_pkey PRIMARY KEY (permiso_id);


--
-- Name: costos costos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos
    ADD CONSTRAINT costos_pkey PRIMARY KEY (costo_id);


--
-- Name: facturas facturas_numero_factura_key; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas
    ADD CONSTRAINT facturas_numero_factura_key UNIQUE (numero_factura);


--
-- Name: facturas facturas_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas
    ADD CONSTRAINT facturas_pkey PRIMARY KEY (id_factura);


--
-- Name: ordenescompra ordenescompra_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra
    ADD CONSTRAINT ordenescompra_pkey PRIMARY KEY (id_orden);


--
-- Name: pagos pagos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id_pago);


--
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);


--
-- Name: proyectos proyectos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos
    ADD CONSTRAINT proyectos_pkey PRIMARY KEY (proyecto_id);


--
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (area_id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: empleados empleados_correo_key; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT empleados_correo_key UNIQUE (correo);


--
-- Name: empleados empleados_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (id_empleado);


--
-- Name: oficina oficina_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.oficina
    ADD CONSTRAINT oficina_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);


--
-- Name: solicitudes_permiso solicitudes_permiso_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_pkey PRIMARY KEY (permiso_id);


--
-- Name: asistencias asistencias_pkey; Type: CONSTRAINT; Schema: sistemas; Owner: postgres
--

ALTER TABLE ONLY sistemas.asistencias
    ADD CONSTRAINT asistencias_pkey PRIMARY KEY (asistencia_id);


--
-- Name: asignaciones_tareas asignaciones_tareas_pkey; Type: CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_pkey PRIMARY KEY (asignacion_id);


--
-- Name: tareas tareas_pkey; Type: CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.tareas
    ADD CONSTRAINT tareas_pkey PRIMARY KEY (tarea_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON recursos_humanos.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON recursos_humanos.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON recursos_humanos.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON recursos_humanos.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON recursos_humanos.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON recursos_humanos.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON recursos_humanos.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON recursos_humanos.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON recursos_humanos.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON recursos_humanos.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON recursos_humanos.django_admin_log USING btree (user_id);


--
-- Name: idx_empleados_activo; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX idx_empleados_activo ON recursos_humanos.empleados USING btree (activo);


--
-- Name: idx_empleados_area_id; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX idx_empleados_area_id ON recursos_humanos.empleados USING btree (area_id);


--
-- Name: idx_empleados_geom; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX idx_empleados_geom ON recursos_humanos.empleados USING gist (geom);


--
-- Name: idx_empleados_rol_id; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX idx_empleados_rol_id ON recursos_humanos.empleados USING btree (rol_id);


--
-- Name: idx_asignaciones_tareas_asignador_id; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_asignaciones_tareas_asignador_id ON tareas.asignaciones_tareas USING btree (asignador_id);


--
-- Name: idx_asignaciones_tareas_empleado_id; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_asignaciones_tareas_empleado_id ON tareas.asignaciones_tareas USING btree (empleado_id);


--
-- Name: idx_asignaciones_tareas_tarea_id; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_asignaciones_tareas_tarea_id ON tareas.asignaciones_tareas USING btree (tarea_id);


--
-- Name: idx_tareas_estado; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_tareas_estado ON tareas.tareas USING btree (estado);


--
-- Name: idx_tareas_fecha_estimada_fin; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_tareas_fecha_estimada_fin ON tareas.tareas USING btree (fecha_estimada_fin);


--
-- Name: idx_tareas_fecha_inicio; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_tareas_fecha_inicio ON tareas.tareas USING btree (fecha_inicio);


--
-- Name: idx_tareas_tarea_padre; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_tareas_tarea_padre ON tareas.tareas USING btree (tarea_padre);


--
-- Name: evaluaciones_desempeño evaluaciones_desempeño_empleado_id_fkey; Type: FK CONSTRAINT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño"
    ADD CONSTRAINT "evaluaciones_desempeño_empleado_id_fkey" FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- Name: evaluaciones_desempeño evaluaciones_desempeño_evaluador_id_fkey; Type: FK CONSTRAINT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño"
    ADD CONSTRAINT "evaluaciones_desempeño_evaluador_id_fkey" FOREIGN KEY (evaluador_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- Name: solicitudes_permiso solicitudes_permiso_aprobado_por_fkey; Type: FK CONSTRAINT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_aprobado_por_fkey FOREIGN KEY (aprobado_por) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- Name: solicitudes_permiso solicitudes_permiso_empleado_id_fkey; Type: FK CONSTRAINT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- Name: costos costos_proveedor_id_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos
    ADD CONSTRAINT costos_proveedor_id_fkey FOREIGN KEY (proveedor_id) REFERENCES proyectos.proveedores(id_proveedor);


--
-- Name: facturas facturas_id_orden_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas
    ADD CONSTRAINT facturas_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES proyectos.ordenescompra(id_orden) ON DELETE CASCADE;


--
-- Name: costos fk_proyecto; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos
    ADD CONSTRAINT fk_proyecto FOREIGN KEY (proyecto_id) REFERENCES proyectos.proyectos(proyecto_id) ON DELETE SET NULL;


--
-- Name: proyectos fk_responsable; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos
    ADD CONSTRAINT fk_responsable FOREIGN KEY (responsable_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- Name: ordenescompra ordenescompra_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra
    ADD CONSTRAINT ordenescompra_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES proyectos.proveedores(id_proveedor) ON DELETE CASCADE;


--
-- Name: ordenescompra ordenescompra_id_proyecto_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra
    ADD CONSTRAINT ordenescompra_id_proyecto_fkey FOREIGN KEY (id_proyecto) REFERENCES proyectos.proyectos(proyecto_id) ON DELETE CASCADE;


--
-- Name: pagos pagos_id_factura_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.pagos
    ADD CONSTRAINT pagos_id_factura_fkey FOREIGN KEY (id_factura) REFERENCES proyectos.facturas(id_factura) ON DELETE CASCADE;


--
-- Name: areas areas_supervisor_id_fkey; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.areas
    ADD CONSTRAINT areas_supervisor_id_fkey FOREIGN KEY (supervisor_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES recursos_humanos.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES recursos_humanos.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES recursos_humanos.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES recursos_humanos.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES recursos_humanos.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES recursos_humanos.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES recursos_humanos.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES recursos_humanos.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES recursos_humanos.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: empleados fk_area_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT fk_area_id FOREIGN KEY (area_id) REFERENCES recursos_humanos.areas(area_id) NOT VALID;


--
-- Name: empleados fk_rol_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT fk_rol_id FOREIGN KEY (rol_id) REFERENCES recursos_humanos.roles(id_rol) NOT VALID;


--
-- Name: asistencias asistencias_empleado_id_fkey; Type: FK CONSTRAINT; Schema: sistemas; Owner: postgres
--

ALTER TABLE ONLY sistemas.asistencias
    ADD CONSTRAINT asistencias_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- Name: asignaciones_tareas asignaciones_tareas_asignador_id_fkey; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_asignador_id_fkey FOREIGN KEY (asignador_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- Name: asignaciones_tareas asignaciones_tareas_empleado_id_fkey; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- Name: asignaciones_tareas asignaciones_tareas_tarea_id_fkey; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_tarea_id_fkey FOREIGN KEY (tarea_id) REFERENCES tareas.tareas(tarea_id) ON DELETE CASCADE;


--
-- Name: tareas fk_tarea_padre; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.tareas
    ADD CONSTRAINT fk_tarea_padre FOREIGN KEY (tarea_padre) REFERENCES tareas.tareas(tarea_id) ON DELETE CASCADE;


--
-- Name: tareas tareas_proyecto_id_fkey; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.tareas
    ADD CONSTRAINT tareas_proyecto_id_fkey FOREIGN KEY (proyecto_id) REFERENCES proyectos.proyectos(proyecto_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

