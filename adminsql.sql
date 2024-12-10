--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Ubuntu 17.2-1.pgdg24.04+1)
-- Dumped by pg_dump version 17.2 (Ubuntu 17.2-1.pgdg24.04+1)

-- Started on 2024-12-04 15:07:16 -05

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
-- TOC entry 7 (class 2615 OID 18736)
-- Name: evaluaciones; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA evaluaciones;


ALTER SCHEMA evaluaciones OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 18737)
-- Name: permisos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA permisos;


ALTER SCHEMA permisos OWNER TO postgres;

--
-- TOC entry 9 (class 2615 OID 18738)
-- Name: proyectos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA proyectos;


ALTER SCHEMA proyectos OWNER TO postgres;

--
-- TOC entry 10 (class 2615 OID 18739)
-- Name: recursos_humanos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA recursos_humanos;


ALTER SCHEMA recursos_humanos OWNER TO postgres;

--
-- TOC entry 11 (class 2615 OID 18740)
-- Name: sistemas; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sistemas;


ALTER SCHEMA sistemas OWNER TO postgres;

--
-- TOC entry 12 (class 2615 OID 18741)
-- Name: tareas; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tareas;


ALTER SCHEMA tareas OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 18742)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4616 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 19814)
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
-- TOC entry 230 (class 1259 OID 19819)
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
-- TOC entry 4617 (class 0 OID 0)
-- Dependencies: 230
-- Name: evaluaciones_desempeño_evaluacion_id_seq; Type: SEQUENCE OWNED BY; Schema: evaluaciones; Owner: postgres
--

ALTER SEQUENCE evaluaciones."evaluaciones_desempeño_evaluacion_id_seq" OWNED BY evaluaciones."evaluaciones_desempeño".evaluacion_id;


--
-- TOC entry 231 (class 1259 OID 19820)
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
-- TOC entry 232 (class 1259 OID 19825)
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
-- TOC entry 4618 (class 0 OID 0)
-- Dependencies: 232
-- Name: solicitudes_permiso_permiso_id_seq; Type: SEQUENCE OWNED BY; Schema: permisos; Owner: postgres
--

ALTER SEQUENCE permisos.solicitudes_permiso_permiso_id_seq OWNED BY permisos.solicitudes_permiso.permiso_id;


--
-- TOC entry 233 (class 1259 OID 19826)
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
-- TOC entry 234 (class 1259 OID 19831)
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
-- TOC entry 4619 (class 0 OID 0)
-- Dependencies: 234
-- Name: costos_costo_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.costos_costo_id_seq OWNED BY proyectos.costos.costo_id;


--
-- TOC entry 274 (class 1259 OID 24787)
-- Name: facturas; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.facturas (
    id_factura integer NOT NULL,
    id_orden integer,
    numero_factura character varying(50) NOT NULL,
    fecha_emision date,
    monto numeric(15,2),
    estado_pago character varying(20) DEFAULT 'Pendiente'::character varying,
    CONSTRAINT facturas_estado_pago_check CHECK (((estado_pago)::text = ANY ((ARRAY['Pendiente'::character varying, 'Pagado'::character varying, 'Parcial'::character varying])::text[])))
);


ALTER TABLE proyectos.facturas OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 24786)
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
-- TOC entry 4620 (class 0 OID 0)
-- Dependencies: 273
-- Name: facturas_id_factura_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.facturas_id_factura_seq OWNED BY proyectos.facturas.id_factura;


--
-- TOC entry 272 (class 1259 OID 24768)
-- Name: ordenescompra; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.ordenescompra (
    id_orden integer NOT NULL,
    id_proyecto integer,
    id_proveedor integer,
    monto numeric(15,2),
    fecha date,
    estado character varying(20) DEFAULT 'Pendiente'::character varying,
    CONSTRAINT ordenescompra_estado_check CHECK (((estado)::text = ANY ((ARRAY['Pendiente'::character varying, 'Completado'::character varying, 'Cancelado'::character varying])::text[])))
);


ALTER TABLE proyectos.ordenescompra OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 24767)
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
-- TOC entry 4621 (class 0 OID 0)
-- Dependencies: 271
-- Name: ordenescompra_id_orden_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.ordenescompra_id_orden_seq OWNED BY proyectos.ordenescompra.id_orden;


--
-- TOC entry 276 (class 1259 OID 24803)
-- Name: pagos; Type: TABLE; Schema: proyectos; Owner: postgres
--

CREATE TABLE proyectos.pagos (
    id_pago integer NOT NULL,
    id_factura integer,
    monto numeric(15,2),
    fecha_pago date,
    metodo_pago character varying(50),
    CONSTRAINT pagos_metodo_pago_check CHECK (((metodo_pago)::text = ANY ((ARRAY['Transferencia'::character varying, 'Efectivo'::character varying, 'Tarjeta'::character varying, 'Cheque'::character varying])::text[])))
);


ALTER TABLE proyectos.pagos OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 24802)
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
-- TOC entry 4622 (class 0 OID 0)
-- Dependencies: 275
-- Name: pagos_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.pagos_id_pago_seq OWNED BY proyectos.pagos.id_pago;


--
-- TOC entry 270 (class 1259 OID 24735)
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
-- TOC entry 269 (class 1259 OID 24734)
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
-- TOC entry 4623 (class 0 OID 0)
-- Dependencies: 269
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.proveedores_id_proveedor_seq OWNED BY proyectos.proveedores.id_proveedor;


--
-- TOC entry 235 (class 1259 OID 19832)
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
-- TOC entry 236 (class 1259 OID 19838)
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
-- TOC entry 4624 (class 0 OID 0)
-- Dependencies: 236
-- Name: proyectos_proyecto_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.proyectos_proyecto_id_seq OWNED BY proyectos.proyectos.proyecto_id;


--
-- TOC entry 237 (class 1259 OID 19839)
-- Name: areas; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.areas (
    area_id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    supervisor_id integer,
    geom public.geometry(Polygon,4326)
);


ALTER TABLE recursos_humanos.areas OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 19842)
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
-- TOC entry 4625 (class 0 OID 0)
-- Dependencies: 238
-- Name: areas_area_id_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.areas_area_id_seq OWNED BY recursos_humanos.areas.area_id;


--
-- TOC entry 254 (class 1259 OID 24599)
-- Name: auth_group; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE recursos_humanos.auth_group OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 24598)
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
-- TOC entry 256 (class 1259 OID 24607)
-- Name: auth_group_permissions; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE recursos_humanos.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 24606)
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
-- TOC entry 252 (class 1259 OID 24593)
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
-- TOC entry 251 (class 1259 OID 24592)
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
-- TOC entry 258 (class 1259 OID 24613)
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
-- TOC entry 260 (class 1259 OID 24621)
-- Name: auth_user_groups; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE recursos_humanos.auth_user_groups OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 24620)
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
-- TOC entry 257 (class 1259 OID 24612)
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
-- TOC entry 262 (class 1259 OID 24627)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE recursos_humanos.auth_user_user_permissions OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 24626)
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
-- TOC entry 264 (class 1259 OID 24685)
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
-- TOC entry 263 (class 1259 OID 24684)
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
-- TOC entry 250 (class 1259 OID 24585)
-- Name: django_content_type; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE recursos_humanos.django_content_type OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 24584)
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
-- TOC entry 268 (class 1259 OID 24724)
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
-- TOC entry 267 (class 1259 OID 24723)
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
-- TOC entry 239 (class 1259 OID 19843)
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
    geom public.geometry(Point,4326)
);


ALTER TABLE recursos_humanos.empleados OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 19849)
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
-- TOC entry 4626 (class 0 OID 0)
-- Dependencies: 240
-- Name: empleados_id_empleado_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.empleados_id_empleado_seq OWNED BY recursos_humanos.empleados.id_empleado;


--
-- TOC entry 241 (class 1259 OID 19850)
-- Name: roles; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.roles (
    id_rol integer NOT NULL,
    nombre character varying(50) NOT NULL,
    describcion character varying(500)
);


ALTER TABLE recursos_humanos.roles OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 19855)
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
-- TOC entry 4627 (class 0 OID 0)
-- Dependencies: 242
-- Name: roles_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.roles_id_rol_seq OWNED BY recursos_humanos.roles.id_rol;


--
-- TOC entry 266 (class 1259 OID 24714)
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
-- TOC entry 265 (class 1259 OID 24713)
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
-- TOC entry 243 (class 1259 OID 19856)
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
-- TOC entry 244 (class 1259 OID 19861)
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
-- TOC entry 4628 (class 0 OID 0)
-- Dependencies: 244
-- Name: asistencias_asistencia_id_seq; Type: SEQUENCE OWNED BY; Schema: sistemas; Owner: postgres
--

ALTER SEQUENCE sistemas.asistencias_asistencia_id_seq OWNED BY sistemas.asistencias.asistencia_id;


--
-- TOC entry 245 (class 1259 OID 19862)
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
-- TOC entry 246 (class 1259 OID 19865)
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
-- TOC entry 4629 (class 0 OID 0)
-- Dependencies: 246
-- Name: asignaciones_tareas_asignacion_id_seq; Type: SEQUENCE OWNED BY; Schema: tareas; Owner: postgres
--

ALTER SEQUENCE tareas.asignaciones_tareas_asignacion_id_seq OWNED BY tareas.asignaciones_tareas.asignacion_id;


--
-- TOC entry 247 (class 1259 OID 19866)
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
    puntos integer
);


ALTER TABLE tareas.tareas OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 19871)
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
-- TOC entry 4630 (class 0 OID 0)
-- Dependencies: 248
-- Name: tareas_tarea_id_seq; Type: SEQUENCE OWNED BY; Schema: tareas; Owner: postgres
--

ALTER SEQUENCE tareas.tareas_tarea_id_seq OWNED BY tareas.tareas.tarea_id;


--
-- TOC entry 4283 (class 2604 OID 19872)
-- Name: evaluaciones_desempeño evaluacion_id; Type: DEFAULT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño" ALTER COLUMN evaluacion_id SET DEFAULT nextval('evaluaciones."evaluaciones_desempeño_evaluacion_id_seq"'::regclass);


--
-- TOC entry 4284 (class 2604 OID 19873)
-- Name: solicitudes_permiso permiso_id; Type: DEFAULT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso ALTER COLUMN permiso_id SET DEFAULT nextval('permisos.solicitudes_permiso_permiso_id_seq'::regclass);


--
-- TOC entry 4285 (class 2604 OID 19874)
-- Name: costos costo_id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos ALTER COLUMN costo_id SET DEFAULT nextval('proyectos.costos_costo_id_seq'::regclass);


--
-- TOC entry 4298 (class 2604 OID 24790)
-- Name: facturas id_factura; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas ALTER COLUMN id_factura SET DEFAULT nextval('proyectos.facturas_id_factura_seq'::regclass);


--
-- TOC entry 4296 (class 2604 OID 24771)
-- Name: ordenescompra id_orden; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra ALTER COLUMN id_orden SET DEFAULT nextval('proyectos.ordenescompra_id_orden_seq'::regclass);


--
-- TOC entry 4300 (class 2604 OID 24806)
-- Name: pagos id_pago; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.pagos ALTER COLUMN id_pago SET DEFAULT nextval('proyectos.pagos_id_pago_seq'::regclass);


--
-- TOC entry 4295 (class 2604 OID 24738)
-- Name: proveedores id_proveedor; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proveedores ALTER COLUMN id_proveedor SET DEFAULT nextval('proyectos.proveedores_id_proveedor_seq'::regclass);


--
-- TOC entry 4286 (class 2604 OID 19875)
-- Name: proyectos proyecto_id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos ALTER COLUMN proyecto_id SET DEFAULT nextval('proyectos.proyectos_proyecto_id_seq'::regclass);


--
-- TOC entry 4288 (class 2604 OID 19876)
-- Name: areas area_id; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.areas ALTER COLUMN area_id SET DEFAULT nextval('recursos_humanos.areas_area_id_seq'::regclass);


--
-- TOC entry 4289 (class 2604 OID 19877)
-- Name: empleados id_empleado; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados ALTER COLUMN id_empleado SET DEFAULT nextval('recursos_humanos.empleados_id_empleado_seq'::regclass);


--
-- TOC entry 4291 (class 2604 OID 19878)
-- Name: roles id_rol; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.roles ALTER COLUMN id_rol SET DEFAULT nextval('recursos_humanos.roles_id_rol_seq'::regclass);


--
-- TOC entry 4292 (class 2604 OID 19879)
-- Name: asistencias asistencia_id; Type: DEFAULT; Schema: sistemas; Owner: postgres
--

ALTER TABLE ONLY sistemas.asistencias ALTER COLUMN asistencia_id SET DEFAULT nextval('sistemas.asistencias_asistencia_id_seq'::regclass);


--
-- TOC entry 4293 (class 2604 OID 19880)
-- Name: asignaciones_tareas asignacion_id; Type: DEFAULT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas ALTER COLUMN asignacion_id SET DEFAULT nextval('tareas.asignaciones_tareas_asignacion_id_seq'::regclass);


--
-- TOC entry 4294 (class 2604 OID 19881)
-- Name: tareas tarea_id; Type: DEFAULT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.tareas ALTER COLUMN tarea_id SET DEFAULT nextval('tareas.tareas_tarea_id_seq'::regclass);


--
-- TOC entry 4563 (class 0 OID 19814)
-- Dependencies: 229
-- Data for Name: evaluaciones_desempeño; Type: TABLE DATA; Schema: evaluaciones; Owner: postgres
--

COPY evaluaciones."evaluaciones_desempeño" (evaluacion_id, empleado_id, fecha_evaluacion, comentarios, puntuacion, evaluador_id) FROM stdin;
\.


--
-- TOC entry 4565 (class 0 OID 19820)
-- Dependencies: 231
-- Data for Name: solicitudes_permiso; Type: TABLE DATA; Schema: permisos; Owner: postgres
--

COPY permisos.solicitudes_permiso (permiso_id, empleado_id, tipo_permiso, fecha_inicio, fecha_fin, estado, aprobado_por, comentarios) FROM stdin;
\.


--
-- TOC entry 4567 (class 0 OID 19826)
-- Dependencies: 233
-- Data for Name: costos; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.costos (costo_id, descripcion, monto, fecha, categoria, tipo, proyecto_id, proveedor_id) FROM stdin;
2	Pago de servicios de consultoría	15000.75	2024-12-02	Servicios	Variable	2	3
3	Adquisición de equipo de oficina	1200.40	2024-12-03	Equipos	Fijo	3	4
4	Gastos en transporte y logística	3000.60	2024-12-04	Logística	Variable	4	5
5	Pago de licencias de software	2500.00	2024-12-05	Tecnología	Fijo	5	6
6	Costo de subcontratación de personal	8500.25	2024-12-06	Servicios	Variable	6	7
7	Materiales de construcción para obra X	6400.90	2024-12-07	Materiales	Fijo	7	8
8	Gastos operativos en proyecto Y	11200.35	2024-12-08	Operativos	Variable	8	9
9	Pago de alquiler de equipos	5300.50	2024-12-09	Equipos	Fijo	9	10
10	Costo de servicios profesionales externos	7700.60	2024-12-10	Servicios	Variable	10	1
1	Costo de materiales para construcción	6000.00	2024-12-01	Materiales	Fijo	1	2
\.


--
-- TOC entry 4608 (class 0 OID 24787)
-- Dependencies: 274
-- Data for Name: facturas; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.facturas (id_factura, id_orden, numero_factura, fecha_emision, monto, estado_pago) FROM stdin;
22	4	FAC-2024-0004	2024-12-04	1800.25	Pagado
23	5	FAC-2024-0005	2024-12-05	950.00	Pendiente
24	6	FAC-2024-0006	2024-12-06	2200.40	Pagado
25	7	FAC-2024-0007	2024-12-07	1700.60	Pendiente
26	8	FAC-2024-0008	2024-12-08	1400.30	Pagado
27	9	FAC-2024-0009	2024-12-09	2000.15	Pendiente
21	3	FAC-2024-0003	2024-12-03	1300.00	Pendiente
28	10	FAC-2024-0010	2024-12-10	1700.00	Pagado
\.


--
-- TOC entry 4606 (class 0 OID 24768)
-- Dependencies: 272
-- Data for Name: ordenescompra; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.ordenescompra (id_orden, id_proyecto, id_proveedor, monto, fecha, estado) FROM stdin;
4	2	5	15000.75	2024-12-02	Completado
5	3	4	7500.60	2024-12-03	Pendiente
6	1	2	12000.40	2024-12-04	Completado
7	4	6	3200.00	2024-12-05	Pendiente
8	5	7	8500.25	2024-12-06	Completado
9	3	1	6400.90	2024-12-07	Pendiente
10	2	3	22000.35	2024-12-08	Completado
11	6	8	11250.50	2024-12-09	Pendiente
12	7	9	9800.60	2024-12-10	Completado
3	1	3	5001.00	2024-12-01	Completado
\.


--
-- TOC entry 4610 (class 0 OID 24803)
-- Dependencies: 276
-- Data for Name: pagos; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.pagos (id_pago, id_factura, monto, fecha_pago, metodo_pago) FROM stdin;
44	23	8500.25	2024-12-06	Efectivo
45	24	6400.90	2024-12-07	Cheque
46	25	22000.35	2024-12-08	Transferencia
47	26	11250.50	2024-12-09	Tarjeta
48	27	9800.60	2024-12-10	Efectivo
42	21	1300.00	2024-12-04	Transferencia
\.


--
-- TOC entry 4604 (class 0 OID 24735)
-- Dependencies: 270
-- Data for Name: proveedores; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.proveedores (id_proveedor, nombre, direccion, telefono, correo) FROM stdin;
1	Proveedor A	Calle Ficticia 123, Lima	987654321	contacto@proveedora.com
2	Proveedor B	Avenida Siempre Viva 456, Lima	987654322	ventas@proveedorb.com
3	Proveedor C	Jirón de la Unión 789, Lima	987654323	soporte@proveedorc.com
4	Proveedor D	Calle Los Olivos 234, Lima	987654324	info@proveedord.com
5	Proveedor E	Avenida Pardo 567, Lima	987654325	atencion@proveedore.com
6	Proveedor F	Calle San Martín 890, Lima	987654326	servicios@proveedorf.com
7	Proveedor G	Jirón Huancavelica 112, Lima	987654327	contacto@proveedorg.com
8	Proveedor H	Avenida Grau 334, Lima	987654328	ventas@proveedorh.com
9	Proveedor I	Calle de la Libertad 456, Lima	987654329	soporte@proveedori.com
10	Proveedor J	Jirón Arequipa 678, Lima	987654330	informes@proveedorj.com
11	Proveedor A	Calle Ficticia 123, Lima	987654321	contacto@proveedora.com
12	Proveedor B	Avenida Siempre Viva 456, Lima	987654322	ventas@proveedorb.com
13	Proveedor C	Jirón de la Unión 789, Lima	987654323	soporte@proveedorc.com
14	Proveedor D	Calle Los Olivos 234, Lima	987654324	info@proveedord.com
15	Proveedor E	Avenida Pardo 567, Lima	987654325	atencion@proveedore.com
16	Proveedor F	Calle San Martín 890, Lima	987654326	servicios@proveedorf.com
17	Proveedor G	Jirón Huancavelica 112, Lima	987654327	contacto@proveedorg.com
18	Proveedor H	Avenida Grau 334, Lima	987654328	ventas@proveedorh.com
19	Proveedor I	Calle de la Libertad 456, Lima	987654329	soporte@proveedori.com
20	Proveedor J	Jirón Arequipa 678, Lima	987654330	informes@proveedorj.com
\.


--
-- TOC entry 4569 (class 0 OID 19832)
-- Dependencies: 235
-- Data for Name: proyectos; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.proyectos (proyecto_id, nombre, descripcion, fecha_inicio, fecha_fin, estado, presupuesto, responsable_id) FROM stdin;
2	Proyecto Beta	Desarrollo de una plataforma web para gestión empresarial.	2024-02-01	2024-08-30	Planificado	200000.00	2
3	Proyecto Gamma	Investigación en IA para automatización de procesos.	2024-03-10	2024-12-01	En progreso	250000.00	3
4	Proyecto Delta	Implementación de soluciones en la nube para almacenamiento seguro.	2024-04-20	2024-11-10	En progreso	100000.00	6
5	Proyecto Epsilon	Rediseño de la red interna para mejorar la seguridad.	2024-05-05	2024-12-15	Pendiente	120000.00	6
6	Proyecto Zeta	Desarrollo de un sistema de atención al cliente basado en IA.	2024-06-01	2025-05-01	En progreso	180000.00	9
7	Proyecto Eta	Modernización de la infraestructura de TI en la empresa.	2024-07-10	2025-01-20	Planificado	220000.00	9
8	Proyecto Theta	Implementación de una red de comunicación de alta velocidad.	2024-08-15	2024-12-25	En progreso	130000.00	9
9	Proyecto Iota	Automatización de procesos administrativos mediante software personalizado.	2024-09-01	2025-02-28	Pendiente	140000.00	6
10	Proyecto Kappa	Estudio y planificación de un nuevo centro de datos para la empresa.	2024-10-10	2025-05-10	Planificado	300000.00	3
1	Proyecto Alpha	Este proyecto busca optimizar la infraestructura tecnológica.	2024-01-15	2024-06-15	En progreso	100000.00	1
\.


--
-- TOC entry 4282 (class 0 OID 19064)
-- Dependencies: 225
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 4571 (class 0 OID 19839)
-- Dependencies: 237
-- Data for Name: areas; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.areas (area_id, nombre, supervisor_id, geom) FROM stdin;
23	Desarrollo	3	\N
35	Talento Humano	3	\N
37	Computación	3	\N
38	Telecomunicacion	6	\N
2	Recursos Humanos	1	0103000020E610000001000000050000000000000000000000000000000000000000000000000000000000000000002440000000000000244000000000000024400000000000002440000000000000000000000000000000000000000000000000
22	Marketing	3	\N
\.


--
-- TOC entry 4588 (class 0 OID 24599)
-- Dependencies: 254
-- Data for Name: auth_group; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 4590 (class 0 OID 24607)
-- Dependencies: 256
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 4586 (class 0 OID 24593)
-- Dependencies: 252
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_permission (id, name, content_type_id, codename) FROM stdin;
\.


--
-- TOC entry 4592 (class 0 OID 24613)
-- Dependencies: 258
-- Data for Name: auth_user; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
\.


--
-- TOC entry 4594 (class 0 OID 24621)
-- Dependencies: 260
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 4596 (class 0 OID 24627)
-- Dependencies: 262
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- TOC entry 4598 (class 0 OID 24685)
-- Dependencies: 264
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- TOC entry 4584 (class 0 OID 24585)
-- Dependencies: 250
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.django_content_type (id, app_label, model) FROM stdin;
\.


--
-- TOC entry 4602 (class 0 OID 24724)
-- Dependencies: 268
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.django_migrations (id, app, name, applied) FROM stdin;
\.


--
-- TOC entry 4573 (class 0 OID 19843)
-- Dependencies: 239
-- Data for Name: empleados; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.empleados (id_empleado, nombre, apellidos, correo, especialidad, sueldo, activo, foto, nombre_usuario, contrasenia, fecha_contratacion, area_id, rol_id, geom) FROM stdin;
3	Carlos	Paucar	carlos.perez@example.com	Administrador de sistemas	3500.00	t	https://example.com/fotos/juan_perez.jpg	carlospaucar	123456	2024-11-25	\N	1	\N
2	Ana	Martínez	ana.martinez@empresa.com	Analista	4200.00	t	foto2.jpg	anamartinez	securepass	2024-11-20	\N	3	\N
6	Harold	Espinoza	hard@gmail.com	diseñador	5000.00	f	\N	haroldespinoza	123456	2024-11-25	\N	2	\N
1	Juana	Pérez	juan.perez@empresa.com	Desarrollador	1500.00	t	foto1.jpg	juanperez	password123	2024-11-25	\N	4	0101000020E6100000DCD78173460C54C0FB5C6DC5FEC23940
9	Carlos	Gómez	carlos.gomez@tecom.com	Ingeniero de Software	3500.00	t	/fotos/carlos.jpg	cgomez	password123	2023-01-15	\N	\N	0101000020E6100000045F8720BD4253C00AD40737BE1728C0
\.


--
-- TOC entry 4575 (class 0 OID 19850)
-- Dependencies: 241
-- Data for Name: roles; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.roles (id_rol, nombre, describcion) FROM stdin;
1	Administrador	Responsable de gestionar y supervisar todos los recursos del sistema.
2	Gerente	Encargado de la planificación, organización y dirección de proyectos.
3	Analista	Encargado de analizar datos y proponer soluciones estratégicas.
4	Desarrollador	Responsable del diseño y desarrollo de software y sistemas.
5	Soporte Técnico	Encargado de brindar asistencia técnica y solucionar problemas.
6	Recursos Humanos	Responsable de la gestión de personal y políticas internas.
\.


--
-- TOC entry 4600 (class 0 OID 24714)
-- Dependencies: 266
-- Data for Name: solicitudes_permiso; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.solicitudes_permiso (permiso_id, empleado_id, tipo_permiso, fecha_inicio, fecha_fin, estado, aprobado_por, comentarios) FROM stdin;
\.


--
-- TOC entry 4577 (class 0 OID 19856)
-- Dependencies: 243
-- Data for Name: asistencias; Type: TABLE DATA; Schema: sistemas; Owner: postgres
--

COPY sistemas.asistencias (asistencia_id, empleado_id, fecha, hora_entrada, hora_salida, estado, comentarios) FROM stdin;
1	1	2024-11-01	08:00:00	17:00:00	P	Asistencia completa.
2	2	2024-11-01	08:15:00	17:10:00	T	Llegada tardía por tráfico.
3	3	2024-11-01	\N	\N	A	No marcó asistencia.
\.


--
-- TOC entry 4579 (class 0 OID 19862)
-- Dependencies: 245
-- Data for Name: asignaciones_tareas; Type: TABLE DATA; Schema: tareas; Owner: postgres
--

COPY tareas.asignaciones_tareas (asignacion_id, tarea_id, empleado_id, asignador_id) FROM stdin;
77	121	\N	3
79	120	2	3
78	120	6	3
80	121	6	3
\.


--
-- TOC entry 4581 (class 0 OID 19866)
-- Dependencies: 247
-- Data for Name: tareas; Type: TABLE DATA; Schema: tareas; Owner: postgres
--

COPY tareas.tareas (tarea_id, titulo, descripcion, fecha_inicio, fecha_estimada_fin, fecha_real_fin, prioridad, estado, tiempo_restante_paralizado, tiempo_pasado_paralizado, tarea_padre, complejidad, puntos) FROM stdin;
120	Prueba1	Prueba1	2024-12-03 17:08:06-05	2024-12-20 20:13:00-05	2024-12-03 17:10:42.347-05	Alta	Completada	\N	\N	\N	1	1
121	Desarrollar Aplicativo de Mesa de Partes	Desarrollar Aplicativo de Mesa de Partes	2024-12-03 17:08:25-05	2024-12-04 19:00:00-05	2024-12-03 17:49:24.786-05	Alta	Completada	\N	\N	\N	1	1
\.


--
-- TOC entry 4631 (class 0 OID 0)
-- Dependencies: 230
-- Name: evaluaciones_desempeño_evaluacion_id_seq; Type: SEQUENCE SET; Schema: evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('evaluaciones."evaluaciones_desempeño_evaluacion_id_seq"', 1, false);


--
-- TOC entry 4632 (class 0 OID 0)
-- Dependencies: 232
-- Name: solicitudes_permiso_permiso_id_seq; Type: SEQUENCE SET; Schema: permisos; Owner: postgres
--

SELECT pg_catalog.setval('permisos.solicitudes_permiso_permiso_id_seq', 1, false);


--
-- TOC entry 4633 (class 0 OID 0)
-- Dependencies: 234
-- Name: costos_costo_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.costos_costo_id_seq', 10, true);


--
-- TOC entry 4634 (class 0 OID 0)
-- Dependencies: 273
-- Name: facturas_id_factura_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.facturas_id_factura_seq', 28, true);


--
-- TOC entry 4635 (class 0 OID 0)
-- Dependencies: 271
-- Name: ordenescompra_id_orden_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.ordenescompra_id_orden_seq', 12, true);


--
-- TOC entry 4636 (class 0 OID 0)
-- Dependencies: 275
-- Name: pagos_id_pago_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.pagos_id_pago_seq', 48, true);


--
-- TOC entry 4637 (class 0 OID 0)
-- Dependencies: 269
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.proveedores_id_proveedor_seq', 20, true);


--
-- TOC entry 4638 (class 0 OID 0)
-- Dependencies: 236
-- Name: proyectos_proyecto_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.proyectos_proyecto_id_seq', 10, true);


--
-- TOC entry 4639 (class 0 OID 0)
-- Dependencies: 238
-- Name: areas_area_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.areas_area_id_seq', 38, true);


--
-- TOC entry 4640 (class 0 OID 0)
-- Dependencies: 253
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_group_id_seq', 1, false);


--
-- TOC entry 4641 (class 0 OID 0)
-- Dependencies: 255
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 4642 (class 0 OID 0)
-- Dependencies: 251
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_permission_id_seq', 1, false);


--
-- TOC entry 4643 (class 0 OID 0)
-- Dependencies: 259
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_user_groups_id_seq', 1, false);


--
-- TOC entry 4644 (class 0 OID 0)
-- Dependencies: 257
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_user_id_seq', 1, false);


--
-- TOC entry 4645 (class 0 OID 0)
-- Dependencies: 261
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 4646 (class 0 OID 0)
-- Dependencies: 263
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.django_admin_log_id_seq', 1, false);


--
-- TOC entry 4647 (class 0 OID 0)
-- Dependencies: 249
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.django_content_type_id_seq', 1, false);


--
-- TOC entry 4648 (class 0 OID 0)
-- Dependencies: 267
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.django_migrations_id_seq', 1, false);


--
-- TOC entry 4649 (class 0 OID 0)
-- Dependencies: 240
-- Name: empleados_id_empleado_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.empleados_id_empleado_seq', 13, true);


--
-- TOC entry 4650 (class 0 OID 0)
-- Dependencies: 242
-- Name: roles_id_rol_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.roles_id_rol_seq', 10, true);


--
-- TOC entry 4651 (class 0 OID 0)
-- Dependencies: 265
-- Name: solicitudes_permiso_permiso_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.solicitudes_permiso_permiso_id_seq', 1, false);


--
-- TOC entry 4652 (class 0 OID 0)
-- Dependencies: 244
-- Name: asistencias_asistencia_id_seq; Type: SEQUENCE SET; Schema: sistemas; Owner: postgres
--

SELECT pg_catalog.setval('sistemas.asistencias_asistencia_id_seq', 1, false);


--
-- TOC entry 4653 (class 0 OID 0)
-- Dependencies: 246
-- Name: asignaciones_tareas_asignacion_id_seq; Type: SEQUENCE SET; Schema: tareas; Owner: postgres
--

SELECT pg_catalog.setval('tareas.asignaciones_tareas_asignacion_id_seq', 80, true);


--
-- TOC entry 4654 (class 0 OID 0)
-- Dependencies: 248
-- Name: tareas_tarea_id_seq; Type: SEQUENCE SET; Schema: tareas; Owner: postgres
--

SELECT pg_catalog.setval('tareas.tareas_tarea_id_seq', 121, true);


--
-- TOC entry 4309 (class 2606 OID 19883)
-- Name: evaluaciones_desempeño evaluaciones_desempeño_pkey; Type: CONSTRAINT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño"
    ADD CONSTRAINT "evaluaciones_desempeño_pkey" PRIMARY KEY (evaluacion_id);


--
-- TOC entry 4311 (class 2606 OID 19885)
-- Name: solicitudes_permiso solicitudes_permiso_pkey; Type: CONSTRAINT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_pkey PRIMARY KEY (permiso_id);


--
-- TOC entry 4313 (class 2606 OID 19887)
-- Name: costos costos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos
    ADD CONSTRAINT costos_pkey PRIMARY KEY (costo_id);


--
-- TOC entry 4380 (class 2606 OID 24796)
-- Name: facturas facturas_numero_factura_key; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas
    ADD CONSTRAINT facturas_numero_factura_key UNIQUE (numero_factura);


--
-- TOC entry 4382 (class 2606 OID 24794)
-- Name: facturas facturas_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas
    ADD CONSTRAINT facturas_pkey PRIMARY KEY (id_factura);


--
-- TOC entry 4378 (class 2606 OID 24775)
-- Name: ordenescompra ordenescompra_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra
    ADD CONSTRAINT ordenescompra_pkey PRIMARY KEY (id_orden);


--
-- TOC entry 4384 (class 2606 OID 24809)
-- Name: pagos pagos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 4376 (class 2606 OID 24742)
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);


--
-- TOC entry 4315 (class 2606 OID 19889)
-- Name: proyectos proyectos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos
    ADD CONSTRAINT proyectos_pkey PRIMARY KEY (proyecto_id);


--
-- TOC entry 4317 (class 2606 OID 19891)
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (area_id);


--
-- TOC entry 4341 (class 2606 OID 24711)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 4346 (class 2606 OID 24642)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 4349 (class 2606 OID 24611)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4343 (class 2606 OID 24603)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 4336 (class 2606 OID 24633)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 4338 (class 2606 OID 24597)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 4357 (class 2606 OID 24625)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4360 (class 2606 OID 24657)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 4351 (class 2606 OID 24617)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 4363 (class 2606 OID 24631)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4366 (class 2606 OID 24671)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 4354 (class 2606 OID 24706)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 4369 (class 2606 OID 24692)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4331 (class 2606 OID 24591)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 4333 (class 2606 OID 24589)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4374 (class 2606 OID 24730)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4319 (class 2606 OID 19893)
-- Name: empleados empleados_correo_key; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT empleados_correo_key UNIQUE (correo);


--
-- TOC entry 4321 (class 2606 OID 19895)
-- Name: empleados empleados_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (id_empleado);


--
-- TOC entry 4323 (class 2606 OID 19897)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 4372 (class 2606 OID 24720)
-- Name: solicitudes_permiso solicitudes_permiso_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_pkey PRIMARY KEY (permiso_id);


--
-- TOC entry 4325 (class 2606 OID 19899)
-- Name: asistencias asistencias_pkey; Type: CONSTRAINT; Schema: sistemas; Owner: postgres
--

ALTER TABLE ONLY sistemas.asistencias
    ADD CONSTRAINT asistencias_pkey PRIMARY KEY (asistencia_id);


--
-- TOC entry 4327 (class 2606 OID 19901)
-- Name: asignaciones_tareas asignaciones_tareas_pkey; Type: CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_pkey PRIMARY KEY (asignacion_id);


--
-- TOC entry 4329 (class 2606 OID 19903)
-- Name: tareas tareas_pkey; Type: CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.tareas
    ADD CONSTRAINT tareas_pkey PRIMARY KEY (tarea_id);


--
-- TOC entry 4339 (class 1259 OID 24712)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON recursos_humanos.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 4344 (class 1259 OID 24653)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON recursos_humanos.auth_group_permissions USING btree (group_id);


--
-- TOC entry 4347 (class 1259 OID 24654)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON recursos_humanos.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 4334 (class 1259 OID 24639)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON recursos_humanos.auth_permission USING btree (content_type_id);


--
-- TOC entry 4355 (class 1259 OID 24669)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON recursos_humanos.auth_user_groups USING btree (group_id);


--
-- TOC entry 4358 (class 1259 OID 24668)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON recursos_humanos.auth_user_groups USING btree (user_id);


--
-- TOC entry 4361 (class 1259 OID 24683)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON recursos_humanos.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 4364 (class 1259 OID 24682)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON recursos_humanos.auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 4352 (class 1259 OID 24707)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON recursos_humanos.auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 4367 (class 1259 OID 24703)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON recursos_humanos.django_admin_log USING btree (content_type_id);


--
-- TOC entry 4370 (class 1259 OID 24704)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON recursos_humanos.django_admin_log USING btree (user_id);


--
-- TOC entry 4385 (class 2606 OID 19904)
-- Name: evaluaciones_desempeño evaluaciones_desempeño_empleado_id_fkey; Type: FK CONSTRAINT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño"
    ADD CONSTRAINT "evaluaciones_desempeño_empleado_id_fkey" FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- TOC entry 4386 (class 2606 OID 19909)
-- Name: evaluaciones_desempeño evaluaciones_desempeño_evaluador_id_fkey; Type: FK CONSTRAINT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño"
    ADD CONSTRAINT "evaluaciones_desempeño_evaluador_id_fkey" FOREIGN KEY (evaluador_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- TOC entry 4387 (class 2606 OID 19914)
-- Name: solicitudes_permiso solicitudes_permiso_aprobado_por_fkey; Type: FK CONSTRAINT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_aprobado_por_fkey FOREIGN KEY (aprobado_por) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- TOC entry 4388 (class 2606 OID 19919)
-- Name: solicitudes_permiso solicitudes_permiso_empleado_id_fkey; Type: FK CONSTRAINT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- TOC entry 4389 (class 2606 OID 24744)
-- Name: costos costos_proveedor_id_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos
    ADD CONSTRAINT costos_proveedor_id_fkey FOREIGN KEY (proveedor_id) REFERENCES proyectos.proveedores(id_proveedor);


--
-- TOC entry 4411 (class 2606 OID 24797)
-- Name: facturas facturas_id_orden_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas
    ADD CONSTRAINT facturas_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES proyectos.ordenescompra(id_orden) ON DELETE CASCADE;


--
-- TOC entry 4390 (class 2606 OID 19924)
-- Name: costos fk_proyecto; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos
    ADD CONSTRAINT fk_proyecto FOREIGN KEY (proyecto_id) REFERENCES proyectos.proyectos(proyecto_id) ON DELETE SET NULL;


--
-- TOC entry 4391 (class 2606 OID 19929)
-- Name: proyectos fk_responsable; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos
    ADD CONSTRAINT fk_responsable FOREIGN KEY (responsable_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- TOC entry 4409 (class 2606 OID 24781)
-- Name: ordenescompra ordenescompra_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra
    ADD CONSTRAINT ordenescompra_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES proyectos.proveedores(id_proveedor) ON DELETE CASCADE;


--
-- TOC entry 4410 (class 2606 OID 24776)
-- Name: ordenescompra ordenescompra_id_proyecto_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra
    ADD CONSTRAINT ordenescompra_id_proyecto_fkey FOREIGN KEY (id_proyecto) REFERENCES proyectos.proyectos(proyecto_id) ON DELETE CASCADE;


--
-- TOC entry 4412 (class 2606 OID 24810)
-- Name: pagos pagos_id_factura_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.pagos
    ADD CONSTRAINT pagos_id_factura_fkey FOREIGN KEY (id_factura) REFERENCES proyectos.facturas(id_factura) ON DELETE CASCADE;


--
-- TOC entry 4392 (class 2606 OID 19934)
-- Name: areas areas_supervisor_id_fkey; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.areas
    ADD CONSTRAINT areas_supervisor_id_fkey FOREIGN KEY (supervisor_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- TOC entry 4401 (class 2606 OID 24648)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES recursos_humanos.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4402 (class 2606 OID 24643)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES recursos_humanos.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4400 (class 2606 OID 24634)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES recursos_humanos.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4403 (class 2606 OID 24663)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES recursos_humanos.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4404 (class 2606 OID 24658)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES recursos_humanos.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4405 (class 2606 OID 24677)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES recursos_humanos.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4406 (class 2606 OID 24672)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES recursos_humanos.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4407 (class 2606 OID 24693)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES recursos_humanos.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4408 (class 2606 OID 24698)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES recursos_humanos.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4393 (class 2606 OID 19939)
-- Name: empleados fk_area_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT fk_area_id FOREIGN KEY (area_id) REFERENCES recursos_humanos.areas(area_id) NOT VALID;


--
-- TOC entry 4394 (class 2606 OID 19944)
-- Name: empleados fk_rol_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT fk_rol_id FOREIGN KEY (rol_id) REFERENCES recursos_humanos.roles(id_rol) NOT VALID;


--
-- TOC entry 4395 (class 2606 OID 19949)
-- Name: asistencias asistencias_empleado_id_fkey; Type: FK CONSTRAINT; Schema: sistemas; Owner: postgres
--

ALTER TABLE ONLY sistemas.asistencias
    ADD CONSTRAINT asistencias_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- TOC entry 4396 (class 2606 OID 19954)
-- Name: asignaciones_tareas asignaciones_tareas_asignador_id_fkey; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_asignador_id_fkey FOREIGN KEY (asignador_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- TOC entry 4397 (class 2606 OID 19959)
-- Name: asignaciones_tareas asignaciones_tareas_empleado_id_fkey; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- TOC entry 4398 (class 2606 OID 19964)
-- Name: asignaciones_tareas asignaciones_tareas_tarea_id_fkey; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_tarea_id_fkey FOREIGN KEY (tarea_id) REFERENCES tareas.tareas(tarea_id) ON DELETE CASCADE;


--
-- TOC entry 4399 (class 2606 OID 32926)
-- Name: tareas fk_tarea_padre; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.tareas
    ADD CONSTRAINT fk_tarea_padre FOREIGN KEY (tarea_padre) REFERENCES tareas.tareas(tarea_id) ON DELETE CASCADE;


-- Completed on 2024-12-04 15:07:19 -05

--
-- PostgreSQL database dump complete
--

