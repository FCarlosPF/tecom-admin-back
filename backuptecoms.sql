--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Debian 14.12-1.pgdg130+2)
-- Dumped by pg_dump version 17.2 (Ubuntu 17.2-1.pgdg24.04+1)

-- Started on 2024-12-17 22:47:22 -05

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
-- TOC entry 7 (class 2615 OID 1474386)
-- Name: evaluaciones; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA evaluaciones;


ALTER SCHEMA evaluaciones OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 1474387)
-- Name: permisos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA permisos;


ALTER SCHEMA permisos OWNER TO postgres;

--
-- TOC entry 9 (class 2615 OID 1474388)
-- Name: proyectos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA proyectos;


ALTER SCHEMA proyectos OWNER TO postgres;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 10 (class 2615 OID 1474389)
-- Name: recursos_humanos; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA recursos_humanos;


ALTER SCHEMA recursos_humanos OWNER TO postgres;

--
-- TOC entry 11 (class 2615 OID 1474390)
-- Name: sistemas; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sistemas;


ALTER SCHEMA sistemas OWNER TO postgres;

--
-- TOC entry 12 (class 2615 OID 1474391)
-- Name: tareas; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tareas;


ALTER SCHEMA tareas OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 1474392)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4570 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 1475467)
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
-- TOC entry 222 (class 1259 OID 1475472)
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
-- TOC entry 4572 (class 0 OID 0)
-- Dependencies: 222
-- Name: evaluaciones_desempeño_evaluacion_id_seq; Type: SEQUENCE OWNED BY; Schema: evaluaciones; Owner: postgres
--

ALTER SEQUENCE evaluaciones."evaluaciones_desempeño_evaluacion_id_seq" OWNED BY evaluaciones."evaluaciones_desempeño".evaluacion_id;


--
-- TOC entry 223 (class 1259 OID 1475473)
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
-- TOC entry 224 (class 1259 OID 1475478)
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
-- TOC entry 4575 (class 0 OID 0)
-- Dependencies: 224
-- Name: solicitudes_permiso_permiso_id_seq; Type: SEQUENCE OWNED BY; Schema: permisos; Owner: postgres
--

ALTER SEQUENCE permisos.solicitudes_permiso_permiso_id_seq OWNED BY permisos.solicitudes_permiso.permiso_id;


--
-- TOC entry 225 (class 1259 OID 1475479)
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
-- TOC entry 226 (class 1259 OID 1475484)
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
-- TOC entry 4578 (class 0 OID 0)
-- Dependencies: 226
-- Name: costos_costo_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.costos_costo_id_seq OWNED BY proyectos.costos.costo_id;


--
-- TOC entry 227 (class 1259 OID 1475485)
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
-- TOC entry 228 (class 1259 OID 1475490)
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
-- TOC entry 4581 (class 0 OID 0)
-- Dependencies: 228
-- Name: facturas_id_factura_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.facturas_id_factura_seq OWNED BY proyectos.facturas.id_factura;


--
-- TOC entry 229 (class 1259 OID 1475491)
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
-- TOC entry 230 (class 1259 OID 1475496)
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
-- TOC entry 4584 (class 0 OID 0)
-- Dependencies: 230
-- Name: ordenescompra_id_orden_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.ordenescompra_id_orden_seq OWNED BY proyectos.ordenescompra.id_orden;


--
-- TOC entry 231 (class 1259 OID 1475497)
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
-- TOC entry 232 (class 1259 OID 1475501)
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
-- TOC entry 4587 (class 0 OID 0)
-- Dependencies: 232
-- Name: pagos_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.pagos_id_pago_seq OWNED BY proyectos.pagos.id_pago;


--
-- TOC entry 233 (class 1259 OID 1475502)
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
-- TOC entry 234 (class 1259 OID 1475507)
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
-- TOC entry 4590 (class 0 OID 0)
-- Dependencies: 234
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.proveedores_id_proveedor_seq OWNED BY proyectos.proveedores.id_proveedor;


--
-- TOC entry 235 (class 1259 OID 1475508)
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
-- TOC entry 236 (class 1259 OID 1475514)
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
-- TOC entry 4593 (class 0 OID 0)
-- Dependencies: 236
-- Name: proyectos_proyecto_id_seq; Type: SEQUENCE OWNED BY; Schema: proyectos; Owner: postgres
--

ALTER SEQUENCE proyectos.proyectos_proyecto_id_seq OWNED BY proyectos.proyectos.proyecto_id;


--
-- TOC entry 237 (class 1259 OID 1475515)
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
-- TOC entry 238 (class 1259 OID 1475520)
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
-- TOC entry 4596 (class 0 OID 0)
-- Dependencies: 238
-- Name: areas_area_id_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.areas_area_id_seq OWNED BY recursos_humanos.areas.area_id;


--
-- TOC entry 239 (class 1259 OID 1475521)
-- Name: auth_group; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE recursos_humanos.auth_group OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 1475524)
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
-- TOC entry 241 (class 1259 OID 1475525)
-- Name: auth_group_permissions; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE recursos_humanos.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 1475528)
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
-- TOC entry 243 (class 1259 OID 1475529)
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
-- TOC entry 244 (class 1259 OID 1475532)
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
-- TOC entry 245 (class 1259 OID 1475533)
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
-- TOC entry 246 (class 1259 OID 1475538)
-- Name: auth_user_groups; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE recursos_humanos.auth_user_groups OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 1475541)
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
-- TOC entry 248 (class 1259 OID 1475542)
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
-- TOC entry 249 (class 1259 OID 1475543)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE recursos_humanos.auth_user_user_permissions OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 1475546)
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
-- TOC entry 251 (class 1259 OID 1475547)
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
-- TOC entry 252 (class 1259 OID 1475553)
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
-- TOC entry 253 (class 1259 OID 1475554)
-- Name: django_content_type; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE recursos_humanos.django_content_type OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 1475557)
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
-- TOC entry 255 (class 1259 OID 1475558)
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
-- TOC entry 256 (class 1259 OID 1475563)
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
-- TOC entry 257 (class 1259 OID 1475564)
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
-- TOC entry 258 (class 1259 OID 1475570)
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
-- TOC entry 4617 (class 0 OID 0)
-- Dependencies: 258
-- Name: empleados_id_empleado_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.empleados_id_empleado_seq OWNED BY recursos_humanos.empleados.id_empleado;


--
-- TOC entry 270 (class 1259 OID 1476656)
-- Name: oficina; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.oficina (
    id integer NOT NULL,
    nombre character varying(50),
    geom public.geometry(MultiLineString)
);


ALTER TABLE recursos_humanos.oficina OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 1476655)
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
-- TOC entry 4620 (class 0 OID 0)
-- Dependencies: 269
-- Name: oficina_id_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.oficina_id_seq OWNED BY recursos_humanos.oficina.id;


--
-- TOC entry 259 (class 1259 OID 1475571)
-- Name: roles; Type: TABLE; Schema: recursos_humanos; Owner: postgres
--

CREATE TABLE recursos_humanos.roles (
    id_rol integer NOT NULL,
    nombre character varying(50) NOT NULL,
    describcion character varying(500)
);


ALTER TABLE recursos_humanos.roles OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 1475576)
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
-- TOC entry 4623 (class 0 OID 0)
-- Dependencies: 260
-- Name: roles_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: recursos_humanos; Owner: postgres
--

ALTER SEQUENCE recursos_humanos.roles_id_rol_seq OWNED BY recursos_humanos.roles.id_rol;


--
-- TOC entry 261 (class 1259 OID 1475577)
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
-- TOC entry 262 (class 1259 OID 1475582)
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
-- TOC entry 265 (class 1259 OID 1475589)
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
-- TOC entry 267 (class 1259 OID 1475593)
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
-- TOC entry 271 (class 1259 OID 1476785)
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
    count(t.tarea_id) AS cantidad_tareas_pendientes_o_en_progreso
   FROM ((recursos_humanos.empleados e
     LEFT JOIN tareas.asignaciones_tareas at ON ((e.id_empleado = at.empleado_id)))
     LEFT JOIN tareas.tareas t ON (((at.tarea_id = t.tarea_id) AND ((t.estado)::text = ANY ((ARRAY['Pendiente'::character varying, 'En Progreso'::character varying])::text[])))))
  GROUP BY e.id_empleado, e.nombre, e.apellidos, e.correo, e.especialidad, e.sueldo, e.activo, e.foto, e.nombre_usuario, e.contrasenia, e.fecha_contratacion, e.area_id, e.rol_id, e.geom;


ALTER VIEW recursos_humanos.vista_empleados_tareas OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 1475583)
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
-- TOC entry 264 (class 1259 OID 1475588)
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
-- TOC entry 4631 (class 0 OID 0)
-- Dependencies: 264
-- Name: asistencias_asistencia_id_seq; Type: SEQUENCE OWNED BY; Schema: sistemas; Owner: postgres
--

ALTER SEQUENCE sistemas.asistencias_asistencia_id_seq OWNED BY sistemas.asistencias.asistencia_id;


--
-- TOC entry 266 (class 1259 OID 1475592)
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
-- TOC entry 4633 (class 0 OID 0)
-- Dependencies: 266
-- Name: asignaciones_tareas_asignacion_id_seq; Type: SEQUENCE OWNED BY; Schema: tareas; Owner: postgres
--

ALTER SEQUENCE tareas.asignaciones_tareas_asignacion_id_seq OWNED BY tareas.asignaciones_tareas.asignacion_id;


--
-- TOC entry 268 (class 1259 OID 1475598)
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
-- TOC entry 4635 (class 0 OID 0)
-- Dependencies: 268
-- Name: tareas_tarea_id_seq; Type: SEQUENCE OWNED BY; Schema: tareas; Owner: postgres
--

ALTER SEQUENCE tareas.tareas_tarea_id_seq OWNED BY tareas.tareas.tarea_id;


--
-- TOC entry 4219 (class 2604 OID 1475599)
-- Name: evaluaciones_desempeño evaluacion_id; Type: DEFAULT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño" ALTER COLUMN evaluacion_id SET DEFAULT nextval('evaluaciones."evaluaciones_desempeño_evaluacion_id_seq"'::regclass);


--
-- TOC entry 4220 (class 2604 OID 1475600)
-- Name: solicitudes_permiso permiso_id; Type: DEFAULT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso ALTER COLUMN permiso_id SET DEFAULT nextval('permisos.solicitudes_permiso_permiso_id_seq'::regclass);


--
-- TOC entry 4221 (class 2604 OID 1475601)
-- Name: costos costo_id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos ALTER COLUMN costo_id SET DEFAULT nextval('proyectos.costos_costo_id_seq'::regclass);


--
-- TOC entry 4222 (class 2604 OID 1475602)
-- Name: facturas id_factura; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas ALTER COLUMN id_factura SET DEFAULT nextval('proyectos.facturas_id_factura_seq'::regclass);


--
-- TOC entry 4224 (class 2604 OID 1475603)
-- Name: ordenescompra id_orden; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra ALTER COLUMN id_orden SET DEFAULT nextval('proyectos.ordenescompra_id_orden_seq'::regclass);


--
-- TOC entry 4226 (class 2604 OID 1475604)
-- Name: pagos id_pago; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.pagos ALTER COLUMN id_pago SET DEFAULT nextval('proyectos.pagos_id_pago_seq'::regclass);


--
-- TOC entry 4227 (class 2604 OID 1475605)
-- Name: proveedores id_proveedor; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proveedores ALTER COLUMN id_proveedor SET DEFAULT nextval('proyectos.proveedores_id_proveedor_seq'::regclass);


--
-- TOC entry 4228 (class 2604 OID 1475606)
-- Name: proyectos proyecto_id; Type: DEFAULT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos ALTER COLUMN proyecto_id SET DEFAULT nextval('proyectos.proyectos_proyecto_id_seq'::regclass);


--
-- TOC entry 4230 (class 2604 OID 1475607)
-- Name: areas area_id; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.areas ALTER COLUMN area_id SET DEFAULT nextval('recursos_humanos.areas_area_id_seq'::regclass);


--
-- TOC entry 4231 (class 2604 OID 1475608)
-- Name: empleados id_empleado; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados ALTER COLUMN id_empleado SET DEFAULT nextval('recursos_humanos.empleados_id_empleado_seq'::regclass);


--
-- TOC entry 4237 (class 2604 OID 1476659)
-- Name: oficina id; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.oficina ALTER COLUMN id SET DEFAULT nextval('recursos_humanos.oficina_id_seq'::regclass);


--
-- TOC entry 4233 (class 2604 OID 1475609)
-- Name: roles id_rol; Type: DEFAULT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.roles ALTER COLUMN id_rol SET DEFAULT nextval('recursos_humanos.roles_id_rol_seq'::regclass);


--
-- TOC entry 4234 (class 2604 OID 1475610)
-- Name: asistencias asistencia_id; Type: DEFAULT; Schema: sistemas; Owner: postgres
--

ALTER TABLE ONLY sistemas.asistencias ALTER COLUMN asistencia_id SET DEFAULT nextval('sistemas.asistencias_asistencia_id_seq'::regclass);


--
-- TOC entry 4235 (class 2604 OID 1475611)
-- Name: asignaciones_tareas asignacion_id; Type: DEFAULT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas ALTER COLUMN asignacion_id SET DEFAULT nextval('tareas.asignaciones_tareas_asignacion_id_seq'::regclass);


--
-- TOC entry 4236 (class 2604 OID 1475612)
-- Name: tareas tarea_id; Type: DEFAULT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.tareas ALTER COLUMN tarea_id SET DEFAULT nextval('tareas.tareas_tarea_id_seq'::regclass);


--
-- TOC entry 4508 (class 0 OID 1475467)
-- Dependencies: 221
-- Data for Name: evaluaciones_desempeño; Type: TABLE DATA; Schema: evaluaciones; Owner: postgres
--

COPY evaluaciones."evaluaciones_desempeño" (evaluacion_id, empleado_id, fecha_evaluacion, comentarios, puntuacion, evaluador_id) FROM stdin;
\.


--
-- TOC entry 4510 (class 0 OID 1475473)
-- Dependencies: 223
-- Data for Name: solicitudes_permiso; Type: TABLE DATA; Schema: permisos; Owner: postgres
--

COPY permisos.solicitudes_permiso (permiso_id, empleado_id, tipo_permiso, fecha_inicio, fecha_fin, estado, aprobado_por, comentarios) FROM stdin;
\.


--
-- TOC entry 4512 (class 0 OID 1475479)
-- Dependencies: 225
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
-- TOC entry 4514 (class 0 OID 1475485)
-- Dependencies: 227
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
-- TOC entry 4516 (class 0 OID 1475491)
-- Dependencies: 229
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
-- TOC entry 4518 (class 0 OID 1475497)
-- Dependencies: 231
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
-- TOC entry 4520 (class 0 OID 1475502)
-- Dependencies: 233
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
-- TOC entry 4522 (class 0 OID 1475508)
-- Dependencies: 235
-- Data for Name: proyectos; Type: TABLE DATA; Schema: proyectos; Owner: postgres
--

COPY proyectos.proyectos (proyecto_id, nombre, descripcion, fecha_inicio, fecha_fin, estado, presupuesto, responsable_id) FROM stdin;
3	Proyecto Gamma	Investigación en IA para automatización de procesos.	2024-03-10	2024-12-01	En progreso	250000.00	\N
10	Proyecto Kappa	Estudio y planificación de un nuevo centro de datos para la empresa.	2024-10-10	2025-05-10	Planificado	300000.00	\N
2	Proyecto Beta	Desarrollo de una plataforma web para gestión empresarial.	2024-02-01	2024-08-30	Planificado	200000.00	\N
4	Proyecto Delta	Implementación de soluciones en la nube para almacenamiento seguro.	2024-04-20	2024-11-10	En progreso	100000.00	\N
5	Proyecto Epsilon	Rediseño de la red interna para mejorar la seguridad.	2024-05-05	2024-12-15	Pendiente	120000.00	\N
9	Proyecto Iota	Automatización de procesos administrativos mediante software personalizado.	2024-09-01	2025-02-28	Pendiente	140000.00	\N
1	Proyecto Alpha	Este proyecto busca optimizar la infraestructura tecnológica.	2024-01-15	2024-06-15	En progreso	100000.00	\N
6	Proyecto Zeta	Desarrollo de un sistema de atención al cliente basado en IA.	2024-06-01	2025-05-01	En progreso	180000.00	\N
7	Proyecto Eta	Modernización de la infraestructura de TI en la empresa.	2024-07-10	2025-01-20	Planificado	220000.00	\N
8	Proyecto Theta	Implementación de una red de comunicación de alta velocidad.	2024-08-15	2024-12-25	En progreso	130000.00	\N
\.


--
-- TOC entry 4218 (class 0 OID 1474709)
-- Dependencies: 217
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 4524 (class 0 OID 1475515)
-- Dependencies: 237
-- Data for Name: areas; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.areas (area_id, nombre, supervisor_id, geom) FROM stdin;
23	Desarrollo	17	\N
39	Diseño	29	\N
40	Construcción	24	\N
2	Recursos Humanos	25	010300000001000000050000000000000000000000000000000000000000000000000000000000000000002440000000000000244000000000000024400000000000002440000000000000000000000000000000000000000000000000
\.


--
-- TOC entry 4526 (class 0 OID 1475521)
-- Dependencies: 239
-- Data for Name: auth_group; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 4528 (class 0 OID 1475525)
-- Dependencies: 241
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 4530 (class 0 OID 1475529)
-- Dependencies: 243
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_permission (id, name, content_type_id, codename) FROM stdin;
\.


--
-- TOC entry 4532 (class 0 OID 1475533)
-- Dependencies: 245
-- Data for Name: auth_user; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
\.


--
-- TOC entry 4533 (class 0 OID 1475538)
-- Dependencies: 246
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 4536 (class 0 OID 1475543)
-- Dependencies: 249
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- TOC entry 4538 (class 0 OID 1475547)
-- Dependencies: 251
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- TOC entry 4540 (class 0 OID 1475554)
-- Dependencies: 253
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.django_content_type (id, app_label, model) FROM stdin;
\.


--
-- TOC entry 4542 (class 0 OID 1475558)
-- Dependencies: 255
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.django_migrations (id, app, name, applied) FROM stdin;
\.


--
-- TOC entry 4544 (class 0 OID 1475564)
-- Dependencies: 257
-- Data for Name: empleados; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.empleados (id_empleado, nombre, apellidos, correo, especialidad, sueldo, activo, foto, nombre_usuario, contrasenia, fecha_contratacion, area_id, rol_id, geom) FROM stdin;
15	ERICK	BARRIOS VALDIVIA	erick@tecom.sg	\N	\N	t	\N	ebarrios	123456	\N	\N	1	0101000000219E235CAF0C91400362DC73DB979B40
20	HEINE	VALVERDE MEJIA	heine@tecom.sg	\N	\N	t	\N	hvalverde	123456	\N	\N	1	010100000023FA47A3910C91404B5555A9FB899B40
16	MAXIMO	CANCHARI RAMOS	maximo@tecom.sg	\N	\N	t	\N	mcanchari	123456	\N	\N	2	01010000000483E714BED79040F46794EC7E989B40
17	JOHAN	JARA VALDIVIEZO	johan@tecom.sg	\N	\N	t	\N	jjara	123456	\N	\N	3	01010000001218F7973FCC904076A86543EC929B40
18	BRITANNY STACY	MENDOZA PADILLA	britannystacy@tecom.sg	\N	\N	t	\N	bmendoza	123456	\N	\N	2	01010000009658C8EEACC69040B29085605E909B40
19	FABIO	OHARA ROJAS	fabio@tecom.sg	\N	\N	t	\N	fohara	123456	\N	\N	3	0101000000D167944457FA904072B976D43D889B40
21	JUAN CARLOS	MUÑOZ VILCA	juancarlos@tecom.sg	\N	\N	t	\N	jmunoz	123456	\N	\N	1	010100000012852C7073C19040B15AF66814A69B40
22	LUCERO LUZ	SANCHEZ FAQUIN	luceroluz@tecom.sg	\N	\N	t	\N	lsanchez	123456	\N	\N	2	0101000000ECFFFF0B2EF990405A10FA7B15949B40
23	JUNIOR	DELGADO MEDINA	junior@tecom.sg	\N	\N	t	\N	jdelgado	123456	\N	\N	3	01010000007C432DA7F0FD9040B8DB9816EF9A9B40
27	EDGAR DO SANTOS	MOSQUERA DAVALOS	edgardosantos@tecom.sg	\N	\N	t	\N	emosquera	123456	\N	\N	3	0101000000ECFFFF0B2EF99040B8DB9816EF9A9B40
25	MARYLIN	SALCEDO LOAYZA	marylin@tecom.sg	\N	\N	t	\N	msalcedo	123456	\N	\N	3	0101000000D8556CCA65E49040F09E3ACD68A39B40
26	JUAN JOSE	VALDEZ SILVA	juanjose@tecom.sg	\N	\N	t	\N	jvaldez	123456	\N	\N	2	0101000000C1E27E6987DA90403076495989AB9B40
28	HEIDER	REYES AVENDAÑO	heider@tecom.sg	\N	\N	t	\N	hreyes	123456	\N	\N	2	0101000000E757B1251BCE9040ECAF4B5EBA989B40
29	LUIS	LOPEZ RAMOS	luis@tecom.sg	\N	\N	t	\N	llopez	123456	\N	\N	3	0101000000769BDEC0DDD29040ECAF4B5EBA989B40
30	CARLOS	BECERRA HERNANDEZ	carlos@tecom.sg	\N	\N	t	\N	cbecerra	123456	\N	\N	2	01010000005714848A58C99040EF0B70A59C989B40
31	FREDDY	PAUCAR FLORES	freddy@tecom.sg	\N	\N	t	\N	fpaucar	123456	\N	\N	1	0101000000CB1C818EC6EF90405A10FA7B15949B40
32	EDISON DANIEL	MAÑUICO GUERRA	edisondaniel@tecom.sg	\N	\N	t	\N	emanico	123456	\N	\N	2	0101000000D0D4C91C8BEF9040B8DB9816EF9A9B40
33	JESUS MOISES	GUEVARA VITON	jesusmoises@tecom.sg	\N	\N	t	\N	jguevara	123456	\N	\N	3	0101000000778BE4182CFE904057B4D53433949B40
24	JOEL	SANTILLAN ULLOA	joel@tecom.sg	\N	\N	t	\N	jsantillan	123456	\N	\N	2	01010000005A60AE2989F49040B8DB9816EF9A9B40
\.


--
-- TOC entry 4557 (class 0 OID 1476656)
-- Dependencies: 270
-- Data for Name: oficina; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.oficina (id, nombre, geom) FROM stdin;
2	\N	0105000000AD070000010200000002000000263B9C9AE8BE9040BFC1137EB2AB9B40273B9C9AE8BE9040BFC1137EB2AB9B40010200000002000000273B9C9AE8BE9040BFC1137EB2AB9B40FE3A167070C19040BFC1137EB2AB9B40010200000002000000273B9C9AE8BE9040BFC1137EB2AB9B40273B9C9AE8BE9040C1C1137EB2AB9B40010200000005000000BF1916452FC19040C5B5FCC342929B4026D0819A11C090408D60F9768F989B40B9361DE650BF9040A07F99E4E99E9B408BBB4ECAEDBE904048B134B24CA59B40273B9C9AE8BE9040BFC1137EB2AB9B400102000000040000007C98B79AFEBF9040A953EC0C969C9B40A0EC0C35B3BF904044D3FD881C9F9B40B0006D7B53BF9040FAEF7CC964A59B40A09378F84EBF9040295C06E1AFAB9B4001020000000200000044A04B8CF3BF9040A953EC0C969C9B407C98B79AFEBF9040A953EC0C969C9B400102000000030000007C98B79AFEBF9040A953EC0C969C9B4016074C4C43C09040A953EC0C969C9B4016074C4C43C090409F7C489C589C9B4001020000000200000081BDA68410C0904010BA5273FC9B9B407C98B79AFEBF9040A953EC0C969C9B400102000000020000000B5D070805C0904010BA5273FC9B9B4081BDA68410C0904010BA5273FC9B9B4001020000000200000081BDA68410C0904010BA5273FC9B9B4018074C4C43C0904010BA5273FC9B9B40010200000003000000FF5224C782C190402A1C632AA9929B40DD4FB8D66DC09040C7B47E48DC989B4081BDA68410C0904010BA5273FC9B9B4001020000000200000018074C4C43C0904010BA5273FC9B9B409CF29D0462C0904010BA5273FC9B9B4001020000000300000018074C4C43C0904010BA5273FC9B9B4018074C4C43C090409D7C489C589C9B40C64E2DC757C090409D7C489C589C9B40010200000006000000C64E2DC757C090409D7C489C589C9B40C64E2DC757C09040559BCD872A9C9B409DF29D0462C09040559BCD872A9C9B409DF29D0462C090400EBA5273FC9B9B4018074C4C43C090400EBA5273FC9B9B4018074C4C43C0904010BA5273FC9B9B400102000000020000009ACD1BAF4DC090401A6ACDAB1B9F9B4052E33AEC4AC0904079B0241CFC9E9B4001020000001E00000053E33AEC4AC0904079B0241CFC9E9B4045D9CFF14BC090406016BAACFA9E9B40970B2C104DC09040C1C04650F99E9B40B696F0454EC0904026A87508F89E9B4064E8A1914FC09040907CD8D6F69E9B40D090A9F150C090403EB9E5BCF59E9B40A034586452C09040D3D9F6BBF49E9B407E9DE7E753C09040FCB246D5F39E9B40A6E67C7A55C09040ADF0EF09F39E9B40D6C22A1A57C09040C1BBEB5AF29E9B40BCD8F3C458C09040AC8810C9F19E9B401C33CD785AC09040B3101155F19E9B4098C1A0335CC09040EE767BFFF09E9B4020E74FF35DC09040199AB8C8F09E9B40D012B6B55FC090401A940BB1F09E9B402060AB7861C09040C36791B8F09E9B40263B073A63C090404ADD40DFF09E9B40AC05A3F764C090408F8DEA24F19E9B40E6B95CAF66C09040371C3989F19E9B408087195F68C0904041A0B10BF29E9B40DB67C8046AC09040A43AB4ABF29E9B4047A6649E6BC0904032DA7C68F39E9B402859F8296DC09040DC2B2441F49E9B40FCC89EA56EC090401EB6A034F59E9B404AC2860F70C09040551EC841F69E9B40A8CFF46571C090404B965067F79E9B40265945A772C090405F70D2A3F89E9B406BA6EED173C090403AD8C9F5F99E9B4028C182E474C090400CAE985BFB9E9B408A35B1DD75C09040FA8188D3FC9E9B4001020000001E000000D6C7B5D977C09040B0333482139F9B402C51982577C09040D606B31F159F9B401614525576C090409B5DC0AF169F9B40A045E26975C09040AE047230189F9B405663696474C09040699AF09F199F9B40C4D1274673C0904066D079FC1A9F9B40D8537C1072C090404C9362441C9F9B40235DE2C470C090401C1619761D9F9B40D440F0646FC0904087BE26901E9F9B40DE3F55F26DC09040F9EF31911F9F9B408A78D76E6CC090400FB3FF77209F9B40FCB951DC6AC090408D377543219F9B40723EB13C69C09040E72E99F2219F9B40D44EF39167C09040C0FD9484229F9B40B9D222DE65C09040DDC2B5F8229F9B409DCF552364C0904059326D4E239F9B408DDAAA6362C0904000445285239F9B404A7F46A160C0904004B4219D239F9B4025A050DE5EC090406655BE95239F9B40BAD1F11C5DC09040B935316F239F9B40DBB5505F5BC090400A92A929239F9B40D9588FA759C09040FB9C7CC5229F9B406A94C8F757C0904061162543229F9B40647B0D5256C09040D8B442A3219F9B4070D162B854C09040126299E6209F9B40D691BE2C53C09040C64A100E209F9B405E8805B151C090406BC3B01A1F9F9B404EFF084750C090401A03A50D1E9F9B403E8584F04EC0904023B636E81C9F9B409CCD1BAF4DC09040196ACDAB1B9F9B40010200000002000000C64E2DC757C090409D7C489C589C9B400A82920991C09040411D8216E79E9B40010200000003000000C64E2DC757C090409D7C489C589C9B408C8FC4AE85C09040F4F42698549C9B40E8A80F3DC1C09040D2281552FD9E9B400102000000190000005D1804DE72C090406EB8E4303BA69B404A72024A72C09040D8A966773CA69B408F4DA9CC71C09040017142C73DA69B40C0B08E6671C090402813E61E3FA69B4070D02C1871C090408D45B67C40A69B40E37CE1E170C09040B35910DF41A69B40D1B1EDC370C0904080324C4443A69B40964875BE70C09040D33FBEAA44A69B4050CD7ED170C09040497EB91046A69B400377F3FC70C09040AD78917447A69B40E6429F4071C09040CF489CD448A69B409C32319C71C090403F95342F4AA69B4028AD3B0F72C090409A89BB824BA69B401802359972C090400CC79ACD4CA69B40530E783973C09040AD4A460E4EA69B40BE0145EF73C090407D473E434FA69B40CC44C2B974C09040BBF1106B50A69B40F17CFD9775C0904088395C8451A69B40B2AEEC8876C090409F72CF8D52A69B40F97B6F8B77C0904054E72C8653A69B40407D509E78C09040CF544B6C54A69B40DBB346C079C09040D84E173F55A69B40C313F7EF7AC090407B8994FD55A69B40EC22F62B7CC090400007DFA656A69B4057ACC9727DC09040CB282C3A57A69B400102000000020000007B1804DE72C0904070B8E4303BA69B40C14232A99BC09040C28695CFE8A59B40010200000003000000D6C7B5D977C09040B0333482139F9B40D4C7B5D977C09040B0333482139F9B408A35B1DD75C09040FA8188D3FC9E9B40010200000002000000E13DA7397CC090408AE71A45FC9E9B408A35B1DD75C09040FA8188D3FC9E9B40010200000002000000D6C7B5D977C09040AF333482139F9B40D6C7B5D977C09040B0333482139F9B400102000000020000002DD0AB357EC090403F99C6F3129F9B40D6C7B5D977C09040B0333482139F9B400102000000020000007BACC9727DC09040CC282C3A57A69B407B69DD0E34C19040D462D720A2A69B400102000000020000002ED0AB357EC090403F99C6F3129F9B402DD0AB357EC090403F99C6F3129F9B4001020000000300000089E370E389C090408E5593E0129F9B40A0FAB64A7EC09040882F4EE4139F9B402DD0AB357EC090403F99C6F3129F9B400102000000030000002DD0AB357EC090403F99C6F3129F9B406E139C247CC0904040519354FB9E9B4056FC55BD87C090404877D850FA9E9B40010200000002000000C14232A99BC09040C28695CFE8A59B409B4F91F07FC090402F8D6A15DBA59B400102000000620000009B4F91F07FC090402F8D6A15DBA59B407BC453D95AC09040047F6CFC25A69B40493C9A2F5AC090406203A13727A69B409D57C37059C090400451846628A69B4032DFB29D58C09040C3E1AC8729A69B40A7BF64B757C09040A192C1992AA69B40D1DCEBBE56C09040BC3F7B9B2BA69B40A3C970B555C09040C54AA68B2CA69B402B66309C54C090402D0A24692DA69B405E657A7453C090404E1FEC322EA69B4066BCAF3F52C09040F8B10DE82EA69B405CFD40FF50C09040E68FB0872FA69B40569FACB44FC09040CD2E161130A69B40EB357D614EC09040CA8F9A8330A69B403A9A47074DC090401F03B5DE30A69B40B207A9A74BC090405ACBF82131A69B40D32E45444AC090401E9F154D31A69B404540C4DE48C09040F708D85F31A69B4085F2D07847C09040C9A4295A31A69B409184161446C09040873A113C31A69B40F7BF3EB244C090401AB6B20531A69B409EFCEF5443C0904084FC4EB730A69B40A628CBFD41C09040689E435130A69B40C9D669AE40C090405F680AD42FA69B407B555C683FC0904094D138402FA69B407BB870FF20C090403C56383120A69B4013343CC41FC0904007CE7E871FA69B4068E658951EC0904059E9A7C81EA69B40A05530741DC09040EA7097F51DA69B40B8A41B621CC090405A51490F1DA69B4095F761601BC09040806ED0161CA69B4084EC36701AC090404C5B550D1BA69B40142DB99219C09040CEF714F419A69B40EB17F1C818C09040FAF65ECC18A69B403B85CF1318C09040FC4D949717A69B4047A72C7417C09040EA8E255716A69B405A08C7EA16C09040DC30910C15A69B4057A7427816C0904069C761B913A69B40FD33281D16C09040B02B2C5F12A69B40BE6BE4D915C090401E998DFF10A69B40F697C7AE15C0904036C0299C0FA69B401A2E059C15C090409FD1A8360EA69B404592B3A115C09040D583B5D00CA69B4086FCCBBF15C09040D715FB6B0BA69B40F2802AF615C090403451230A0AA69B40883A8E4416C09040D18DD4AC08A69B40A49899AA16C09040CFB9AF5507A69B40AFCED22717C09040E8674E0606A69B407B65A4BB17C0904090E640C004A69B407B46E2F2B9C0904068F4BE2ABDA49B40ADCE9B9CBAC090400A708AEFBBA49B4059B3725BBBC090406822A7C0BAA49B40C42B832EBCC09040A9917E9FB9A49B404F4BD114BDC09040CBE0698DB8A49B40252E4A0DBEC09040B033B08BB7A49B405341C516BFC09040A728859BB6A49B40CBA40530C0C090403F6907BEB5A49B4098A5BB57C1C090401E543FF4B4A49B40904E868CC2C0904074C11D3FB4A49B409A0DF5CCC3C0904086E37A9FB3A49B40A06B8917C5C090409F441516B3A49B400BD5B86AC6C09040A2E390A3B2A49B40BC70EEC4C7C090404D707648B2A49B4044038D24C9C0904012A83205B2A49B4023DCF087CAC090404ED415DAB1A49B40B1CA71EDCBC09040756A53C7B1A49B4071186553CDC09040A3CE01CDB1A49B4065861FB8CEC09040E5381AEBB1A49B40FF4AF719D0C0904052BD7821B2A49B40580E4677D1C09040E876DC6FB2A49B4050E26ACED2C0904004D5E7D5B2A49B402D34CC1DD4C090400D0B2153B3A49B407BB5D963D5C09040D8A1F2E6B3A49B407B52C5CCF3C09040301DF3F5C2A49B40E3D6F907F5C0904065A5AC9FC3A49B408E24DD36F6C09040138A835EC4A49B4056B50558F7C0904082029431C5A49B403E661A6AF8C090401222E217C6A49B406113D46BF9C09040EC045B10C7A49B40721EFF5BFAC090402018D619C8A49B40E2DD7C39FBC090409E7B1633C9A49B400BF34403FCC09040727CCC5ACAA49B40BB8566B8FCC090407025978FCBA49B40AF630958FDC0904082E405D0CCA49B409C026FE1FDC0904090429A1ACEA49B409F63F353FEC0904003ACC96DCFA49B40F9D60DAFFEC09040BC47FFC7D0A49B40389F51F2FEC090404EDA9D27D2A49B4000736E1DFFC0904036B3018BD3A49B40DCDC3030FFC09040CDA182F0D4A49B40B178822AFFC0904097EF7556D6A49B40700E6A0CFFC09040955D30BBD7A49B40048A0BD6FEC090403822081DD9A49B406ED0A787FEC090409BE5567ADAA49B4052729C21FEC090409DB97BD1DBA49B40473C63A4FDC09040840BDD20DDA49B407BA59110FDC09040DC8CEA66DEA49B4090A652A2E0C090401CD8D9D017A59B400102000000040000009B4F91F07FC090402F8D6A15DBA59B407B68A39568C090408856B884CFA59B407BF5A13E71C09040F4AFA507BEA59B40EADB8F9988C0904067E65798C9A59B40010200000002000000EADB8F9988C0904067E65798C9A59B409B4F91F07FC090402F8D6A15DBA59B4001020000000200000089E370E389C090408E5593E0129F9B4056FC55BD87C090404877D850FA9E9B400102000000020000003CC534E089C09040775A423CF89E9B4056FC55BD87C090404877D850FA9E9B40010200000002000000EADB8F9988C0904067E65798C9A59B40F8CE3052A4C0904017E08252D7A59B40010200000002000000651A54F9D7C090409C7EEC4D29A59B40EADB8F9988C0904067E65798C9A59B400102000000020000003C567C5A8CC09040E2911B8E149F9B403CC534E089C09040775A423CF89E9B40010200000002000000FC96671E8CC09040BAD0AB84E79E9B403CC534E089C09040775A423CF89E9B400102000000020000003C567C5A8CC09040E2911B8E149F9B4089E370E389C090408E5593E0129F9B40010200000002000000207F1A7791C09040877CF8A0249F9B40FC96671E8CC09040BAD0AB84E79E9B400102000000020000000A82920991C09040411D8216E79E9B40FC96671E8CC09040BAD0AB84E79E9B40010200000002000000207F1A7791C09040877CF8A0249F9B403C567C5A8CC09040E2911B8E149F9B400102000000020000000A82920991C09040411D8216E79E9B402F6A456296C090400EC9CE32249F9B400102000000020000002F6A456296C090400EC9CE32249F9B40207F1A7791C09040877CF8A0249F9B400102000000020000002F6A456296C090400EC9CE32249F9B40A5B32A9B9BC09040D25098E35F9F9B40010200000002000000A5B32A9B9BC09040D25098E35F9F9B406BF4C182C9C090402AC976DF5B9F9B400102000000030000006BF4C182C9C090402AC976DF5B9F9B406BF4C182C9C090402BC976DF5B9F9B40A5B32A9B9BC09040D25098E35F9F9B40010200000004000000F8CE3052A4C0904017E08252D7A59B407B846BDDC5C09040B0A2CEEEE7A59B407BF86C34BDC090404449E16BF9A59B40C14232A99BC09040C28695CFE8A59B40010200000002000000C14232A99BC09040C28695CFE8A59B40F8CE3052A4C0904017E08252D7A59B40010200000002000000F8CE3052A4C0904017E08252D7A59B40330DF5B1F3C090402C78170837A59B40010200000002000000E8A80F3DC1C09040D2281552FD9E9B40F5AADC49C4C090406641AD2E209F9B40010200000003000000E8A80F3DC1C09040D2281552FD9E9B40F4AADC49C4C090406641AD2E209F9B40F5AADC49C4C090406641AD2E209F9B40010200000003000000E8A80F3DC1C09040D2281552FD9E9B40D0C229F1BEC0904098956012E39E9B40DEAD54DCC3C0904020E236A4E29E9B40010200000002000000DEAD54DCC3C0904020E236A4E29E9B40C4D6F2F8C8C09040C4CC13B7F29E9B4001020000000200000005960735C9C09040ED8D83C01F9F9B40DEAD54DCC3C0904020E236A4E29E9B40010200000002000000F5AADC49C4C090406641AD2E209F9B406BF4C182C9C090402AC976DF5B9F9B40010200000002000000F5AADC49C4C090406641AD2E209F9B4005960735C9C09040ED8D83C01F9F9B40010200000002000000C4D6F2F8C8C09040C4CC13B7F29E9B407649FE6FCBC0904018099C64F49E9B40010200000002000000C3673A73CBC090402F04ED080F9F9B40C4D6F2F8C8C09040C4CC13B7F29E9B4001020000000200000005960735C9C09040ED8D83C01F9F9B40C3673A73CBC090402F04ED080F9F9B400102000000160000009DF29D0462C390409D7C489C589C9B40755F913A60C3904044CA475A8D9C9B403AD686DE5AC390409D5631DAC19C9B40EB6CCDF651C390408E7538DEF59C9B4020B2E08D45C39040544F2229299D9B4018565CB235C3904009F48D7E5B9D9B4096F8EA7622C390409F6E3BA38C9D9B40C82F30F20BC39040B783515DBC9D9B4006E2AD3EF2C290402ACAA174EA9D9B40E311A57AD5C290402ECDEAB2169E9B403241F2C7B5C290402BEA17E4409E9B40F894E54B93C29040259F7ED6689E9B4034E9162F6EC290407901195B8E9E9B402E08369D46C290403918BD45B19E9B40923DD7C41CC29040DED8506DD19E9B40DE813CD7F0C190403989FAABEE9E9B40A87E1B08C3C19040A04D4DDF089F9B400AB0608D93C19040E7AE71E81F9F9B40C8EAEF9E62C1904074E849AC339F9B400292627630C19040AED39113449F9B40C6C9C34EFDC090403C4BFA0A519F9B406EF64A64C9C09040C8E53F835A9F9B40010200000002000000A8301996CDC090405FE756F40C9F9B407649FE6FCBC0904018099C64F49E9B400102000000030000007649FE6FCBC0904018099C64F49E9B405E32B808D7C090401F2FE160F39E9B40D15CC31DD7C0904068C56851F49E9B40010200000002000000C3673A73CBC090402F04ED080F9F9B40A8301996CDC090405FE756F40C9F9B40010200000003000000A8301996CDC090405FE756F40C9F9B409219D32ED9C09040660D9CF00B9F9B401FEFC719D9C090401D7714000B9F9B400102000000020000001FEFC719D9C090401D7714000B9F9B40D15CC31DD7C0904068C56851F49E9B40010200000002000000D15CC31DD7C0904068C56851F49E9B402A65B979DDC09040F72AFBC2F39E9B40010200000002000000330DF5B1F3C090402C78170837A59B40651A54F9D7C090409C7EEC4D29A59B40010200000004000000651A54F9D7C090409C7EEC4D29A59B407B33669EC0C09040EC473ABD1DA59B407BBF6447C9C0904058A127400CA59B4090A652A2E0C090401CD8D9D017A59B4001020000000200000090A652A2E0C090401CD8D9D017A59B40651A54F9D7C090409C7EEC4D29A59B400102000000020000001EEFC719D9C090401D7714000B9F9B401FEFC719D9C090401D7714000B9F9B400102000000020000001FEFC719D9C090401D7714000B9F9B4076F7BD75DFC09040ACDCA6710A9F9B4001020000000300000076F7BD75DFC09040ACDCA6710A9F9B4078F7BD75DFC09040ACDCA6710A9F9B402A65B979DDC09040F72AFBC2F39E9B4001020000001F0000002A65B979DDC09040F72AFBC2F39E9B40D4DBD62DDEC09040D0577C25F29E9B40EB181DFEDEC090400B016F95F09E9B4060E78CE9DFC09040F859BD14EF9E9B40AAC905EFE0C090403DC43EA5ED9E9B403D5B470DE2C09040408EB548EC9E9B4028D9F242E3C090405ACBCC00EB9E9B40DDCF8C8EE4C090408A4816CFE99E9B402CEC7EEEE5C090401FA008B5E89E9B4022ED1961E7C09040AD6EFDB3E79E9B4077B497E4E8C0904097AB2FCDE69E9B4004731D77EAC090401927BA01E69E9B408EEEBD16ECC09040BF2F9652E59E9B402CDE7BC1EDC09040E6609AC0E49E9B40485A4C75EFC09040C99B794CE49E9B40645D1930F1C090404E2CC2F6E39E9B407452C4EFF2C09040A61ADDBFE39E9B40B6AD28B2F4C09040A3AA0DA8E39E9B40DB8C1E75F6C09040400971AFE39E9B40465B7D36F8C09040ED28FED5E39E9B4025771EF4F9C090409CCC851BE49E9B4027D4DFABFBC09040ABC1B27FE49E9B409698A65BFDC0904046480A02E59E9B409CB16101FFC09040CFA9ECA1E59E9B40905B0C9B00C1904094FC955EE69E9B402A9BB02602C19040E0131F37E79E9B40A2A469A203C190403C9B7E2AE89E9B40B22D660C05C190408D5B8A37E99E9B40C2A7EA6206C1904083A8F85CEA9E9B40645F53A407C190408DF46199EB9E9B40AC4934670AC190402EAE0A290B9F9B4001020000001E000000AD4934670AC190402DAE0A290B9F9B40BB539F6109C19040464875980C9F9B406921434308C19040E69DE8F40D9F9B404A967E0D07C1904081B6B93C0F9F9B409C44CDC105C1904017E2566E109F9B40309CC56104C1904068A54988119F9B4060F816EF02C19040D4843889129F9B40828F876B01C19040ABABE86F139F9B405A46F2D8FFC09040FA6D3F3B149F9B402A6A4439FEC09040E5A243EA149F9B4043547B8EFCC09040FAD51E7C159F9B40E4F9A1DAFAC09040F34D1EF0159F9B40686BCE1FF9C09040B9E7B345169F9B40E0451F60F7C090408DC4767C169F9B402F1AB99DF5C090408CCA2394169F9B40DFCCC3DAF3C09040E3F69D8C169F9B40DAF16719F2C090405C81EE65169F9B405427CC5BF0C0904017D14420169F9B401A7312A4EEC090407042F6BB159F9B4080A555F4ECC0904066BE7D39159F9B4024C5A64EEBC0904002247B99149F9B40B9860AB5E9C090407484B2DC139F9B40D8D37629E8C09040CA320B04139F9B400464D0ADE6C0904088A88E10129F9B40B66AE843E5C0904051406703119F9B40585D7AEDE3C090405BC8DEDD0F9F9B40D9D329ACE2C0904047EE5CA10E9F9B4095868081E1C090406C86654F0D9F9B40D86BEC6EE0C090409AB096E90B9F9B4076F7BD75DFC09040ACDCA6710A9F9B4001020000000200000090A652A2E0C090401CD8D9D017A59B405799F35AFCC09040A7D1048B25A59B400102000000040000005799F35AFCC09040A7D1048B25A59B407B4E2EE61DC190401094502736A59B407BC22F3D15C19040A83A63A447A59B40330DF5B1F3C090402C78170837A59B40010200000002000000330DF5B1F3C090402C78170837A59B405799F35AFCC09040A7D1048B25A59B400102000000020000005799F35AFCC09040A7D1048B25A59B407B9DF50620C19040D0028981DDA49B400102000000190000000F3353BD3CC19040317D6CEDD4A49B4092FE0F823BC19040E129C542D4A49B40DF08E03B3AC19040B92C0FAED3A49B407CB949EC38C190409D82FC2FD3A49B4007B8DE9437C190402D1024C9D2A49B40780B3A3736C1904030ED007AD2A49B40342EFED434C190403CD1F142D2A49B402E19D36F33C1904059A23824D2A49B407348640932C190402526FA1DD2A49B4089BB5EA330C19040CFD53D30D2A49B40FAF36E3F2FC1904024D5ED5AD2A49B4072F43EDF2DC19040BB0CD79DD2A49B40E34274842CC190401B67A9F8D2A49B4002F0AD302BC190409430F86AD3A49B4079A682E529C190405A993AF4D3A49B4037C47EA428C190404159CC93D4A49B400080226F27C190406274EE48D5A49B40981DE04626C19040AD1FC812D6A49B4099321A2D25C1904062C467F0D6A49B400CFE212324C190403821C4E0D7A49B40C9D4352A23C19040D987BDE2D8A49B4074A47F4322C1904030351FF5D9A49B40E98E137021C19040F9C2A016DBA49B40BB9FEEB020C19040CAB0E745DCA49B405D9DF50620C19040CE028981DDA49B40010200000003000000BD1916452FC19040C1B5FCC342929B40CEB36940CEC29040C6B5FCC342929B40CEB36940CEC290400D20B9D962869B400102000000020000007B3353BD3CC19040307D6CEDD4A49B4065CB5700E7C19040BF48A4C338A59B40010200000002000000FE3A167070C19040BFC1137EB2AB9B40FE3A167070C39040BFC1137EB2AB9B40010200000005000000FE3A167070C39040BFC1137EB2AB9B40FE3A167070C59040BFC1137EB2AB9B40FE3A167070C5904025287AE418AB9B40FE3A167070C1904025287AE418AB9B40FE3A167070C19040BFC1137EB2AB9B40010200000002000000005324C782C19040281C632AA9929B40351AD0A634C39040281C632AA9929B400102000000020000007B6BCADEACC19040FC2A8EAED3A69B407B26F1AAEAC19040D89C8207EDA69B40010200000002000000CC4AC57BB5C190408DBC5A0AEDA99B40030ABF6DB5C1904036777DFAD5A99B40010200000006000000030ABF6DB5C1904036777DFAD5A99B407BA556B6B1C190400009C0FCD5A99B407B90BA76B1C19040BC79FA626DA99B407B8C511BD4C190408450E94D6DA99B407BA0ED5AD4C19040C4DFAEE7D5A99B4025DA63DFB9C1904078A4C9F7D5A99B40010200000004000000030ABF6DB5C1904036777DFAD5A99B407B82166AB5C19040209072F6CFA99B407B52BBDBB9C1904060BDBEF3CFA99B4025DA63DFB9C1904078A4C9F7D5A99B4001020000000200000025DA63DFB9C1904078A4C9F7D5A99B40030ABF6DB5C1904036777DFAD5A99B40010200000004000000731B6AEDB9C19040CFE9A607EDA99B407BE4EFF6B9C19040281A61B0FCA99B407B134B85B5C19040E8EC14B3FCA99B40CC4AC57BB5C190408DBC5A0AEDA99B40010200000006000000731B6AEDB9C19040CFE9A607EDA99B407BA8EFC22CC2904028B6D1C1ECA99B407B89066C2CC2904038390CD75DA99B407B68CEE3A5C19040BCFCDB285EA99B407B87B73AA6C19040AC79A113EDA99B40CC4AC57BB5C190408DBC5A0AEDA99B40010200000002000000CC4AC57BB5C190408DBC5A0AEDA99B40731B6AEDB9C19040CFE9A607EDA99B4001020000000200000025DA63DFB9C1904078A4C9F7D5A99B40731B6AEDB9C19040CFE9A607EDA99B400102000000020000007BB99FDFE3C1904080CA5A0C7BA99B4006BA9FDFE3C1904080CA5A0C7BA99B4001020000000200000006BA9FDFE3C1904080CA5A0C7BA99B40EADED9E5E3C19040A089C94985A99B400102000000030000007B264914EEC190409A66E3996CA99B407B67DAD6E3C19040708B1DA06CA99B4006BA9FDFE3C1904080CA5A0C7BA99B4001020000000200000006BA9FDFE3C1904080CA5A0C7BA99B4006790E1DEEC19040AAA520067BA99B400102000000020000007BDED9E5E3C19040A089C94985A99B40EADED9E5E3C19040A089C94985A99B40010200000002000000EADED9E5E3C19040A089C94985A99B40CE0314ECE3C19040C04838878FA99B40010200000002000000EADED9E5E3C19040A089C94985A99B40EA9D4823EEC19040CA648F4385A99B400102000000020000007B0314ECE3C19040C04838878FA99B40CE0314ECE3C19040C04838878FA99B40010200000002000000CE0314ECE3C19040C04838878FA99B40B3284EF2E3C19040E007A7C499A99B40010200000002000000CE0314ECE3C19040C04838878FA99B40CEC28229EEC19040EA23FE808FA99B400102000000020000007B284EF2E3C19040E007A7C499A99B40B3284EF2E3C19040E007A7C499A99B40010200000002000000B3284EF2E3C19040E007A7C499A99B40974D88F8E3C1904000C71502A4A99B40010200000002000000B3284EF2E3C19040E007A7C499A99B40B3E7BC2FEEC190400AE36CBE99A99B400102000000020000007B4D88F8E3C1904000C71502A4A99B40974D88F8E3C1904000C71502A4A99B40010200000003000000974D88F8E3C1904000C71502A4A99B407B72C2FEE3C190402086843FAEA99B407B31313CEEC190404A614A39AEA99B40010200000002000000974D88F8E3C1904000C71502A4A99B40970CF735EEC190402AA2DBFBA3A99B4001020000000600000065CB5700E7C19040BF48A4C338A59B407B599CBA5BC29040641FFE9072A59B407B07298647C29040B0BA695E9BA59B407BEA9F115EC19040800DB6C327A59B407B3D134672C1904030724AF6FEA49B4065CB5700E7C19040BF48A4C338A59B4001020000000200000065CB5700E7C19040BF48A4C338A59B407BCB5700E7C19040CC48A4C338A59B400102000000170000005726F1AAEAC19040DB9C8207EDA69B40820F18FAEBC19040F9FECE83EDA69B4083CDEF50EDC190405E0FFBE8EDA69B406063E0ADEEC190408F688E36EEA69B40B1924A0FF0C190409DB92C6CEEA69B40C7C98973F1C1904001349689EEA69B402618F6D8F2C1904089D7A78EEEA69B400427E63DF4C19040FE9B5B7BEEA69B407533B1A0F5C190405578C84FEEA69B40DE07B1FFF6C190405847220CEEA69B406BF24359F8C19040F189B9B0EDA69B4019B6CEABF9C190405F07FB3DEDA69B401E74BEF5FAC19040C24B6FB4ECA69B404F8B8A35FCC190409B05BA14ECA69B405F6BB669FDC190400843995FEBA69B40BF59D390FEC19040948FE495EAA69B40092682A9FFC19040B8F38BB8E9A69B40EACB74B200C290403AD796C8E8A69B409C0070AA01C29040B0C722C7E7A69B4021AA4C9002C29040BA2462B5E6A69B40673EF96203C2904063B39A94E5A69B40D4087B2104C29040791A2466E4A69B409954EFCA04C290409A49662BE3A69B400102000000020000007B264914EEC190409866E3996CA99B407B264914EEC190409A66E3996CA99B400102000000020000007B264914EEC190409A66E3996CA99B4006790E1DEEC19040AAA520067BA99B400102000000020000007BA4268F02C29040ED1C6F8D6CA99B407B264914EEC190409A66E3996CA99B4001020000000200000006790E1DEEC19040AAA520067BA99B40EA9D4823EEC19040CA648F4385A99B4001020000000200000006790E1DEEC19040AAA520067BA99B4006387D5AF8C19040D580E6FF7AA99B40010200000002000000EA9D4823EEC19040CA648F4385A99B40CEC28229EEC19040EA23FE808FA99B40010200000002000000EA9D4823EEC19040CA648F4385A99B40EA5CB760F8C19040F53F553D85A99B40010200000002000000CEC28229EEC19040EA23FE808FA99B40B3E7BC2FEEC190400AE36CBE99A99B40010200000002000000CEC28229EEC19040EA23FE808FA99B40CE81F166F8C1904015FFC37A8FA99B40010200000002000000B3E7BC2FEEC190400AE36CBE99A99B40970CF735EEC190402AA2DBFBA3A99B40010200000002000000B3E7BC2FEEC190400AE36CBE99A99B40B3A62B6DF8C1904035BE32B899A99B40010200000002000000970CF735EEC190402AA2DBFBA3A99B407B31313CEEC190404A614A39AEA99B40010200000002000000970CF735EEC190402AA2DBFBA3A99B4097CB6573F8C19040557DA1F5A3A99B400102000000020000007B31313CEEC190404A614A39AEA99B407B31313CEEC190404C614A39AEA99B400102000000020000007B31313CEEC190404A614A39AEA99B407BAF0EB702C290409F17D62CAEA99B400102000000020000007BE5B751F8C19040C441A9936CA99B4006387D5AF8C19040D580E6FF7AA99B4001020000000200000006387D5AF8C19040D580E6FF7AA99B40EA5CB760F8C19040F53F553D85A99B4001020000000200000006387D5AF8C19040D580E6FF7AA99B4006F7EB9702C29040FF5BACF97AA99B40010200000002000000EA5CB760F8C19040F53F553D85A99B40CE81F166F8C1904015FFC37A8FA99B40010200000002000000EA5CB760F8C19040F53F553D85A99B40EA1B269E02C290401F1B1B3785A99B40010200000002000000CE81F166F8C1904015FFC37A8FA99B40B3A62B6DF8C1904035BE32B899A99B40010200000002000000CE81F166F8C1904015FFC37A8FA99B40CE4060A402C290403FDA89748FA99B40010200000002000000B3A62B6DF8C1904035BE32B899A99B4097CB6573F8C19040557DA1F5A3A99B40010200000002000000B3A62B6DF8C1904035BE32B899A99B40B3659AAA02C290405F99F8B199A99B4001020000000200000097CB6573F8C19040557DA1F5A3A99B407BF09F79F8C19040743C1033AEA99B4001020000000200000097CB6573F8C19040557DA1F5A3A99B40978AD4B002C290407F5867EFA3A99B400102000000020000007BA4268F02C29040EC1C6F8D6CA99B407BA4268F02C29040ED1C6F8D6CA99B400102000000020000007BA4268F02C29040ED1C6F8D6CA99B4006F7EB9702C29040FF5BACF97AA99B400102000000030000004651AC7E1CC290405423D1648FA99B407BB572691CC290400066B67D6CA99B407BA4268F02C29040ED1C6F8D6CA99B4001020000000200000006F7EB9702C29040FF5BACF97AA99B40EA1B269E02C290401F1B1B3785A99B4001020000000200000006F7EB9702C29040FF5BACF97AA99B4006B65AD50CC290402A3772F37AA99B40010200000002000000EA1B269E02C290401F1B1B3785A99B40CE4060A402C290403FDA89748FA99B40010200000002000000EA1B269E02C290401F1B1B3785A99B40EADA94DB0CC290404AF6E03085A99B40010200000002000000CE4060A402C290403FDA89748FA99B40B3659AAA02C290405F99F8B199A99B40010200000002000000CE4060A402C290403FDA89748FA99B40CEFFCEE10CC290406AB54F6E8FA99B40010200000002000000B3659AAA02C290405F99F8B199A99B40978AD4B002C290407F5867EFA3A99B40010200000002000000B3659AAA02C290405F99F8B199A99B40B32409E80CC290408A74BEAB99A99B40010200000002000000978AD4B002C290407F5867EFA3A99B407BAF0EB702C290409F17D62CAEA99B40010200000002000000978AD4B002C290407F5867EFA3A99B40974943EE0CC29040AA332DE9A3A99B400102000000020000007BAF0EB702C290409F17D62CAEA99B407BAF0EB702C29040A017D62CAEA99B400102000000020000007BAF0EB702C290409F17D62CAEA99B407B6E7DF40CC29040CAF29B26AEA99B400102000000020000007B90C24199C2904020B7235BB7A59B407B54EFCA04C290409849662BE3A69B400102000000020000007B6395CC0CC2904018F834876CA99B4006B65AD50CC290402A3772F37AA99B4001020000000200000006B65AD50CC290402A3772F37AA99B40EADA94DB0CC290404AF6E03085A99B4001020000000200000006B65AD50CC290402A3772F37AA99B407B0738721CC2904014A5F3E97AA99B40010200000002000000EADA94DB0CC290404AF6E03085A99B40CEFFCEE10CC290406AB54F6E8FA99B40010200000002000000EADA94DB0CC290404AF6E03085A99B407B2C72781CC290403464622785A99B40010200000002000000CEFFCEE10CC290406AB54F6E8FA99B40B32409E80CC290408A74BEAB99A99B40010200000002000000CEFFCEE10CC290406AB54F6E8FA99B404651AC7E1CC290405423D1648FA99B40010200000002000000B32409E80CC290408A74BEAB99A99B40974943EE0CC29040AA332DE9A3A99B40010200000002000000B32409E80CC290408A74BEAB99A99B407B75E6841CC2904074E23FA299A99B40010200000002000000974943EE0CC29040AA332DE9A3A99B407B6E7DF40CC29040CAF29B26AEA99B40010200000002000000974943EE0CC29040AA332DE9A3A99B407B9A208B1CC2904094A1AEDFA3A99B400102000000020000007B6E7DF40CC29040CAF29B26AEA99B407B6E7DF40CC29040CCF29B26AEA99B400102000000030000007B6E7DF40CC29040CAF29B26AEA99B407BBF5A911CC29040B4601D1DAEA99B404651AC7E1CC290405423D1648FA99B400102000000020000004651AC7E1CC290405423D1648FA99B407B51AC7E1CC290405423D1648FA99B400102000000020000007BE6F3A457C29040D02DA1D07AA59B407B635C4391C290406414DC999CA59B400102000000170000009990C24199C290401EB7235BB7A59B407BB65FD599C29040603A9515B6A59B40CF0C76529AC29040A07CB9C6B4A59B4080B870B89AC2904072FA1E70B3A59B40365ED6069BC29040F3675D13B2A59B40C0B2493D9BC2904096CB13B2B0A59B4019EA895B9BC290404990E64DAFA59B40840473619BC2904021917DE8ADA59B4064F9FD4E9BC29040F6208283ACA59B4098BF40249BC2904041109D20ABA59B405B336EE19AC2904091B374C1A9A59B40BCD9D5869AC29040F8ECAA67A8A59B40FC81E3149AC29040C03ADB14A7A59B4045C51E8C99C29040BBCD98CAA5A59B404A652AED98C290407AA96C8AA4A59B409A8AC33898C2904096D0D355A3A59B4086E3C06F97C290404C7F3D2EA2A59B40A7A4119396C2904076760915A1A59B40336CBCA395C29040F658860BA0A59B408009DEA294C290407A1DF0129FA59B400C2AA89193C290407F966E2C9EA59B40C2ED5F7192C29040451214599DA59B400F645C4391C290406514DC999CA59B40010200000002000000351AD0A634C390400D20B9D962869B40CEB36940CEC290400D20B9D962869B40010200000004000000B98848715DE290406F861F40C9859B40D4921F154EDA90406F861F40C9859B40CEB36940CEC290406F861F40C9859B40CEB36940CEC290400D20B9D962869B400102000000020000004AF1C368D8D690400D20B9D962869B40351AD0A634C390400D20B9D962869B40010200000003000000351AD0A634C390400D20B9D962869B40351AD0A634C390408E82C9900F899B40351AD0A634C39040281C632AA9929B40010200000005000000351AD0A634C39040281C632AA9929B409B80360D9BC59040281C632AA9929B409B80360D9BC5904073861F40C9889B404AF1C368D8D6904073861F40C9889B404AF1C368D8D690400D20B9D962869B40010200000002000000C54E2DC757C3904010BA5273FC9B9B40C64E2DC757C3904010BA5273FC9B9B40010200000002000000C64E2DC757C3904010BA5273FC9B9B404B3A7F7F76C3904010BA5273FC9B9B400102000000050000009DF29D0462C390409D7C489C589C9B409CF29D0462C390409D7C489C589C9B409CF29D0462C39040559BCD872A9C9B40C64E2DC757C39040559BCD872A9C9B40C64E2DC757C3904010BA5273FC9B9B40010200000004000000C64E2DC757C3904010BA5273FC9B9B40C64E2DC757C390400EBA5273FC9B9B404B3A7F7F76C390400EBA5273FC9B9B404B3A7F7F76C3904010BA5273FC9B9B400102000000030000004B3A7F7F76C3904010BA5273FC9B9B404B3A7F7F76C390409D7C489C589C9B409DF29D0462C390409D7C489C589C9B40010200000002000000FE3A167070C39040BFC1137EB2AB9B40FE3A167070C39040BFC1137EB2AD9B4001020000000200000070252F0103C99040BFC1137EB2AD9B40FE3A167070C39040BFC1137EB2AD9B4001020000000600000091D1850137F19040412E510218A89B4091D1850137F190404C05F57255A89B405322E20AF7E290404C05F57255A89B405322E20AF7E29040585BAD174CAE9B40FE3A167070C39040585BAD174CAE9B40FE3A167070C39040BFC1137EB2AD9B400102000000040000004A3A7F7F76C390409F7C489C589C9B404A3A7F7F76C39040A953EC0C969C9B4012F9857BB4DA9040A953EC0C969C9B4012F9857BB4DA904010BA5273FC9B9B400102000000020000004B3A7F7F76C3904010BA5273FC9B9B40E40F7AB2EDC6904010BA5273FC9B9B4001020000000200000042E3CF5222C790409F80713FA98A9B40B927B2271DC6904012DE70E9A88A9B40010200000004000000B927B2271DC6904012DE70E9A88A9B40199484FB06C690404F7D04D0C18A9B40199484FB06C690409F545B1E2A8C9B40B927B2271DC69040DCF3EE04438C9B40010200000034000000B927B2271DC69040DCF3EE04438C9B40B927B2271DC6904082D2E4F56E8C9B4041E3CF5222C7904082D2E4F56E8C9B407B7090F02AC790406B078BAA6E8C9B40183A088433C790404096D7C86D8C9B40EEC2FA023CC79040FDE3D7516C8C9B400D0C446344C79040EB884B476A8C9B404FAFE49A4CC790406A3AA2AB678C9B4036CE0DA054C7904078E2F881648C9B40E0C62C695CC7904081E815CE608C9B4014A1F6EC63C79040E4AF64945C8C9B40C62573226BC790408851F0D9578C9B40D393070172C79040D0965DA4528C9B4032E5808078C79040223DE4F94C8C9B4053981D997EC79040018A47E1468C9B4001F2964384C79040A238CE61408C9B40B9AC297989C7904095CA3983398C9B40150B9E338EC79040E345BD4D328C9B40B1434F6D92C79040AF6BF3C92A8C9B40A83D322196C790400573D400238C9B409B95DB4A99C790401E54ABFB1A8C9B401CE484E69BC79040DDB00AC4128C9B402E3F11F19DC79040BD67C1630A8C9B4071F110689FC79040E7DECEE4018C9B409B62C449A0C790404A155751F98B9B40B32D1E95A0C79040118896B3F08B9B40B32D1E95A0C79040DD49C93AFB8A9B409B62C449A0C79040A4BC089DF28A9B4071F110689FC7904007F39009EA8A9B402E3F11F19DC79040316A9E8AE18A9B401CE484E69BC790401121552AD98A9B409B95DB4A99C79040D07DB4F2D08A9B40A93D322196C79040E95E8BEDC88A9B40B2434F6D92C790403F666C24C18A9B40150B9E338EC790400A8CA2A0B98A9B40B9AC297989C790405907266BB28A9B4001F2964384C790404C99918CAB8A9B4053981D997EC79040ED47180DA58A9B4032E5808078C79040CC947BF49E8A9B40D393070172C790401D3B024A998A9B40C62573226BC7904066806F14948A9B4014A1F6EC63C790400A22FB598F8A9B40E0C62C695CC790406DE949208B8A9B4036CE0DA054C7904076EF666C878A9B404FAFE49A4CC790408497BD42848A9B400D0C446344C79040024914A7818A9B40EEC2FA023CC79040F1ED879C7F8A9B40183A088433C79040AD3B88257E8A9B407B7090F02AC7904083CAD4437D8A9B4042E3CF5222C790406CFF7AF87C8A9B40B927B2271DC690406CFF7AF87C8A9B40B927B2271DC6904012DE70E9A88A9B40010200000004000000B927B2271DC69040DCF3EE04438C9B40B927B2271DC690404F51EEAE428C9B4041E3CF5222C790404F51EEAE428C9B4042E3CF5222C790404F51EEAE428C9B4001020000000200000042E3CF5222C790406C4D3E0C768F9B40B927B2271DC69040DFAA3DB6758F9B40010200000004000000B927B2271DC69040DFAA3DB6758F9B40199484FB06C690401C4AD19C8E8F9B40199484FB06C690406C2128EBF6909B40B927B2271DC69040A9C0BBD10F919B40010200000034000000B927B2271DC69040A9C0BBD10F919B40B927B2271DC690404F9FB1C23B919B4041E3CF5222C790404F9FB1C23B919B407B7090F02AC7904038D457773B919B40183A088433C790400D63A4953A919B40EEC2FA023CC79040CAB0A41E39919B400D0C446344C79040B855181437919B404FAFE49A4CC7904037076F7834919B4036CE0DA054C7904045AFC54E31919B40E0C62C695CC790404EB5E29A2D919B4014A1F6EC63C79040B17C316129919B40C62573226BC79040551EBDA624919B40D393070172C790409D632A711F919B4032E5808078C79040EF09B1C619919B4053981D997EC79040CE5614AE13919B4001F2964384C790406F059B2E0D919B40B9AC297989C790406297065006919B40150B9E338EC79040B0128A1AFF909B40B1434F6D92C790407C38C096F7909B40A83D322196C79040D23FA1CDEF909B409B95DB4A99C79040EB2078C8E7909B401CE484E69BC79040AA7DD790DF909B402E3F11F19DC790408A348E30D7909B4071F110689FC79040B4AB9BB1CE909B409B62C449A0C7904017E2231EC6909B40B32D1E95A0C79040DE546380BD909B40B32D1E95A0C79040AA169607C88F9B409B62C449A0C790407189D569BF8F9B4071F110689FC79040D4BF5DD6B68F9B402E3F11F19DC79040FE366B57AE8F9B401CE484E69BC79040DEED21F7A58F9B409B95DB4A99C790409D4A81BF9D8F9B40A93D322196C79040B62B58BA958F9B40B2434F6D92C790400C3339F18D8F9B40150B9E338EC79040D7586F6D868F9B40B9AC297989C7904026D4F2377F8F9B4001F2964384C7904019665E59788F9B4053981D997EC79040BA14E5D9718F9B4032E5808078C79040996148C16B8F9B40D393070172C79040EA07CF16668F9B40C62573226BC79040334D3CE1608F9B4014A1F6EC63C79040D7EEC7265C8F9B40E0C62C695CC790403AB616ED578F9B4036CE0DA054C7904043BC3339548F9B404FAFE49A4CC7904051648A0F518F9B400D0C446344C79040CF15E1734E8F9B40EEC2FA023CC79040BEBA54694C8F9B40183A088433C790407A0855F24A8F9B407B7090F02AC790405097A1104A8F9B4042E3CF5222C7904039CC47C5498F9B40B927B2271DC6904039CC47C5498F9B40B927B2271DC69040DFAA3DB6758F9B40010200000004000000B927B2271DC69040A9C0BBD10F919B40B927B2271DC690401C1EBB7B0F919B4041E3CF5222C790401C1EBB7B0F919B4042E3CF5222C790401C1EBB7B0F919B40010200000004000000EBF4AD1157C79040F4C6572FDCA79B40F15E0A6437C790403B3BAB95E6A79B40C290A57682C69040F902A42B1EA99B40C7844F2289C690401D998AD63EA99B40010200000004000000EDE252CD6AC790401D8EDC41FFA59B40F34CAF1F4BC79040D61989DBF4A59B40C47E4A3296C6904018529045BDA49B40C972F4DD9CC69040F4BBA99A9CA49B40010200000002000000E40F7AB2EDC6904010BA5273FC9B9B401843ADE520DA904010BA5273FC9B9B40010200000004000000E40F7AB2EDC6904010BA5273FC9B9B40E40F7AB2EDC69040A553EC0C96999B401843ADE520DA9040A553EC0C96999B401843ADE520DA904010BA5273FC9B9B4001020000003000000042E3CF5222C790404F51EEAE428C9B4061FB09EB27C79040AA2C017E428C9B408E95967C2DC790409E2474EB418C9B40422CD00033C790402025F6F7408C9B405621217138C7904071CFA9A43F8C9B40E7990BC73DC79040341F24F33D8C9B40F33D31FC42C7904011876AE53B8C9B4049D25A0A48C790401287F07D398C9B40D5A37FEB4CC79040ACBF94BF368C9B4058BBCC9951C79040E6849DAD338C9B4005D1AB0F56C79040B8F5B44B308C9B40ADF7C9475AC79040529CE49D2C8C9B4082F71D3D5EC790407C9C90A8288C9B40E850EEEA61C79040D5757270248C9B4017E0D64C65C79040286093FA1F8C9B40DD1ACE5E68C79040A548464C1B8C9B4043E2291D6BC790401977216B168C9B4041E2A3846DC79040C2E2F75C118C9B40657A5D926FC79040B63ED2270C8C9B40A22AE34371C7904025C6E7D1068C9B4051802F9772C7904012D19661018C9B40CE7FAD8A73C790405D3A5DDDFB8B9B40DB873A1D74C7904030A0D04BF68B9B4080AC274E74C79040118896B3F08B9B4080AC274E74C79040DD49C93AFB8A9B40DB873A1D74C79040BE318FA2F58A9B40CF7FAD8A73C7904091970211F08A9B4051802F9772C79040DC00C98CEA8A9B40A22AE34371C79040C90B781CE58A9B40657A5D926FC7904038938DC6DF8A9B4042E2A3846DC790402CEF6791DA8A9B4043E2291D6BC79040D55A3E83D58A9B40DD1ACE5E68C79040498919A2D08A9B4017E0D64C65C79040C671CCF3CB8A9B40E850EEEA61C79040195CED7DC78A9B4082F71D3D5EC790407235CF45C38A9B40ADF7C9475AC790409C357B50BF8A9B4006D1AB0F56C7904036DCAAA2BB8A9B4058BBCC9951C79040084DC240B88A9B40D6A37FEB4CC790404212CB2EB58A9B404AD25A0A48C79040DC4A6F70B28A9B40F33D31FC42C79040DD4AF508B08A9B40E7990BC73DC79040BAB23BFBAD8A9B405621217138C790407D02B649AC8A9B40432CD00033C79040CEAC69F6AA8A9B408E95967C2DC7904050ADEB02AA8A9B4061FB09EB27C7904044A55E70A98A9B4042E3CF5222C790409F80713FA98A9B4001020000002000000042E3CF5222C790404F51EEAE428C9B40BEBC474628C790404C722D283E8C9B40200B5EE52DC79040497C283A398C9B40AB80162933C79040D2B3FFEA338C9B406059E60A38C79040CF134C412E8C9B402F7CBC843CC79040B81A1744288C9B40F104099140C79040E40BD2FA218C9B40CE2DC42A44C79040F6AF4C6D1B8C9B408C8F744D47C79040CA9FABA3148C9B40E0B034F549C79040FE255EA60D8C9B40FBDDB71E4CC79040AFC3137E068C9B4037424EC74DC790406565B133FF8B9B40D33EE8EC4EC790409E5546D0F78B9B409CFA188E4FC79040B4FA005DF08B9B40532718AA4FC790401C6E23E3E88B9B4090FAC2404FC7904026FBF76BE18B9B4090FAC2404FC79040C8D667820A8B9B40532718AA4FC79040D2633C0B038B9B409CFA188E4FC790403AD75E91FB8A9B40D33EE8EC4EC79040507C191EF48A9B4037424EC74DC79040896CAEBAEC8A9B40FBDDB71E4CC790403F0E4C70E58A9B40E0B034F549C79040F0AB0148DE8A9B408C8F744D47C790402432B44AD78A9B40CE2DC42A44C79040F7211381D08A9B40F104099140C790400AC68DF3C98A9B402F7CBC843CC7904036B748AAC38A9B406059E60A38C790401FBE13ADBD8A9B40AB80162933C790401C1E6003B88A9B40200B5EE52DC79040A55537B4B28A9B40BEBC474628C79040A25F32C6AD8A9B4042E3CF5222C790409F80713FA98A9B4001020000003000000042E3CF5222C790401C1EBB7B0F919B4061FB09EB27C7904077F9CD4A0F919B408E95967C2DC790406BF140B80E919B40422CD00033C79040EDF1C2C40D919B405621217138C790403E9C76710C919B40E7990BC73DC7904001ECF0BF0A919B40F33D31FC42C79040DE5337B208919B4049D25A0A48C79040DF53BD4A06919B40D5A37FEB4CC79040798C618C03919B4058BBCC9951C79040B3516A7A00919B4005D1AB0F56C7904085C28118FD909B40ADF7C9475AC790401F69B16AF9909B4082F71D3D5EC7904049695D75F5909B40E850EEEA61C79040A2423F3DF1909B4017E0D64C65C79040F52C60C7EC909B40DD1ACE5E68C7904072151319E8909B4043E2291D6BC79040E643EE37E3909B4041E2A3846DC790408FAFC429DE909B40657A5D926FC79040830B9FF4D8909B40A22AE34371C79040F292B49ED3909B4051802F9772C79040DF9D632ECE909B40CE7FAD8A73C790402A072AAAC8909B40DB873A1D74C79040FD6C9D18C3909B4080AC274E74C79040DE546380BD909B4080AC274E74C79040AA169607C88F9B40DB873A1D74C790408BFE5B6FC28F9B40CF7FAD8A73C790405E64CFDDBC8F9B4051802F9772C79040A9CD9559B78F9B40A22AE34371C7904096D844E9B18F9B40657A5D926FC7904005605A93AC8F9B4042E2A3846DC79040F9BB345EA78F9B4043E2291D6BC79040A2270B50A28F9B40DD1ACE5E68C790401656E66E9D8F9B4017E0D64C65C79040933E99C0988F9B40E850EEEA61C79040E628BA4A948F9B4082F71D3D5EC790403F029C12908F9B40ADF7C9475AC790406902481D8C8F9B4006D1AB0F56C7904003A9776F888F9B4058BBCC9951C79040D5198F0D858F9B40D6A37FEB4CC790400FDF97FB818F9B404AD25A0A48C79040A9173C3D7F8F9B40F33D31FC42C79040AA17C2D57C8F9B40E7990BC73DC79040877F08C87A8F9B405621217138C790404ACF8216798F9B40432CD00033C790409B7936C3778F9B408E95967C2DC790401D7AB8CF768F9B4061FB09EB27C7904011722B3D768F9B4042E3CF5222C790406C4D3E0C768F9B4001020000002000000042E3CF5222C790401C1EBB7B0F919B40BEBC474628C79040193FFAF40A919B40200B5EE52DC790401649F50606919B40AB80162933C790409F80CCB700919B406059E60A38C790409CE0180EFB909B402F7CBC843CC7904085E7E310F5909B40F104099140C79040B1D89EC7EE909B40CE2DC42A44C79040C37C193AE8909B408C8F744D47C79040976C7870E1909B40E0B034F549C79040CBF22A73DA909B40FBDDB71E4CC790407C90E04AD3909B4037424EC74DC7904032327E00CC909B40D33EE8EC4EC790406B22139DC4909B409CFA188E4FC7904081C7CD29BD909B40532718AA4FC79040E93AF0AFB5909B4090FAC2404FC79040F3C7C438AE909B4090FAC2404FC7904095A3344FD78F9B40532718AA4FC790409F3009D8CF8F9B409CFA188E4FC7904007A42B5EC88F9B40D33EE8EC4EC790401D49E6EAC08F9B4037424EC74DC7904056397B87B98F9B40FBDDB71E4CC790400CDB183DB28F9B40E0B034F549C79040BD78CE14AB8F9B408C8F744D47C79040F1FE8017A48F9B40CE2DC42A44C79040C4EEDF4D9D8F9B40F104099140C79040D7925AC0968F9B402F7CBC843CC7904003841577908F9B406059E60A38C79040EC8AE0798A8F9B40AB80162933C79040E9EA2CD0848F9B40200B5EE52DC79040722204817F8F9B40BEBC474628C790406F2CFF927A8F9B4042E3CF5222C790406C4D3E0C768F9B400102000000020000000A34FEC038C890405217F59E5FA89B40EBF4AD1157C79040F4C6572FDCA79B40010200000035000000EBF4AD1157C79040F4C6572FDCA79B40459055226DC79040C75F742FB6A79B403B71D5FC4EC89040511EB25439A89B40C53C7D4A56C89040315979E93DA89B4042BAC0435DC89040AFA81BFB42A89B402C0A4DE063C89040EB348C8348A89B4011F73D186AC89040E757307C4EA89B40DF6027E46FC89040707FE7DD54A89B40DE181E3D75C89040EFAE13A15BA89B40BD23C01C7AC89040DE96A2BD62A89B40E6573C7D7EC890402537172B6AA89B40ED4E595982C89040BB0094E071A89B40DEA17BAC85C890409D6AE5D479A89B40FB68AB7288C8904051ED8CFE81A89B4048F898A88AC89040FB57CC538AA89B4057D3A04B8CC890406071B1CA92A89B4086D3CE598DC8904015D721599BA89B40FA7CE0D18DC890408B0CE7F4A3A89B40857F46B38DC89040B6ABBA93ACA89B40BD6125FE8CC89040A7A8522BB5A89B40585555B38BC8904089996DB1BDA89B40293561D489C8904045F4DE1BC6A89B40D2AD846387C890404D339B60CEA89B406993A96384C89040E8D2C375D6A89B40456764D880C89040DC18B351DEA89B400D12F0C57CC890403E9807EBE5A89B404F447D8201C89040011E9132BAA99B406F09B6EDFCC790408BE93880C1A99B40F2B913DCF7C7904008677C79C8A99B40B52DA353F2C79040F2B60816CFA99B40BA0AFF5AECC79040D8A3F94DD5A99B4030E347F9E5C79040A60DE319DBA99B40B2B31B36DFC79040A4C5D972E0A99B40C2CB8C19D8C7904084D07B52E5A99B407C2B18ACD0C79040AD04F8B2E9A99B40E5619BF6C8C79040B3FB148FEDA99B4004F84902C1C79040A54E37E2F0A99B404F75A2D8B8C79040C11567A8F3A99B40A60A6383B0C790400EA554DEF5A99B4040F17D0CA8C790401D805C81F7A99B408B8B0D7E9FC790404D808A8FF8A99B40155648E296C79040C0299C07F9A99B40EAB674438EC790404C2C02E9F8A99B40F9B9DCAB85C79040830EE133F8A99B4018C9C1257DC790401E0211E9F6A99B405B6E50BB74C79040F0E11C0AF5A99B40542F94766CC79040985A4099F2A99B40B88F6B6164C7904030406599EFA99B40C4497C855CC790400C14200EECA99B4062CA27EC54C79040D4BEABFBE7A99B406DE9A71173C690404A006ED664A99B409E267F4D89C6904049072B8C3EA99B409307FF276BC79040D3C568B1C1A99B40010200000035000000EDE252CD6AC790401D8EDC41FFA59B40477EFADD80C790404AF5BF4125A69B403D5F7AB862C89040C036821CA2A59B40C72A22066AC89040E0FBBA879DA59B4044A865FF70C8904062AC187698A59B402EF8F19B77C890402620A8ED92A59B4013E5E2D37DC890402AFD03F58CA59B40E14ECC9F83C89040A1D54C9386A59B40E006C3F888C8904022A620D07FA59B40BF1165D88DC8904033BE91B378A59B40E845E13892C89040EC1D1D4671A59B40EF3CFE1496C890405654A09069A59B40E08F206899C8904074EA4E9C61A59B40FD56502E9CC89040C067A77259A59B404AE63D649EC8904016FD671D51A59B4059C14507A0C89040B1E382A648A59B4088C17315A1C89040FC7D121840A59B40FC6A858DA1C8904086484D7C37A59B40876DEB6EA1C890405BA979DD2EA59B40BF4FCAB9A0C890406AACE14526A59B405A43FA6E9FC8904088BBC6BF1DA59B402B2306909DC89040CC60555515A59B40D49B291F9BC89040C42199100DA59B406B814E1F98C89040298270FB04A59B404755099494C89040353C811FFDA49B400F00958190C89040D3BC2C86F5A49B405132223E15C890401037A33E21A49B4071F75AA910C89040866BFBF019A49B40F4A7B8970BC8904009EEB7F712A49B40B71B480F06C890401F9E2B5B0CA49B40BCF8A31600C8904039B13A2306A49B4032D1ECB4F9C790406B47515700A49B40B4A1C0F1F2C790406D8F5AFEFAA39B40C4B931D5EBC790408D84B81EF6A39B407E19BD67E4C7904064503CBEF1A39B40E74F40B2DCC790405E591FE2EDA39B4006E6EEBDD4C790406C06FD8EEAA39B4051634794CCC79040503FCDC8E7A39B40A8F8073FC4C7904003B0DF92E5A39B4042DF22C8BBC79040F4D4D7EFE3A39B408D79B239B3C79040C4D4A9E1E2A39B401744ED9DAAC79040512B9869E2A39B40ECA419FFA1C79040C5283288E2A39B40FBA7816799C790408E46533DE3A39B401AB766E190C79040F3522388E4A39B405D5CF57688C7904021731767E6A39B40561D393280C7904079FAF3D7E8A39B40BA7D101D78C79040E114CFD7EBA39B40C637214170C7904005411463EFA39B4064B8CCA768C790403D968875F3A39B406FD74CCD86C69040C754C69A76A49B40A01424099DC69040C84D09E59CA49B4095F5A3E37EC790403E8FCBBF19A49B400102000000020000000C22A37C4CC89040BF3D3FD27BA59B40EDE252CD6AC790401D8EDC41FFA59B400102000000300000009307FF276BC79040D3C568B1C1A99B406196201770C790407C424A56C4A99B403276813175C790407FD064A3C6A99B40395F0A717AC79040DC49F995C8A99B4033B077CF7FC79040EE94B42BCAA99B4077E8604685C79040BB6AB262CBA99B400D4E40CF8AC79040F8987F39CCA99B40A6B67A6390C7904019BD1BAFCCA99B402A6A67FC95C790405676FAC2CCA99B40791558939BC790403A0D0475CCA99B40D1C3A021A1C79040EC8F95C5CBA99B406DD59FA0A6C79040266380B5CAA99B40C9E9C509ACC790403F480946C9A99B401BB49D56B1C7904092D9E678C7A99B40B4B0D380B6C79040F27E3F50C5A99B4009B23D82BBC79040BFDCA6CEC2A99B40623CE254C0C7904087C01AF7BFA99B4072A7FFF2C4C79040FA8EFFCCBCA99B4045FD1257C9C7904068371C54B9A99B405D8EDE7BCDC79040A5B19590B5A99B402033705CD1C79040A60BEA86B1A99B401A3327F4D4C79040D60CEB3BADA99B4011CBB93ED8C790406F75B8B4A8A99B404E4B3A38DBC79040D0E0B9F6A3A99B400C19AD7B56C890400D5B30AFCFA89B40B6958E2059C890403FCC0EC0CAA89B40B923A96D5BC890406FECADA5C5A89B40159D3D605DC8904067032566C0A89B4028E8F8F55EC890406DB2B707BBA89B40F4BDF62C60C89040297ACE90B5A89B4031ECC30361C890409314EF07B0A89B405310607961C89040FBABB473AAA89B4090C93E8D61C8904076F8C7DAA4A89B407360483F61C89040284DD7439FA89B4026E3D98F60C89040D09E8EB599A89B405FB6C47F5FC89040338D8F3694A89B40799B4D105EC89040D87869CD8EA89B40CB2C2B435CC8904085AE918089A89B402CD2831A5AC89040ECB15B5684A89B40F92FEB9857C8904097B0F1547FA89B40C1135FC154C890403E264D827AA89B4033E2439751C890402EBB2FE475A89B40A28A601E4EC890405C651C8071A89B40DF04DA5A4AC8904043D4505B6DA89B40E05E2E5146C89040812FBF7A69A89B400F602F0642C89040862F08E365A89B40A9C8FC7E3DC890408F97759862A89B400A34FEC038C890405217F59E5FA89B400102000000110000009307FF276BC79040D3C568B1C1A99B409F5F549372C79040A76C59C4C0A99B40E8F78BE979C790407E739D53BFA99B409FD1872181C79040F010FF60BDA99B40DE7F4F3288C79040BAE2E9EEBAA99B405A4D1B138FC79040C1EB6700B8A99B4087255FBB95C7904045CD1D99B4A99B40A733D5229CC79040EA3F46BDB0A99B40872A8841A2C7904048D2AC71ACA99B403628DD0FA8C7904078F3A7BBA7A99B4050299D86ADC790400B5112A1A2A99B403A00FE9EB2C79040B59043289DA99B401CC5AA52B7C79040A26E085897A99B401DB4CB9BBBC79040534A9A3791A99B401E700D75BFC79040722C96CE8AA99B40F4A0A7D9C2C79040DA50F32484A99B4051E3ABC42EC890407C59CD4ACAA89B4001020000001100000095F5A3E37EC790403E8FCBBF19A49B40A14DF94E86C790406AE8DAAC1AA49B40EAE530A58DC7904093E1961D1CA49B40A1BF2CDD94C79040214435101EA49B40E06DF4ED9BC7904057724A8220A49B405C3BC0CEA2C790405069CC7023A49B4089130477A9C79040CC8716D826A49B40A9217ADEAFC790402715EEB32AA49B4089182DFDB5C79040C98287FF2EA49B40381682CBBBC7904099618CB533A49B4052174242C1C79040060422D038A49B403CEEA25AC6C790405CC4F0483EA49B401EB34F0ECBC790406FE62B1944A49B401FA27057CFC79040BE0A9A394AA49B40205EB230D3C790409F289EA250A49B40F68E4C95D6C790403704414C57A49B4053D1508042C8904095FB662611A59B4001020000003000000095F5A3E37EC790403E8FCBBF19A49B406384C5D283C790409512EA1A17A49B40346426ED88C790409284CFCD14A49B403B4DAF2C8EC79040350B3BDB12A49B40359E1C8B93C7904023C07F4511A49B4079D6050299C7904056EA810E10A49B400F3CE58A9EC7904019BCB4370FA49B40A8A41F1FA4C79040F89718C20EA49B402C580CB8A9C79040BBDE39AE0EA49B407B03FD4EAFC79040D74730FC0EA49B40D3B145DDB4C7904025C59EAB0FA49B406FC3445CBAC79040EBF1B3BB10A49B40CBD76AC5BFC79040D20C2B2B12A49B401DA24212C5C790407F7B4DF813A49B40B69E783CCAC790401FD6F42016A49B400BA0E23DCFC7904052788DA218A49B40642A8710D4C790408A94197A1BA49B407495A4AED8C7904017C634A41EA49B4047EBB712DDC79040A91D181D22A49B405F7C8337E1C790406CA39EE025A49B4022211518E5C790406B494AEA29A49B401C21CCAFE8C790403B4849352EA49B4013B95EFAEBC79040A2DF7BBC32A49B405039DFF3EEC7904041747A7A37A49B400E0752376AC8904004FA03C20BA59B40B88333DC6CC89040D28825B110A59B40BB114E296FC89040A26886CB15A59B40178BE21B71C89040AA510F0B1BA59B402AD69DB172C89040A4A27C6920A59B40F6AB9BE873C89040E8DA65E025A59B4033DA68BF74C890407E4045692BA59B4055FE043575C8904016A97FFD30A59B4092B7E34875C890409B5C6C9636A59B40754EEDFA74C89040E9075D2D3CA59B4028D17E4B74C8904041B6A5BB41A59B4061A4693B73C89040DEC7A43A47A59B407B89F2CB71C8904039DCCAA34CA59B40CD1AD0FE6FC890408CA6A2F051A59B402EC028D66DC8904025A3D81A57A59B40FB1D90546BC890407AA4421C5CA59B40C301047D68C89040D32EE7EE60A59B4035D0E85265C89040E399048D65A59B40A47805DA61C89040B5EF17F169A59B40E1F27E165EC89040CE80E3156EA59B40E24CD30C5AC89040902575F671A59B40114ED4C155C890408B252C8E75A59B40ABB6A13A51C8904082BDBED878A59B400C22A37C4CC89040BF3D3FD27BA59B4001020000001000000052E3ABC42EC890407C59CD4ACAA89B40850674DF32C89040B390F30AC4A89B4083AF498836C89040FE77D185BDA89B404AB2A0BA39C89040E53B81C3B6A89B40AC2280723CC89040BA0F69CCAFA89B40FB4387AC3EC89040A1BD30A9A8A89B40A3BBF16540C8904013E5B662A1A89B4062019B9C41C890403CF505029AA89B40F608014F42C89040F0F0489092A89B40CE21467C42C89040160AC0168BA89B408A0A322442C89040CF22B59E83A89B40E836324741C89040894270317CA89B40B74759E63FC89040640D2CD874A89B409AB55D033EC890403A4C0A9C6DA89B4026B097A03BC890408693088666A89B400A34FEC038C890405217F59E5FA89B4001020000001000000054D1508042C8904095FB662611A59B4087F4189B46C890405EC4406617A59B40859DEE434AC8904013DD62EB1DA59B404CA045764DC890402C19B3AD24A59B40AE10252E50C890405745CBA42BA59B40FD312C6852C89040709703C832A59B40A5A9962154C89040FE6F7D0E3AA59B4064EF3F5855C89040D55F2E6F41A59B40F8F6A50A56C890402164EBE048A59B40D00FEB3756C89040FB4A745A50A59B408CF8D6DF55C8904042327FD257A59B40EA24D70255C890408812C43F5FA59B40B935FEA153C89040AD47089966A59B409CA302BF51C89040D7082AD56DA59B40289E3C5C4FC890408BC12BEB74A59B400C22A37C4CC89040BF3D3FD27BA59B40010200000004000000686B210B87C8904087AC70F213999B40A50AB5F19FC8904027409E1E2A999B40F5E10B4008CA904027409E1E2A999B4032819F2621CA904087AC70F213999B4001020000003400000032819F2621CA904087AC70F213999B40D85F95174DCA904087AC70F213999B40D85F95174DCA9040FFF052C70E989B40C1943BCC4CCA9040C563922906989B40962388EA4BCA9040289A1A96FD979B40537188734ACA904052112817F5979B404116FC6848CA904033C8DEB6EC979B40C0C752CD45CA9040F1243E7FE4979B40CE6FA9A342CA90400A06157ADC979B40D775C6EF3ECA9040600DF6B0D4979B403A3D15B63ACA90402C332C2DCD979B40DEDEA0FB35CA90407AAEAFF7C5979B4026240EC630CA90406D401B19BF979B4078CA941B2BCA90400EEFA199B8979B405717F80225CA9040ED3B0581B2979B40F8C57E831ECA90403FE28BD6AC979B40EB57EAA417CA90408727F9A0A7979B4039D36D6F10CA90402BC984E6A2979B4005F9A3EB08CA90408F90D3AC9E979B405B00852201CA90409896F0F89A979B4074E15B1DF9C99040A53E47CF97979B40333EBBE5F0C9904024F09D3395979B4013F57185E8C990401295112993979B403D6C7F06E0C99040CFE211B291979B40A0A20773D7C99040A5715ED090979B40671547D5CEC990408DA6048590979B4033D7795CD9C890408DA6048590979B40FA49B9BED0C89040A5715ED090979B405D80412BC8C89040CFE211B291979B4087F74EACBFC890401295112993979B4067AE054CB7C8904024F09D3395979B40260B6514AFC89040A53E47CF97979B403FEC3B0FA7C890409796F0F89A979B4095F31C469FC890408E90D3AC9E979B40601953C297C890402BC984E6A2979B40AF94D68C90C890408727F9A0A7979B40A22642AE89C890403FE28BD6AC979B4043D5C82E83C89040ED3B0581B2979B4022222C167DC890400EEFA199B8979B4073C8B26B77C890406D401B19BF979B40BC0D203672C890407AAEAFF7C5979B4060AFAB7B6DC890402C332C2DCD979B40C376FA4169C89040600DF6B0D4979B40CC7C178E65C890400A06157ADC979B40DA246E6462C89040F1243E7FE4979B4058D6C4C85FC8904033C8DEB6EC979B40477B38BE5DC8904052112817F5979B4003C938475CC89040289A1A96FD979B40D95785655BC89040C563922906989B40C28C2B1A5BC89040FEF052C70E989B40C28C2B1A5BC8904087AC70F213999B40686B210B87C8904087AC70F213999B40010200000002000000F50D226187C89040FEF052C70E989B40686B210B87C8904087AC70F213999B40010200000030000000A5DE9ED020CA9040FEF052C70E989B4000BAB19F20CA9040DFD8182F09989B40F4B1240D20CA9040B23E8C9D03989B4076B2A6191FCA9040FEA75219FE979B40C75C5AC61DCA9040EAB201A9F8979B408AACD4141CCA9040593A1753F3979B4067141B071ACA90404D96F11DEE979B406814A19F17CA9040F701C80FE9979B40024D45E114CA90406B30A32EE4979B403C124ECF11CA9040E8185680DF979B400E83656D0ECA90403B03770ADB979B40A82995BF0ACA904093DC58D2D6979B40D22941CA06CA9040BEDC04DDD2979B402B03239202CA90405883342FCF979B407EED431CFEC9904029F44BCDCB979B40FBD5F66DF9C9904063B954BBC8979B406F04D28CF4C99040FDF1F8FCC5979B401870A87EEFC99040FFF17E95C3979B400CCC8249EAC99040DB59C587C1979B407B5398F3E4C990409EA93FD6BF979B40685E4783DFC99040EF53F382BE979B40B3C70DFFD9C990407254758FBD979B40862D816DD4C99040654CE8FCBC979B40671547D5CEC99040C027FBCBBC979B4033D7795CD9C89040C027FBCBBC979B4014BF3FC4D3C89040654CE8FCBC979B40E724B332CEC890407154758FBD979B40328E79AEC8C89040EF53F382BE979B401F99283EC3C890409EA93FD6BF979B408E203EE8BDC89040DB59C587C1979B40827C18B3B8C89040FEF17E95C3979B402BE8EEA4B3C89040FDF1F8FCC5979B409F16CAC3AEC8904063B954BBC8979B401CFF7C15AAC8904029F44BCDCB979B406FE99D9FA5C890405883342FCF979B40C8C27F67A1C89040BEDC04DDD2979B40F2C22B729DC8904093DC58D2D6979B408C695BC499C890403A03770ADB979B405EDA726296C89040E8185680DF979B40989F7B5093C890406A30A32EE4979B4032D81F9290C89040F601C80FE9979B4033D8A52A8EC890404D96F11DEE979B401040EC1C8CC89040593A1753F3979B40D38F666B8AC89040EAB201A9F8979B40243A1A1889C89040FDA75219FE979B40A63A9C2488C89040B23E8C9D03989B409A320F9287C89040DFD8182F09989B40F50D226187C89040FEF052C70E989B40010200000020000000A5DE9ED020CA9040FEF052C70E989B40A2FFDD491CCA90408217DBD308989B409F09D95B17CA904020C9C43403989B402841B00C12CA904095530CF1FD979B4025A1FC620CCA9040E07A3C0FF9979B400EA8C76506CA904011586695F4979B403A99821C00CA90404FCF1989F0979B404C3DFD8EF9C9904072A65EEFEC979B40202D5CC5F2C99040B444AECCE9979B4054B30EC8EBC990406023EE24E7979B400551C49FE4C9904045F66AFBE4979B40BBF26155DDC990400992D452E3979B40F4E2F6F1D5C990406D953A2DE2979B400A88B17ECEC99040A4D9098CE1979B4072FBD304C7C99040EDAC0A70E1979B407C88A88DBFC99040B0D95FD9E1979B401E6418A4E8C89040B0D95FD9E1979B4028F1EC2CE1C89040EDAC0A70E1979B4090640FB3D9C89040A4D9098CE1979B40A609CA3FD2C890406D953A2DE2979B40DFF95EDCCAC890400992D452E3979B40959BFC91C3C8904045F66AFBE4979B404639B269BCC890406023EE24E7979B407ABF646CB5C89040B444AECCE9979B404DAFC3A2AEC8904072A65EEFEC979B4060533E15A8C890404FCF1989F0979B408C44F9CBA1C8904011586695F4979B40754BC4CE9BC89040E07A3C0FF9979B4072AB102596C8904095530CF1FD979B40FBE2E7D590C8904020C9C43403989B40F8ECE2E78BC890408217DBD308989B40F50D226187C89040FEF052C70E989B40010200000003000000A9C938520CD29040A953EC0C96A09B40A9C938520CD29040BFC1137EB2AD9B4070252F0103C99040BFC1137EB2AD9B40010200000005000000A9C938520CD29040A953EC0C96A09B400B309FB872D09040A953EC0C96A09B400B309FB872D0904025287AE418AC9B4070252F0103C9904025287AE418AC9B4070252F0103C99040BFC1137EB2AD9B4001020000000400000063E6045B0BCA9040912D9B5A4B899B40F08805B10BCA9040912D9B5A4B899B40F08805B10BCA904019E9B885508A9B40F08805B10BCA90401AE9B885508A9B4001020000003400000063E6045B0BCA9040912D9B5A4B899B40BD070F6ADFC99040912D9B5A4B899B40BD070F6ADFC9904019E9B885508A9B40D4D268B5DFC9904053767923598A9B40FF431C97E0C99040F03FF1B6618A9B4042F61B0EE2C99040C6C8E3356A8A9B405451A818E4C99040E5112D96728A9B40D59F51B4E6C9904027B5CDCD7A8A9B40C7F7FADDE9C990400ED4F6D2828A9B40BEF1DD91EDC99040B8CC159C8A8A9B405B2A8FCBF1C99040ECA6DF1F928A9B40B7880386F6C990409E2B5C55998A9B406F4396BBFBC99040AB99F033A08A9B401D9D0F6601CA90400AEB69B3A68A9B403E50AC7E07CA90402B9E06CCAC8A9B409DA125FE0DCA9040D9F77F76B28A9B40AA0FBADC14CA904091B212ACB78A9B405C9436121CCA9040ED108766BC8A9B40906E009623CA9040894938A0C08A9B403A671F5F2BCA904080431B54C48A9B402186486433CA9040739BC47DC78A9B406229E99B3BCA9040F4E96D19CA8A9B40827232FC43CA90400645FA23CC8A9B4058FB247B4CCA904049F7F99ACD8A9B40F5C49C0E55CA90407368AD7CCE8A9B402E525DAC5DCA90408B3307C8CE8A9B4062902A2553CB90408B3307C8CE8A9B409B1DEBC25BCB90407368AD7CCE8A9B4038E7625664CB904049F7F99ACD8A9B400E7055D56CCB90400645FA23CC8A9B402EB99E3575CB9040F4E96D19CA8A9B406F5C3F6D7DCB9040739BC47DC78A9B40567B687285CB904081431B54C48A9B400074873B8DCB90408A4938A0C08A9B40354E51BF94CB9040ED108766BC8A9B40E6D2CDF49BCB904091B212ACB78A9B40F34062D3A2CB9040D9F77F76B28A9B405292DB52A9CB90402B9E06CCAC8A9B407345786BAFCB90400AEB69B3A68A9B40229FF115B5CB9040AB99F033A08A9B40D959844BBACB90409E2B5C55998A9B4035B8F805BFCB9040ECA6DF1F928A9B40D2F0A93FC3CB9040B8CC159C8A8A9B40C9EA8CF3C6CB90400ED4F6D2828A9B40BB42361DCACB904027B5CDCD7A8A9B403D91DFB8CCCB9040E5112D96728A9B404EEC6BC3CECB9040C6C8E3356A8A9B40929E6B3AD0CB9040F03FF1B6618A9B40BC0F1F1CD1CB904053767923598A9B40D3DA7867D1CB90401AE9B885508A9B40D3DA7867D1CB9040912D9B5A4B899B402DFC8276A5CB9040912D9B5A4B899B400102000000040000002DFC8276A5CB9040912D9B5A4B899B40F05CEF8F8CCB9040F1996D2E35899B40A085984124CA9040F1996D2E35899B4063E6045B0BCA9040912D9B5A4B899B40010200000020000000F08805B10BCA90401AE9B885508A9B40F367C63710CA904096C23079568A9B40F65DCB2515CA9040F81047185C8A9B406D26F4741ACA90408386FF5B618A9B4070C6A71E20CA9040385FCF3D668A9B4087BFDC1B26CA90400782A5B76A8A9B405BCE21652CCA9040C90AF2C36E8A9B40492AA7F232CA9040A633AD5D728A9B40753A48BC39CA904064955D80758A9B4041B495B940CA9040B8B61D28788A9B409016E0E147CA9040D3E3A0517A8A9B40DA74422C4FCA90400F4837FA7B8A9B40A184AD8F56CA9040AB44D11F7D8A9B408BDFF2025ECA9040740002C17D8A9B40236CD07C65CA90402B2D01DD7D8A9B4019DFFBF36CCA90406800AC737D8A9B4077038CDD43CB90406800AC737D8A9B406D76B7544BCB90402B2D01DD7D8A9B40050395CE52CB9040740002C17D8A9B40EF5DDA415ACB9040AB44D11F7D8A9B40B66D45A561CB90400F4837FA7B8A9B4000CCA7EF68CB9040D3E3A0517A8A9B404F2EF21770CB9040B8B61D28788A9B401BA83F1577CB904064955D80758A9B4048B8E0DE7DCB9040A633AD5D728A9B403514666C84CB9040C90AF2C36E8A9B400923ABB58ACB90400782A5B76A8A9B40201CE0B290CB9040385FCF3D668A9B4023BC935C96CB90408386FF5B618A9B409A84BCAB9BCB9040F81047185C8A9B409D7AC199A0CB904096C23079568A9B40A0598220A5CB90401AE9B885508A9B40010200000030000000F08805B10BCA90401AE9B885508A9B4095ADF2E10BCA90403901F31D568A9B40A1B57F740CCA9040669B7FAF5B8A9B401FB5FD670DCA90401A32B933618A9B40CE0A4ABB0ECA90402E270AA4668A9B400BBBCF6C10CA9040BF9FF4F96B8A9B402E53897A12CA9040CB431A2F718A9B402D5303E214CA904021D8433D768A9B40931A5FA017CA9040ADA9681E7B8A9B40595556B21ACA904030C1B5CC7F8A9B4087E43E141ECA9040DDD69442848A9B40ED3D0FC221CA904085FDB27A888A9B40C33D63B725CA90405AFD06708C8A9B406A6481EF29CA9040C056D71D908A9B40177A60652ECA9040EFE5BF7F938A9B409A91AD1333CA9040B520B791968A9B402663D2F437CA90401BE81250998A9B407DF7FB023DCA904019E88CB79B8A9B40899B213842CA90403D8046C59D8A9B401A140C8E47CA90407A30CC769F8A9B402D095DFE4CCA9040298618CAA08A9B40E29F968252CA9040A68596BDA18A9B400F3A231458CA9040B38D2350A28A9B402E525DAC5DCA904058B21081A28A9B4062902A2553CB904058B21081A28A9B4081A864BD58CB9040B38D2350A28A9B40AE42F14E5ECB9040A78596BDA18A9B4063D92AD363CB9040298618CAA08A9B4076CE7B4369CB90407A30CC769F8A9B40074766996ECB90403D8046C59D8A9B4013EB8BCE73CB90401AE88CB79B8A9B406A7FB5DC78CB90401BE81250998A9B40F650DABD7DCB9040B520B791968A9B407968276C82CB9040EFE5BF7F938A9B40267E06E286CB9040C056D71D908A9B40CDA4241A8BCB90405AFD06708C8A9B40A3A4780F8FCB904085FDB27A888A9B4009FE48BD92CB9040DED69442848A9B40378D311F96CB904030C1B5CC7F8A9B40FDC7283199CB9040AEA9681E7B8A9B40638F84EF9BCB904022D8433D768A9B40628FFE569ECB9040CB431A2F718A9B408527B864A0CB9040BF9FF4F96B8A9B40C2D73D16A2CB90402E270AA4668A9B40712D8A69A3CB90401B32B933618A9B40EF2C085DA4CB9040669B7FAF5B8A9B40FB3495EFA4CB90403901F31D568A9B40A0598220A5CB90401AE9B885508A9B4001020000000400000032819F2621CA904087AC70F213999B40A5DE9ED020CA904087AC70F213999B40A5DE9ED020CA9040FFF052C70E989B40A5DE9ED020CA9040FEF052C70E989B40010200000002000000A0598220A5CB90401AE9B885508A9B402DFC8276A5CB9040912D9B5A4B899B400102000000040000004A47D052CCCC904061F5ACD1A68E9B404A47D052CCCC9040EE97AD27A78E9B40C28BB227C7CB9040EE97AD27A78E9B40C18BB227C7CB9040EE97AD27A78E9B40010200000020000000C18BB227C7CB9040EE97AD27A78E9B4045B23A34C1CB9040F1766EAEAB8E9B40E3632495BBCB9040F46C739CB08E9B4058EE6B51B6CB90406B359CEBB58E9B40A3159C6FB1CB90406ED54F95BB8E9B40D4F2C5F5ACCB904085CE8492C18E9B40126A79E9A8CB904059DDC9DBC78E9B403541BE4FA5CB904047394F69CE8E9B4077DF0D2DA2CB90407349F032D58E9B4023BE4D859FCB90403FC33D30DC8E9B400891CA5B9DCB90408E258858E38E9B40CC2C34B39BCB9040D883EAA2EA8E9B4030309A8D9ACB90409F935506F28E9B40677469EC99CB904089EE9A79F98E9B40B0476AD099CB9040217B78F3008F9B407374BF399ACB904017EEA36A088F9B407374BF399ACB904075123454DF8F9B40B0476AD099CB90406B855FCBE68F9B40677469EC99CB904003123D45EE8F9B4030309A8D9ACB9040ED6C82B8F58F9B40CC2C34B39BCB9040B47CED1BFD8F9B400891CA5B9DCB9040FEDA4F6604909B4023BE4D859FCB90404D3D9A8E0B909B4077DF0D2DA2CB904019B7E78B12909B403541BE4FA5CB904046C7885519909B40126A79E9A8CB904033230EE31F909B40D4F2C5F5ACCB90400732532C26909B40A3159C6FB1CB90401E2B88292C909B4058EE6B51B6CB904021CB3BD331909B40E3632495BBCB90409893642237909B4045B23A34C1CB90409B8969103C909B40C18BB227C7CB90409E682A9740909B40010200000030000000C18BB227C7CB9040EE97AD27A78E9B40A273788FC1CB904093BC9A58A78E9B4075D9EBFDBBCB90409FC427EBA78E9B40C142B279B6CB90401DC4A5DEA88E9B40AD4D6109B1CB9040CC19F231AA8E9B401CD576B3ABCB904009CA77E3AB8E9B401031517EA6CB90402C6231F1AD8E9B40BA9C2770A1CB90402B62AB58B08E9B402ECB028F9CCB904091290717B38E9B40ABB3B5E097CB90405764FE28B68E9B40FE9DD66A93CB904085F3E68AB98E9B405677B8328FCB9040EB4CB738BD8E9B408177643D8BCB9040C14C0B2EC18E9B401B1E948F87CB904068732966C58E9B40EC8EAB2D84CB9040158908DCC98E9B402654B41B81CB904098A0558ACE8E9B40C08C585D7ECB904024727A6BD38E9B40C28CDEF57BCB90407B06A479D88E9B409EF424E879CB904087AAC9AEDD8E9B4061449F3678CB90401823B404E38E9B40B2EE52E376CB90402B180575E88E9B4035EFD4EF75CB9040E0AE3EF9ED8E9B4028E7475D75CB90400D49CB8AF38E9B4083C25A2C75CB90402C610523F98E9B4083C25A2C75CB9040609FD29BEE8F9B4028E7475D75CB90407FB70C34F48F9B4034EFD4EF75CB9040AC5199C5F98F9B40B2EE52E376CB904061E8D249FF8F9B4061449F3678CB904074DD23BA04909B409EF424E879CB904005560E100A909B40C18CDEF57BCB904011FA33450F909B40C08C585D7ECB9040688E5D5314909B402654B41B81CB9040F45F823419909B40EC8EAB2D84CB90407777CFE21D909B401B1E948F87CB9040248DAE5822909B408177643D8BCB9040CBB3CC9026909B405677B8328FCB9040A1B320862A909B40FD9DD66A93CB9040070DF1332E909B40ABB3B5E097CB9040359CD99531909B402DCB028F9CCB9040FBD6D0A734909B40B99C2770A1CB9040619E2C6637909B401031517EA6CB9040609EA6CD39909B401CD576B3ABCB9040833660DB3B909B40AD4D6109B1CB9040C0E6E58C3D909B40C042B279B6CB90406F3C32E03E909B4075D9EBFDBBCB9040ED3BB0D33F909B40A273788FC1CB9040F9433D6640909B40C18BB227C7CB90409E682A9740909B40010200000002000000C18BB227C7CB90409E682A9740909B404A47D052CCCC90402B0B2BED40909B400102000000040000004A47D052CCCC90402F66960CFE919B404A47D052CCCC9040BC089762FE919B40C28BB227C7CB9040BC089762FE919B40C18BB227C7CB9040BC089762FE919B40010200000020000000C18BB227C7CB9040BC089762FE919B4045B23A34C1CB9040BFE757E902929B40E3632495BBCB9040C2DD5CD707929B4058EE6B51B6CB904039A685260D929B40A3159C6FB1CB90403C4639D012929B40D4F2C5F5ACCB9040533F6ECD18929B40126A79E9A8CB9040274EB3161F929B403541BE4FA5CB904015AA38A425929B4077DF0D2DA2CB904041BAD96D2C929B4023BE4D859FCB90400D34276B33929B400891CA5B9DCB90405C9671933A929B40CC2C34B39BCB9040A6F4D3DD41929B4030309A8D9ACB90406D043F4149929B40677469EC99CB9040575F84B450929B40B0476AD099CB9040EFEB612E58929B407374BF399ACB9040E55E8DA55F929B407374BF399ACB904043831D8F36939B40B0476AD099CB904039F648063E939B40677469EC99CB9040D182268045939B4030309A8D9ACB9040BBDD6BF34C939B40CC2C34B39BCB904082EDD65654939B400891CA5B9DCB9040CC4B39A15B939B4023BE4D859FCB90401BAE83C962939B4077DF0D2DA2CB9040E727D1C669939B403541BE4FA5CB90401438729070939B40126A79E9A8CB90400194F71D77939B40D4F2C5F5ACCB9040D5A23C677D939B40A3159C6FB1CB9040EC9B716483939B4058EE6B51B6CB9040EF3B250E89939B40E3632495BBCB904066044E5D8E939B4045B23A34C1CB904069FA524B93939B40C18BB227C7CB90406CD913D297939B40010200000030000000C18BB227C7CB9040BC089762FE919B40A273788FC1CB9040612D8493FE919B4075D9EBFDBBCB90406D351126FF919B40C142B279B6CB9040EB348F1900929B40AD4D6109B1CB90409A8ADB6C01929B401CD576B3ABCB9040D73A611E03929B401031517EA6CB9040FAD21A2C05929B40BA9C2770A1CB9040F9D2949307929B402ECB028F9CCB90405F9AF0510A929B40ABB3B5E097CB904025D5E7630D929B40FE9DD66A93CB90405364D0C510929B405677B8328FCB9040B9BDA07314929B408177643D8BCB90408FBDF46818929B401B1E948F87CB904036E412A11C929B40EC8EAB2D84CB9040E3F9F11621929B402654B41B81CB904066113FC525929B40C08C585D7ECB9040F2E263A62A929B40C28CDEF57BCB904049778DB42F929B409EF424E879CB9040551BB3E934929B4061449F3678CB9040E6939D3F3A929B40B2EE52E376CB9040F988EEAF3F929B4035EFD4EF75CB9040AE1F283445929B4028E7475D75CB9040DBB9B4C54A929B4083C25A2C75CB9040FAD1EE5D50929B4083C25A2C75CB90402E10BCD645939B4028E7475D75CB90404D28F66E4B939B4034EFD4EF75CB90407AC2820051939B40B2EE52E376CB90402F59BC8456939B4061449F3678CB9040424E0DF55B939B409EF424E879CB9040D3C6F74A61939B40C18CDEF57BCB9040DF6A1D8066939B40C08C585D7ECB904036FF468E6B939B402654B41B81CB9040C2D06B6F70939B40EC8EAB2D84CB904045E8B81D75939B401B1E948F87CB9040F2FD979379939B408177643D8BCB90409924B6CB7D939B405677B8328FCB90406F240AC181939B40FD9DD66A93CB9040D57DDA6E85939B40ABB3B5E097CB9040030DC3D088939B402DCB028F9CCB9040C947BAE28B939B40B99C2770A1CB90402F0F16A18E939B401031517EA6CB90402E0F900891939B401CD576B3ABCB904051A7491693939B40AD4D6109B1CB90408E57CFC794939B40C042B279B6CB90403DAD1B1B96939B4075D9EBFDBBCB9040BBAC990E97939B40A273788FC1CB9040C7B426A197939B40C18BB227C7CB90406CD913D297939B40010200000002000000C18BB227C7CB90406CD913D297939B404A47D052CCCC9040F97B142898939B400102000000040000004A47D052CCCC90402B0B2BED40909B40EADAFD7EE2CC9040EE6B970628909B40EADAFD7EE2CC90409E9440B8BF8E9B404A47D052CCCC904061F5ACD1A68E9B400102000000340000004A47D052CCCC904061F5ACD1A68E9B404A47D052CCCC9040BB16B7E07A8E9B40C28BB227C7CB9040BB16B7E07A8E9B4088FEF189BECB9040D2E1102C7B8E9B40EB347AF6B5CB9040FD52C40D7C8E9B4015AC8777ADCB90404005C4847D8E9B40F6623E17A5CB90405260508F7F8E9B40B4BF9DDF9CCB9040D3AEF92A828E9B40CDA074DA94CB9040C506A354858E9B4023A855118DCB9040BC008608898E9B40EFCD8B8D85CB9040593937428D8E9B403D490F587ECB9040B597ABFC918E9B4030DB7A7977CB90406D523E32978E9B40D18901FA70CB90401BACB7DC9C8E9B40B0D664E16ACB90403C5F54F5A28E9B40027DEB3665CB90409BB0CD74A98E9B404AC2580160CB9040A81E6253B08E9B40EE63E4465BCB90405AA3DE88B78E9B40522B330D57CB90408E7DA80CBF8E9B405B31505953CB90403876C7D5C68E9B4068D9A62F50CB90401F95F0DACE8E9B40E78AFD934DCB904060389112D78E9B40D52F71894BCB90408081DA72DF8E9B40927D71124ACB9040560ACDF1E78E9B40680CBE3049CB9040F3D34485F08E9B40504164E548CB90402C610523F98E9B40504164E548CB9040609FD29BEE8F9B40680CBE3049CB9040992C9339F78F9B40927D71124ACB904036F60ACDFF8F9B40D52F71894BCB90400C7FFD4B08909B40E78AFD934DCB90402CC846AC10909B4068D9A62F50CB90406D6BE7E318909B405A31505953CB9040548A10E920909B40512B330D57CB9040FE822FB228909B40EE63E4465BCB9040335DF93530909B404AC2580160CB9040E4E1756B37909B40027DEB3665CB9040F14F0A4A3E909B40B0D664E16ACB904050A183C944909B40D18901FA70CB9040715420E24A909B4030DB7A7977CB904020AE998C50909B403D490F587ECB9040D7682CC255909B40EFCD8B8D85CB904033C7A07C5A909B4023A855118DCB9040D0FF51B65E909B40CDA074DA94CB9040C7F9346A62909B40B4BF9DDF9CCB9040B951DE9365909B40F6623E17A5CB90403BA0872F68909B4015AC8777ADCB90404CFB133A6A909B40EB347AF6B5CB904090AD13B16B909B4088FEF189BECB9040BA1EC7926C909B40C18BB227C7CB9040D1E920DE6C909B404A47D052CCCC9040D1E920DE6C909B404A47D052CCCC90402B0B2BED40909B400102000000040000004A47D052CCCC9040F97B142898939B40EADAFD7EE2CC9040BCDC80417F939B40EADAFD7EE2CC90406C052AF316929B404A47D052CCCC90402F66960CFE919B400102000000340000004A47D052CCCC90402F66960CFE919B404A47D052CCCC90408987A01BD2919B40C28BB227C7CB90408987A01BD2919B4088FEF189BECB9040A052FA66D2919B40EB347AF6B5CB9040CBC3AD48D3919B4015AC8777ADCB90400E76ADBFD4919B40F6623E17A5CB904020D139CAD6919B40B4BF9DDF9CCB9040A11FE365D9919B40CDA074DA94CB904093778C8FDC919B4023A855118DCB90408A716F43E0919B40EFCD8B8D85CB904027AA207DE4919B403D490F587ECB904083089537E9919B4030DB7A7977CB90403BC3276DEE919B40D18901FA70CB9040E91CA117F4919B40B0D664E16ACB90400AD03D30FA919B40027DEB3665CB90406921B7AF00929B404AC2580160CB9040768F4B8E07929B40EE63E4465BCB90402814C8C30E929B40522B330D57CB90405CEE914716929B405B31505953CB904006E7B0101E929B4068D9A62F50CB9040ED05DA1526929B40E78AFD934DCB90402EA97A4D2E929B40D52F71894BCB90404EF2C3AD36929B40927D71124ACB9040247BB62C3F929B40680CBE3049CB9040C1442EC047929B40504164E548CB9040FAD1EE5D50929B40504164E548CB90402E10BCD645939B40680CBE3049CB9040679D7C744E939B40927D71124ACB90400467F40757939B40D52F71894BCB9040DAEFE6865F939B40E78AFD934DCB9040FA3830E767939B4068D9A62F50CB90403BDCD01E70939B405A31505953CB904022FBF92378939B40512B330D57CB9040CCF318ED7F939B40EE63E4465BCB904001CEE27087939B404AC2580160CB9040B2525FA68E939B40027DEB3665CB9040BFC0F38495939B40B0D664E16ACB90401E126D049C939B40D18901FA70CB90403FC5091DA2939B4030DB7A7977CB9040EE1E83C7A7939B403D490F587ECB9040A5D915FDAC939B40EFCD8B8D85CB904001388AB7B1939B4023A855118DCB90409E703BF1B5939B40CDA074DA94CB9040956A1EA5B9939B40B4BF9DDF9CCB904087C2C7CEBC939B40F6623E17A5CB90400911716ABF939B4015AC8777ADCB90401A6CFD74C1939B40EB347AF6B5CB90405E1EFDEBC2939B4088FEF189BECB9040888FB0CDC3939B40C18BB227C7CB90409F5A0A19C4939B404A47D052CCCC90409F5A0A19C4939B404A47D052CCCC9040F97B142898939B400102000000020000007FEF83493FCD904049A4884DFE909B40E755EAAFA5CF904049A4884DFE909B40010200000003000000E555EAAFA5CF9040E23D22E797949B407FEF83493FCD9040E23D22E797949B407FEF83493FCD904049A4884DFE909B400102000000030000007FEF83493FCD904049A4884DFE909B407FEF83493FCD9040AF0AEFB3648D9B40EA55EAAFA5CF9040AF0AEFB3648D9B400102000000040000003038EED753CD904087AC70F213999B406DD781BE6CCD904027409E1E2A999B40BDAED80CD5CE904027409E1E2A999B40FA4D6CF3EDCE904087AC70F213999B40010200000034000000FA4D6CF3EDCE904087AC70F213999B40A02C62E419CF904087AC70F213999B40A02C62E419CF9040FFF052C70E989B408961089919CF9040C563922906989B405EF054B718CF9040289A1A96FD979B401B3E554017CF904052112817F5979B4009E3C83515CF904033C8DEB6EC979B4088941F9A12CF9040F1243E7FE4979B40963C76700FCF90400A06157ADC979B409F4293BC0BCF9040600DF6B0D4979B40020AE28207CF90402C332C2DCD979B40A6AB6DC802CF90407AAEAFF7C5979B40EEF0DA92FDCE90406D401B19BF979B40409761E8F7CE90400EEFA199B8979B401FE4C4CFF1CE9040ED3B0581B2979B40C0924B50EBCE90403FE28BD6AC979B40B324B771E4CE90408727F9A0A7979B4001A03A3CDDCE90402BC984E6A2979B40CDC570B8D5CE90408F90D3AC9E979B4023CD51EFCDCE90409896F0F89A979B403CAE28EAC5CE9040A53E47CF97979B40FB0A88B2BDCE904024F09D3395979B40DBC13E52B5CE90401295112993979B4005394CD3ACCE9040CFE211B291979B40686FD43FA4CE9040A5715ED090979B402FE213A29BCE90408DA6048590979B40FBA34629A6CD90408DA6048590979B40C216868B9DCD9040A5715ED090979B40254D0EF894CD9040CFE211B291979B404FC41B798CCD90401295112993979B402F7BD21884CD904024F09D3395979B40EED731E17BCD9040A53E47CF97979B4007B908DC73CD90409796F0F89A979B405DC0E9126CCD90408E90D3AC9E979B4028E61F8F64CD90402BC984E6A2979B407761A3595DCD90408727F9A0A7979B406AF30E7B56CD90403FE28BD6AC979B400BA295FB4FCD9040ED3B0581B2979B40EAEEF8E249CD90400EEFA199B8979B403B957F3844CD90406D401B19BF979B4084DAEC023FCD90407AAEAFF7C5979B40287C78483ACD90402C332C2DCD979B408B43C70E36CD9040600DF6B0D4979B409449E45A32CD90400A06157ADC979B40A2F13A312FCD9040F1243E7FE4979B4020A391952CCD904033C8DEB6EC979B400F48058B2ACD904052112817F5979B40CB95051429CD9040289A1A96FD979B40A124523228CD9040C563922906989B408A59F8E627CD9040FEF052C70E989B408A59F8E627CD904087AC70F213999B403038EED753CD904087AC70F213999B40010200000002000000BDDAEE2D54CD9040FEF052C70E989B403038EED753CD904087AC70F213999B400102000000300000006DAB6B9DEDCE9040FEF052C70E989B40C8867E6CEDCE9040DFD8182F09989B40BC7EF1D9ECCE9040B23E8C9D03989B403E7F73E6EBCE9040FEA75219FE979B408F292793EACE9040EAB201A9F8979B405279A1E1E8CE9040593A1753F3979B402FE1E7D3E6CE90404D96F11DEE979B4030E16D6CE4CE9040F701C80FE9979B40CA1912AEE1CE90406B30A32EE4979B4004DF1A9CDECE9040E8185680DF979B40D64F323ADBCE90403B03770ADB979B4070F6618CD7CE904093DC58D2D6979B409AF60D97D3CE9040BEDC04DDD2979B40F3CFEF5ECFCE90405883342FCF979B4046BA10E9CACE904029F44BCDCB979B40C3A2C33AC6CE904063B954BBC8979B4037D19E59C1CE9040FDF1F8FCC5979B40E03C754BBCCE9040FFF17E95C3979B40D4984F16B7CE9040DB59C587C1979B40432065C0B1CE90409EA93FD6BF979B40302B1450ACCE9040EF53F382BE979B407B94DACBA6CE90407254758FBD979B404EFA4D3AA1CE9040654CE8FCBC979B402FE213A29BCE9040C027FBCBBC979B40FBA34629A6CD9040C027FBCBBC979B40DC8B0C91A0CD9040654CE8FCBC979B40AFF17FFF9ACD90407154758FBD979B40FA5A467B95CD9040EF53F382BE979B40E765F50A90CD90409EA93FD6BF979B4056ED0AB58ACD9040DB59C587C1979B404A49E57F85CD9040FEF17E95C3979B40F3B4BB7180CD9040FDF1F8FCC5979B4067E396907BCD904063B954BBC8979B40E4CB49E276CD904029F44BCDCB979B4037B66A6C72CD90405883342FCF979B40908F4C346ECD9040BEDC04DDD2979B40BA8FF83E6ACD904093DC58D2D6979B405436289166CD90403A03770ADB979B4026A73F2F63CD9040E8185680DF979B40606C481D60CD90406A30A32EE4979B40FAA4EC5E5DCD9040F601C80FE9979B40FBA472F75ACD90404D96F11DEE979B40D80CB9E958CD9040593A1753F3979B409B5C333857CD9040EAB201A9F8979B40EC06E7E455CD9040FDA75219FE979B406E0769F154CD9040B23E8C9D03989B4062FFDB5E54CD9040DFD8182F09989B40BDDAEE2D54CD9040FEF052C70E989B400102000000200000006DAB6B9DEDCE9040FEF052C70E989B406ACCAA16E9CE90408217DBD308989B4067D6A528E4CE904020C9C43403989B40F00D7DD9DECE904095530CF1FD979B40ED6DC92FD9CE9040E07A3C0FF9979B40D6749432D3CE904011586695F4979B4002664FE9CCCE90404FCF1989F0979B40140ACA5BC6CE904072A65EEFEC979B40E8F92892BFCE9040B444AECCE9979B401C80DB94B8CE90406023EE24E7979B40CD1D916CB1CE904045F66AFBE4979B4083BF2E22AACE90400992D452E3979B40BCAFC3BEA2CE90406D953A2DE2979B40D2547E4B9BCE9040A4D9098CE1979B403AC8A0D193CE9040EDAC0A70E1979B404455755A8CCE9040B0D95FD9E1979B40E630E570B5CD9040B0D95FD9E1979B40F0BDB9F9ADCD9040EDAC0A70E1979B405831DC7FA6CD9040A4D9098CE1979B406ED6960C9FCD90406D953A2DE2979B40A7C62BA997CD90400992D452E3979B405D68C95E90CD904045F66AFBE4979B400E067F3689CD90406023EE24E7979B40428C313982CD9040B444AECCE9979B40157C906F7BCD904072A65EEFEC979B4028200BE274CD90404FCF1989F0979B405411C6986ECD904011586695F4979B403D18919B68CD9040E07A3C0FF9979B403A78DDF162CD904095530CF1FD979B40C3AFB4A25DCD904020C9C43403989B40C0B9AFB458CD90408217DBD308989B40BDDAEE2D54CD9040FEF052C70E989B40010200000016000000B2A0DCC249D29040FD0B0B9281A09B405709049006D2904019FD60457FA09B408245A6ADC3D190408AD2236278A09B40EEC5DD6B81D19040484693F06CA09B4039A9041A40D1904014E963FE5CA09B40DCB2550600D1904078B8AE9E48A09B40509A8E7DC1D09040823FDAE92FA09B408C2294CA84D09040AA5D7DFD12A09B40ED6718364AD09040D8D63BFCF19F9B4006D0430612D0904000D79C0DCD9F9B407B03617EDCCF9040FC9ADB5DA49F9B40B2568CDEA9CF90406877B21D789F9B40BD0167637ACF9040D67C2082489F9B408283CE454ECF90405EFF29C4159F9B40158798BA25CF9040724D9420E09E9B40D79C53F200CF9040D0E79CD7A79E9B401B130D19E0CE9040B491AC2C6D9E9B40FC331C56C3CE904070950666309E9B409827F3CBAACE9040229E74CCF19D9B4011B3F59796CE9040408BEFAAB19D9B40C90556D286CE904072A6454E709D9B40F9BEF78D7BCE90402FA7BE042E9D9B400102000000020000006697A68C93CE904055FAC9A9FD9C9B40EDE37C1E93CE9040480F9FBEF89C9B40010200000002000000EDE37C1E93CE9040480F9FBEF89C9B4093CE5931A3CE904062E600A2F39C9B40010200000002000000EDE37C1E93CE9040480F9FBEF89C9B40BB8FC93AD0CE90402227EC65F39C9B400102000000040000006697A68C93CE904055FAC9A9FD9C9B406697A68C93CE904057FAC9A9FD9C9B403443F3A8D0CE904032121751F89C9B403443F3A8D0CE904030121751F89C9B400102000000040000000E1FC89097CE90401C3B61912B9D9B40246D637A7ACE9040CDD4DA1C2E9D9B407CE5417676CE904006944335009D9B406697A68C93CE904055FAC9A9FD9C9B400102000000020000003443F3A8D0CE904030121751F89C9B406697A68C93CE904055FAC9A9FD9C9B400102000000020000000E1FC89097CE90401C3B61912B9D9B4088D2F1FE97CE90402C268C7C309D9B400102000000030000000E1FC89097CE90401C3B61912B9D9B40DCCA14ADD4CE9040F652AE38269D9B40DCCA14ADD4CE9040F752AE38269D9B40010200000002000000DCCA14ADD4CE9040F752AE38269D9B400E1FC89097CE90401C3B61912B9D9B4001020000000200000088D2F1FE97CE90402C268C7C309D9B40465C88B6A8CE9040EAF7BEBA329D9B4001020000000200000088D2F1FE97CE90402C268C7C309D9B40557E3E1BD5CE9040063ED9232B9D9B400102000000020000005BF6A7139CCE9040C15DA0F6B49C9B40FBAF50A3BBCE90407973BF33B29C9B400102000000190000006EEA58539CCE9040765E3F24DA9C9B4028CD127B9BCE904000E40058D99C9B40594A5C499ACE90404AED660CD89C9B40EDA14E2F99CE9040FAD074ACD69C9B407B70432E98CE904004D0D939D59C9B4065AD754797CE9040B0085CB6D39C9B40E728007C96CE9040234AD623D29C9B408D31DCCC95CE904098CE3584D09C9B40B462E03A95CE9040FBDE77D9CE9C9B40989DBFC694CE9040E062A725CD9C9B401C2E087194CE9040C45FDA6ACB9C9B40751C233A94CE9040B46A2FABC99C9B4071AC532294CE9040710FCBE8C79C9B400F0BB72994CE90404C30D525C69C9B40BB2A445094CE9040E0617664C49C9B406ACECB9594CE90400246D5A6C29C9B4079C3F8F994CE904000E913EFC09C9B40144A507C95CE904090244D3FBF9C9B409DAB321C96CE90408A0B9299BD9C9B4063FEDBD896CE90409761E7FFBB9C9B40AF1565B197CE9040FC214374BA9C9B400A9DC4A498CE904085188AF8B89C9B405B5DD0B199CE9040748F8D8EB79C9B4051AA3ED79ACE904064150938B69C9B405CF6A7139CCE9040C25DA0F6B49C9B400102000000020000003F79A14E9CCE9040A901A924DA9C9B406EEA58539CCE9040765E3F24DA9C9B40010200000006000000B373DF74A2CE90402711C956DE9C9B40DA02B50FA1CE90403CA4D69CDD9C9B40C65B038F9FCE9040C6D566B1DC9C9B400CC6841F9ECE90407DF3EDABDB9C9B400E90FBC29CCE9040EA61AC8DDA9C9B406EEA58539CCE9040765E3F24DA9C9B400102000000020000006EEA58539CCE9040765E3F24DA9C9B406E234FD9C1CE9040CBB3D5DBD69C9B400102000000020000000605FB71A2CE9040B0D80957DE9C9B40B373DF74A2CE90402711C956DE9C9B40010200000003000000C52C413DA4CE9040FC573A21DF9C9B409F59C29FA2CE904052E11C6DDE9C9B40B373DF74A2CE90402711C956DE9C9B40010200000002000000B373DF74A2CE90402711C956DE9C9B40AA42388ABCCE9040F4DF970EDC9C9B4001020000000200000093CE5931A3CE904062E600A2F39C9B40E60AE2DEA4CE9040B273F52AF19C9B4001020000000200000093CE5931A3CE904062E600A2F39C9B40FD053383BFCE90406455B927F19C9B4001020000000200000036C7AECBA4CE90405560307DE59C9B40C52C413DA4CE9040FC573A21DF9C9B40010200000002000000C52C413DA4CE9040FC573A21DF9C9B407ADEECEBBACE9040B0C53525DD9C9B4001020000000200000036C7AECBA4CE90405660307DE59C9B4036C7AECBA4CE90405560307DE59C9B40010200000003000000E60AE2DEA4CE9040B273F52AF19C9B40ED3027DBA3CE9040C88A3B92E59C9B4036C7AECBA4CE90405560307DE59C9B4001020000000200000036C7AECBA4CE90405560307DE59C9B40EB785A7ABBCE904007CE2B81E39C9B40010200000002000000E60AE2DEA4CE9040B273F52AF19C9B402DE99C6EBDCE90407E8CDA04EF9C9B40010200000002000000A6CDB45BA6CE9040B53C0C074D9D9B40D63E6C60A6CE90408299A2064D9D9B4001020000001900000048B26A96ACCE9040D4D9B8AE719D9B402F180027ABCE9040E2E323A9709D9B408FC28CCAA9CE904090B1C78A6F9D9B40F4A9BB82A8CE9040722603556E9D9B405E7E1E51A7CE9040C4D451096D9D9B400CBB2B37A6CE9040582C4AA96B9D9B40A1DB3C36A5CE904088889B366A9D9B40CAB48C4FA4CE9040AA1F0CB3689D9B407BF23584A3CE904081D67620679D9B4090BD31D5A2CE904051FAC880659D9B407B8A5643A2CE90406AE4FFD5639D9B40821257CFA1CE90400C8A2622629D9B40BC78C179A1CE90408FFB5267609D9B40E79BFE42A1CE904007D6A3A75E9D9B40E895512BA1CE904056AA3DE55C9D9B409269D732A1CE9040065D48225B9D9B4019DF8659A1CE90400282EC60599D9B405E8F309FA1CE90407CB750A3579D9B40051E7F03A2CE9040420397EB559D9B400FA2F785A2CE9040A735DA3B549D9B40723CFA25A3CE90404C552B96529D9B4001DCC2E2A3CE9040E0168FFC509D9B40AA2D6ABBA4CE9040FF63FB704F9D9B40EDB7E6AEA5CE90402CF454F54D9D9B40D63E6C60A6CE90408299A2064D9D9B40010200000006000000D63E6C60A6CE90408299A2064D9D9B4024200EBCA6CE9040DEFA6C8B4C9D9B401A9896E1A7CE90407FEDFE344B9D9B402E72181EA9CE90400064AEF3499D9B4009DA0F70AACE9040BC1605C9489D9B409B1F83AFABCE9040596DE0D3479D9B40010200000002000000D63E6C60A6CE90408299A2064D9D9B40D57762E6CBCE9040D8EE38BE499D9B40010200000002000000465C88B6A8CE9040EAF7BEBA329D9B4016791ECBAACE9040D0C09DDD349D9B40010200000002000000465C88B6A8CE9040EAF7BEBA329D9B40B0936108C5CE9040EC667740309D9B4001020000000300000016791ECBAACE9040D0C09DDD349D9B400E53D9CEABCE9040B9A95776409D9B4057E960BFACCE9040467F4C61409D9B4001020000000200000016791ECBAACE9040D0C09DDD349D9B405C57D95AC3CE90409DD982B7329D9B40010200000002000000EFB09EACABCE9040E23421D4479D9B409B1F83AFABCE9040596DE0D3479D9B400102000000030000009B1F83AFABCE9040596DE0D3479D9B40DBAFDED5ABCE9040FFFB70B6479D9B40C983CE4DADCE90409E8742BD469D9B400102000000020000009B1F83AFABCE9040596DE0D3479D9B4092EEDBC4C5CE9040283CAF8B459D9B4001020000000200000047B26A96ACCE9040D4D9B8AE719D9B4048B26A96ACCE9040D4D9B8AE719D9B4001020000000200000048B26A96ACCE9040D4D9B8AE719D9B40E86B1326CCCE90408DEFD7EB6E9D9B4001020000000400000057E960BFACCE9040467F4C61409D9B40C883CE4DADCE90409E8742BD469D9B407E357AFCC3CE904051F53DC1449D9B400C9B0C6EC3CE9040FBEC47653E9D9B4001020000000200000057E960BFACCE9040467F4C61409D9B400C9B0C6EC3CE9040FBEC47653E9D9B40010200000002000000EB785A7ABBCE904007CE2B81E39C9B407ADEECEBBACE9040B0C53525DD9C9B40010200000003000000AA42388ABCCE9040F4DF970EDC9C9B4068B2DC63BCCE90404F51072CDC9C9B407ADEECEBBACE9040B0C53525DD9C9B40010200000002000000EB785A7ABBCE904008CE2B81E39C9B40EB785A7ABBCE904007CE2B81E39C9B40010200000003000000EB785A7ABBCE904007CE2B81E39C9B40340FE26ABCCE904094A3206CE39C9B402DE99C6EBDCE90407E8CDA04EF9C9B40010200000019000000FCAF50A3BBCE90407A73BF33B29C9B40144ABB12BDCE90406C695439B39C9B40B49F2E6FBECE9040BE9BB057B49C9B404FB8FFB6BFCE9040DC26758DB59C9B40E5E39CE8C0CE90408A7826D9B69C9B4037A78F02C2CE9040F6202E39B89C9B40A2867E03C3CE9040C6C4DCABB99C9B4079AD2EEAC3CE9040A42D6C2FBB9C9B40C86F85B5C4CE9040CD7601C2BC9C9B40B4A48964C5CE9040FD52AF61BE9C9B40C8D764F6C5CE9040E368780CC09C9B40C14F646AC6CE904042C351C0C19C9B4087E9F9BFC6CE9040BE51257BC39C9B405CC6BCF6C6CE90404777D43AC59C9B405BCC690EC7CE9040F7A23AFDC69C9B40B1F8E306C7CE904047F02FC0C89C9B402B8334E0C6CE90404CCB8B81CA9C9B40E6D28A9AC6CE9040D295273FCC9C9B403E443C36C6CE90400C4AE1F6CD9C9B4034C0C3B3C5CE9040A7179EA6CF9C9B40D125C113C5CE904002F84C4CD19C9B404286F856C4CE90406E36E9E5D29C9B409934517EC3CE90404EE97C71D49C9B4056AAD48AC2CE9040225923EDD59C9B406E234FD9C1CE9040CBB3D5DBD69C9B400102000000060000006E234FD9C1CE9040CBB3D5DBD69C9B402042AD7DC1CE904070520B57D79C9B4029CA2458C0CE9040CF5F79ADD89C9B4015F0A21BBFCE90404DE9C9EED99C9B403A88ABC9BDCE904092367319DB9C9B40AA42388ABCCE9040F4DF970EDC9C9B40010200000002000000AA42388ABCCE9040F4DF970EDC9C9B4054B11C8DBCCE90406B18570EDC9C9B40010200000002000000FD053383BFCE90406455B927F19C9B402DE99C6EBDCE90407E8CDA04EF9C9B40010200000002000000BB8FC93AD0CE90402227EC65F39C9B40FD053383BFCE90406455B927F19C9B400102000000020000006E234FD9C1CE9040CBB3D5DBD69C9B409D9406DEC1CE904098106CDBD69C9B400102000000030000005C57D95AC3CE90409DD982B7329D9B405631945EC4CE904088C23C503E9D9B400C9B0C6EC3CE9040FBEC47653E9D9B40010200000002000000B0936108C5CE9040EC667740309D9B405C57D95AC3CE90409DD982B7329D9B400102000000020000000C9B0C6EC3CE9040FAEC47653E9D9B400C9B0C6EC3CE9040FBEC47653E9D9B400102000000030000007E357AFCC3CE904052F53DC1449D9B40A508F999C5CE9040FC6B5B75459D9B4092EEDBC4C5CE9040283CAF8B459D9B40010200000002000000557E3E1BD5CE9040063ED9232B9D9B40B0936108C5CE9040EC667740309D9B4001020000000600000092EEDBC4C5CE9040283CAF8B459D9B406A5F062AC7CE904012A9A145469D9B407D06B8AAC8CE904088771131479D9B40389C361ACACE9040D1598A36489D9B4035D2BF76CBCE904064EBCB54499D9B40D57762E6CBCE9040D8EE38BE499D9B4001020000000200000092EEDBC4C5CE9040283CAF8B459D9B403D5DC0C7C5CE90409F746E8B459D9B40010200000019000000D57762E6CBCE9040D8EE38BE499D9B401B95A8BECCCE90404F69778A4A9D9B40EB175FF0CDCE9040046011D64B9D9B4056C06C0ACFCE9040547C03364D9D9B40C8F1770BD0CE90404A7D9EA84E9D9B40DEB445F2D0CE90409E441C2C509D9B405C39BBBDD1CE90402B03A2BE519D9B40B630DF6CD2CE9040B67E425E539D9B408FFFDAFED2CE9040546E0009559D9B40ACC4FB72D3CE90406FEAD0BC569D9B402834B3C8D3CE90408BED9D77589D9B40CF4598FFD3CE90409BE248375A9D9B40D2B56717D4CE9040DD3DADF95B9D9B4035570410D4CE9040021DA3BC5D9D9B40883777E9D3CE90406EEB017E5F9D9B40D993EFA3D3CE90404C07A33B619D9B40CA9EC23FD3CE90404E6464F3629D9B402F186BBDD2CE9040BE282BA3649D9B40A6B6881DD2CE9040C441E648669D9B40E163DF60D1CE9040B7EB90E2679D9B40954C5688D0CE9040522B356E699D9B403AC5F694CFCE9040CA34EEE96A9D9B40E804EB87CECE9040DABDEA536C9D9B40F2B77C62CDCE9040EA376FAA6D9D9B40E86B1326CCCE90408CEFD7EB6E9D9B40010200000002000000D57762E6CBCE9040D8EE38BE499D9B4004E919EBCBCE9040A54BCFBD499D9B400102000000020000003443F3A8D0CE904030121751F89C9B40BB8FC93AD0CE90402227EC65F39C9B40010200000002000000B2A0DCC249D29040599BCD87AA9C9B403443F3A8D0CE904030121751F89C9B40010200000002000000DCCA14ADD4CE9040F752AE38269D9B40557E3E1BD5CE9040063ED9232B9D9B40010200000003000000B2A0DCC249D29040599BCD87AA9C9B405A28FEC64DD2904020DC646FD89C9B40DCCA14ADD4CE9040F752AE38269D9B4001020000000400000030B3D127D8CE9040912D9B5A4B899B40BD55D27DD8CE9040912D9B5A4B899B40BD55D27DD8CE904019E9B885508A9B40BD55D27DD8CE90401AE9B885508A9B4001020000003400000030B3D127D8CE9040912D9B5A4B899B408AD4DB36ACCE9040912D9B5A4B899B408AD4DB36ACCE904019E9B885508A9B40A19F3582ACCE904053767923598A9B40CC10E963ADCE9040F03FF1B6618A9B400FC3E8DAAECE9040C6C8E3356A8A9B40211E75E5B0CE9040E5112D96728A9B40A26C1E81B3CE904027B5CDCD7A8A9B4094C4C7AAB6CE90400ED4F6D2828A9B408BBEAA5EBACE9040B8CC159C8A8A9B4028F75B98BECE9040ECA6DF1F928A9B408455D052C3CE90409E2B5C55998A9B403C106388C8CE9040AB99F033A08A9B40EA69DC32CECE90400AEB69B3A68A9B400B1D794BD4CE90402B9E06CCAC8A9B406A6EF2CADACE9040D9F77F76B28A9B4077DC86A9E1CE904091B212ACB78A9B40296103DFE8CE9040ED108766BC8A9B405D3BCD62F0CE9040894938A0C08A9B400734EC2BF8CE904080431B54C48A9B40EE52153100CF9040739BC47DC78A9B402FF6B56808CF9040F4E96D19CA8A9B404F3FFFC810CF90400645FA23CC8A9B4025C8F14719CF904049F7F99ACD8A9B40C29169DB21CF90407368AD7CCE8A9B40FB1E2A792ACF90408B3307C8CE8A9B402F5DF7F11FD090408B3307C8CE8A9B4068EAB78F28D090407368AD7CCE8A9B4005B42F2331D0904049F7F99ACD8A9B40DB3C22A239D090400645FA23CC8A9B40FB856B0242D09040F4E96D19CA8A9B403C290C3A4AD09040739BC47DC78A9B402348353F52D0904081431B54C48A9B40CD4054085AD090408A4938A0C08A9B40021B1E8C61D09040ED108766BC8A9B40B39F9AC168D0904091B212ACB78A9B40C00D2FA06FD09040D9F77F76B28A9B401F5FA81F76D090402B9E06CCAC8A9B40401245387CD090400AEB69B3A68A9B40EF6BBEE281D09040AB99F033A08A9B40A626511887D090409E2B5C55998A9B400285C5D28BD09040ECA6DF1F928A9B409FBD760C90D09040B8CC159C8A8A9B4096B759C093D090400ED4F6D2828A9B40880F03EA96D0904027B5CDCD7A8A9B400A5EAC8599D09040E5112D96728A9B401BB938909BD09040C6C8E3356A8A9B405F6B38079DD09040F03FF1B6618A9B4089DCEBE89DD0904053767923598A9B40A0A745349ED090401AE9B885508A9B40A0A745349ED09040912D9B5A4B899B40FAC84F4372D09040912D9B5A4B899B40010200000004000000FAC84F4372D09040912D9B5A4B899B40BD29BC5C59D09040F1996D2E35899B406D52650EF1CE9040F1996D2E35899B4030B3D127D8CE9040912D9B5A4B899B40010200000020000000BD55D27DD8CE90401AE9B885508A9B40C0349304DDCE904096C23079568A9B40C32A98F2E1CE9040F81047185C8A9B403AF3C041E7CE90408386FF5B618A9B403D9374EBECCE9040385FCF3D668A9B40548CA9E8F2CE90400782A5B76A8A9B40289BEE31F9CE9040C90AF2C36E8A9B4016F773BFFFCE9040A633AD5D728A9B404207158906CF904064955D80758A9B400E8162860DCF9040B8B61D28788A9B405DE3ACAE14CF9040D3E3A0517A8A9B40A7410FF91BCF90400F4837FA7B8A9B406E517A5C23CF9040AB44D11F7D8A9B4058ACBFCF2ACF9040740002C17D8A9B40F0389D4932CF90402B2D01DD7D8A9B40E6ABC8C039CF90406800AC737D8A9B4044D058AA10D090406800AC737D8A9B403A43842118D090402B2D01DD7D8A9B40D2CF619B1FD09040740002C17D8A9B40BC2AA70E27D09040AB44D11F7D8A9B40833A12722ED090400F4837FA7B8A9B40CD9874BC35D09040D3E3A0517A8A9B401CFBBEE43CD09040B8B61D28788A9B40E8740CE243D0904064955D80758A9B401585ADAB4AD09040A633AD5D728A9B4002E1323951D09040C90AF2C36E8A9B40D6EF778257D090400782A5B76A8A9B40EDE8AC7F5DD09040385FCF3D668A9B40F088602963D090408386FF5B618A9B406751897868D09040F81047185C8A9B406A478E666DD0904096C23079568A9B406D264FED71D090401AE9B885508A9B40010200000030000000BD55D27DD8CE90401AE9B885508A9B40627ABFAED8CE90403901F31D568A9B406E824C41D9CE9040669B7FAF5B8A9B40EC81CA34DACE90401A32B933618A9B409BD71688DBCE90402E270AA4668A9B40D8879C39DDCE9040BF9FF4F96B8A9B40FB1F5647DFCE9040CB431A2F718A9B40FA1FD0AEE1CE904021D8433D768A9B4060E72B6DE4CE9040ADA9681E7B8A9B402622237FE7CE904030C1B5CC7F8A9B4054B10BE1EACE9040DDD69442848A9B40BA0ADC8EEECE904085FDB27A888A9B40900A3084F2CE90405AFD06708C8A9B4037314EBCF6CE9040C056D71D908A9B40E4462D32FBCE9040EFE5BF7F938A9B40675E7AE0FFCE9040B520B791968A9B40F32F9FC104CF90401BE81250998A9B404AC4C8CF09CF904019E88CB79B8A9B405668EE040FCF90403D8046C59D8A9B40E7E0D85A14CF90407A30CC769F8A9B40FAD529CB19CF9040298618CAA08A9B40AF6C634F1FCF9040A68596BDA18A9B40DC06F0E024CF9040B38D2350A28A9B40FB1E2A792ACF904058B21081A28A9B402F5DF7F11FD0904058B21081A28A9B404E75318A25D09040B38D2350A28A9B407B0FBE1B2BD09040A78596BDA18A9B4030A6F79F30D09040298618CAA08A9B40439B481036D090407A30CC769F8A9B40D41333663BD090403D8046C59D8A9B40E0B7589B40D090401AE88CB79B8A9B40374C82A945D090401BE81250998A9B40C31DA78A4AD09040B520B791968A9B404635F4384FD09040EFE5BF7F938A9B40F34AD3AE53D09040C056D71D908A9B409A71F1E657D090405AFD06708C8A9B40707145DC5BD0904085FDB27A888A9B40D6CA158A5FD09040DED69442848A9B40045AFEEB62D0904030C1B5CC7F8A9B40CA94F5FD65D09040AEA9681E7B8A9B40305C51BC68D0904022D8433D768A9B402F5CCB236BD09040CB431A2F718A9B4052F484316DD09040BF9FF4F96B8A9B408FA40AE36ED090402E270AA4668A9B403EFA563670D090401B32B933618A9B40BCF9D42971D09040669B7FAF5B8A9B40C80162BC71D090403901F31D568A9B406D264FED71D090401AE9B885508A9B40010200000004000000FA4D6CF3EDCE904087AC70F213999B406DAB6B9DEDCE904087AC70F213999B406DAB6B9DEDCE9040FFF052C70E989B406DAB6B9DEDCE9040FEF052C70E989B400102000000030000004CBC50160CD2904049A4884DFE909B404CBC50160CD29040E23D22E797949B40E555EAAFA5CF9040E23D22E797949B40010200000002000000E555EAAFA5CF9040E23D22E797949B40E755EAAFA5CF904049A4884DFE909B40010200000002000000E755EAAFA5CF904049A4884DFE909B404CBC50160CD2904049A4884DFE909B40010200000002000000E755EAAFA5CF904049A4884DFE909B40EA55EAAFA5CF9040AF0AEFB3648D9B40010200000003000000EA55EAAFA5CF9040AF0AEFB3648D9B404CBC50160CD29040AF0AEFB3648D9B404CBC50160CD2904049A4884DFE909B400102000000020000006D264FED71D090401AE9B885508A9B40FAC84F4372D09040912D9B5A4B899B40010200000002000000AFA0DCC249D29040A953EC0C96A09B40A9C938520CD29040A953EC0C96A09B40010200000004000000FD04BBA420D2904087AC70F213999B403AA44E8B39D2904027409E1E2A999B408A7BA5D9A1D3904027409E1E2A999B40C71A39C0BAD3904087AC70F213999B40010200000034000000C71A39C0BAD3904087AC70F213999B406DF92EB1E6D3904087AC70F213999B406DF92EB1E6D39040FFF052C70E989B40562ED565E6D39040C563922906989B402BBD2184E5D39040289A1A96FD979B40E80A220DE4D3904052112817F5979B40D6AF9502E2D3904033C8DEB6EC979B405561EC66DFD39040F1243E7FE4979B406309433DDCD390400A06157ADC979B406C0F6089D8D39040600DF6B0D4979B40CFD6AE4FD4D390402C332C2DCD979B4073783A95CFD390407AAEAFF7C5979B40BBBDA75FCAD390406D401B19BF979B400D642EB5C4D390400EEFA199B8979B40ECB0919CBED39040ED3B0581B2979B408D5F181DB8D390403FE28BD6AC979B4080F1833EB1D390408727F9A0A7979B40CE6C0709AAD390402BC984E6A2979B409A923D85A2D390408F90D3AC9E979B40F0991EBC9AD390409896F0F89A979B40097BF5B692D39040A53E47CF97979B40C8D7547F8AD3904024F09D3395979B40A88E0B1F82D390401295112993979B40D20519A079D39040CFE211B291979B40353CA10C71D39040A5715ED090979B40FCAEE06E68D390408DA6048590979B40C87013F672D290408DA6048590979B408FE352586AD29040A5715ED090979B40F219DBC461D29040CFE211B291979B401C91E84559D290401295112993979B40FC479FE550D2904024F09D3395979B40BBA4FEAD48D29040A53E47CF97979B40D485D5A840D290409796F0F89A979B402A8DB6DF38D290408E90D3AC9E979B40F5B2EC5B31D290402BC984E6A2979B40442E70262AD290408727F9A0A7979B4037C0DB4723D290403FE28BD6AC979B40D86E62C81CD29040ED3B0581B2979B40B7BBC5AF16D290400EEFA199B8979B4008624C0511D290406D401B19BF979B4051A7B9CF0BD290407AAEAFF7C5979B40F548451507D290402C332C2DCD979B40581094DB02D29040600DF6B0D4979B406116B127FFD190400A06157ADC979B406FBE07FEFBD19040F1243E7FE4979B40ED6F5E62F9D1904033C8DEB6EC979B40DC14D257F7D1904052112817F5979B409862D2E0F5D19040289A1A96FD979B406EF11EFFF4D19040C563922906989B405726C5B3F4D19040FEF052C70E989B405726C5B3F4D1904087AC70F213999B40FD04BBA420D2904087AC70F213999B400102000000020000008AA7BBFA20D29040FEF052C70E989B40FD04BBA420D2904087AC70F213999B400102000000300000003A78386ABAD39040FEF052C70E989B4095534B39BAD39040DFD8182F09989B40894BBEA6B9D39040B23E8C9D03989B400B4C40B3B8D39040FEA75219FE979B405CF6F35FB7D39040EAB201A9F8979B401F466EAEB5D39040593A1753F3979B40FCADB4A0B3D390404D96F11DEE979B40FDAD3A39B1D39040F701C80FE9979B4097E6DE7AAED390406B30A32EE4979B40D1ABE768ABD39040E8185680DF979B40A31CFF06A8D390403B03770ADB979B403DC32E59A4D3904093DC58D2D6979B4067C3DA63A0D39040BEDC04DDD2979B40C09CBC2B9CD390405883342FCF979B401387DDB597D3904029F44BCDCB979B40906F900793D3904063B954BBC8979B40049E6B268ED39040FDF1F8FCC5979B40AD09421889D39040FFF17E95C3979B40A1651CE383D39040DB59C587C1979B4010ED318D7ED390409EA93FD6BF979B40FDF7E01C79D39040EF53F382BE979B404861A79873D390407254758FBD979B401BC71A076ED39040654CE8FCBC979B40FCAEE06E68D39040C027FBCBBC979B40C87013F672D29040C027FBCBBC979B40A958D95D6DD29040654CE8FCBC979B407CBE4CCC67D290407154758FBD979B40C727134862D29040EF53F382BE979B40B432C2D75CD290409EA93FD6BF979B4023BAD78157D29040DB59C587C1979B401716B24C52D29040FEF17E95C3979B40C081883E4DD29040FDF1F8FCC5979B4034B0635D48D2904063B954BBC8979B40B19816AF43D2904029F44BCDCB979B40048337393FD290405883342FCF979B405D5C19013BD29040BEDC04DDD2979B40875CC50B37D2904093DC58D2D6979B402103F55D33D290403A03770ADB979B40F3730CFC2FD29040E8185680DF979B402D3915EA2CD290406A30A32EE4979B40C771B92B2AD29040F601C80FE9979B40C8713FC427D290404D96F11DEE979B40A5D985B625D29040593A1753F3979B406829000524D29040EAB201A9F8979B40B9D3B3B122D29040FDA75219FE979B403BD435BE21D29040B23E8C9D03989B402FCCA82B21D29040DFD8182F09989B408AA7BBFA20D29040FEF052C70E989B400102000000200000003A78386ABAD39040FEF052C70E989B40379977E3B5D390408217DBD308989B4034A372F5B0D3904020C9C43403989B40BDDA49A6ABD3904095530CF1FD979B40BA3A96FCA5D39040E07A3C0FF9979B40A34161FF9FD3904011586695F4979B40CF321CB699D390404FCF1989F0979B40E1D6962893D3904072A65EEFEC979B40B5C6F55E8CD39040B444AECCE9979B40E94CA86185D390406023EE24E7979B409AEA5D397ED3904045F66AFBE4979B40508CFBEE76D390400992D452E3979B40897C908B6FD390406D953A2DE2979B409F214B1868D39040A4D9098CE1979B4007956D9E60D39040EDAC0A70E1979B401122422759D39040B0D95FD9E1979B40B3FDB13D82D29040B0D95FD9E1979B40BD8A86C67AD29040EDAC0A70E1979B4025FEA84C73D29040A4D9098CE1979B403BA363D96BD290406D953A2DE2979B407493F87564D290400992D452E3979B402A35962B5DD2904045F66AFBE4979B40DBD24B0356D290406023EE24E7979B400F59FE054FD29040B444AECCE9979B40E2485D3C48D2904072A65EEFEC979B40F5ECD7AE41D290404FCF1989F0979B4021DE92653BD2904011586695F4979B400AE55D6835D29040E07A3C0FF9979B400745AABE2FD2904095530CF1FD979B40907C816F2AD2904020C9C43403989B408D867C8125D290408217DBD308989B408AA7BBFA20D29040FEF052C70E989B40010200000007000000B2A0DCC249D29040599BCD87AA9C9B40FA8157D777D29040599BCD87AA9C9B40FA8157D777D29040303F3EC5B49C9B404163D2EBA5D29040303F3EC5B49C9B404163D2EBA5D29040AB53EC0C969C9B40B2A0DCC249D29040AB53EC0C969C9B40B2A0DCC249D29040599BCD87AA9C9B40010200000007000000B2A0DCC249D29040FD0B0B9281A09B40FA8157D777D29040FD0B0B9281A09B40FA8157D777D2904025689A5477A09B404163D2EBA5D2904025689A5477A09B404163D2EBA5D29040AA53EC0C96A09B40B2A0DCC249D29040AA53EC0C96A09B40B2A0DCC249D29040FD0B0B9281A09B40010200000002000000D22A2FD88BD39040F297AD27A78E9B40496F11AD86D2904065F5ACD1A68E9B40010200000004000000496F11AD86D2904065F5ACD1A68E9B40A9DBE38070D29040A29440B8BF8E9B40A9DBE38070D29040F26B970628909B40496F11AD86D290402F0B2BED40909B40010200000034000000496F11AD86D290402F0B2BED40909B40496F11AD86D29040D5E920DE6C909B40D12A2FD88BD39040D5E920DE6C909B400BB8EF7594D39040BE1EC7926C909B40A88167099DD3904093AD13B16B909B407E0A5A88A5D3904050FB133A6A909B409D53A3E8ADD390403EA0872F68909B40DFF64320B6D39040BD51DE9365909B40C6156D25BED39040CBF9346A62909B40700E8CEEC5D39040D4FF51B65E909B40A4E85572CDD3904037C7A07C5A909B40566DD2A7D4D39040DB682CC255909B4063DB6686DBD3904023AE998C50909B40C22CE005E2D39040755420E24A909B40E3DF7C1EE8D3904054A183C944909B409139F6C8EDD39040F54F0A4A3E909B4049F488FEF2D39040E8E1756B37909B40A552FDB8F7D39040365DF93530909B40418BAEF2FBD3904002832FB228909B40388591A6FFD39040588A10E920909B402BDD3AD002D49040716BE7E318909B40AC2BE46B05D4904030C846AC10909B40BE86707607D49040107FFD4B08909B40013970ED08D490403AF60ACDFF8F9B402BAA23CF09D490409D2C9339F78F9B4043757D1A0AD49040649FD29BEE8F9B4043757D1A0AD4904030610523F98E9B402BAA23CF09D49040F7D34485F08E9B40013970ED08D490405A0ACDF1E78E9B40BE86707607D490408481DA72DF8E9B40AC2BE46B05D4904064389112D78E9B402BDD3AD002D490402395F0DACE8E9B40398591A6FFD390403C76C7D5C68E9B40428BAEF2FBD39040927DA80CBF8E9B40A552FDB8F7D390405DA3DE88B78E9B4049F488FEF2D39040AC1E6253B08E9B409139F6C8EDD390409FB0CD74A98E9B40E3DF7C1EE8D39040405F54F5A28E9B40C22CE005E2D390401FACB7DC9C8E9B4063DB6686DBD3904070523E32978E9B40566DD2A7D4D39040B997ABFC918E9B40A4E85572CDD390405D3937428D8E9B40700E8CEEC5D39040C0008608898E9B40C6156D25BED39040C906A354858E9B40DFF64320B6D39040D7AEF92A828E9B409D53A3E8ADD390405560508F7F8E9B407E0A5A88A5D390404405C4847D8E9B40A88167099DD390400053C40D7C8E9B400BB8EF7594D39040D6E1102C7B8E9B40D22A2FD88BD39040BF16B7E07A8E9B40496F11AD86D29040BF16B7E07A8E9B40496F11AD86D2904065F5ACD1A68E9B40010200000004000000496F11AD86D290402F0B2BED40909B40496F11AD86D29040A2682A9740909B40D12A2FD88BD39040A2682A9740909B40D22A2FD88BD39040A2682A9740909B40010200000002000000D22A2FD88BD39040C0089762FE919B40496F11AD86D290403366960CFE919B40010200000004000000496F11AD86D290403366960CFE919B40A9DBE38070D2904070052AF316929B40A9DBE38070D29040C0DC80417F939B40496F11AD86D29040FD7B142898939B40010200000034000000496F11AD86D29040FD7B142898939B40496F11AD86D29040A35A0A19C4939B40D12A2FD88BD39040A35A0A19C4939B400BB8EF7594D390408C8FB0CDC3939B40A88167099DD39040611EFDEBC2939B407E0A5A88A5D390401E6CFD74C1939B409D53A3E8ADD390400C11716ABF939B40DFF64320B6D390408BC2C7CEBC939B40C6156D25BED39040996A1EA5B9939B40700E8CEEC5D39040A2703BF1B5939B40A4E85572CDD3904005388AB7B1939B40566DD2A7D4D39040A9D915FDAC939B4063DB6686DBD39040F11E83C7A7939B40C22CE005E2D3904043C5091DA2939B40E3DF7C1EE8D3904022126D049C939B409139F6C8EDD39040C3C0F38495939B4049F488FEF2D39040B6525FA68E939B40A552FDB8F7D3904004CEE27087939B40418BAEF2FBD39040D0F318ED7F939B40388591A6FFD3904026FBF92378939B402BDD3AD002D490403FDCD01E70939B40AC2BE46B05D49040FE3830E767939B40BE86707607D49040DEEFE6865F939B40013970ED08D490400867F40757939B402BAA23CF09D490406B9D7C744E939B4043757D1A0AD490403210BCD645939B4043757D1A0AD49040FED1EE5D50929B402BAA23CF09D49040C5442EC047929B40013970ED08D49040287BB62C3F929B40BE86707607D4904052F2C3AD36929B40AC2BE46B05D4904032A97A4D2E929B402BDD3AD002D49040F105DA1526929B40398591A6FFD390400AE7B0101E929B40428BAEF2FBD3904060EE914716929B40A552FDB8F7D390402B14C8C30E929B4049F488FEF2D390407A8F4B8E07929B409139F6C8EDD390406D21B7AF00929B40E3DF7C1EE8D390400ED03D30FA919B40C22CE005E2D39040ED1CA117F4919B4063DB6686DBD390403EC3276DEE919B40566DD2A7D4D3904087089537E9919B40A4E85572CDD390402BAA207DE4919B40700E8CEEC5D390408E716F43E0919B40C6156D25BED3904097778C8FDC919B40DFF64320B6D39040A51FE365D9919B409D53A3E8ADD3904023D139CAD6919B407E0A5A88A5D390401276ADBFD4919B40A88167099DD39040CEC3AD48D3919B400BB8EF7594D39040A452FA66D2919B40D22A2FD88BD390408D87A01BD2919B40496F11AD86D290408D87A01BD2919B40496F11AD86D290403366960CFE919B40010200000004000000496F11AD86D29040FD7B142898939B40496F11AD86D2904070D913D297939B40D12A2FD88BD3904070D913D297939B40D22A2FD88BD3904070D913D297939B4001020000000600000012F9857BB4DE90409D7C489C589C9B4012F9857BB4DE9040A953EC0C969C9B40B98848715DE29040A953EC0C969C9B40B98848715DE29040BFC1137EB2AD9B404363D2EBA5D29040BFC1137EB2AD9B404363D2EBA5D2904020689A5477A09B40010200000030000000D22A2FD88BD39040A2682A9740909B40F142697091D39040FD433D6640909B401EDDF50197D39040F13BB0D33F909B40D2732F869CD39040733C32E03E909B40E66880F6A1D39040C4E6E58C3D909B4077E16A4CA7D39040873660DB3B909B4083859081ACD39040649EA6CD39909B40D919BA8FB1D39040659E2C6637909B4065EBDE70B6D39040FFD6D0A734909B40E8022C1FBBD39040399CD99531909B4095180B95BFD390400B0DF1332E909B403D3F29CDC3D39040A5B320862A909B40123F7DC2C7D39040CFB3CC9026909B4078984D70CBD39040288DAE5822909B40A72736D2CED390407B77CFE21D909B406D622DE4D1D39040F85F823419909B40D32989A2D4D390406C8E5D5314909B40D129030AD7D3904015FA33450F909B40F5C1BC17D9D3904009560E100A909B40327242C9DAD3904078DD23BA04909B40E1C78E1CDCD3904065E8D249FF8F9B405EC70C10DDD39040B05199C5F98F9B406BCF99A2DDD3904083B70C34F48F9B4010F486D3DDD39040649FD29BEE8F9B4010F486D3DDD3904030610523F98E9B406BCF99A2DDD390401149CB8AF38E9B405FC70C10DDD39040E4AE3EF9ED8E9B40E1C78E1CDCD390402F180575E88E9B40327242C9DAD390401C23B404E38E9B40F5C1BC17D9D390408BAAC9AEDD8E9B40D229030AD7D390407F06A479D88E9B40D32989A2D4D3904028727A6BD38E9B406D622DE4D1D390409CA0558ACE8E9B40A72736D2CED39040198908DCC98E9B4078984D70CBD390406C732966C58E9B40123F7DC2C7D39040C54C0B2EC18E9B403D3F29CDC3D39040EF4CB738BD8E9B4096180B95BFD3904089F3E68AB98E9B40E8022C1FBBD390405B64FE28B68E9B4066EBDE70B6D3904095290717B38E9B40DA19BA8FB1D390402F62AB58B08E9B4083859081ACD39040306231F1AD8E9B4077E16A4CA7D390400DCA77E3AB8E9B40E66880F6A1D39040D019F231AA8E9B40D3732F869CD3904021C4A5DEA88E9B401EDDF50197D39040A3C427EBA78E9B40F142697091D3904097BC9A58A78E9B40D22A2FD88BD39040F297AD27A78E9B40010200000020000000D22A2FD88BD39040A2682A9740909B404E04A7CB91D390409F8969103C909B40B052BD6A97D390409C93642237909B403BC875AE9CD3904025CB3BD331909B40F0A04590A1D39040222B88292C909B40BFC31B0AA6D390400B32532C26909B40814C6816AAD3904037230EE31F909B405E7523B0ADD3904049C7885519909B401CD7D3D2B0D390401DB7E78B12909B4070F8937AB3D39040513D9A8E0B909B408B2517A4B5D3904002DB4F6604909B40C789AD4CB7D39040B87CED1BFD8F9B4063864772B8D39040F16C82B8F58F9B402C427813B9D3904007123D45EE8F9B40E36E772FB9D390406F855FCBE68F9B40204222C6B8D3904079123454DF8F9B40204222C6B8D390401BEEA36A088F9B40E36E772FB9D39040257B78F3008F9B402C427813B9D390408DEE9A79F98E9B4063864772B8D39040A3935506F28E9B40C789AD4CB7D39040DC83EAA2EA8E9B408B2517A4B5D3904092258858E38E9B4070F8937AB3D3904043C33D30DC8E9B401CD7D3D2B0D390407749F032D58E9B405E7523B0ADD390404A394F69CE8E9B40814C6816AAD390405DDDC9DBC78E9B40BFC31B0AA6D3904089CE8492C18E9B40F0A04590A1D3904072D54F95BB8E9B403BC875AE9CD390406F359CEBB58E9B40B052BD6A97D39040F86C739CB08E9B404E04A7CB91D39040F5766EAEAB8E9B40D22A2FD88BD39040F297AD27A78E9B40010200000030000000D22A2FD88BD3904070D913D297939B40F142697091D39040CBB426A197939B401EDDF50197D39040BFAC990E97939B40D2732F869CD3904041AD1B1B96939B40E66880F6A1D390409257CFC794939B4077E16A4CA7D3904055A7491693939B4083859081ACD39040320F900891939B40D919BA8FB1D39040330F16A18E939B4065EBDE70B6D39040CD47BAE28B939B40E8022C1FBBD39040070DC3D088939B4095180B95BFD39040D97DDA6E85939B403D3F29CDC3D3904073240AC181939B40123F7DC2C7D390409D24B6CB7D939B4078984D70CBD39040F6FD979379939B40A72736D2CED3904049E8B81D75939B406D622DE4D1D39040C6D06B6F70939B40D32989A2D4D390403AFF468E6B939B40D129030AD7D39040E36A1D8066939B40F5C1BC17D9D39040D7C6F74A61939B40327242C9DAD39040464E0DF55B939B40E1C78E1CDCD390403359BC8456939B405EC70C10DDD390407EC2820051939B406BCF99A2DDD390405128F66E4B939B4010F486D3DDD390403210BCD645939B4010F486D3DDD39040FED1EE5D50929B406BCF99A2DDD39040DFB9B4C54A929B405FC70C10DDD39040B21F283445929B40E1C78E1CDCD39040FD88EEAF3F929B40327242C9DAD39040EA939D3F3A929B40F5C1BC17D9D39040591BB3E934929B40D229030AD7D390404D778DB42F929B40D32989A2D4D39040F6E263A62A929B406D622DE4D1D390406A113FC525929B40A72736D2CED39040E7F9F11621929B4078984D70CBD390403AE412A11C929B40123F7DC2C7D3904093BDF46818929B403D3F29CDC3D39040BDBDA07314929B4096180B95BFD390405764D0C510929B40E8022C1FBBD3904029D5E7630D929B4066EBDE70B6D39040639AF0510A929B40DA19BA8FB1D39040FDD2949307929B4083859081ACD39040FED21A2C05929B4077E16A4CA7D39040DB3A611E03929B40E66880F6A1D390409E8ADB6C01929B40D3732F869CD39040EF348F1900929B401EDDF50197D3904071351126FF919B40F142697091D39040652D8493FE919B40D22A2FD88BD39040C0089762FE919B40010200000020000000D22A2FD88BD3904070D913D297939B404E04A7CB91D390406DFA524B93939B40B052BD6A97D390406A044E5D8E939B403BC875AE9CD39040F33B250E89939B40F0A04590A1D39040F09B716483939B40BFC31B0AA6D39040D9A23C677D939B40814C6816AAD390400594F71D77939B405E7523B0ADD390401738729070939B401CD7D3D2B0D39040EB27D1C669939B4070F8937AB3D390401FAE83C962939B408B2517A4B5D39040D04B39A15B939B40C789AD4CB7D3904086EDD65654939B4063864772B8D39040BFDD6BF34C939B402C427813B9D39040D582268045939B40E36E772FB9D390403DF648063E939B40204222C6B8D3904047831D8F36939B40204222C6B8D39040E95E8DA55F929B40E36E772FB9D39040F3EB612E58929B402C427813B9D390405B5F84B450929B4063864772B8D3904071043F4149929B40C789AD4CB7D39040AAF4D3DD41929B408B2517A4B5D39040609671933A929B4070F8937AB3D390401134276B33929B401CD7D3D2B0D3904045BAD96D2C929B405E7523B0ADD3904018AA38A425929B40814C6816AAD390402B4EB3161F929B40BFC31B0AA6D39040573F6ECD18929B40F0A04590A1D39040404639D012929B403BC875AE9CD390403DA685260D929B40B052BD6A97D39040C6DD5CD707929B404E04A7CB91D39040C3E757E902929B40D22A2FD88BD39040C0089762FE919B40010200000004000000FD7F9EF4A4D39040912D9B5A4B899B408A229F4AA5D39040912D9B5A4B899B408A229F4AA5D3904019E9B885508A9B408A229F4AA5D390401AE9B885508A9B40010200000034000000FD7F9EF4A4D39040912D9B5A4B899B4057A1A80379D39040912D9B5A4B899B4057A1A80379D3904019E9B885508A9B406E6C024F79D3904053767923598A9B4099DDB5307AD39040F03FF1B6618A9B40DC8FB5A77BD39040C6C8E3356A8A9B40EEEA41B27DD39040E5112D96728A9B406F39EB4D80D3904027B5CDCD7A8A9B406191947783D390400ED4F6D2828A9B40588B772B87D39040B8CC159C8A8A9B40F5C328658BD39040ECA6DF1F928A9B4051229D1F90D390409E2B5C55998A9B4009DD2F5595D39040AB99F033A08A9B40B736A9FF9AD390400AEB69B3A68A9B40D8E94518A1D390402B9E06CCAC8A9B40373BBF97A7D39040D9F77F76B28A9B4044A95376AED3904091B212ACB78A9B40F62DD0ABB5D39040ED108766BC8A9B402A089A2FBDD39040894938A0C08A9B40D400B9F8C4D3904080431B54C48A9B40BB1FE2FDCCD39040739BC47DC78A9B40FCC28235D5D39040F4E96D19CA8A9B401C0CCC95DDD390400645FA23CC8A9B40F294BE14E6D3904049F7F99ACD8A9B408F5E36A8EED390407368AD7CCE8A9B40C8EBF645F7D390408B3307C8CE8A9B40FC29C4BEECD490408B3307C8CE8A9B4035B7845CF5D490407368AD7CCE8A9B40D280FCEFFDD4904049F7F99ACD8A9B40A809EF6E06D590400645FA23CC8A9B40C85238CF0ED59040F4E96D19CA8A9B4009F6D80617D59040739BC47DC78A9B40F014020C1FD5904081431B54C48A9B409A0D21D526D590408A4938A0C08A9B40CFE7EA582ED59040ED108766BC8A9B40806C678E35D5904091B212ACB78A9B408DDAFB6C3CD59040D9F77F76B28A9B40EC2B75EC42D590402B9E06CCAC8A9B400DDF110549D590400AEB69B3A68A9B40BC388BAF4ED59040AB99F033A08A9B4073F31DE553D590409E2B5C55998A9B40CF51929F58D59040ECA6DF1F928A9B406C8A43D95CD59040B8CC159C8A8A9B406384268D60D590400ED4F6D2828A9B4055DCCFB663D5904027B5CDCD7A8A9B40D72A795266D59040E5112D96728A9B40E885055D68D59040C6C8E3356A8A9B402C3805D469D59040F03FF1B6618A9B4056A9B8B56AD5904053767923598A9B406D7412016BD590401AE9B885508A9B406D7412016BD59040912D9B5A4B899B40C7951C103FD59040912D9B5A4B899B40010200000004000000C7951C103FD59040912D9B5A4B899B408AF6882926D59040F1996D2E35899B403A1F32DBBDD39040F1996D2E35899B40FD7F9EF4A4D39040912D9B5A4B899B400102000000200000008A229F4AA5D390401AE9B885508A9B408D0160D1A9D3904096C23079568A9B4090F764BFAED39040F81047185C8A9B4007C08D0EB4D390408386FF5B618A9B400A6041B8B9D39040385FCF3D668A9B40215976B5BFD390400782A5B76A8A9B40F567BBFEC5D39040C90AF2C36E8A9B40E3C3408CCCD39040A633AD5D728A9B400FD4E155D3D3904064955D80758A9B40DB4D2F53DAD39040B8B61D28788A9B402AB0797BE1D39040D3E3A0517A8A9B40740EDCC5E8D390400F4837FA7B8A9B403B1E4729F0D39040AB44D11F7D8A9B4025798C9CF7D39040740002C17D8A9B40BD056A16FFD390402B2D01DD7D8A9B40B378958D06D490406800AC737D8A9B40119D2577DDD490406800AC737D8A9B40071051EEE4D490402B2D01DD7D8A9B409F9C2E68ECD49040740002C17D8A9B4089F773DBF3D49040AB44D11F7D8A9B405007DF3EFBD490400F4837FA7B8A9B409A65418902D59040D3E3A0517A8A9B40E9C78BB109D59040B8B61D28788A9B40B541D9AE10D5904064955D80758A9B40E2517A7817D59040A633AD5D728A9B40CFADFF051ED59040C90AF2C36E8A9B40A3BC444F24D590400782A5B76A8A9B40BAB5794C2AD59040385FCF3D668A9B40BD552DF62FD590408386FF5B618A9B40341E564535D59040F81047185C8A9B4037145B333AD5904096C23079568A9B403AF31BBA3ED590401AE9B885508A9B400102000000300000008A229F4AA5D390401AE9B885508A9B402F478C7BA5D390403901F31D568A9B403B4F190EA6D39040669B7FAF5B8A9B40B94E9701A7D390401A32B933618A9B4068A4E354A8D390402E270AA4668A9B40A5546906AAD39040BF9FF4F96B8A9B40C8EC2214ACD39040CB431A2F718A9B40C7EC9C7BAED3904021D8433D768A9B402DB4F839B1D39040ADA9681E7B8A9B40F3EEEF4BB4D3904030C1B5CC7F8A9B40217ED8ADB7D39040DDD69442848A9B4087D7A85BBBD3904085FDB27A888A9B405DD7FC50BFD390405AFD06708C8A9B4004FE1A89C3D39040C056D71D908A9B40B113FAFEC7D39040EFE5BF7F938A9B40342B47ADCCD39040B520B791968A9B40C0FC6B8ED1D390401BE81250998A9B401791959CD6D3904019E88CB79B8A9B402335BBD1DBD390403D8046C59D8A9B40B4ADA527E1D390407A30CC769F8A9B40C7A2F697E6D39040298618CAA08A9B407C39301CECD39040A68596BDA18A9B40A9D3BCADF1D39040B38D2350A28A9B40C8EBF645F7D3904058B21081A28A9B40FC29C4BEECD4904058B21081A28A9B401B42FE56F2D49040B38D2350A28A9B4048DC8AE8F7D49040A78596BDA18A9B40FD72C46CFDD49040298618CAA08A9B40106815DD02D590407A30CC769F8A9B40A1E0FF3208D590403D8046C59D8A9B40AD8425680DD590401AE88CB79B8A9B4004194F7612D590401BE81250998A9B4090EA735717D59040B520B791968A9B401302C1051CD59040EFE5BF7F938A9B40C017A07B20D59040C056D71D908A9B40673EBEB324D590405AFD06708C8A9B403D3E12A928D5904085FDB27A888A9B40A397E2562CD59040DED69442848A9B40D126CBB82FD5904030C1B5CC7F8A9B409761C2CA32D59040AEA9681E7B8A9B40FD281E8935D5904022D8433D768A9B40FC2898F037D59040CB431A2F718A9B401FC151FE39D59040BF9FF4F96B8A9B405C71D7AF3BD590402E270AA4668A9B400BC723033DD590401B32B933618A9B4089C6A1F63DD59040669B7FAF5B8A9B4095CE2E893ED590403901F31D568A9B403AF31BBA3ED590401AE9B885508A9B40010200000004000000C71A39C0BAD3904087AC70F213999B403A78386ABAD3904087AC70F213999B403A78386ABAD39040FFF052C70E989B403A78386ABAD39040FEF052C70E989B400102000000020000003AF31BBA3ED590401AE9B885508A9B40C7951C103FD59040912D9B5A4B899B400102000000050000004AF1C368D8D690400D20B9D962869B40D4921F154EDA90400D20B9D962869B40D4921F154EDA9040DC15E235F2889B406D2CB9AEE7DA9040DC15E235F2889B406D2CB9AEE7DA90404953EC0C96889B40010200000018000000443AF4EDE3D690407AD13A39A0A99B40561A693CE4D6904069E7E531A9A99B406E156A27E5D690407AB5DB1FB2A99B4000ACDEADE6D69040C8BB73F8BAA99B40D7D2F4CDE8D690401AFB1EB1C3A99B405E1F2385EBD69040288F743FCCA99B40C2CE2BD0EED69040691B3E99D4A99B4056A420ABF2D6904088FB83B4DCA99B409C9A6711F7D6904004299987E4A99B405B61C0FDFBD69040BDC72609ECA99B402AA24A6A01D79040AA4B3730F3A99B4001048D5007D79040662A41F4F9A99B406DE57CA90DD79040D20B314D00AA9B4029C4866D14D79040A96D733306AA9B40164897941BD7904077AEFD9F0BAA9B40CFE6241623D790403675568C10AA9B404B143AE92AD790407D6B9DF214AA9B406AF47F0433D79040114192CD18AA9B40AB80495E3BD7904075F09A181CAA9B40B9149FEC43D79040FC3CC9CF1EAA9B400B544AA54CD79040D363DFEF20AA9B40585AE27D55D7904065FA537622AA9B406A28D86B5ED790407DF5546123AA9B40583E836467D790408FD5C9AF23AA9B40010200000002000000443AF4EDE3D690407AD13A39A0A99B40443AF4EDE3D690407BD13A39A0A99B40010200000002000000463AF4EDE3D690404BA06D5D0BA99B40443AF4EDE3D690407AD13A39A0A99B40010200000002000000463AF4EDE3D69040D939905DD8A39B40453AF4EDE3D69040F639905DD8A39B40010200000002000000463AF4EDE3D690403FEC4E7378A69B40453AF4EDE3D690405CEC4E7378A69B40010200000002000000463AF4EDE3D690404BA06D5D0BA99B40453AF4EDE3D6904068A06D5D0BA99B40010200000002000000463AF4EDE3D69040B4798A5DD8A39B40463AF4EDE3D69040D939905DD8A39B40010200000019000000463AF4EDE3D69040D939905DD8A39B40443AF4EDE3D69040096B5D396DA49B40561A693CE4D69040F780083276A49B406E156A27E5D69040094FFE1F7FA49B4000ACDEADE6D69040565596F887A49B40D7D2F4CDE8D69040A89441B190A49B405E1F2385EBD69040B628973F99A49B40C2CE2BD0EED69040F7B46099A1A49B4056A420ABF2D690401695A6B4A9A49B409C9A6711F7D6904092C2BB87B1A49B405B61C0FDFBD690404B614909B9A49B402AA24A6A01D7904038E55930C0A49B4001048D5007D79040F4C363F4C6A49B406DE57CA90DD7904060A5534DCDA49B4029C4866D14D7904037079633D3A49B40164897941BD79040064820A0D8A49B40CFE6241623D79040C50E798CDDA49B404B143AE92AD790400B05C0F2E1A49B406AF47F0433D790409FDAB4CDE5A49B40AB80495E3BD79040038ABD18E9A49B40B9149FEC43D790408AD6EBCFEBA49B400B544AA54CD7904061FD01F0EDA49B40585AE27D55D79040F3937676EFA49B406A28D86B5ED790400B8F7761F0A49B40583E836467D790401D6FECAFF0A49B400102000000180000004A27576467D79040DB4114E754A39B4031EBD86B5ED790400693873555A39B402EDDE37D55D790404666882056A39B407F914CA54CD79040D9BAFCA657A39B40B404A2EC43D79040288612C759A39B407A184D5E3BD790407A5E407E5CA39B40D826840433D79040148248C95FA39B40B7D13EE92AD790409AB53CA463A39B404F1D2A1623D7904019F5820A68A39B4098E39C941BD7904014F2DAF66CA39B409EAE8C6D14D790401358646372A39B40F50683A90DD790402ED0A54978A39B401A43935007D790403ABB94A27EA39B40E6E3506A01D7904061999D6685A39B409789C6FDFBD690401615AD8D8CA39B40398C6D11F7D69040A4A6390F94A39B40774126ABF2D69040C6C44DE29BA39B400CF930D0EED69040379692FDA3A39B4036B82785EBD690405D175B57ACA39B40A4BBF8CDE8D69040D6A6AFE5B4A39B4070C6E1ADE6D6904008EB599EBDA39B40B5436C27E5D690409E02F176C6A39B40733F6A3CE4D6904047F1E564CFA39B40463AF4EDE3D69040D939905DD8A39B40010200000002000000463AF4EDE3D690401A2C497378A69B40463AF4EDE3D690403FEC4E7378A69B40010200000019000000463AF4EDE3D690403FEC4E7378A69B40443AF4EDE3D690406F1D1C4F0DA79B40561A693CE4D690405E33C74716A79B406E156A27E5D690406F01BD351FA79B4000ACDEADE6D69040BD07550E28A79B40D7D2F4CDE8D690400E4700C730A79B405E1F2385EBD690401CDB555539A79B40C2CE2BD0EED690405D671FAF41A79B4056A420ABF2D690407C4765CA49A79B409C9A6711F7D69040F8747A9D51A79B405B61C0FDFBD69040B113081F59A79B402AA24A6A01D790409F97184660A79B4001048D5007D790405A76220A67A79B406DE57CA90DD79040C65712636DA79B4029C4866D14D790409DB9544973A79B40164897941BD790406CFADEB578A79B40CFE6241623D790402BC137A27DA79B404B143AE92AD7904072B77E0882A79B406AF47F0433D79040068D73E385A79B40AB80495E3BD790406A3C7C2E89A79B40B9149FEC43D79040F188AAE58BA79B400B544AA54CD79040C7AFC0058EA79B40585AE27D55D790405946358C8FA79B406A28D86B5ED790407241367790A79B40583E836467D790408321ABC590A79B400102000000180000004C27576467D7904041F4D2FCF4A59B4031EBD86B5ED790406C45464BF5A59B402EDDE37D55D79040AC184736F6A59B407F914CA54CD790403F6DBBBCF7A59B40B404A2EC43D790408E38D1DCF9A59B407A184D5E3BD79040E010FF93FCA59B40D826840433D790407A3407DFFFA59B40B7D13EE92AD790400068FBB903A69B404F1D2A1623D790407FA7412008A69B4098E39C941BD790407AA4990C0DA69B409EAE8C6D14D79040790A237912A69B40F50683A90DD790409482645F18A69B401A43935007D79040A06D53B81EA69B40E6E3506A01D79040C74B5C7C25A69B409789C6FDFBD690407CC76BA32CA69B40398C6D11F7D690400A59F82434A69B40774126ABF2D690402C770CF83BA69B400CF930D0EED690409D48511344A69B4036B82785EBD69040C4C9196D4CA69B40A4BBF8CDE8D690403C596EFB54A69B4070C6E1ADE6D690406E9D18B45DA69B40B5436C27E5D6904004B5AF8C66A69B40733F6A3CE4D69040ADA3A47A6FA69B40463AF4EDE3D690403FEC4E7378A69B40010200000002000000463AF4EDE3D6904025E0675D0BA99B40463AF4EDE3D690404BA06D5D0BA99B400102000000180000004A27576467D790404DA8F1E687A89B4031EBD86B5ED7904078F9643588A89B402EDDE37D55D79040B8CC652089A89B407F914CA54CD790404A21DAA68AA89B40B404A2EC43D790409AECEFC68CA89B407A184D5E3BD79040ECC41D7E8FA89B40D826840433D7904086E825C992A89B40B7D13EE92AD790400C1C1AA496A89B404F1D2A1623D790408B5B600A9BA89B4098E39C941BD790408658B8F69FA89B409EAE8C6D14D7904085BE4163A5A89B40F50683A90DD79040A0368349ABA89B401A43935007D79040AC2172A2B1A89B40E6E3506A01D79040D2FF7A66B8A89B409789C6FDFBD69040887B8A8DBFA89B40398C6D11F7D69040150D170FC7A89B40774126ABF2D69040372B2BE2CEA89B400CF930D0EED69040A8FC6FFDD6A89B4036B82785EBD69040CF7D3857DFA89B40A4BBF8CDE8D69040470D8DE5E7A89B4070C6E1ADE6D690407A51379EF0A89B40B5436C27E5D690401069CE76F9A89B40733F6A3CE4D69040B957C36402A99B40463AF4EDE3D690404BA06D5D0BA99B40010200000004000000CED18771EDD6904087AC70F213999B400B711B5806D7904027409E1E2A999B405B4872A66ED8904027409E1E2A999B4098E7058D87D8904087AC70F213999B4001020000003400000098E7058D87D8904087AC70F213999B403EC6FB7DB3D8904087AC70F213999B403EC6FB7DB3D89040FFF052C70E989B4027FBA132B3D89040C563922906989B40FC89EE50B2D89040289A1A96FD979B40B9D7EED9B0D8904052112817F5979B40A77C62CFAED8904033C8DEB6EC979B40262EB933ACD89040F1243E7FE4979B4034D60F0AA9D890400A06157ADC979B403DDC2C56A5D89040600DF6B0D4979B40A0A37B1CA1D890402C332C2DCD979B40444507629CD890407AAEAFF7C5979B408C8A742C97D890406D401B19BF979B40DE30FB8191D890400EEFA199B8979B40BD7D5E698BD89040ED3B0581B2979B405E2CE5E984D890403FE28BD6AC979B4051BE500B7ED890408727F9A0A7979B409F39D4D576D890402BC984E6A2979B406B5F0A526FD890408F90D3AC9E979B40C166EB8867D890409896F0F89A979B40DA47C2835FD89040A53E47CF97979B4099A4214C57D8904024F09D3395979B40795BD8EB4ED890401295112993979B40A3D2E56C46D89040CFE211B291979B4006096ED93DD89040A5715ED090979B40CD7BAD3B35D890408DA6048590979B40993DE0C23FD790408DA6048590979B4060B01F2537D79040A5715ED090979B40C3E6A7912ED79040CFE211B291979B40ED5DB51226D790401295112993979B40CD146CB21DD7904024F09D3395979B408C71CB7A15D79040A53E47CF97979B40A552A2750DD790409796F0F89A979B40FB5983AC05D790408E90D3AC9E979B40C67FB928FED690402BC984E6A2979B4015FB3CF3F6D690408727F9A0A7979B40088DA814F0D690403FE28BD6AC979B40A93B2F95E9D69040ED3B0581B2979B408888927CE3D690400EEFA199B8979B40D92E19D2DDD690406D401B19BF979B402274869CD8D690407AAEAFF7C5979B40C61512E2D3D690402C332C2DCD979B4029DD60A8CFD69040600DF6B0D4979B4032E37DF4CBD690400A06157ADC979B40408BD4CAC8D69040F1243E7FE4979B40BE3C2B2FC6D6904033C8DEB6EC979B40ADE19E24C4D6904052112817F5979B40692F9FADC2D69040289A1A96FD979B403FBEEBCBC1D69040C563922906989B4028F39180C1D69040FEF052C70E989B4028F39180C1D6904087AC70F213999B40CED18771EDD6904087AC70F213999B400102000000020000005B7488C7EDD69040FEF052C70E989B40CED18771EDD6904087AC70F213999B400102000000300000000B45053787D89040FEF052C70E989B406620180687D89040DFD8182F09989B405A188B7386D89040B23E8C9D03989B40DC180D8085D89040FEA75219FE979B402DC3C02C84D89040EAB201A9F8979B40F0123B7B82D89040593A1753F3979B40CD7A816D80D890404D96F11DEE979B40CE7A07067ED89040F701C80FE9979B4068B3AB477BD890406B30A32EE4979B40A278B43578D89040E8185680DF979B4074E9CBD374D890403B03770ADB979B400E90FB2571D8904093DC58D2D6979B403890A7306DD89040BEDC04DDD2979B40916989F868D890405883342FCF979B40E453AA8264D8904029F44BCDCB979B40613C5DD45FD8904063B954BBC8979B40D56A38F35AD89040FDF1F8FCC5979B407ED60EE555D89040FFF17E95C3979B407232E9AF50D89040DB59C587C1979B40E1B9FE594BD890409EA93FD6BF979B40CEC4ADE945D89040EF53F382BE979B40192E746540D890407254758FBD979B40EC93E7D33AD89040654CE8FCBC979B40CD7BAD3B35D89040C027FBCBBC979B40993DE0C23FD79040C027FBCBBC979B407A25A62A3AD79040654CE8FCBC979B404D8B199934D790407154758FBD979B4098F4DF142FD79040EF53F382BE979B4085FF8EA429D790409EA93FD6BF979B40F486A44E24D79040DB59C587C1979B40E8E27E191FD79040FEF17E95C3979B40914E550B1AD79040FDF1F8FCC5979B40057D302A15D7904063B954BBC8979B408265E37B10D7904029F44BCDCB979B40D54F04060CD790405883342FCF979B402E29E6CD07D79040BEDC04DDD2979B40582992D803D7904093DC58D2D6979B40F2CFC12A00D790403A03770ADB979B40C440D9C8FCD69040E8185680DF979B40FE05E2B6F9D690406A30A32EE4979B40983E86F8F6D69040F601C80FE9979B40993E0C91F4D690404D96F11DEE979B4076A65283F2D69040593A1753F3979B4039F6CCD1F0D69040EAB201A9F8979B408AA0807EEFD69040FDA75219FE979B400CA1028BEED69040B23E8C9D03989B40009975F8EDD69040DFD8182F09989B405B7488C7EDD69040FEF052C70E989B400102000000200000000B45053787D89040FEF052C70E989B40086644B082D890408217DBD308989B4005703FC27DD8904020C9C43403989B408EA7167378D8904095530CF1FD979B408B0763C972D89040E07A3C0FF9979B40740E2ECC6CD8904011586695F4979B40A0FFE88266D890404FCF1989F0979B40B2A363F55FD8904072A65EEFEC979B408693C22B59D89040B444AECCE9979B40BA19752E52D890406023EE24E7979B406BB72A064BD8904045F66AFBE4979B402159C8BB43D890400992D452E3979B405A495D583CD890406D953A2DE2979B4070EE17E534D89040A4D9098CE1979B40D8613A6B2DD89040EDAC0A70E1979B40E2EE0EF425D89040B0D95FD9E1979B4084CA7E0A4FD79040B0D95FD9E1979B408E57539347D79040EDAC0A70E1979B40F6CA751940D79040A4D9098CE1979B400C7030A638D790406D953A2DE2979B404560C54231D790400992D452E3979B40FB0163F829D7904045F66AFBE4979B40AC9F18D022D790406023EE24E7979B40E025CBD21BD79040B444AECCE9979B40B3152A0915D7904072A65EEFEC979B40C6B9A47B0ED790404FCF1989F0979B40F2AA5F3208D7904011586695F4979B40DBB12A3502D79040E07A3C0FF9979B40D811778BFCD6904095530CF1FD979B4061494E3CF7D6904020C9C43403989B405E53494EF2D690408217DBD308989B405B7488C7EDD69040FEF052C70E989B4001020000001C0000004A27576467D79040DB4114E754A39B40A49DBC585DD790406B49708D5AA39B4029D459B353D7904070337EDC60A39B406211647F4AD790409271EDCC67A39B40FDBF62C741D79040C79FCD566FA39B40147A4F9539D7904052CD7E7177A39B409C9F8AF231D79040D45ABB1380A39B40359CD0E72AD79040EC95A23389A39B4078E82F7D24D790404206C4C692A39B405CD2FFB91ED790400D5F2BC29CA39B401917D8A419D7904071076D1AA7A39B404358894315D79040552BB3C3B1A39B40AB74169B11D79040C545CBB1BCA39B40A6CCAEAF0ED790405B1534D8C7A39B40A6CCAEAF0ED7904062CFB3BE7DA49B40AB74169B11D79040F89E1CE588A49B404358894315D7904067B934D393A49B401917D8A419D790404BDD7A7C9EA49B405CD2FFB91ED79040B085BCD4A8A49B4078E82F7D24D790407BDE23D0B2A49B40359CD0E72AD79040D04E4563BCA49B409C9F8AF231D79040E8892C83C5A49B40147A4F9539D790406A176925CEA49B40FDBF62C741D79040F6441A40D6A49B406211647F4AD790402B73FAC9DDA49B4029D459B353D790404DB169BAE4A49B40A49DBC585DD79040519B7709EBA49B40583E836467D790401D6FECAFF0A49B40010200000002000000583E836467D790409F75FBE654A39B404A27576467D79040DB4114E754A39B400102000000030000001D2E18413CD8904047C012E754A39B40583E836467D7904047C012E754A39B404A27576467D79040DB4114E754A39B4001020000001C0000004A27576467D790404DA8F1E687A89B40A49DBC585DD79040DDAF4D8D8DA89B4029D459B353D79040E2995BDC93A89B406211647F4AD7904003D8CACC9AA89B40FDBF62C741D790403906AB56A2A89B40147A4F9539D79040C4335C71AAA89B409C9F8AF231D7904046C19813B3A89B40359CD0E72AD790405EFC7F33BCA89B4078E82F7D24D79040B46CA1C6C5A89B405CD2FFB91ED790407FC508C2CFA89B401917D8A419D79040E36D4A1ADAA89B404358894315D79040C79190C3E4A89B40AB74169B11D7904037ACA8B1EFA89B40A6CCAEAF0ED79040CC7B11D8FAA89B40A6CCAEAF0ED79040D43591BEB0A99B40AB74169B11D790406A05FAE4BBA99B404358894315D79040D91F12D3C6A99B401917D8A419D79040BD43587CD1A99B405CD2FFB91ED7904022EC99D4DBA99B4078E82F7D24D79040EC4401D0E5A99B40359CD0E72AD7904042B52263EFA99B409C9F8AF231D790405AF00983F8A99B40147A4F9539D79040DC7D462501AA9B40FDBF62C741D7904068ABF73F09AA9B406211647F4AD790409DD9D7C910AA9B4029D459B353D79040BE1747BA17AA9B40A49DBC585DD79040C30155091EAA9B40583E836467D790408FD5C9AF23AA9B40010200000002000000583E836467D7904011DCD8E687A89B404A27576467D790404DA8F1E687A89B400102000000030000001D2E18413CD89040B926F0E687A89B40583E836467D79040B926F0E687A89B404A27576467D790404DA8F1E687A89B4001020000001C0000004C27576467D7904041F4D2FCF4A59B40A49DBC585DD79040D2FB2EA3FAA59B4029D459B353D79040D6E53CF200A69B406211647F4AD79040F823ACE207A69B40FDBF62C741D790402D528C6C0FA69B40147A4F9539D79040B87F3D8717A69B409C9F8AF231D790403B0D7A2920A69B40359CD0E72AD790405348614929A69B4078E82F7D24D79040A8B882DC32A69B405CD2FFB91ED790407311EAD73CA69B401917D8A419D79040D7B92B3047A69B404358894315D79040BCDD71D951A69B40AB74169B11D790402BF889C75CA69B40A6CCAEAF0ED79040C1C7F2ED67A69B40A6CCAEAF0ED79040C88172D41DA79B40AB74169B11D790405E51DBFA28A79B404358894315D79040CD6BF3E833A79B401917D8A419D79040B28F39923EA79B405CD2FFB91ED7904016387BEA48A79B4078E82F7D24D79040E190E2E552A79B40359CD0E72AD79040360104795CA79B409C9F8AF231D790404E3CEB9865A79B40147A4F9539D79040D1C9273B6EA79B40FDBF62C741D790405CF7D85576A79B406211647F4AD790409125B9DF7DA79B4029D459B353D79040B36328D084A79B40A49DBC585DD79040B84D361F8BA79B40583E836467D790408321ABC590A79B40010200000002000000583E836467D790400628BAFCF4A59B404C27576467D7904041F4D2FCF4A59B400102000000030000001D2E18413CD89040AD72D1FCF4A59B40583E836467D79040AD72D1FCF4A59B404C27576467D7904041F4D2FCF4A59B400102000000020000001D2E18413CD890401D6FECAFF0A49B40583E836467D790401D6FECAFF0A49B400102000000020000001D2E18413CD890408321ABC590A79B40583E836467D790408321ABC590A79B400102000000020000001D2E18413CD890408FD5C9AF23AA9B40583E836467D790408FD5C9AF23AA9B400102000000060000001D2E18413CD890401D6FECAFF0A49B401D2E18413CD8904097A23ED9EFA49B40BEC1456D52D890405A03ABF2D6A49B40BEC1456D52D890400A2C54A46EA39B401D2E18413CD89040CD8CC0BD55A39B401D2E18413CD8904047C012E754A39B400102000000340000001D2E18413CD8904047C012E754A39B401D2E18413CD8904027AECACC29A39B40583E836467D7904027AECACC29A39B40C4A1D77A5BD7904003B1F8342AA39B404111649F4FD790409B60066D2BA39B402BA04FE043D790406B467F732DA39B40B0849F4B38D79040F18AF84530A39B40CD5B26EF2CD790405AD813E133A39B40A1A973D821D79040C25F834038A39B40E7A9C31417D790404EFC0E5F3DA39B40CA83EFB00CD79040FF6D9A3643A39B4001F45DB902D79040BEA42CC049A39B407E7FF439F9D690400013F8F350A39B405640093EF0D6904006FE63C958A39B40D75D55D0E7D69040A0C0163761A39B40F33FE8FADFD6904034F400336AA39B40478D1BC7D8D69040B47269B273A39B401602883DD2D690403123FAA97DA39B40822DFB65CCD69040C381CD0D88A39B4047216E47C7D69040A0D27CD192A39B401E1FFDE7C2D690406FEF2EE89DA39B40A44DE04CBFD69040289DA744A9A39B408C7D657ABCD690403C5857D9B4A39B408406EB73BAD6904025846B98C0A39B40E9C1DB3BB9D6904005EBDE73CCA39B402628ACD3B8D69040B3798A5DD8A39B402428ACD3B8D69040096B5D396DA49B40B13CDA3BB9D69040410A0A2379A49B403221E873BAD69040CA997EFE84A49B40A45E617ABCD69040AF0294BD90A49B40B41CDB4CBFD69040380B45529CA49B406C04F7E7C2D69040F712BFAEA7A49B4073456747C7D69040739272C5B2A49B402FB9F365CCD69040BE4A2389BDA49B40951D803DD2D69040A111F8ECC7A49B403F6013C7D8D690408B278AE4D1A49B400EF1DFFADFD69040E304F463DBA49B4073124DD0E7D690402C8DDF5FE4A49B40351C013EF0D69040EE9693CDECA49B407EA4EC39F9D6904053B800A3F4A49B40D68156B902D790402249CDD6FBA49B40C097E8B00CD79040CC8B606002A59B40A35EBD1417D7904032F0EC3708A59B40EE166ED821D79040EE6379560DA59B406A9621EF2CD79040F5A4E9B511A59B40299E9B4B38D79040AD8C055115A59B40B2A64CE043D79040BD4A7F2318A59B40970F629F4FD790402F88F8291AA59B40209FD67A5BD79040B06C06621BA59B40583E836467D790403D8134CA1BA59B401D2E18413CD890403D8134CA1BA59B401D2E18413CD890401D6FECAFF0A49B400102000000020000001D2E18413CD89040333F7FD3F5A59B401D2E18413CD89040AD72D1FCF4A59B400102000000340000001D2E18413CD89040AD72D1FCF4A59B401D2E18413CD890408D6089E2C9A59B40583E836467D790408D6089E2C9A59B40C4A1D77A5BD790406963B74ACAA59B404111649F4FD790400213C582CBA59B402BA04FE043D79040D1F83D89CDA59B40B0849F4B38D79040573DB75BD0A59B40CD5B26EF2CD79040C18AD2F6D3A59B40A1A973D821D7904028124256D8A59B40E7A9C31417D79040B4AECD74DDA59B40CA83EFB00CD790406520594CE3A59B4001F45DB902D790402457EBD5E9A59B407E7FF439F9D6904066C5B609F1A59B405640093EF0D690406CB022DFF8A59B40D75D55D0E7D690400673D54C01A69B40F33FE8FADFD690409AA6BF480AA69B40478D1BC7D8D690401A2528C813A69B401602883DD2D6904097D5B8BF1DA69B40822DFB65CCD6904029348C2328A69B4047216E47C7D6904006853BE732A69B401E1FFDE7C2D69040D5A1EDFD3DA69B40A44DE04CBFD690408E4F665A49A69B408C7D657ABCD69040A30A16EF54A69B408406EB73BAD690408C362AAE60A69B40E9C1DB3BB9D690406B9D9D896CA69B402628ACD3B8D69040192C497378A69B402428ACD3B8D690406F1D1C4F0DA79B40B13CDA3BB9D69040A8BCC83819A79B403221E873BAD69040304C3D1425A79B40A45E617ABCD6904015B552D330A79B40B41CDB4CBFD690409FBD03683CA79B406C04F7E7C2D690405EC57DC447A79B4073456747C7D69040D94431DB52A79B402FB9F365CCD6904024FDE19E5DA79B40951D803DD2D6904008C4B60268A79B403F6013C7D8D69040F1D948FA71A79B400EF1DFFADFD690404AB7B2797BA79B4073124DD0E7D69040923F9E7584A79B40351C013EF0D69040544952E38CA79B407EA4EC39F9D69040B96ABFB894A79B40D68156B902D7904088FB8BEC9BA79B40C097E8B00CD79040323E1F76A2A79B40A35EBD1417D7904098A2AB4DA8A79B40EE166ED821D790405416386CADA79B406A9621EF2CD790405B57A8CBB1A79B40299E9B4B38D79040133FC466B5A79B40B2A64CE043D7904023FD3D39B8A79B40970F629F4FD79040953AB73FBAA79B40209FD67A5BD79040161FC577BBA79B40583E836467D79040A333F3DFBBA79B401D2E18413CD89040A333F3DFBBA79B401D2E18413CD890408321ABC590A79B400102000000050000001D2E18413CD89040343F7FD3F5A59B40BEC1456D52D8904071DE12BA0EA69B40BEC1456D52D89040C0B5690877A79B401D2E18413CD89040FD54FDEE8FA79B401D2E18413CD890408321ABC590A79B400102000000060000001D2E18413CD890408FD5C9AF23AA9B401D2E18413CD8904009091CD922AA9B40BEC1456D52D89040CC6988F209AA9B40BEC1456D52D890407C9231A4A1A89B401D2E18413CD890403FF39DBD88A89B401D2E18413CD89040B926F0E687A89B400102000000340000001D2E18413CD89040B926F0E687A89B401D2E18413CD890409914A8CC5CA89B40583E836467D790409914A8CC5CA89B40C4A1D77A5BD790407517D6345DA89B404111649F4FD790400DC7E36C5EA89B402BA04FE043D79040DCAC5C7360A89B40B0849F4B38D7904063F1D54563A89B40CD5B26EF2CD79040CC3EF1E066A89B40A1A973D821D7904034C660406BA89B40E7A9C31417D79040C062EC5E70A89B40CA83EFB00CD7904071D4773676A89B4001F45DB902D790402F0B0AC07CA89B407E7FF439F9D690407179D5F383A89B405640093EF0D69040776441C98BA89B40D75D55D0E7D690401227F43694A89B40F33FE8FADFD69040A65ADE329DA89B40478D1BC7D8D6904026D946B2A6A89B401602883DD2D69040A389D7A9B0A89B40822DFB65CCD6904035E8AA0DBBA89B4047216E47C7D6904012395AD1C5A89B401E1FFDE7C2D69040E1550CE8D0A89B40A44DE04CBFD690409A038544DCA89B408C7D657ABCD69040AEBE34D9E7A89B408406EB73BAD6904097EA4898F3A89B40E9C1DB3BB9D690407751BC73FFA89B402628ACD3B8D6904025E0675D0BA99B402428ACD3B8D690407AD13A39A0A99B40B13CDA3BB9D69040B370E722ACA99B403221E873BAD690403B005CFEB7A99B40A45E617ABCD69040216971BDC3A99B40B41CDB4CBFD69040AA712252CFA99B406C04F7E7C2D6904069799CAEDAA99B4073456747C7D69040E5F84FC5E5A99B402FB9F365CCD6904030B10089F0A99B40951D803DD2D690401378D5ECFAA99B403F6013C7D8D69040FD8D67E404AA9B400EF1DFFADFD69040556BD1630EAA9B4073124DD0E7D690409EF3BC5F17AA9B40351C013EF0D6904060FD70CD1FAA9B407EA4EC39F9D69040C51EDEA227AA9B40D68156B902D7904094AFAAD62EAA9B40C097E8B00CD790403EF23D6035AA9B40A35EBD1417D79040A456CA373BAA9B40EE166ED821D7904060CA565640AA9B406A9621EF2CD79040670BC7B544AA9B40299E9B4B38D790401EF3E25048AA9B40B2A64CE043D790402FB15C234BAA9B40970F629F4FD79040A1EED5294DAA9B40209FD67A5BD7904022D3E3614EAA9B40583E836467D79040AFE711CA4EAA9B401D2E18413CD89040AFE711CA4EAA9B401D2E18413CD890408FD5C9AF23AA9B4001020000000400000098E7058D87D8904087AC70F213999B400B45053787D8904087AC70F213999B400B45053787D89040FFF052C70E989B400B45053787D89040FEF052C70E989B40010200000019000000060664AAB6DA904058B15E9F2BA19B40D6D496CE21DA904056B15E9F2BA19B40E8BEEBD518DA90406891D3ED2BA19B40D6F0F5E70FDA9040808CD4D82CA19B4089EA5D0F07DA90401223495F2EA19B4037ABB256FED99040E9495F7F30A19B4029175DC8F5D9904070968D3633A19B40E88A936EEDD99040D445968136A19B40C9AA4D53E5D99040681B8B5C3AA19B404D7D3880DDD99040AE11D2C23EA19B4094DEAAFED5D990406ED82AAF43A19B40A75A9AD7CED990403C19B51B49A19B40EB7B9013C8D99040137BF7014FA19B407F9AA0BAC1D990407F5CE75A55A19B40A8385ED4BBD990403B3BF11E5CA19B40D9F7D367B6D9904028BF014663A19B401A317B7BB1D99040E15D8FC76AA19B40D43A3415ADD990405D8BA49A72A19B4040653F3AA9D990407C6BEAB57AA19B40DCB536EFA5D99040BDF7B30F83A19B4055690838A3D99040CB8B099E8BA19B407E42F217A1D990401DCBB45694A19B40ECAB7D919FD990406BD14C2F9DA19B40D4B07CA69ED990407C9F421DA6A19B40C2D007589ED990406AB5ED15AFA19B40010200000006000000C2D007589ED990402FA582F283A29B40489DB52E9FD990402FA582F283A29B40853C4915B8D99040D038B01E9AA29B40D513A06320DB9040D038B01E9AA29B4012B3334A39DB90402FA582F283A29B40987FE1203ADB90402FA582F283A29B4001020000001A000000C2D007589ED990402FA582F283A29B40A2BEBF3D73D990402FA582F283A29B40A2BEBF3D73D990406BB5ED15AFA19B402FD3EDA573D990403216412CA3A19B40B0B7FBDD74D99040AA86CC5097A19B4022F574E476D99040C41DB7918BA19B4033B3EEB679D990403B1506FD7FA19B40EA9A0A527DD990407C0D8CA074A19B40F1DB7AB181D99040008ED88969A19B40AD4F07D086D99040B5D527C65EA19B4013B493A78CD99040D20E536254A19B40BDF6263193D99040E8F8C06A4AA19B408C87F3649AD99040901B57EB40A19B40F1A8603AA2D9904047936BEF37A19B40B3B214A8AAD990408589B7812FA19B40FC3A00A4B3D9904020684AAC27A19B4054186A23BDD9904051D77D7820A19B403E2EFC1AC7D99040A794EAEE19A19B4021F5D07ED1D9904041305E1714A19B406CAD8142DCD9904085BCD1F80EA19B40E82C3559E7D990407E7B61990AA19B40A734AFB5F2D99040C79345FE06A19B40303D604AFED99040B6D5CB2B04A19B4015A675090ADA90404498522502A19B409E35EAE415DA9040C3B344ED00A19B40D6D496CE21DA9040369F168500A19B40010200000010000000842AC02FC7DA9040B843196156A19B407D70404911DA9040B843196156A19B40E7A0D72206DA9040BDEB804C59A19B407886BF34FBD9904055CFF3F45CA19B409462798BF0D990402B8E425661A19B402FBA3733E6D990406E496A6B66A19B406461D037DCD990408A5F9A2E6CA19B400FF1AEA4D2D9904047133B9972A19B40F7B5C784C9D99040AE16F5A379A19B4075288BE2C0D9904026F1B94681A19B40E9FAD9C7B8D990400F37CD7889A19B40B4CCF93DB1D990407488CE3092A19B40928E8A4DAAD990403B4BC4649BA19B408EA47CFEA3D99040B614270AA5A19B40C2D007589ED990406BB5ED15AFA19B40C2D007589ED990402FA582F283A29B40010200000006000000C2D007589ED99040D4C2C6E2F3AA9B40489DB52E9FD99040D4C2C6E2F3AA9B40853C4915B8D99040332F99B6DDAA9B40D513A06320DB9040332F99B6DDAA9B4012B3334A39DB9040D4C2C6E2F3AA9B40987FE1203ADB9040D4C2C6E2F3AA9B40010200000002000000C2D007589ED99040D4C2C6E2F3AA9B40C2D007589ED9904098B25BBFC8AB9B4001020000001A000000C2D007589ED99040D4C2C6E2F3AA9B40A2BEBF3D73D99040D4C2C6E2F3AA9B40A2BEBF3D73D9904098B25BBFC8AB9B402FD3EDA573D99040D15108A9D4AB9B40B0B7FBDD74D9904059E17C84E0AB9B4022F574E476D990403F4A9243ECAB9B4033B3EEB679D99040C85243D8F7AB9B40EA9A0A527DD99040875ABD3403AC9B40F1DB7AB181D9904003DA704B0EAC9B40AD4F07D086D990404E92210F19AC9B4013B493A78CD990403159F67223AC9B40BDF6263193D990401B6F886A2DAC9B408C87F3649AD99040734CF2E936AC9B40F1A8603AA2D99040BCD4DDE53FAC9B40B3B214A8AAD990407EDE915348AC9B40FC3A00A4B3D99040E3FFFE2850AC9B4054186A23BDD99040B290CB5C57AC9B403E2EFC1AC7D990405CD35EE65DAC9B4021F5D07ED1D99040C237EBBD63AC9B406CAD8142DCD990407EAB77DC68AC9B40E82C3559E7D9904085ECE73B6DAC9B40A734AFB5F2D990403CD403D770AC9B40303D604AFED990404D927DA973AC9B4015A675090ADA9040BFCFF6AF75AC9B409E35EAE415DA904040B404E876AC9B40D6D496CE21DA9040CDC8325077AC9B4001020000000F000000C2D007589ED9904098B25BBFC8AB9B408EA47CFEA3D990404D5322CBD2AB9B40928E8A4DAAD99040C81C8570DCAB9B40B4CCF93DB1D990408FDF7AA4E5AB9B40E9FAD9C7B8D99040F4307C5CEEAB9B4075288BE2C0D99040DD768F8EF6AB9B40F7B5C784C9D9904054515431FEAB9B400FF1AEA4D2D99040BC540E3C05AC9B406461D037DCD990407908AFA60BAC9B402FBA3733E6D99040951EDF6911AC9B409462798BF0D99040D8D9067F16AC9B407886BF34FBD99040AE9855E01AAC9B40E7A0D72206DA9040467CC8881EAC9B407D70404911DA90404B24307421AC9B40842AC02FC7DA90404B24307421AC9B40010200000019000000C2D007589ED9904098B25BBFC8AB9B40D4B07CA69ED9904087C806B8D1AB9B40ECAB7D919FD990409896FCA5DAAB9B407E42F217A1D99040E69C947EE3AB9B4055690838A3D9904038DC3F37ECAB9B40DCB536EFA5D99040467095C5F4AB9B4040653F3AA9D9904087FC5E1FFDAB9B40D43A3415ADD99040A6DCA43A05AC9B401A317B7BB1D99040220ABA0D0DAC9B40D9F7D367B6D99040DBA8478F14AC9B40A8385ED4BBD99040C82C58B61BAC9B407F9AA0BAC1D99040840B627A22AC9B40EB7B9013C8D99040F0EC51D328AC9B40A75A9AD7CED99040C74E94B92EAC9B4094DEAAFED5D99040958F1E2634AC9B404D7D3880DDD990405456771239AC9B40C9AA4D53E5D990409B4CBE783DAC9B40E88A936EEDD990402F22B35341AC9B4029175DC8F5D9904093D1BB9E44AC9B4037ABB256FED990401A1EEA5547AC9B4089EA5D0F07DA9040F144007649AC9B40D6F0F5E70FDA904083DB74FC4AAC9B40E8BEEBD518DA90409BD675E74BAC9B40D6D496CE21DA9040ADB6EA354CAC9B40060664AAB6DA9040ABB6EA354CAC9B400102000000020000001843ADE520DA904010BA5273FC9B9B40AC921F154EDA904010BA5273FC9B9B4001020000001B000000987FE1203ADB90402FA582F283A29B40B891293B65DB90402FA582F283A29B40B891293B65DB90406BB5ED15AFA19B40DC8EFBD264DB9040D618422CA3A19B4044DFED9A63DB90405388CE5097A19B4075F9749461DB90403D17BA918BA19B40EEB4FBC15EDB9040C2FB09FD7FA19B408567E0265BDB9040DFD290A074A19B401DE070C756DB9040B320DE8969A19B409143E5A851DB9040F9202EC65EA19B40E0D159D14BDB9040DCFA596254A19B40229BC74745DB9040136BC86A4AA19B40E02CFC133EDB904090F65EEB40A19B40DA41903E36DB904068B773EF37A19B403F7FDDD02DDB9040E9D4BF812FA19B40AB4BF3D424DB904005B752AC27A19B402BCD8A551BDB90405904867820A19B40AE1CFA5D11DB90402879F2EE19A19B401CBE26FA06DB904094A4651714A19B403F6D7736FCDA90405998D8F80EA19B407050C51FF1DA9040309667990AA19B40B7A24CC3E5DA9040B6C44AFE06A19B40A3E79C2EDADA90409EF4CF2B04A19B40BABB886FCEDA9040967D552502A19B40DA541594C2DA9040FB3846ED00A19B402CC669AAB6DA9040389F168500A19B40D7D496CE21DA9040369F168500A19B4001020000001B000000987FE1203ADB9040D4C2C6E2F3AA9B40B891293B65DB9040D4C2C6E2F3AA9B40B891293B65DB904098B25BBFC8AB9B40DC8EFBD264DB90402D4F07A9D4AB9B4044DFED9A63DB9040B0DF7A84E0AB9B4075F9749461DB9040C6508F43ECAB9B40EEB4FBC15EDB9040416C3FD8F7AB9B408567E0265BDB90402495B83403AC9B401DE070C756DB904050476B4B0EAC9B409143E5A851DB90400A471B0F19AC9B40E0D159D14BDB9040276DEF7223AC9B40229BC74745DB9040F0FC806A2DAC9B40E02CFC133EDB90407371EAE936AC9B40DA41903E36DB90409AB0D5E53FAC9B403F7FDDD02DDB90401A93895348AC9B40AB4BF3D424DB9040FEB0F62850AC9B402BCD8A551BDB9040AA63C35C57AC9B40AE1CFA5D11DB9040DBEE56E65DAC9B401CBE26FA06DB90406FC3E3BD63AC9B403F6D7736FCDA9040AACF70DC68AC9B407050C51FF1DA9040D3D1E13B6DAC9B40B7A24CC3E5DA90404DA3FED670AC9B40A3E79C2EDADA9040657379A973AC9B40BABB886FCEDA90406DEAF3AF75AC9B40DA541594C2DA9040082F03E876AC9B402CC669AAB6DA9040CBC8325077AC9B40D7D496CE21DA9040CDC8325077AC9B400102000000020000009A921F154EDA90404D53EC0C96969B40AC921F154EDA90404D53EC0C96969B40010200000003000000AC921F154EDA90404D53EC0C96969B4012F9857BB4DA90404D53EC0C96969B4012F9857BB4DA904010BA5273FC9B9B40010200000002000000AC921F154EDA90404D53EC0C96969B40AC921F154EDA904010BA5273FC9B9B40010200000002000000AC921F154EDA904010BA5273FC9B9B4012F9857BB4DA904010BA5273FC9B9B4001020000000200000012F9857BB4DA904010BA5273FC9B9B4013F9857BB4DA904010BA5273FC9B9B4001020000000200000013F9857BB4DA904010BA5273FC9B9B4098E4D733D3DA904010BA5273FC9B9B4001020000000300000013F9857BB4DA904010BA5273FC9B9B4013F9857BB4DA90409D7C489C589C9B40C04067F6C8DA90409D7C489C589C9B4001020000000400000098E4D733D3DA904010BA5273FC9B9B4098E4D733D3DA90400EBA5273FC9B9B4013F9857BB4DA90400EBA5273FC9B9B4013F9857BB4DA904010BA5273FC9B9B40010200000002000000060664AAB6DA904058B15E9F2BA19B40E90564AAB6DA904057B15E9F2BA19B40010200000002000000E90564AAB6DA9040ACB6EA354CAC9B40060664AAB6DA9040ABB6EA354CAC9B400102000000020000002CC669AAB6DA904058B15E9F2BA19B40060664AAB6DA904058B15E9F2BA19B4001020000001800000004FEDF203ADB90405D9EC115AFA19B40D9AC6CD239DB90404362431DA6A19B4099D96BE738DB904040544E2F9DA19B400785F76037DB90409108B75694A19B40B7B9E14035DB9040C67B0C9E8BA19B4065E1B38932DB90408C8FB70F83A19B40CBBDAB3E2FDB9040EA9DEEB57AA19B40458AB7632BDB9040C948A99A72A19B40C64A71FD26DB9040619494C76AA19B40CB4D191122DB9040AA5A074663A19B40CCE78FA41CDB9040B025F71E5CA19B40B16F4EBE16DB9040077EED5A55A19B40A5845F6510DB90402CBAFD014FA19B407FA656A109DB9040F85ABB1B49A19B40C92A477A02DB9040A90031AF43A19B403C99BAF8FADA90404B03D8C23EA19B401A7BA625F3DA904089B8905C3AA19B40A9A9610AEBDA90401E709B8136A19B40822899B0E2DA9040482F923633A19B4009994422DADA9040B632637F30A19B40D7549A69D1DA9040823D4C5F2EA19B40413D0391C8DA9040C7BAD6D82CA19B40984E0EA3BFDA904085B6D4ED2BA19B40060664AAB6DA904058B15E9F2BA19B400102000000020000002CC669AAB6DA9040ABB6EA354CAC9B40060664AAB6DA9040ABB6EA354CAC9B40010200000018000000060664AAB6DA9040ABB6EA354CAC9B40984E0EA3BFDA90407EB174E74BAC9B40413D0391C8DA90403CAD72FC4AAC9B40D7549A69D1DA9040812AFD7549AC9B4009994422DADA90404D35E65547AC9B40822899B0E2DA9040BB38B79E44AC9B40A9A9610AEBDA9040E5F7AD5341AC9B401A7BA625F3DA90407AAFB8783DAC9B403C99BAF8FADA9040B764711239AC9B40C92A477A02DB90405A67182634AC9B407FA656A109DB90400B0D8EB92EAC9B40A5845F6510DB9040D7AD4BD328AC9B40B16F4EBE16DB9040FCE95B7A22AC9B40CCE78FA41CDB9040534252B61BAC9B40CB4D191122DB9040590D428F14AC9B40C64A71FD26DB9040A2D3B40D0DAC9B40458AB7632BDB90403A1FA03A05AC9B40CBBDAB3E2FDB904019CA5A1FFDAB9B4065E1B38932DB904077D891C5F4AB9B40B7B9E14035DB90403DEC3C37ECAB9B400785F76037DB9040725F927EE3AB9B4099D96BE738DB9040C313FBA5DAAB9B40D9AC6CD239DB9040C00506B8D1AB9B4004FEDF203ADB9040A6C987BFC8AB9B40010200000016000000A23465CBC1DA9040A33B348103899B40010DAC6FF4DA9040B167243B05899B40FF0AC2D726DB904070A6E7660A899B409FDEBDC758DB9040F89758FE12899B409EF744048ADB9040EA0F41F71E899B402A11D252BADB9040943866432E899B4008C0FA79E9DB9040A87C99D040899B4096B0B34117DC90407C23CE8856899B407B43937343DC9040328633526F899B40E03912DB6DDC904073BE530F8B899B405524CA4596DC904082AA369FA9899B402D4AB183BCDC9040D01C89DDCA899B4017C25367E0DC9040B008C8A2EE899B40217809C601DD9040A8786FC4148A9B40EAE0287820DD9040BE162D153D8A9B40C41D36593CDD9040900A1665678A9B40B2590E4855DD90403EEDDF81938A9B40D12B0F276BDD90406C8F1C37C18A9B403CD039DC7DDD9040684A784EF08A9B40AC0D52518DDD90403A92FA8F208B9B4006A3F87399DD90400E7C48C2518B9B407A1DC135A2DD9040C3E9E8AA838B9B40010200000007000000A23465CBC1DA9040EE930028EB8B9B40A45FECE19ADA9040EE930028EB8B9B40A45FECE19ADA90400C815782E28B9B40A58A73F873DA90400C815782E28B9B40A58A73F873DA9040B4B95273FC8B9B40A23465CBC1DA9040B4B95273FC8B9B40A23465CBC1DA9040EE930028EB8B9B40010200000003000000A23465CBC1DA9040EE930028EB8B9B40EC28292CBFDA9040A6C02B55C48B9B40ABD177D958DD9040D8840A60978B9B40010200000002000000A23465CBC1DA9040EE930028EB8B9B4061DDB3785BDD90402158DF32BE8B9B40010200000002000000852AC02FC7DA9040B843196156A19B40842AC02FC7DA9040B843196156A19B4001020000000E00000004FEDF203ADB90405D9EC115AFA19B4074F6837A34DB9040B614270AA5A19B406F0C762B2EDB90403B4BC4649BA19B404DCE063B27DB90407488CE3092A19B4018A026B11FDB90400F37CD7889A19B408D72759617DB904026F1B94681A19B400BE538F40EDB9040AE16F5A379A19B40F3A951D405DB904047133B9972A19B409D393041FCDA90408A5F9A2E6CA19B40D2E0C845F2DA90406E496A6B66A19B406E3887EDE7DA90402B8E425661A19B408A144144DDDA904055CFF3F45CA19B401AFA2856D2DA9040BDEB804C59A19B40842AC02FC7DA9040B843196156A19B40010200000002000000852AC02FC7DA90404B24307421AC9B40842AC02FC7DA90404B24307421AC9B4001020000000E000000842AC02FC7DA90404B24307421AC9B401AFA2856D2DA9040467CC8881EAC9B408A144144DDDA9040AE9855E01AAC9B406E3887EDE7DA9040D8D9067F16AC9B40D2E0C845F2DA9040951EDF6911AC9B409D393041FCDA90407908AFA60BAC9B40F3A951D405DB9040BC540E3C05AC9B400BE538F40EDB904054515431FEAB9B408D72759617DB9040DD768F8EF6AB9B4018A026B11FDB9040F4307C5CEEAB9B404DCE063B27DB90408FDF7AA4E5AB9B406F0C762B2EDB9040C81C8570DCAB9B4074F6837A34DB90404D5322CBD2AB9B4004FEDF203ADB9040A6C987BFC8AB9B40010200000016000000C04067F6C8DA90409D7C489C589C9B40A44F1143CBDA9040F81321CF9B9C9B40347A4E26D2DA9040CDD77EB1DE9C9B407606DF97DDDA9040615747F3209D9B40AA630E8AEDDA904016742045629D9B404694C3E901DB9040736ACF58A29D9B403C0D989E1ADB9040FE8296E1E09D9B4014EFF48A37DB9040C3FA90941D9E9B40E675368C58DB904061B50C29589E9B40BE75D57A7DDB9040494DE158909E9B40C2B1962AA6DB9040D419C4E0C59E9B4056D5BF6AD2DB90409DC69880F89E9B40E8CF510602DC9040921BBEFB279F9B40604D48C434DC9040CD995619549F9B404BFFDD676ADC90403A968CA47C9F9B40ED64D5B0A2DC90407880D16CA19F9B400ABBC55BDDDC9040340A1846C29F9B404EB76B221ADD904053E90809DF9F9B409CAEFDBB58DD9040B7F53193F79F9B407DC182DD98DD90403E6A2FC70BA09B404CA62C3ADADD90408617CF8C1BA09B408EA5B3831CDE9040565E2DD126A09B40010200000004000000C04067F6C8DA90409D7C489C589C9B40C04067F6C8DA9040559BCD872A9C9B4098E4D733D3DA9040559BCD872A9C9B4098E4D733D3DA904010BA5273FC9B9B40010200000002000000B336905298DC90404953EC0C96889B406D2CB9AEE7DA90404953EC0C96889B400102000000040000006D2CB9AEE7DA90404953EC0C96889B40692CB9AEE7DA90404953EC0C96889B40692CB9AEE7DA90400820B9D962869B40B736905298DC90400820B9D962869B40010200000003000000B736905298DC90400D20B9D962869B406D2CB9AEE7DA90400D20B9D962869B406D2CB9AEE7DA90404953EC0C96889B400102000000020000006D2CB9AEE7DA9040B4B95273FC8B9B4020EFAED7C3E19040DBB95273FC8B9B4001020000000200000040CAF8203ADB90406BB5ED15AFA19B4004FEDF203ADB90405D9EC115AFA19B40010200000002000000987FE1203ADB90406AB5ED15AFA19B4004FEDF203ADB90405D9EC115AFA19B4001020000000300000004FEDF203ADB9040A6C987BFC8AB9B40987FE1203ADB904098B25BBFC8AB9B40987FE1203ADB9040D4C2C6E2F3AA9B4001020000000200000004FEDF203ADB9040A6C987BFC8AB9B4040CAF8203ADB904098B25BBFC8AB9B40010200000002000000987FE1203ADB90402FA582F283A29B40987FE1203ADB90406BB5ED15AFA19B40010200000013000000B8237EF5F4DB90405CFC532FC8869B40834870E5F3DB9040F1855893C6869B40085B4AF2F2DB9040B35CABE5C4869B40BAB0311DF2DB904025DD5228C3869B40E85D2767F1DB9040114B685DC1869B4094FF06D1F0DB90405C491587BF869B4088B2855BF0DB9040253E91A7BD869B40D5383107F0DB90403CA61EC1BB869B40CD4E6FD4EFDB9040455B08D6B9869B404A307DC3EFDB9040B8CF9EE8B7869B40CD4E6FD4EFDB90402B4435FBB5869B40D5383107F0DB904034F91E10B4869B4088B2855BF0DB90404B61AC29B2869B4094FF06D1F0DB90401456284AB0869B40E85D2767F1DB90405F54D573AE869B40BAB0311DF2DB90404BC2EAA8AC869B40085B4AF2F2DB9040BD4292EBAA869B40834870E5F3DB90408019E53DA9869B40B8237EF5F4DB904014A3E9A1A7869B40010200000002000000E1BE7F4DFBDB90403B3EEBF9AD869B40E0BE7F4DFBDB90403A3EEBF9AD869B40010200000002000000E0BE7F4DFBDB90403A3EEBF9AD869B40E0BE7F4DFBDB90403B3EEBF9AD869B40010200000004000000B784A094FBDB90401542C702A1869B40E5FC3A0FEEDB904043BA617D93869B40E79B1870E7DB9040411B841C9A869B40E0BE7F4DFBDB90403A3EEBF9AD869B40010200000003000000E0BE7F4DFBDB90403A3EEBF9AD869B40DF1FA2EC01DC90403CDDC85AA7869B40B784A094FBDB90401542C702A1869B40010200000013000000B784A094FBDB90401542C702A1869B4023FB9B30FDDB9040DF66B9F29F869B40602449DEFEDB9040647993FF9E869B40EEA3A19B00DC904017CF7A2A9E869B4003368C6602DC9040447C70749D869B40B737DF3C04DC9040F01D50DE9C869B40EF42631C06DC9040E5D0CE689C869B40D7DAD50208DC904031577A149C869B40CE25ECED09DC9040296DB8E19B869B405BB155DB0BDC9040A64EC6D09B869B40E93CBFC80DDC9040296DB8E19B869B40E087D5B30FDC904031577A149C869B40C81F489A11DC9040E4D0CE689C869B40002BCC7913DC9040F01D50DE9C869B40B42C1F5015DC9040447C70749D869B40C9BE091B17DC904016CF7A2A9E869B40573E62D818DC9040647993FF9E869B4095670F861ADC9040DF66B9F29F869B4000DE0A221CDC90401442C702A1869B4001020000001300000001DE0A221CDC90405B5D76CECE869B4096670F861ADC9040903884DECF869B40583E62D818DC90400B26AAD1D0869B40CBBE091B17DC904059D0C2A6D1869B40B62C1F5015DC90402C23CD5CD2869B40012BCC7913DC90408081EDF2D2869B40CA1F489A11DC90408CCE6E68D3869B40E287D5B30FDC90403F48C3BCD3869B40EA3CBFC80DDC9040473285EFD3869B405DB155DB0BDC9040CA507700D4869B40D025ECED09DC9040473285EFD3869B40D8DAD50208DC90403F48C3BCD3869B40F042631C06DC90408CCE6E68D3869B40B937DF3C04DC90408081EDF2D2869B4004368C6602DC90402D23CD5CD2869B40EFA3A19B00DC90405AD0C2A6D1869B40612449DEFEDB90400C26AAD1D0869B4023FB9B30FDDB9040913884DECF869B40B884A094FBDB90405C5D76CECE869B4001020000000200000002DE0A221CDC90405B5D76CECE869B4001DE0A221CDC90405B5D76CECE869B4001020000000400000001DE0A221CDC90405B5D76CECE869B40D46570A729DC90402EE5DB53DC869B40D2C6924630DC90403084B9B4D5869B40FF3E2DC122DC90405DFC532FC8869B4001020000000400000001DE0A221CDC90405B5D76CECE869B40DA4209CA15DC904034C27476C8869B40D8A32B691CDC9040366152D7C1869B40FF3E2DC122DC90405DFC532FC8869B40010200000013000000003F2DC122DC904014A3E9A1A7869B40351A3BD123DC90408019E53DA9869B40B00761C424DC9040BE4292EBAA869B40FEB1799925DC90404BC2EAA8AC869B40D004844F26DC90406054D573AE869B402463A4E526DC90401556284AB0869B4030B0255B27DC90404C61AC29B2869B40E3297AAF27DC904034F91E10B4869B40EB133CE227DC90402C4435FBB5869B406E322EF327DC9040B9CF9EE8B7869B40EB133CE227DC9040465B08D6B9869B40E3297AAF27DC90403DA61EC1BB869B402FB0255B27DC9040263E91A7BD869B402463A4E526DC90405D491587BF869B40D004844F26DC9040124B685DC1869B40FDB1799925DC904026DD5228C3869B40B00761C424DC9040B45CABE5C4869B40351A3BD123DC9040F2855893C6869B40FF3E2DC122DC90405DFC532FC8869B4001020000002D0000004D2CC58886DC9040B917388DD2869B408AC6A82677DC9040494A23FED3869B40546FA5ED67DC9040D430A04CD6869B406A5C97F058DC90405F35D375D9869B408D7A10424ADC9040E9C8D175DD869B409D6B41F43BDC9040843DA747E2869B4043FDE2182EDC90402FEA5AE5E7869B400C3420C120DC9040C190F747EE869B40370681FD13DC9040CEFC9367F5869B4082E0D5DD07DC9040C3D05C3BFD869B40580E2471FCDB904026759FB905879B40B71D93C5F1DB9040681CD6D70E879B40C0555BE8E7DB904060CCB48A18879B40C755B5E5DEDB9040525D37C622879B401BF1CAC8D6DB9040225DB07D2D879B40505AA99BCFDB904047C4D8A338879B4032AF3467C9DB90400969E02A44879B40C0F41C33C4DB9040A31C7F0450879B40E990D405C0DB9040145D06225C879B40C54D88E4BCDB9040C085737468879B403EF018D3BADB9040466882EC74879B40126A16D4B9DB90408F36C07A81879B4020ADBCE8B9DB90409AA69E0F8E879B40FC23F210BBDB90405A38879B9A879B40A1D1474BBDDB9040C185EE0EA7879B401C18FB94C0DB90400785675AB3879B400624F9E9C4DB904054A5B66EBF879B4084F8E344CADB904021AEE43CCB879B409815199FD0DB9040E84951B6D6879B407AB0B9F0D7DB90403225C5CCE1879B40D673B430E0DB9040898B8372EC879B40CBBBD054E9DB9040826C5B9AF6879B40D73FBB51F3DB9040BBB3B73700889B40E31A141BFEDB9040A5DFAE3E09889B4024207EA309DC9040AEC311A411889B40C569AFDC15DC90409F63795D19889B40DD0C83B722DC9040E0D6536120889B40BEDC0B2430DC9040D623F0A626889B406526A8113EDC9040790489262C889B40874B166F4CDC9040FB864ED930889B40D2238A2A5BDC90406F7E6EB934889B40BF09C3316ADC904005B91BC237889B40C977227279DC9040FAF293EF39889B40E319C3D888DC9040CB7E243F3B889B40B336905298DC9040E89C2DAF3B889B40010200000018000000B536905298DC9040E9BAED0F63879B40ADC526C097DC9040E9BAED0F63879B40B37E0A9C96DC9040709580FB62879B403E25117A95DC904050C4BFD262879B409B61A45B94DC9040691BDE9562879B40E46E294293DC90404589274562879B40785DFF2E92DC90405FB800E161879B40225D7D2391DC90409C91E66961879B401011F12090DC90407EA06DE060879B40B7EF9C288FDC9040E059414560879B40A6B0B63B8EDC9040214623995F879B403FCA655B8DDC9040C00FEADC5E879B403301C2888CDC9040A37780115E879B40980BD2C48BDC90404D30E4375D879B403F498A108BDC904076A124515C879B40EA92CB6C8ADC90408895615E5B879B40E22162DA89DC9040B2D2C9605A879B403D91045A89DC90404AA1995959879B4022FA52EC88DC90405341194A58879B40192CD69188DC904017519B3357879B406E02FF4A88DC9040D5267B1756879B406AD7251888DC90408E1F1BF754879B4024168AF987DC90400CE5E2D353879B406BEB51EF87DC904050AD3DAF52879B400102000000020000006BEB51EF87DC904050AD3DAF52879B406BEB51EF87DC90403A3655AF52879B400102000000020000006CEB51EF87DC90403CB5D980B8869B406BEB51EF87DC904050AD3DAF52879B4001020000002400000073EB51EF87DC90403BB5D980B8869B40F46CDACF86DC90406D08C352B7869B40D8C116C685DC9040522B6A11B6869B40D94C50D384DC90402B645DBEB4869B409DF2B3F883DC904003EA405BB3869B40CBA4503783DC9040E8DBCCE9B1869B403E12169082DC90406C1FCB6BB0869B40F47DD30382DC9040202915E3AE869B402DBE369381DC9040CBB19151AD869B40FA64CB3E81DC90402F5B32B9AB869B403D13FA0681DC90404047F11BAA869B4000F707EC80DC9040DEA4CE7BA8869B40B77516EE80DC90400935CEDAA6869B40D702230D81DC9040A5CBF43AA5869B400823074981DC9040F1CE459EA3869B40CE9B78A181DC9040BBB8C006A2869B408BCF091682DC90407B9C5E76A0869B405E452AA682DC904050B50FEF9E869B402C5C275183DC9040FEFEB8729D869B4008282D1684DC9040D8DC31039C869B40DA7847F484DC904082D141A29A869B40030963EA85DC9040674A9E5199869B4086D24EF786DC90409081E81298869B401889BD1988DC90408C78ABE796869B403337475089DC9040DD0E5AD195869B4038FC6A998ADC904051364DD194869B4070E990F38BDC90407D47C2E893869B40A6FB0B5D8DDC90406978D91893869B40DD2E1CD48EDC90406177946292869B4091A9F05690DC9040922BD5C691869B40DDFCA9E391DC9040129D5C4691869B40AA765C7893DC90409F05CAE190869B401D83121395DC90404A0B9A9990869B40351ACFB196DC9040FA25266E90869B40B636905298DC90408730A45F90869B40B736905298DC90408730A45F90869B40010200000002000000B236905298DC90408223C07FDF889B40B336905298DC90404953EC0C96889B4001020000002E000000B336905298DC9040E89C2DAF3B889B40B536905298DC9040E89C2DAF3B889B4086535DCCA7DC9040CC7E243F3B889B40A1F5FD32B7DC9040FBF293EF39889B40AA635D73C6DC904006B91BC237889B409849967AD5DC9040707E6EB934889B40E2210A36E4DC9040FD864ED930889B4005477893F2DC90407B0489262C889B40AC90148100DD9040D823F0A626889B408D609DED0DDD9040E3D6536120889B40A50371C81ADD9040A263795D19889B40464DA20127DD9040B2C311A411889B4087520C8A32DD9040A8DFAE3E09889B40932D65533DDD9040BFB3B73700889B409FB14F5047DD9040866C5B9AF6879B4095F96B7450DD90408E8B8372EC879B40F0BC66B458DD90403725C5CCE1879B40D257070660DD9040ED4951B6D6879B40E6743C6066DD904026AEE43CCB879B40654927BB6BDD90405AA5B66EBF879B404E55251070DD90400D85675AB3879B40CA9BD85973DD9040C785EE0EA7879B406F492E9475DD90406038879B9A879B404CC063BC76DD9040A0A69E0F8E879B405A030AD176DD90409536C07A81879B402D7D07D275DD90404C6882EC74879B40A71F98C073DD9040C585737468879B4083DC4B9F70DD9040195D06225C879B40AC7803726CDD9040A81C7F0450879B403ABEEB3D67DD90400E69E02A44879B401C13770961DD90404CC4D8A338879B40527C55DC59DD9040275DB07D2D879B40A5176BBF51DD9040575D37C622879B40AC17C5BC48DD904065CCB48A18879B40B64F8DDF3EDD90406C1CD6D70E879B40145FFC3334DD90402A759FB905879B40EB8C4AC728DD9040C7D05C3BFD869B4036679FA71CDD9040D2FC9367F5869B40613900E40FDD9040C590F747EE869B402A703D8C02DD904031EA5AE5E7869B40D001DFB0F4DC9040863DA747E2869B40E0F20F63E6DC9040EBC8D175DD869B40031189B4D7DC90406135D375D9869B4019FE7AB7C8DC9040D530A04CD6869B40E3A6777EB9DC90404A4A23FED3869B4020415B1CAADC9040B917388DD2869B40010200000002000000B336905298DC90404953EC0C96889B40B336905298DC9040E89C2DAF3B889B40010200000002000000B336905298DC9040E89C2DAF3B889B40B536905298DC9040E9BAED0F63879B40010200000003000000074167F648DE90400D20B9D962869B40104167F648DE90404953EC0C96889B40B336905298DC90404953EC0C96889B400102000000180000000082CEB5A8DC904051AD3DAF52879B40465796ABA8DC90400CE5E2D353879B400196FA8CA8DC90408E1F1BF754879B40FC6A215AA8DC9040D5267B1756879B4051414A13A8DC904017519B3357879B404973CDB8A7DC90405341194A58879B402EDC1B4BA7DC90404AA1995959879B40894BBECAA6DC9040B2D2C9605A879B4080DA5438A6DC90408895615E5B879B402C249694A5DC904076A124515C879B40D2614EE0A4DC90404E30E4375D879B40376C5E1CA4DC9040A37780115E879B402BA3BA49A3DC9040C00FEADC5E879B40C4BC6969A2DC9040214623995F879B40B37D837CA1DC9040E159414560879B405A5C2F84A0DC90407EA06DE060879B404810A3819FDC90409C91E66961879B40F20F21769EDC90405FB800E161879B4086FEF6629DDC90404589274562879B40CF0B7C499CDC9040691BDE9562879B402C480F2B9BDC904050C4BFD262879B40B7EE15099ADC9040709580FB62879B40BDA7F9E498DC9040E9BAED0F63879B40B536905298DC9040E9BAED0F63879B40010200000002000000B536905298DC9040E9BAED0F63879B40B736905298DC90408730A45F90869B40010200000003000000B736905298DC90400820B9D962869B40074167F648DE90400820B9D962869B40074167F648DE90400D20B9D962869B40010200000002000000B736905298DC90400D20B9D962869B40B736905298DC90400820B9D962869B40010200000002000000B736905298DC90400820B9D962869B40B836905298DC9040FDC1E07615869B40010200000002000000074167F648DE90400D20B9D962869B40B736905298DC90400D20B9D962869B40010200000002000000B736905298DC90408730A45F90869B40B736905298DC90400D20B9D962869B40010200000023000000B736905298DC90408730A45F90869B40375351F399DC9040FA25266E90869B4050EA0D929BDC90404A0B9A9990869B40C2F6C32C9DDC90409F05CAE190869B40907076C19EDC9040129D5C4691869B40DCC32F4EA0DC9040922BD5C691869B40903E04D1A1DC90406177946292869B40C6711448A3DC90406978D91893869B40FD838FB1A4DC90407D47C2E893869B403571B50BA6DC904051364DD194869B403936D954A7DC9040DD0E5AD195869B4054E4628BA8DC90408C78ABE796869B40E79AD1ADA9DC90409081E81298869B406A64BDBAAADC9040674A9E5199869B4092F4D8B0ABDC904082D141A29A869B406445F38EACDC9040D8DC31039C869B404111F953ADDC9040FEFEB8729D869B400F28F6FEADDC904050B50FEF9E869B40E19D168FAEDC90407B9C5E76A0869B409FD1A703AFDC9040BBB8C006A2869B40644A195CAFDC9040F1CE459EA3869B40956AFD97AFDC9040A5CBF43AA5869B40B6F709B7AFDC90400935CEDAA6869B406C7618B9AFDC9040DFA4CE7BA8869B402F5A269EAFDC90404047F11BAA869B4072085566AFDC90402F5B32B9AB869B403FAFE911AFDC9040CBB19151AD869B4079EF4CA1AEDC9040202915E3AE869B402E5B0A15AEDC90406C1FCB6BB0869B40A1C8CF6DADDC9040E9DBCCE9B1869B40D07A6CACACDC904003EA405BB3869B409320D0D1ABDC90402B645DBEB4869B4094AB09DFAADC9040532B6A11B6869B40780046D5A9DC90406D08C352B7869B40F981CEB5A8DC90403BB5D980B8869B400102000000030000003D22D1379CDC904047C012E754A39B400212661471DD904047C012E754A39B401029921471DD9040DB4114E754A39B400102000000060000003D22D1379CDC90401D6FECAFF0A49B403D22D1379CDC904097A23ED9EFA49B409C8EA30B86DC90405A03ABF2D6A49B409C8EA30B86DC90400A2C54A46EA39B403D22D1379CDC9040CD8CC0BD55A39B403D22D1379CDC904047C012E754A39B400102000000340000003D22D1379CDC90401D6FECAFF0A49B403D22D1379CDC90403D8134CA1BA59B400212661471DD90403D8134CA1BA59B403AB112FE7CDD9040B06C06621BA59B40C34087D988DD90402F88F8291AA59B40A8A99C9894DD9040BD4A7F2318A59B4031B24D2DA0DD9040AD8C055115A59B40F0B9C789ABDD9040F5A4E9B511A59B406C397BA0B6DD9040EE6379560DA59B40B7F12B64C1DD904032F0EC3708A59B409AB800C8CBDD9040CC8B606002A59B4084CE92BFD5DD90402249CDD6FBA49B40DCABFC3EDFDD904053B800A3F4A49B402534E83AE8DD9040EE9693CDECA49B40E73D9CA8F0DD90402C8DDF5FE4A49B404C5F097EF8DD9040E304F463DBA49B401BF0D5B1FFDD90408B278AE4D1A49B40C532693B06DE9040A111F8ECC7A49B402B97F5120CDE9040BE4A2389BDA49B40E70A823111DE9040739272C5B2A49B40EE4BF29015DE9040F712BFAEA7A49B40A6330E2C19DE9040380B45529CA49B40B6F187FE1BDE9040AF0294BD90A49B40282F01051EDE9040CA997EFE84A49B40A9130F3D1FDE9040410A0A2379A49B4036283DA51FDE9040096B5D396DA49B4034283DA51FDE9040B3798A5DD8A39B40718E0D3D1FDE904005EBDE73CCA39B40D649FE041EDE904025846B98C0A39B40CED283FE1BDE90403C5857D9B4A39B40B602092C19DE9040289DA744A9A39B403C31EC9015DE90406FEF2EE89DA39B40132F7B3111DE9040A0D27CD192A39B40D822EE120CDE9040C381CD0D88A39B40444E613B06DE90403123FAA97DA39B4013C3CDB1FFDD9040B47269B273A39B406710017EF8DD904034F400336AA39B4083F293A8F0DD9040A0C0163761A39B400410E03AE8DD904006FE63C958A39B40DCD0F43EDFDD90400013F8F350A39B40595C8BBFD5DD9040BEA42CC049A39B4090CCF9C7CBDD9040FF6D9A3643A39B4073A62564C1DD90404EFC0E5F3DA39B40B9A675A0B6DD9040C25F834038A39B408DF4C289ABDD90405AD813E133A39B40AACB492DA0DD9040F18AF84530A39B402FB0999894DD90406B467F732DA39B40193F85D988DD90409B60066D2BA39B4096AE11FE7CDD904003B1F8342AA39B400212661471DD904027AECACC29A39B403D22D1379CDC904027AECACC29A39B403D22D1379CDC904047C012E754A39B400102000000020000003D22D1379CDC90401D6FECAFF0A49B400212661471DD90401D6FECAFF0A49B400102000000030000003D22D1379CDC9040AD72D1FCF4A59B400212661471DD9040AD72D1FCF4A59B400E29921471DD904041F4D2FCF4A59B400102000000020000003D22D1379CDC9040333F7FD3F5A59B403D22D1379CDC9040AD72D1FCF4A59B400102000000340000003D22D1379CDC90408321ABC590A79B403D22D1379CDC9040A333F3DFBBA79B400212661471DD9040A333F3DFBBA79B403AB112FE7CDD9040161FC577BBA79B40C34087D988DD9040953AB73FBAA79B40A8A99C9894DD904023FD3D39B8A79B4031B24D2DA0DD9040133FC466B5A79B40F0B9C789ABDD90405B57A8CBB1A79B406C397BA0B6DD90405416386CADA79B40B7F12B64C1DD904098A2AB4DA8A79B409AB800C8CBDD9040323E1F76A2A79B4084CE92BFD5DD904088FB8BEC9BA79B40DCABFC3EDFDD9040B96ABFB894A79B402534E83AE8DD9040544952E38CA79B40E73D9CA8F0DD9040923F9E7584A79B404C5F097EF8DD90404AB7B2797BA79B401BF0D5B1FFDD9040F1D948FA71A79B40C532693B06DE904008C4B60268A79B402B97F5120CDE904024FDE19E5DA79B40E70A823111DE9040D94431DB52A79B40EE4BF29015DE90405EC57DC447A79B40A6330E2C19DE90409FBD03683CA79B40B6F187FE1BDE904015B552D330A79B40282F01051EDE9040304C3D1425A79B40A9130F3D1FDE9040A8BCC83819A79B4036283DA51FDE90406F1D1C4F0DA79B4034283DA51FDE9040192C497378A69B40718E0D3D1FDE90406B9D9D896CA69B40D649FE041EDE90408C362AAE60A69B40CED283FE1BDE9040A30A16EF54A69B40B602092C19DE90408E4F665A49A69B403C31EC9015DE9040D5A1EDFD3DA69B40132F7B3111DE904006853BE732A69B40D822EE120CDE904029348C2328A69B40444E613B06DE904097D5B8BF1DA69B4013C3CDB1FFDD90401A2528C813A69B406710017EF8DD90409AA6BF480AA69B4083F293A8F0DD90400673D54C01A69B400410E03AE8DD90406CB022DFF8A59B40DCD0F43EDFDD904066C5B609F1A59B40595C8BBFD5DD90402457EBD5E9A59B4090CCF9C7CBDD90406520594CE3A59B4073A62564C1DD9040B4AECD74DDA59B40B9A675A0B6DD904028124256D8A59B408DF4C289ABDD9040C18AD2F6D3A59B40AACB492DA0DD9040573DB75BD0A59B402FB0999894DD9040D1F83D89CDA59B40193F85D988DD90400213C582CBA59B4096AE11FE7CDD90406963B74ACAA59B400212661471DD90408D6089E2C9A59B403D22D1379CDC90408D6089E2C9A59B403D22D1379CDC9040AD72D1FCF4A59B400102000000050000003D22D1379CDC9040343F7FD3F5A59B409C8EA30B86DC904071DE12BA0EA69B409C8EA30B86DC9040C0B5690877A79B403D22D1379CDC9040FD54FDEE8FA79B403D22D1379CDC90408321ABC590A79B400102000000020000003D22D1379CDC90408321ABC590A79B400212661471DD90408321ABC590A79B400102000000030000003D22D1379CDC9040B926F0E687A89B400212661471DD9040B926F0E687A89B401029921471DD90404DA8F1E687A89B400102000000060000003D22D1379CDC90408FD5C9AF23AA9B403D22D1379CDC904009091CD922AA9B409C8EA30B86DC9040CC6988F209AA9B409C8EA30B86DC90407C9231A4A1A89B403D22D1379CDC90403FF39DBD88A89B403D22D1379CDC9040B926F0E687A89B400102000000340000003D22D1379CDC90408FD5C9AF23AA9B403D22D1379CDC9040AFE711CA4EAA9B400212661471DD9040AFE711CA4EAA9B403AB112FE7CDD904022D3E3614EAA9B40C34087D988DD9040A1EED5294DAA9B40A8A99C9894DD90402FB15C234BAA9B4031B24D2DA0DD90401EF3E25048AA9B40F0B9C789ABDD9040670BC7B544AA9B406C397BA0B6DD904060CA565640AA9B40B7F12B64C1DD9040A456CA373BAA9B409AB800C8CBDD90403EF23D6035AA9B4084CE92BFD5DD904094AFAAD62EAA9B40DCABFC3EDFDD9040C51EDEA227AA9B402534E83AE8DD904060FD70CD1FAA9B40E73D9CA8F0DD90409EF3BC5F17AA9B404C5F097EF8DD9040556BD1630EAA9B401BF0D5B1FFDD9040FD8D67E404AA9B40C532693B06DE90401378D5ECFAA99B402B97F5120CDE904030B10089F0A99B40E70A823111DE9040E5F84FC5E5A99B40EE4BF29015DE904069799CAEDAA99B40A6330E2C19DE9040AA712252CFA99B40B6F187FE1BDE9040216971BDC3A99B40282F01051EDE90403B005CFEB7A99B40A9130F3D1FDE9040B370E722ACA99B4036283DA51FDE90407AD13A39A0A99B4034283DA51FDE904025E0675D0BA99B40718E0D3D1FDE90407751BC73FFA89B40D649FE041EDE904097EA4898F3A89B40CED283FE1BDE9040AEBE34D9E7A89B40B602092C19DE90409A038544DCA89B403C31EC9015DE9040E1550CE8D0A89B40132F7B3111DE904012395AD1C5A89B40D822EE120CDE904035E8AA0DBBA89B40444E613B06DE9040A389D7A9B0A89B4013C3CDB1FFDD904026D946B2A6A89B406710017EF8DD9040A65ADE329DA89B4083F293A8F0DD90401227F43694A89B400410E03AE8DD9040776441C98BA89B40DCD0F43EDFDD90407179D5F383A89B40595C8BBFD5DD90402F0B0AC07CA89B4090CCF9C7CBDD904071D4773676A89B4073A62564C1DD9040C062EC5E70A89B40B9A675A0B6DD904034C660406BA89B408DF4C289ABDD9040CC3EF1E066A89B40AACB492DA0DD904063F1D54563A89B402FB0999894DD9040DCAC5C7360A89B40193F85D988DD90400DC7E36C5EA89B4096AE11FE7CDD90407517D6345DA89B400212661471DD90409914A8CC5CA89B403D22D1379CDC90409914A8CC5CA89B403D22D1379CDC9040B926F0E687A89B400102000000020000003D22D1379CDC90408FD5C9AF23AA9B400212661471DD90408FD5C9AF23AA9B400102000000020000000182CEB5A8DC90403CB5D980B8869B400082CEB5A8DC9040393655AF52879B400102000000050000009807B0FD06DD904043BA617D93869B409AA68D5E00DD9040421B841C9A869B4095C9F43B14DD90403C3EEBF9AD869B40932A17DB1ADD90403EDDC85AA7869B409807B0FD06DD904044BA617D93869B400102000000130000006D2EF3E30DDD90405FFC532FC8869B403853E5D30CDD9040F3855893C6869B40BD65BFE00BDD9040B55CABE5C4869B406FBBA60B0BDD904028DD5228C3869B409C689C550ADD9040134B685DC1869B40490A7CBF09DD90405E491587BF869B403DBDFA4909DD9040273E91A7BD869B408A43A6F508DD90403FA61EC1BB869B408259E4C208DD9040475B08D6B9869B40FE3AF2B108DD9040BACF9EE8B7869B408159E4C208DD90402D4435FBB5869B408943A6F508DD904036F91E10B4869B403DBDFA4909DD90404D61AC29B2869B40480A7CBF09DD90401656284AB0869B409C689C550ADD90406154D573AE869B406FBBA60B0BDD90404DC2EAA8AC869B40BC65BFE00BDD9040BF4292EBAA869B403753E5D30CDD90408119E53DA9869B406C2EF3E30DDD904016A3E9A1A7869B400102000000040000006B8F158314DD90405C5D76CECE869B409807B0FD06DD90402FE5DB53DC869B409AA68D5E00DD90403184B9B4D5869B406D2EF3E30DDD90405FFC532FC8869B4001020000000200000095C9F43B14DD9040376152D7C1869B406D2EF3E30DDD90405FFC532FC8869B4001020000000200000095C9F43B14DD9040376152D7C1869B4094C9F43B14DD9040366152D7C1869B4001020000000300000095C9F43B14DD9040376152D7C1869B40932A17DB1ADD904035C27476C8869B406B8F158314DD90405C5D76CECE869B40010200000013000000B4E87F1035DD90405E5D76CECE869B404972847433DD9040933884DECF869B400B49D7C631DD90400E26AAD1D0869B407DC97E0930DD90405CD0C2A6D1869B406837943E2EDD90402E23CD5CD2869B40B43541682CDD90408281EDF2D2869B407C2ABD882ADD90408ECE6E68D3869B4094924AA228DD90404148C3BCD3869B409C4734B726DD9040493285EFD3869B400FBCCAC924DD9040CC507700D4869B40823061DC22DD9040493285EFD3869B408BE54AF120DD90404048C3BCD3869B40A24DD80A1FDD90408DCE6E68D3869B406B42542B1DDD90408181EDF2D2869B40B64001551BDD90402D23CD5CD2869B40A1AE168A19DD90405BD0C2A6D1869B40142FBECC17DD90400D26AAD1D0869B40D605111F16DD9040923884DECF869B406B8F158314DD90405C5D76CECE869B400102000000130000006D8F158314DD90401642C702A1869B40D805111F16DD9040E066B9F29F869B40162FBECC17DD9040657993FF9E869B40A3AE168A19DD904018CF7A2A9E869B40B84001551BDD9040457C70749D869B406D42542B1DDD9040F21D50DE9C869B40A44DD80A1FDD9040E6D0CE689C869B408DE54AF120DD904033577A149C869B40843061DC22DD90402B6DB8E19B869B4011BCCAC924DD9040A84EC6D09B869B409E4734B726DD90402B6DB8E19B869B4096924AA228DD904033577A149C869B407E2ABD882ADD9040E6D0CE689C869B40B53541682CDD9040F21D50DE9C869B406A37943E2EDD9040467C70749D869B407FC97E0930DD904018CF7A2A9E869B400C49D7C631DD9040667993FF9E869B404A72847433DD9040E166B9F29F869B40B5E87F1035DD90401642C702A1869B400102000000050000008BAEA05735DD9040366152D7C1869B4086D1073549DD90403284B9B4D5869B408870E59542DD904030E5DB53DC869B408D4D7EB82EDD904035C27476C8869B408BAEA05735DD9040376152D7C1869B40010200000013000000B549A2AF3BDD904016A3E9A1A7869B40EA24B0BF3CDD90408119E53DA9869B406512D6B23DDD9040BF4292EBAA869B40B2BCEE873EDD90404DC2EAA8AC869B40850FF93D3FDD90406154D573AE869B40D96D19D43FDD90401656284AB0869B40E4BA9A4940DD90404D61AC29B2869B409734EF9D40DD904035F91E10B4869B409F1EB1D040DD90402D4435FBB5869B40223DA3E140DD9040BACF9EE8B7869B409F1EB1D040DD9040475B08D6B9869B409734EF9D40DD90403EA61EC1BB869B40E4BA9A4940DD9040273E91A7BD869B40D86D19D43FDD90405E491587BF869B40850FF93D3FDD9040124B685DC1869B40B2BCEE873EDD904027DD5228C3869B406512D6B23DDD9040B55CABE5C4869B40EA24B0BF3CDD9040F2855893C6869B40B449A2AF3BDD90405EFC532FC8869B400102000000050000008870E59542DD904043BA617D93869B4086D1073549DD9040421B841C9A869B408BAEA05735DD90403D3EEBF9AD869B408D4D7EB82EDD90403FDDC85AA7869B408870E59542DD904044BA617D93869B40010200000002000000ABD177D958DD9040D8840A60978B9B4080CF8B9158DD9040C6B61B37938B9B4001020000000200000080CF8B9158DD9040C6B61B37938B9B4067E18C3966DD904061C22D2B8F8B9B400102000000020000005C479C408CDD9040171087B98F8B9B4080CF8B9158DD9040C6B61B37938B9B40010200000002000000ABD177D958DD9040D8840A60978B9B40864988888CDD904029DE75E2938B9B40010200000003000000ABD177D958DD9040D8840A60978B9B40864988888CDD90402BDE75E2938B9B40864988888CDD904029DE75E2938B9B4001020000000200000061DDB3785BDD90402158DF32BE8B9B408ADF9FC05BDD90403326CE5BC28B9B400102000000040000003C55C4278FDD904072B14AB5BA8B9B403C55C4278FDD904071B14AB5BA8B9B4061DDB3785BDD90401F58DF32BE8B9B4061DDB3785BDD90402158DF32BE8B9B4001020000000200000061DDB3785BDD90402158DF32BE8B9B403C55C4278FDD904072B14AB5BA8B9B400102000000020000008ADF9FC05BDD90403326CE5BC28B9B407E2B2CD469DD904080614188C48B9B400102000000020000006657B06F8FDD9040867F39DEBE8B9B408ADF9FC05BDD90403326CE5BC28B9B40010200000002000000316296DA60DD9040C1282F88798B9B40803299D660DD90406A207488798B9B400102000000060000008AA2B5F565DD90405C47AD2D7D8B9B40FFAB46CB64DD90402267B48A7C8B9B4056106E8A63DD904052077DBD7B8B9B40397C8A5862DD9040453594DA7A8B9B402FC1123761DD90409EFB0FE3798B9B40316296DA60DD9040C1282F88798B9B40010200000019000000316296DA60DD9040C1282F88798B9B409791692760DD90402CA51FD8788B9B400ACEDB2A5FDD90404B490ABB778B9B407AED9E425EDD9040103B2D8D768B9B40F981CF6F5DDD9040415DFA4F758B9B400DDC6FB35CDD90401E5DF604748B9B4024CE660E5CDD904017D6B6AD728B9B40C5917E815BDD9040CC60E04B718B9B40BCCF630D5BDD9040AC8F24E16F8B9B4092CCA4B25ADD9040B8DB3F6F6E8B9B4032BAB0715ADD9040D183F7F76C8B9B40AE2FD74A5ADD90406661177D6B8B9B40B5C7473E5ADD9040F4B46F006A8B9B403FE6114C5ADD904028EDD283688B9B40B2A524745ADD9040556B1309678B9B4096EB4EB65ADD9040FD470192658B9B40C0A43F125BDD9040221A6820648B9B40AA2886875BDD90401EC40CB6628B9B407EC392155CDD9040B448AB54618B9B402E66B7BB5CDD904001ABF4FD5F8B9B40B97B28795DDD9040E1DB8CB35E8B9B40A2E2FD4C5EDD904062B708775D8B9B40600934365FDD9040A614EC495C8B9B406D2CAD3360DD9040B0EAA72D5B8B9B4070B4324461DD9040408C98235A8B9B40010200000002000000925BC49680DD904089488163778B9B40316296DA60DD9040C1282F88798B9B40010200000002000000C65E84F57BDD9040B0D31856588B9B406FB4324461DD90403E8C98235A8B9B400102000000020000008AA2B5F565DD90405C47AD2D7D8B9B404D6B43F365DD90403B92D72D7D8B9B4001020000000300000040F2A17367DD9040EEC13CE07D8B9B40CF298B1966DD9040EEDE3E417D8B9B408AA2B5F565DD90405C47AD2D7D8B9B400102000000020000000F3A08057CDD904080AD46B07B8B9B408AA2B5F565DD90405C47AD2D7D8B9B4001020000000200000067E18C3966DD904061C22D2B8F8B9B406F3BC3AE67DD90409E27981D8D8B9B4001020000000200000068FB0F2D7EDD9040C9D4138D8D8B9B4067E18C3966DD904061C22D2B8F8B9B4001020000000200000055CB776A67DD9040C2EDD3B1DA8B9B40A49B7A6667DD90406BE518B2DA8B9B4001020000001900000022C8B70B6CDD90409A623CBFF98B9B40678BE5D96ADD9040D5313CDCF88B9B40C9BA80B869DD9040BBDAA1E4F78B9B4079F1EBA868DD904036C39CD9F68B9B4012F773AC67DD90400E1C74BCF58B9B40D3274EC466DD9040FC4F858EF48B9B408AF996F165DD904087574251F38B9B400A9F503565DD9040A7F32F06F28B9B40C3CB619064DD90406ED1E3AEF08B9B401699940364DD9040EF98024DEF8B9B40B08E958F63DD9040CCE93DE2ED8B9B4022CFF23463DD9040DE475270EC8B9B40B6691BF462DD904088FA04F9EA8B9B405AD25ECD62DD90404CE1217EE98B9B404380ECC062DD904047407901E88B9B40C7B3D3CE62DD90405287DD84E68B9B40A96303F762DD90407616210AE58B9B40FA514A3963DD904072021493E38B9B407248579563DD904013DC8121E28B9B40F17BB90A64DD9040197D2FB7E08B9B40B516E19864DD90404ADDD855DF8B9B4099E81F3F65DD904074F22EFFDD8B9B40863CAAFC65DD9040E49DD5B4DC8B9B4012D297D066DD9040EAA96178DB8B9B4055CB776A67DD9040C2EDD3B1DA8B9B4001020000000600000055CB776A67DD9040C2EDD3B1DA8B9B4011FAE4B967DD9040D4D9564BDA8B9B40CED473B768DD9040CA0E262FD98B9B4051B00DC869DD9040D2832B25D88B9B401B8564EA6ADD90401523AD2ED78B9B40DAEC33FC6BDD9040CB880E65D68B9B40010200000002000000B4C4A52687DD9040890D268DD88B9B4055CB776A67DD9040C2EDD3B1DA8B9B4001020000000200000041F2A17367DD9040EEC13CE07D8B9B4040F2A17367DD9040EEC13CE07D8B9B4001020000000200000026969ED067DD9040AA251341838B9B4040F2A17367DD9040EEC13CE07D8B9B40010200000004000000B82396A27ADD9040738091947C8B9B40B82396A27ADD9040728091947C8B9B4040F2A17367DD9040ECC13CE07D8B9B4040F2A17367DD9040EEC13CE07D8B9B400102000000040000006ABA91747CDD9040C4AC72B68B8B9B405FEEFFCA7BDD904082C7AAE7818B9B40656F310567DD90405A42D04E838B9B406F3BC3AE67DD90409E27981D8D8B9B400102000000020000006ABA91747CDD9040C4AC72B68B8B9B406F3BC3AE67DD90409E27981D8D8B9B400102000000020000007E2B2CD469DD904080614188C48B9B407C6CAA8C6BDD90408889E25EC68B9B400102000000020000007E45AFC781DD9040EC7327EAC28B9B407E2B2CD469DD904080614188C48B9B400102000000030000007C6CAA8C6BDD90408889E25EC68B9B4087383C366CDD9040CB6EAA2DD08B9B40485FA9016DDD90401C52ED1FD08B9B4001020000000200000076EB785280DD9040B00EBDF7C48B9B407C6CAA8C6BDD90408889E25EC68B9B40010200000002000000DAEC33FC6BDD9040CB880E65D68B9B409BB5C1F96BDD9040AAD33865D68B9B40010200000003000000DAEC33FC6BDD9040CB880E65D68B9B406A8F141D6CDD90408AF6D84CD68B9B402F03A65E6DDD9040D8B5C380D58B9B400102000000020000005884860B82DD9040EDEEA7E7D48B9B40DAEC33FC6BDD9040CB880E65D68B9B40010200000002000000777209BD86DD90400DAABCF1F78B9B4021C8B70B6CDD90409C623CBFF98B9B40010200000002000000485FA9016DDD90401B52ED1FD08B9B40485FA9016DDD90401C52ED1FD08B9B40010200000004000000C0909D3080DD9040A01042D4CE8B9B40A6349A8D80DD90405C741835D48B9B403003A65E6DDD9040D8B5C380D58B9B40485FA9016DDD90401C52ED1FD08B9B4001020000000300000076EB785280DD9040B00EBDF7C48B9B4080B70AFC80DD9040F0F384C6CE8B9B40485FA9016DDD90401C52ED1FD08B9B400102000000020000001029921471DD9040DB4114E754A39B400212661471DD90409F75FBE654A39B4001020000001C0000000212661471DD90401D6FECAFF0A49B40B6B22C207BDD9040519B7709EBA49B40327C8FC584DD90404DB169BAE4A49B40F93E85F98DDD90402B73FAC9DDA49B405D9086B196DD9040F6441A40D6A49B4047D699E39EDD90406A176925CEA49B40BEB05E86A6DD9040E8892C83C5A49B4025B41891ADDD9040D04E4563BCA49B40E267B9FBB3DD90407BDE23D0B2A49B40FE7DE9BEB9DD9040B085BCD4A8A49B40423911D4BEDD90404BDD7A7C9EA49B4017F85F35C3DD904067B934D393A49B40AFDBD2DDC6DD9040F89E1CE588A49B40B4833AC9C9DD904062CFB3BE7DA49B40B4833AC9C9DD90405B1534D8C7A39B40AFDBD2DDC6DD9040C545CBB1BCA39B4017F85F35C3DD9040552BB3C3B1A39B40423911D4BEDD904071076D1AA7A39B40FE7DE9BEB9DD90400D5F2BC29CA39B40E267B9FBB3DD90404206C4C692A39B4025B41891ADDD9040EC95A23389A39B40BEB05E86A6DD9040D45ABB1380A39B4047D699E39EDD904052CD7E7177A39B405D9086B196DD9040C79FCD566FA39B40F93E85F98DDD90409271EDCC67A39B40327C8FC584DD904070337EDC60A39B40B6B22C207BDD90406B49708D5AA39B401029921471DD9040DB4114E754A39B400102000000190000000212661471DD90401D6FECAFF0A49B40F027110D7ADD90400B8F7761F0A49B4002F606FB82DD9040F3937676EFA49B404FFC9ED38BDD904061FD01F0EDA49B40A13B4A8C94DD90408AD6EBCFEBA49B40AFCF9F1A9DDD9040038ABD18E9A49B40F05B6974A5DD90409FDAB4CDE5A49B400F3CAF8FADDD90400B05C0F2E1A49B408B69C462B5DD9040C50E798CDDA49B40440852E4BCDD9040064820A0D8A49B40318C620BC4DD904037079633D3A49B40ED6A6CCFCADD904060A5534DCDA49B40594C5C28D1DD9040F4C363F4C6A49B4030AE9E0ED7DD904038E55930C0A49B40FFEE287BDCDD90404B614909B9A49B40BEB58167E1DD904092C2BB87B1A49B4004ACC8CDE5DD90401695A6B4A9A49B409881BDA8E9DD9040F7B46099A1A49B40FC30C6F3ECDD9040B628973F99A49B40837DF4AAEFDD9040A89441B190A49B405AA40ACBF1DD9040565596F887A49B40EC3A7F51F3DD9040094FFE1F7FA49B400436803CF4DD9040F780083276A49B401616F58AF4DD9040096B5D396DA49B401516F58AF4DD9040B4798A5DD8A39B400102000000020000000E29921471DD904041F4D2FCF4A59B400212661471DD90400628BAFCF4A59B4001020000001C0000000212661471DD90408321ABC590A79B40B6B22C207BDD9040B84D361F8BA79B40327C8FC584DD9040B36328D084A79B40F93E85F98DDD90409125B9DF7DA79B405D9086B196DD90405CF7D85576A79B4047D699E39EDD9040D1C9273B6EA79B40BEB05E86A6DD90404E3CEB9865A79B4025B41891ADDD9040360104795CA79B40E267B9FBB3DD9040E190E2E552A79B40FE7DE9BEB9DD904016387BEA48A79B40423911D4BEDD9040B28F39923EA79B4017F85F35C3DD9040CD6BF3E833A79B40AFDBD2DDC6DD90405E51DBFA28A79B40B4833AC9C9DD9040C88172D41DA79B40B4833AC9C9DD9040C1C7F2ED67A69B40AFDBD2DDC6DD90402BF889C75CA69B4017F85F35C3DD9040BCDD71D951A69B40423911D4BEDD9040D7B92B3047A69B40FE7DE9BEB9DD90407311EAD73CA69B40E267B9FBB3DD9040A8B882DC32A69B4025B41891ADDD90405348614929A69B40BEB05E86A6DD90403B0D7A2920A69B4047D699E39EDD9040B87F3D8717A69B405D9086B196DD90402D528C6C0FA69B40F93E85F98DDD9040F823ACE207A69B40327C8FC584DD9040D6E53CF200A69B40B6B22C207BDD9040D2FB2EA3FAA59B400E29921471DD904041F4D2FCF4A59B400102000000190000000212661471DD90408321ABC590A79B40F027110D7ADD90407241367790A79B4002F606FB82DD90405946358C8FA79B404FFC9ED38BDD9040C7AFC0058EA79B40A13B4A8C94DD9040F188AAE58BA79B40AFCF9F1A9DDD90406A3C7C2E89A79B40F05B6974A5DD9040068D73E385A79B400F3CAF8FADDD904072B77E0882A79B408B69C462B5DD90402BC137A27DA79B40440852E4BCDD90406CFADEB578A79B40318C620BC4DD90409DB9544973A79B40ED6A6CCFCADD9040C65712636DA79B40594C5C28D1DD90405A76220A67A79B4030AE9E0ED7DD90409F97184660A79B40FFEE287BDCDD9040B113081F59A79B40BEB58167E1DD9040F8747A9D51A79B4004ACC8CDE5DD90407C4765CA49A79B409881BDA8E9DD90405D671FAF41A79B40FC30C6F3ECDD90401CDB555539A79B40837DF4AAEFDD90400E4700C730A79B405AA40ACBF1DD9040BD07550E28A79B40EC3A7F51F3DD90406F01BD351FA79B400436803CF4DD90405E33C74716A79B401616F58AF4DD90406F1D1C4F0DA79B401516F58AF4DD90401A2C497378A69B400102000000020000001029921471DD90404DA8F1E687A89B400212661471DD904011DCD8E687A89B4001020000001C0000000212661471DD90408FD5C9AF23AA9B40B6B22C207BDD9040C30155091EAA9B40327C8FC584DD9040BE1747BA17AA9B40F93E85F98DDD90409DD9D7C910AA9B405D9086B196DD904068ABF73F09AA9B4047D699E39EDD9040DC7D462501AA9B40BEB05E86A6DD90405AF00983F8A99B4025B41891ADDD904042B52263EFA99B40E267B9FBB3DD9040EC4401D0E5A99B40FE7DE9BEB9DD904022EC99D4DBA99B40423911D4BEDD9040BD43587CD1A99B4017F85F35C3DD9040D91F12D3C6A99B40AFDBD2DDC6DD90406A05FAE4BBA99B40B4833AC9C9DD9040D43591BEB0A99B40B4833AC9C9DD9040CC7B11D8FAA89B40AFDBD2DDC6DD904037ACA8B1EFA89B4017F85F35C3DD9040C79190C3E4A89B40423911D4BEDD9040E36D4A1ADAA89B40FE7DE9BEB9DD90407FC508C2CFA89B40E267B9FBB3DD9040B46CA1C6C5A89B4025B41891ADDD90405EFC7F33BCA89B40BEB05E86A6DD904046C19813B3A89B4047D699E39EDD9040C4335C71AAA89B405D9086B196DD90403906AB56A2A89B40F93E85F98DDD904003D8CACC9AA89B40327C8FC584DD9040E2995BDC93A89B40B6B22C207BDD9040DDAF4D8D8DA89B401029921471DD90404DA8F1E687A89B400102000000180000000212661471DD90408FD5C9AF23AA9B40F027110D7ADD90407DF5546123AA9B4002F606FB82DD904065FA537622AA9B404FFC9ED38BDD9040D363DFEF20AA9B40A13B4A8C94DD9040FC3CC9CF1EAA9B40AFCF9F1A9DDD904075F09A181CAA9B40F05B6974A5DD9040114192CD18AA9B400F3CAF8FADDD90407D6B9DF214AA9B408B69C462B5DD90403675568C10AA9B40440852E4BCDD904077AEFD9F0BAA9B40318C620BC4DD9040A96D733306AA9B40ED6A6CCFCADD9040D20B314D00AA9B40594C5C28D1DD9040662A41F4F9A99B4030AE9E0ED7DD9040AA4B3730F3A99B40FFEE287BDCDD9040BDC72609ECA99B40BEB58167E1DD904004299987E4A99B4004ACC8CDE5DD904088FB83B4DCA99B409881BDA8E9DD9040691B3E99D4A99B40FC30C6F3ECDD9040288F743FCCA99B40837DF4AAEFDD90401AFB1EB1C3A99B405AA40ACBF1DD9040C8BB73F8BAA99B40EC3A7F51F3DD90407AB5DB1FB2A99B400436803CF4DD904069E7E531A9A99B401616F58AF4DD90407AD13A39A0A99B400102000000180000001516F58AF4DD90405CEC4E7378A69B40E7107F3CF4DD9040ADA3A47A6FA69B40A50C7D51F3DD904004B5AF8C66A69B40EA8907CBF1DD90406E9D18B45DA69B40B694F0AAEFDD90403C596EFB54A69B402498C1F3ECDD9040C4C9196D4CA69B404E57B8A8E9DD90409D48511344A69B40E30EC3CDE5DD90402C770CF83BA69B4021C47B67E1DD90400A59F82434A69B40C3C6227BDCDD90407CC76BA32CA69B40746C980ED7DD9040C74B5C7C25A69B40400D5628D1DD9040A06D53B81EA69B40654966CFCADD90409482645F18A69B40BCA15C0BC4DD9040790A237912A69B40C26C4CE4BCDD90407AA4990C0DA69B400B33BF62B5DD90407FA7412008A69B40A37EAA8FADDD90400068FBB903A69B4082296574A5DD90407A3407DFFFA59B40E0379C1A9DDD9040E010FF93FCA59B40A64B478C94DD90408E38D1DCF9A59B40DBBE9CD38BDD90403F6DBBBCF7A59B402C7305FB82DD9040AC184736F6A59B402965100D7ADD90406C45464BF5A59B400E29921471DD904041F4D2FCF4A59B400102000000180000001516F58AF4DD9040F639905DD8A39B40E7107F3CF4DD904047F1E564CFA39B40A50C7D51F3DD90409E02F176C6A39B40EA8907CBF1DD904008EB599EBDA39B40B694F0AAEFDD9040D6A6AFE5B4A39B402498C1F3ECDD90405D175B57ACA39B404E57B8A8E9DD9040379692FDA3A39B40E30EC3CDE5DD9040C6C44DE29BA39B4021C47B67E1DD9040A4A6390F94A39B40C3C6227BDCDD90401615AD8D8CA39B40746C980ED7DD904061999D6685A39B40400D5628D1DD90403ABB94A27EA39B40654966CFCADD90402ED0A54978A39B40BCA15C0BC4DD90401358646372A39B40C26C4CE4BCDD904014F2DAF66CA39B400B33BF62B5DD904019F5820A68A39B40A37EAA8FADDD90409AB53CA463A39B4082296574A5DD9040148248C95FA39B40E0379C1A9DDD90407A5E407E5CA39B40A64B478C94DD9040288612C759A39B40DBBE9CD38BDD9040D9BAFCA657A39B402C7305FB82DD90404666882056A39B402965100D7ADD90400693873555A39B401029921471DD9040DB4114E754A39B400102000000180000001516F58AF4DD904068A06D5D0BA99B40E7107F3CF4DD9040B957C36402A99B40A50C7D51F3DD90401069CE76F9A89B40EA8907CBF1DD90407A51379EF0A89B40B694F0AAEFDD9040470D8DE5E7A89B402498C1F3ECDD9040CF7D3857DFA89B404E57B8A8E9DD9040A8FC6FFDD6A89B40E30EC3CDE5DD9040372B2BE2CEA89B4021C47B67E1DD9040150D170FC7A89B40C3C6227BDCDD9040887B8A8DBFA89B40746C980ED7DD9040D2FF7A66B8A89B40400D5628D1DD9040AC2172A2B1A89B40654966CFCADD9040A0368349ABA89B40BCA15C0BC4DD904085BE4163A5A89B40C26C4CE4BCDD90408658B8F69FA89B400B33BF62B5DD90408B5B600A9BA89B40A37EAA8FADDD90400C1C1AA496A89B4082296574A5DD904086E825C992A89B40E0379C1A9DDD9040ECC41D7E8FA89B40A64B478C94DD90409AECEFC68CA89B40DBBE9CD38BDD90404A21DAA68AA89B402C7305FB82DD9040B8CC652089A89B402965100D7ADD904078F9643588A89B401029921471DD90404DA8F1E687A89B40010200000002000000B82396A27ADD9040738091947C8B9B40B72396A27ADD9040748091947C8B9B400102000000020000009DC792FF7ADD904030E467F5818B9B40B82396A27ADD9040738091947C8B9B400102000000030000000F3A08057CDD904080AD46B07B8B9B407D9727E47BDD9040C23F7CC87B8B9B40B82396A27ADD9040738091947C8B9B40010200000019000000C55E84F57BDD9040B2D31856588B9B40809B56277DDD904077041939598B9B401E6CBB487EDD9040915BB3305A8B9B406E3550587FDD90401673B83B5B8B9B40D52FC85480DD90403E1AE1585C8B9B4014FFED3C81DD904050E6CF865D8B9B405C2DA50F82DD9040C5DE12C45E8B9B40DD87EBCB82DD9040A542250F608B9B40245BDA7083DD9040DE647166618B9B40D18DA7FD83DD90405D9D52C8628B9B403798A67184DD9040804C1733648B9B40C55749CC84DD90406EEE02A5658B9B4031BD200D85DD9040C43B501C678B9B408D54DD3385DD904000553397688B9B40A3A64F4085DD904005F6DB136A8B9B402073683285DD9040FAAE77906B8B9B403EC3380A85DD9040D61F340B6D8B9B40EDD4F1C784DD9040DB3341826E8B9B4074DEE46B84DD9040395AD3F36F8B9B40F5AA82F683DD904033B9255E718B9B4032105B6883DD904002597CBF728B9B404E3E1CC282DD9040D8432616748B9B4060EA910482DD904068987F60758B9B40D554A43081DD9040628CF39C768B9B40925BC49680DD904089488163778B9B40010200000006000000925BC49680DD904089488163778B9B40D52C574780DD9040785CFEC9778B9B401952C8497FDD904082272FE6788B9B4095762E397EDD90407AB229F0798B9B40CCA1D7167DDD90403613A8E67A8B9B400F3A08057CDD904080AD46B07B8B9B400102000000020000004A717A077CDD9040A1621CB07B8B9B400F3A08057CDD904080AD46B07B8B9B4001020000000200000068FB0F2D7EDD9040C9D4138D8D8B9B406ABA91747CDD9040C4AC72B68B8B9B400102000000020000005C479C408CDD9040171087B98F8B9B4068FB0F2D7EDD9040C9D4138D8D8B9B400102000000020000007E45AFC781DD9040EC7327EAC28B9B4076EB785280DD9040B00EBDF7C48B9B40010200000003000000A6349A8D80DD90405D741835D48B9B4018FDB0E781DD90405E5716D4D48B9B405884860B82DD9040EDEEA7E7D48B9B40010200000002000000428BC19A80DD9040E0503C63778B9B40925BC49680DD904089488163778B9B400102000000020000006657B06F8FDD9040867F39DEBE8B9B407E45AFC781DD9040EC7327EAC28B9B400102000000060000005884860B82DD9040EDEEA7E7D48B9B40E87AF53583DD90402ACFA08AD58B9B409116CE7684DD9040F92ED857D68B9B40ADAAB1A885DD90400701C13AD78B9B40B86529CA86DD9040AE3A4532D88B9B40B4C4A52687DD9040890D268DD88B9B4001020000000200000097BBF80D82DD90400EA47DE7D48B9B405884860B82DD9040EDEEA7E7D48B9B40010200000019000000B4C4A52687DD9040890D268DD88B9B405095D2D987DD90402091353DD98B9B40DC5860D688DD904000ED4A5ADA8B9B406D399DBE89DD90403CFB2788DB8B9B40EDA46C918ADD90400AD95AC5DC8B9B40DA4ACC4D8BDD90402DD95E10DE8B9B40C258D5F28BDD904034609E67DF8B9B402295BD7F8CDD904080D574C9E08B9B402B57D8F38CDD9040A0A63034E28B9B40555A974E8DDD9040945A15A6E38B9B40B46C8B8F8DDD90407BB25D1DE58B9B4038F764B68DDD9040E6D43D98E68B9B40325FF4C28DDD90405881E514E88B9B40A8402AB58DDD904024498291E98B9B403581178D8DDD9040F7CA410CEB8B9B40513BED4A8DDD90404FEE5383EC8B9B402782FCEE8CDD90402A1CEDF4ED8B9B403DFEB5798CDD90402E72485FEF8B9B406863A9EB8BDD904098EDA9C0F08B9B40B8C084458BDD90404A8B6017F28B9B402DAB13888ADD90406A5AC861F38B9B4044443EB489DD9040EA7E4C9EF48B9B40861D08CB88DD9040A62169CBF58B9B4079FA8ECD87DD90409C4BADE7F68B9B40777209BD86DD90400CAABCF1F78B9B4001020000000200000066F4A22A87DD9040E015E18CD88B9B40B4C4A52687DD9040890D268DD88B9B40010200000002000000864988888CDD904029DE75E2938B9B405C479C408CDD9040171087B98F8B9B400102000000040000003C55C4278FDD904072B14AB5BA8B9B402A6C81C1A7DD904097D0F60BB98B9B4074604522A5DD90404EFD2139928B9B40864988888CDD904029DE75E2938B9B400102000000020000003C55C4278FDD904072B14AB5BA8B9B406657B06F8FDD9040867F39DEBE8B9B40010200000019000000E972B9D9D8DD9040076BBAC8F59F9B40DB684EDFD9DD904020052538F79F9B402D9BAAFDDADD9040C05A9894F89F9B404C266F33DCDD90405A7369DCF99F9B40FA77207FDDDD9040F19E060EFB9F9B40662028DFDEDD90404262F927FC9F9B4036C4D651E0DD9040AE41E828FD9F9B40142D66D5E1DD90408568980FFE9F9B403C76FB67E3DD9040D32AEFDAFE9F9B406C52A907E5DD9040BF5FF389FF9F9B40536872B2E6DD9040D492CE1B00A09B40B2C24B66E8DD9040CD0ACE8F00A09B402E511F21EADD904092A463E500A09B40B676CEE0EBDD90406781261C01A09B4067A234A3EDDD90406687D33301A09B40B7EF2966EFDD9040BDB34D2C01A09B40BCCA8527F1DD9040363E9E0501A09B40429521E5F2DD9040F18DF4BF00A09B407C49DB9CF4DD90404AFFA55B00A09B401617984CF6DD90403F7B2DD9FF9F9B4072F746F2F7DD9040DCE02A39FF9F9B40DD35E38BF9DD90404E41627CFE9F9B40BEE87617FBDD9040A4EFBAA3FD9F9B4092581D93FCDD904062653EB0FC9F9B403BB3CF81FDDD90407ADEB8FEFB9F9B40010200000002000000E972B9D9D8DD9040086BBAC8F59F9B40E972B9D9D8DD9040076BBAC8F59F9B40010200000002000000E972B9D9D8DD9040076BBAC8F59F9B40305D9A9CDBDD904067B11139D69F9B40010200000019000000E55D39CA00DE904079A5C278D69F9B406EE3FAFDFFDD904034887CA0D59F9B40B9EC60B2FEDD90406405C66ED49F9B406AD06E52FDDD9040F85CB854D39F9B4074CFD3DFFBDD9040872BAD53D29F9B402008565CFADD90407168DF6CD19F9B409249D0C9F8DD9040F3E369A1D09F9B4008CE2F2AF7DD904098EC45F2CF9F9B406ADE717FF5DD9040C01D4A60CF9F9B404E62A1CBF3DD9040A35829ECCE9F9B40325FD410F2DD904027E97196CE9F9B40226A2951F0DD904080D78C5FCE9F9B40E00EC58EEEDD90407C67BD47CE9F9B40BB2FCFCBECDD90401AC6204FCE9F9B405061700AEBDD9040C7E5AD75CE9F9B407145CF4CE9DD9040768935BBCE9F9B406FE80D95E7DD9040857E621FCF9F9B40002447E5E5DD90401F05BAA1CF9F9B40FA0A8C3FE4DD9040A8669C41D09F9B400661E1A5E2DD90406EB945FED09F9B406C213D1AE1DD9040BAD0CED6D19F9B40F417849EDFDD904015582ECAD29F9B40E48E8734DEDD904066183AD7D39F9B40D41403DEDCDD90405D65A8FCD49F9B40325D9A9CDBDD904067B11139D69F9B400102000000020000001516F58AF4DD904025E0675D0BA99B401616F58AF4DD90407AD13A39A0A99B400102000000020000001616F58AF4DD90407AD13A39A0A99B401616F58AF4DD90407BD13A39A0A99B4001020000000200000008106681FDDD9040A94F7003FC9F9B403BB3CF81FDDD90407ADEB8FEFB9F9B400102000000020000003BB3CF81FDDD90407ADEB8FEFB9F9B40E55D39CA00DE904079A5C278D69F9B400102000000060000003BB3CF81FDDD90407ADEB8FEFB9F9B40E05105FDFDDD90402BFD16A3FB9F9B403E5F7353FFDD904035858E7DFA9F9B40BDE8C39400DE904021AB0C41F99F9B4002366DBF01DE9040464315EFF79F9B4065DF91B402DE9040B3FDA1AFF69F9B400102000000060000009510C3FC04DE9040BB2E499ADC9F9B40ACA3D04204DE9040E5BD1E35DB9F9B4036D5605703DE9040D2166DB4D99F9B40ECF2E75102DE90401781EE44D89F9B405A61A63301DE90401A4B65E8D69F9B40E55D39CA00DE904079A5C278D69F9B40010200000002000000E55D39CA00DE904079A5C278D69F9B401801A3CA00DE90404B340B74D69F9B40010200000002000000DC1751B402DE9040606C86B2F69F9B4065DF91B402DE9040B3FDA1AFF69F9B4001020000000200000065DF91B402DE9040B3FDA1AFF69F9B409510C3FC04DE9040BB2E499ADC9F9B4001020000000300000065DF91B402DE9040B3FDA1AFF69F9B40BE5001D202DE9040746D4689F69F9B4020C52FCB03DE904086995611F59F9B400102000000030000006C5734C705DE9040D1E7AA62DE9F9B40C2E0161305DE9040AA142CC5DC9F9B409510C3FC04DE9040BB2E499ADC9F9B400102000000020000009510C3FC04DE9040BB2E499ADC9F9B401ED803FD04DE904012C06497DC9F9B40010200000002000000C35F2A230CDE9040428218F1DE9F9B406C5734C705DE9040D1E7AA62DE9F9B4001020000000300000077CD25270ADE9040F733C49FF59F9B4020C52FCB03DE904087995611F59F9B406C5734C705DE9040D1E7AA62DE9F9B4001020000000200000078CD25270ADE9040F733C49FF59F9B4077CD25270ADE9040F733C49FF59F9B40010200000003000000EE8BD4AA15DE904039A40694F79F9B4004A31A120ADE904041CA4B90F69F9B4077CD25270ADE9040F733C49FF59F9B4001020000000200000077CD25270ADE9040F733C49FF59F9B40C35F2A230CDE9040428218F1DE9F9B40010200000002000000C45F2A230CDE9040428218F1DE9F9B40C35F2A230CDE9040428218F1DE9F9B40010200000003000000C35F2A230CDE9040428218F1DE9F9B40368A35380CDE9040F9EB9000DE9F9B402073EFD017DE9040F2C54B04DF9F9B40010200000002000000D354B3CD17DE904009C19CA8F99F9B40EE8BD4AA15DE904039A40694F79F9B40010200000002000000EE8BD4AA15DE904039A40694F79F9B402073EFD017DE9040F2C54B04DF9F9B400102000000020000009226E60B1ADE9040C74A33600AA09B40D354B3CD17DE904009C19CA8F99F9B40010200000002000000D354B3CD17DE904009C19CA8F99F9B40D2E5FA471ADE90409E89C356DD9F9B40010200000002000000D2E5FA471ADE90409E89C356DD9F9B402073EFD017DE9040F2C54B04DF9F9B40010200000002000000A11111F71EDE904040FE5CCE0AA09B409226E60B1ADE9040C74A33600AA09B400102000000020000009226E60B1ADE9040C74A33600AA09B40B80E99641FDE9040FA9EE643CD9F9B40010200000002000000B80E99641FDE9040FA9EE643CD9F9B40D2E5FA471ADE90409E89C356DD9F9B40010200000004000000A11111F71EDE904040FE5CCE0AA09B40F077976B1CDE90402BB0C1E427A09B40B7B82E534ADE9040D237E3E82BA09B406852A8DE4CDE9040E8857ED20EA09B40010200000002000000C6F9C34F24DE9040735210B2CD9F9B40A11111F71EDE904040FE5CCE0AA09B40010200000003000000A11111F71EDE904040FE5CCE0AA09B40C7F9C34F24DE9040735210B2CD9F9B40C6F9C34F24DE9040735210B2CD9F9B40010200000002000000C6F9C34F24DE9040735210B2CD9F9B40B80E99641FDE9040FA9EE643CD9F9B4001020000000300000064B1A400A0DE90409D7C489C589C9B409E700D1972DE9040F4F42698549C9B40C6F9C34F24DE9040735210B2CD9F9B400102000000020000001BA18A1627DF90400D20B9D962869B40074167F648DE90400D20B9D962869B400102000000020000006852A8DE4CDE9040E8857ED20EA09B40753DD3C951DE90406139A8400FA09B400102000000040000006852A8DE4CDE9040E8857ED20EA09B406652A8DE4CDE9040E8857ED20EA09B408C3A5B3752DE90401BDA31B6D19F9B408D3A5B3752DE90401BDA31B6D19F9B400102000000020000008D3A5B3752DE90401BDA31B6D19F9B406852A8DE4CDE9040E8857ED20EA09B40010200000002000000753DD3C951DE90406139A8400FA09B409B25862257DE9040948D5B24D29F9B40010200000002000000753DD3C951DE90406139A8400FA09B405B6671E656DE9040BC4ECB2DFF9F9B400102000000020000008D3A5B3752DE90401BDA31B6D19F9B409B25862257DE9040948D5B24D29F9B4001020000000200000064B1A400A0DE90409D7C489C589C9B408D3A5B3752DE90401BDA31B6D19F9B400102000000020000005B6671E656DE9040BC4ECB2DFF9F9B4059F7B86059DE90405117F2DBE29F9B400102000000020000005B6671E656DE9040BC4ECB2DFF9F9B400CD97C5D59DE904068124380FD9F9B400102000000020000009B25862257DE9040948D5B24D29F9B4059F7B86059DE90405117F2DBE29F9B400102000000030000000CD97C5D59DE904068124380FD9F9B40F6C136F664DE904062ECFD83FE9F9B4069EC410B65DE904019567693FD9F9B400102000000020000000CD97C5D59DE904068124380FD9F9B403FC097835BDE9040223488F0E49F9B4001020000000200000059F7B86059DE90405117F2DBE29F9B403FC097835BDE9040223488F0E49F9B400102000000030000003FC097835BDE9040223488F0E49F9B4029A9511C67DE90401B0E43F4E59F9B40B67E460767DE904064A4CAE4E69F9B4001020000000200000068EC410B65DE904019567693FD9F9B4069EC410B65DE904019567693FD9F9B4001020000000300000069EC410B65DE904019567693FD9F9B40C1F437676BDE90408AF0E321FE9F9B40C1F437676BDE904089F0E321FE9F9B4001020000000200000069EC410B65DE904019567693FD9F9B40B67E460767DE904064A4CAE4E69F9B40010200000003000000B67E460767DE904064A4CAE4E69F9B400D873C636DDE9040D53E3873E79F9B40C1F437676BDE904089F0E321FE9F9B40010200000003000000C1F437676BDE904089F0E321FE9F9B406C6B551B6CDE9040B0C362BFFF9F9B40973BA9316CDE90409CA945EAFF9F9B400102000000020000000E7468316CDE904049182AEDFF9F9B40973BA9316CDE90409CA945EAFF9F9B40010200000006000000973BA9316CDE90409CA945EAFF9F9B4082A89BEB6CDE9040751A704F01A09B40F7760BD76DDE904089C121D002A09B40405984DC6EDE90404357A03F04A09B40D4EAC5FA6FDE9040418D299C05A09B4047EE326470DE9040E032CC0B06A09B40010200000002000000973BA9316CDE90409CA945EAFF9F9B40C96CDA796EDE9040A5DAECD4E59F9B40010200000003000000C96CDA796EDE9040A5DAECD4E59F9B406EFB6A5C6EDE9040E66A48FBE59F9B400E873C636DDE9040D43E3873E79F9B40010200000002000000C96CDA796EDE9040A5DAECD4E59F9B4052341B7A6EDE9040FB6B08D2E59F9B40010200000006000000F2989CAC73DE9040E1F9D585E09F9B404EFA663173DE90402FDB77E1E09F9B40EEECF8DA71DE904025530007E29F9B407063A89970DE9040392D8243E39F9B402C16FF6E6FDE904015957995E49F9B40C96CDA796EDE9040A5DAECD4E59F9B40010200000002000000144BC96370DE904010A4831006A09B4047EE326470DE9040E032CC0B06A09B4001020000001900000047EE326470DE9040E032CC0B06A09B40BE68713071DE9040275012E406A09B40745F0B7C72DE9040F6D2C81508A09B40C47BFDDB73DE9040627BD62F09A09B40B97C984E75DE9040D3ACE1300AA09B400E4416D276DE9040E96FAF170BA09B409A029C6478DE904067F424E30BA09B40267E3C047ADE9040C2EB48920CA09B40C26DFAAE7BDE90409ABA44240DA09B40DEE9CA627DDE9040B77F65980DA09B40FAEC971D7FDE904033EF1CEE0DA09B400AE242DD80DE9040DA0002250EA09B404C3DA79F82DE9040DE70D13C0EA09B40721C9D6284DE904040126E350EA09B40DDEAFB2386DE904094F2E00E0EA09B40BC069DE187DE9040E44E59C90DA09B40BE635E9989DE9040D5592C650DA09B402D2825498BDE90403BD3D4E20CA09B403341E0EE8CDE9040B271F2420CA09B4026EB8A888EDE9040EC1E49860BA09B40C12A2F1490DE9040A007C0AD0AA09B403834E88F91DE9040458060BA09A09B404ABDE4F992DE9040F4BF54AD08A09B405A37695094DE9040FD72E68707A09B40FCEED19195DE9040F3267D4B06A09B4001020000000200000047EE326470DE9040E032CC0B06A09B40F2989CAC73DE9040E1F9D585E09F9B40010200000002000000F2989CAC73DE9040E1F9D585E09F9B40253C06AD73DE9040B2881E81E09F9B4001020000001900000044D9B25498DE9040536DD4BBE69F9B4052E31D4F97DE90403AD3694CE59F9B4000B1C13096DE90409B7DF6EFE39F9B40E125FDFA94DE9040006525A8E29F9B4034D44BAF93DE90406A398876E19F9B40C72B444F92DE90401876955CE09F9B40F78795DC90DE9040AD96A65BDF9F9B401A1F06598FDE9040D66FF674DE9F9B40F0D570C68DDE904087AD9FA9DD9F9B40C0F9C2268CDE90409B789BFADC9F9B40DAE3F97B8ADE90408645C068DC9F9B407B8920C888DE90408ECDC0F4DB9F9B40FFFA4C0D87DE9040C8332B9FDB9F9B4076D59D4D85DE9040F3566868DB9F9B40C6A9378B83DE9040F450BB50DB9F9B40765C42C881DE90409E244158DB9F9B407181E60680DE9040249AF07EDB9F9B40ECB64A497EDE9040694A9AC4DB9F9B40B10291917CDE904011D9E828DC9F9B401635D4E17ADE90401B5D61ABDC9F9B40BC54253C79DE90407EF7634BDD9F9B40501689A277DE90400D972C08DE9F9B406F63F51676DE9040B6E8D3E0DE9F9B409BF34E9B74DE9040F97250D4DF9F9B40F2989CAC73DE9040E1F9D585E09F9B40010200000002000000FCEED19195DE9040F4267D4B06A09B4044D9B25498DE9040546DD4BBE69F9B400102000000020000008D0D34C395DE904010BA5273FC9B9B408E0D34C395DE904010BA5273FC9B9B400102000000020000008E0D34C395DE904010BA5273FC9B9B4012F9857BB4DE904010BA5273FC9B9B4001020000000400000064B1A400A0DE90409D7C489C589C9B4064B1A400A0DE9040559BCD872A9C9B408E0D34C395DE9040559BCD872A9C9B408E0D34C395DE904010BA5273FC9B9B400102000000040000008E0D34C395DE904010BA5273FC9B9B408E0D34C395DE90400EBA5273FC9B9B4012F9857BB4DE90400EBA5273FC9B9B4012F9857BB4DE904010BA5273FC9B9B4001020000000200000012F9857BB4DE90409D7C489C589C9B4064B1A400A0DE90409D7C489C589C9B4001020000000500000012F9857BB4DE904010BA5273FC9B9B4032769C0B69E8904010BA5273FC9B9B4032769C0B69E89040A953EC0C969C9B405322E20AF7E29040A953EC0C969C9B405322E20AF7E29040CCED013692A29B4001020000000200000012F9857BB4DE904010BA5273FC9B9B4012F9857BB4DE90409D7C489C589C9B400102000000020000003438B0FFC6DE9040222529D2F28C9B40DCBFD103CBDE9040E865C0B9208D9B40010200000003000000DCBFD103CBDE9040E865C0B9208D9B40DBBFD103CBDE9040E865C0B9208D9B403438B0FFC6DE9040222529D2F28C9B400102000000040000003438B0FFC6DE9040222529D2F28C9B4029C6524801E290404F9BCD87AA8C9B40D14D744C05E2904016DC646FD88C9B40DCBFD103CBDE9040E865C0B9208D9B4001020000001600000029C6524801E29040587271F8E78F9B405DCC1AEDC8E190406F4EBF0DE68F9B400C1491D490E19040D279ED4FE08F9B4031F9144159E19040F20AC7C5D68F9B40266A687422E19040DA8D957AC98F9B40C31962AFECE090404CA9137EB88F9B40D3C7A031B8E090406F825AE4A38F9B40A1FA3F3985E0904010F5C9C58B8F9B40AC828E0254E09040ACBCEB3E708F9B40801FC7C724E0904049B05170518F9B40109ACBC0F7DF904026396F7E2F8F9B4022A6E222CDDF9040DA316E910A8F9B4009D97820A5DF9040D260FFD4E28E9B403A00E5E87FDF90408AC62678B88E9B405B1E30A85DDF904091FC03AD8B8E9B401051E1863EDF90403AE796A85C8E9B402ADDCDA922DF9040180081A22B8E9B40F499ED310ADF90408083C3D4F88D9B4034EF333CF5DE9040F8CE7A7BC48D9B4003946DE1E3DE9040BD4197D48E8D9B4003372336D6DE904080F3931F588D9B40A932814ACCDE90402C982B9D208D9B40010200000004000000A536EBA7E3DE904063A0845BEB8C9B401EEA1416E4DE9040708BAF46F08C9B40EB95613221DF90404CA3FCEDEA8C9B4072E237C420DF90403EB8D102E68C9B40010200000002000000A536EBA7E3DE904063A0845BEB8C9B404A21C8BAF3DE90407E77E63EE68C9B40010200000002000000A536EBA7E3DE904063A0845BEB8C9B4072E237C420DF90403EB8D102E68C9B400102000000020000003F256088E8DE904046B77119238D9B40FDAEF63FF9DE90400589A457258D9B400102000000040000003F256088E8DE904046B77119238D9B40C671361AE8DE904038CC462E1E8D9B40941D833625DF904013E493D5188D9B400DD1ACA425DF904022CFBEC01D8D9B400102000000020000003F256088E8DE904046B77119238D9B400DD1ACA425DF904022CFBEC01D8D9B4001020000001A0000001249169DECDE9040DCEE8593A78C9B40B302BF2C0CDF90409404A5D0A48C9B40CB9C299C0DDF904086FA39D6A58C9B406BF29CF80EDF9040D82C96F4A68C9B40060B6E4010DF9040F7B75A2AA88C9B409C360B7211DF9040A4090C76A98C9B40EEF9FD8B12DF904011B213D6AA8C9B4059D9EC8C13DF9040E155C248AC8C9B4030009D7314DF9040BEBE51CCAD8C9B407FC2F33E15DF9040E807E75EAF8C9B406BF7F7ED15DF904018E494FEB08C9B40802AD37F16DF9040FEF95DA9B28C9B4078A2D2F316DF90405D54375DB48C9B403E3C684917DF9040D9E20A18B68C9B4013192B8017DF90406208BAD7B78C9B40121FD89717DF90401234209AB98C9B40684B529017DF90406281155DBB8C9B40E2D5A26917DF9040675C711EBD8C9B409D25F92317DF9040EC260DDCBE8C9B40F596AABF16DF904027DBC693C08C9B40EB12323D16DF9040C2A88343C28C9B4088782F9D15DF90401C8932E9C38C9B40F9D866E014DF904088C7CE82C58C9B405087BF0714DF9040697A620EC78C9B400DFD421413DF90403DEA088AC88C9B402476BD6212DF9040E744BB78C98C9B40010200000019000000263DC7DCECDE904091EF24C1CC8C9B40DF1F8104ECDE90401A75E6F4CB8C9B40109DCAD2EADE9040647E4CA9CA8C9B40A4F4BCB8E9DE904014625A49C98C9B4032C3B1B7E8DE90401F61BFD6C78C9B401D00E4D0E7DE9040CA994153C68C9B409F7B6E05E7DE90403EDBBBC0C48C9B4044844A56E6DE9040B25F1B21C38C9B406BB54EC4E5DE904016705D76C18C9B404FF02D50E5DE9040FAF38CC2BF8C9B40D38076FAE4DE9040DEF0BF07BE8C9B402C6F91C3E4DE9040CEFB1448BC8C9B4028FFC1ABE4DE90408CA0B085BA8C9B40C65D25B3E4DE904066C1BAC2B88C9B40727DB2D9E4DE9040FBF25B01B78C9B4021213A1FE5DE90401CD7BA43B58C9B4030166783E5DE90401A7AF98BB38C9B40CB9CBE05E6DE9040ABB532DCB18C9B4054FEA0A5E6DE9040A59C7736B08C9B401A514A62E7DE9040B2F2CC9CAE8C9B406668D33AE8DE904017B32811AD8C9B40C1EF322EE9DE9040A0A96F95AB8C9B4012B03E3BEADE90408E20732BAA8C9B4008FDAC60EBDE90407EA6EED4A88C9B401349169DECDE9040DCEE8593A78C9B40010200000002000000F6CB0FD8ECDE9040C4928EC1CC8C9B40263DC7DCECDE904091EF24C1CC8C9B400102000000060000006EC64DFEF2DE904043A2AEF3D08C9B4091552399F1DE90405635BC39D08C9B407DAE7118F0DE9040E1664C4ECF8C9B40C318F3A8EEDE90409884D348CE8C9B40C5E2694CEDDE904004F3912ACD8C9B40263DC7DCECDE904091EF24C1CC8C9B40010200000002000000263DC7DCECDE904091EF24C1CC8C9B402476BD6212DF9040E744BB78C98C9B40010200000002000000BD5769FBF2DE9040CC69EFF3D08C9B406EC64DFEF2DE904043A2AEF3D08C9B400102000000030000007C7FAFC6F4DE904017E91FBED18C9B4056AC3029F3DE90406C72020AD18C9B406EC64DFEF2DE904043A2AEF3D08C9B400102000000020000006EC64DFEF2DE904043A2AEF3D08C9B406195A6130DDF90400F717DABCE8C9B400102000000020000004A21C8BAF3DE90407E77E63EE68C9B409E5D5068F5DE9040CC04DBC7E38C9B400102000000020000004A21C8BAF3DE90407E77E63EE68C9B40B458A10C10DF90407FE69EC4E38C9B40010200000004000000EE191D55F5DE904070F1151AD88C9B407C7FAFC6F4DE904018E91FBED18C9B4031315B750BDF9040CC561BC2CF8C9B40A2CBC8030CDF9040235F111ED68C9B400102000000040000009E5D5068F5DE9040CC04DBC7E38C9B40A4839564F4DE9040E41B212FD88C9B40EB6150F40CDF9040B0340609D68C9B40E43B0BF80DDF90409A1DC0A1E18C9B400102000000020000009E5D5068F5DE9040CC04DBC7E38C9B40E43B0BF80DDF90409A1DC0A1E18C9B400102000000020000005D2023E5F6DE9040D0CDF1A33F8D9B408C91DAE9F6DE90409D2A88A33F8D9B40010200000019000000FF04D91FFDDE9040EF6A9E4B648D9B40E66A6EB0FBDE9040FD740946638D9B404615FB53FADE9040AB42AD27628D9B40ABFC290CF9DE90408CB7E8F1608D9B4015D18CDAF7DE9040DE6537A65F8D9B40C40D9AC0F6DE904072BD2F465E8D9B40582EABBFF5DE9040A21981D35C8D9B408107FBD8F4DE9040C4B0F14F5B8D9B403245A40DF4DE90409C675CBD598D9B404710A05EF3DE90406C8BAE1D588D9B4032DDC4CCF2DE90408575E572568D9B403965C558F2DE9040261B0CBF548D9B4073CB2F03F2DE9040AA8C3804538D9B409FEE6CCCF1DE904022678944518D9B40A0E8BFB4F1DE9040713B23824F8D9B4049BC45BCF1DE904021EE2DBF4D8D9B40D031F5E2F1DE90401C13D2FD4B8D9B4015E29E28F2DE9040964836404A8D9B40BC70ED8CF2DE90405C947C88488D9B40C7F4650FF3DE9040C2C6BFD8468D9B402A8F68AFF3DE904066E61033458D9B40B82E316CF4DE9040FBA77499438D9B406280D844F5DE90401AF5E00D428D9B40A40A5538F6DE904046853A92408D9B408C91DAE9F6DE90409D2A88A33F8D9B400102000000060000008C91DAE9F6DE90409D2A88A33F8D9B40DB727C45F7DE9040F88B52283F8D9B40D1EA046BF8DE90409A7EE4D13D8D9B40E5C486A7F9DE90401BF593903C8D9B40C02C7EF9FADE9040D6A7EA653B8D9B405372F138FCDE904073FEC5703A8D9B400102000000020000008C91DAE9F6DE90409D2A88A33F8D9B408DCAD06F1CDF9040F37F1E5B3C8D9B40010200000002000000FDAEF63FF9DE90400589A457258D9B40CDCB8C54FBDE9040EA51837A278D9B40010200000002000000FDAEF63FF9DE90400589A457258D9B4068E6CF9115DF904006F85CDD228D9B40010200000003000000CDCB8C54FBDE9040EA51837A278D9B40C6A54758FCDE9040D43A3D13338D9B400F3CCF48FDDE9040611032FE328D9B40010200000002000000CDCB8C54FBDE9040EA51837A278D9B4014AA47E413DF9040B86A6854258D9B40010200000002000000A6030D36FCDE9040FCC506713A8D9B405372F138FCDE904073FEC5703A8D9B400102000000030000005372F138FCDE904073FEC5703A8D9B4092024D5FFCDE90401A8D56533A8D9B4080D63CD7FDDE9040B818285A398D9B400102000000020000005372F138FCDE904073FEC5703A8D9B404B414A4E16DF904043CD9428388D9B40010200000002000000FE04D91FFDDE9040F06A9E4B648D9B409FBE81AF1CDF9040A880BD88618D9B400102000000020000000F3CCF48FDDE9040601032FE328D9B400F3CCF48FDDE9040611032FE328D9B400102000000030000000F3CCF48FDDE9040611032FE328D9B407FD63CD7FDDE9040B818285A398D9B403588E88514DF90406C86235E378D9B400102000000030000000F3CCF48FDDE9040611032FE328D9B400D8402E814DF9040A25322ED308D9B4014AA47E413DF9040B86A6854258D9B400102000000030000006195A6130DDF90400F717DABCE8C9B4020054BED0CDF90406AE2ECC8CE8C9B4032315B750BDF9040CA561BC2CF8C9B400102000000060000002476BD6212DF9040E744BB78C98C9B40D7941B0712DF90408AE3F0F3C98C9B40E01C93E110DF9040EAF05E4ACB8C9B40CC4211A50FDF9040687AAF8BCC8C9B40F1DA19530EDF9040ACC758B6CD8C9B406195A6130DDF90400F717DABCE8C9B400102000000020000006195A6130DDF90400F717DABCE8C9B400B048B160DDF904086A93CABCE8C9B40010200000002000000B458A10C10DF90407FE69EC4E38C9B40E43B0BF80DDF90409A1DC0A1E18C9B4001020000000200000072E237C420DF90403EB8D102E68C9B40B458A10C10DF90407FE69EC4E38C9B400102000000020000002476BD6212DF9040E744BB78C98C9B4054E7746712DF9040B4A15178C98C9B4001020000000200000068E6CF9115DF904006F85CDD228D9B4014AA47E413DF9040B86A6854258D9B40010200000002000000C4ED7AF713DF9040157E2D02318D9B403588E88514DF90406C86235E378D9B400102000000030000003588E88514DF90406C86235E378D9B405C5B672316DF904016FD4012388D9B404B414A4E16DF904043CD9428388D9B400102000000020000000DD1ACA425DF904022CFBEC01D8D9B4068E6CF9115DF904006F85CDD228D9B400102000000060000004B414A4E16DF904043CD9428388D9B4021B274B317DF90402C3A87E2388D9B403459263419DF9040A208F7CD398D9B40EFEEA4A31ADF9040ECEA6FD33A8D9B40EC242E001CDF90407E7CB1F13B8D9B408DCAD06F1CDF9040F37F1E5B3C8D9B400102000000020000004B414A4E16DF904043CD9428388D9B40F4AF2E5116DF9040BA055428388D9B400102000000190000008DCAD06F1CDF9040F37F1E5B3C8D9B40D2E716481DDF90406AFA5C273D8D9B40A26ACD791EDF90401FF1F6723E8D9B400E13DB931FDF90406E0DE9D23F8D9B407F44E69420DF9040640E8445418D9B409507B47B21DF9040B8D501C9428D9B40138C294722DF90404694875B448D9B406E834DF622DF9040D00F28FB458D9B404652498823DF90406EFFE5A5478D9B4063176AFC23DF90408A7BB659498D9B40DF86215224DF9040A67E83144B8D9B408698068924DF9040B6732ED44C8D9B408A08D6A024DF9040F8CE92964E8D9B40ECA9729924DF90401DAE8859508D9B403F8AE57224DF9040887CE71A528D9B4090E65D2D24DF9040679888D8538D9B4081F130C923DF904069F54990558D9B40E66AD94623DF9040D8B91040578D9B405E09F7A622DF9040DED2CBE5588D9B4098B64DEA21DF9040D27C767F5A8D9B404C9FC41121DF90406CBC1A0B5C8D9B40F117651E20DF9040E4C5D3865D8D9B40A05759111FDF9040F44ED0F05E8D9B40A90AEBEB1DDF904004C95447608D9B409FBE81AF1CDF9040A680BD88618D9B400102000000020000008DCAD06F1CDF9040F37F1E5B3C8D9B40BB3B88741CDF9040C0DCB45A3C8D9B40010200000002000000D8E625821FDF904050A98D342A879B408DA12D881FDF9040B6945B352A879B400102000000070000008DA12D881FDF9040B6945B352A879B40ECA7D6176ADF9040F6977A2734879B4056CCA925B5DF9040983D5A8439879B40FDE27F6300E090406E5805463A879B40A4F955A14BE090409A3D5A8439879B400E1E29AF96E09040FA977A2734879B405524D23EE1E09040BF945B352A879B4001020000000D0000008DA12D881FDF9040B6945B352A879B407E0BDE2C20DF90407A6CD9152B879B403DE18D8121DF9040D7D6B1AA2C879B40730E70F022DF90400EF3F5272E879B40ABD4E37724DF904058ACF48B2F879B40128D2C1626DF904088A219D530879B408AA173C927DF90405EF5EE0132879B4074B250782ADF90409692589E33879B40C70A313F2DDF9040002ED50F35879B40D9C0661B30DF9040A044005536879B406D552F0A33DF90409A16A06C37879B40605DB60836DF9040E6D5A65538879B40A8ED127C72DF90405948B2E13B879B400102000000230000001BA18A1627DF90400D20B9D962869B407E58DA2926DF90400E05CFE162869B401F92443E25DF9040770D07FA62869B40427FE25424DF9040FA50442263869B403CB0CA6E23DF90401CC8565A63869B400DC80F8D22DF90408485FBA163869B409934BFB021DF9040DC05DDF863869B400CEDDFDA20DF9040E895935E64869B40FC37710C20DF90404ACEA5D264869B40B97A69461FDF90406624895465869B403313B5891EDF9040C68FA2E365869B40D93D35D71DDF90402043477F66869B40C508BF2F1DDF90403478BD2667869B406C551A941CDF90408E4D3DD967869B400CEA00051CDF904014B5F19568869B40F0931D831BDF90405872F95B69869B408E5B0B0F1BDF90406827682A6A869B4082CB54A91ADF9040F56E47006B869B402A4B73521ADF90406A0298DC6B869B40C48DCE0A1ADF904098EA52BE6C869B40A216BCD219DF90409EB96AA46D869B401FD37EAA19DF90407BCCCC8D6E869B40B6CA469219DF9040DA9262796F869B40B5E5308A19DF904094DB126670869B40B3E5308A19DF9040492D97E817879B40C153D09B19DF904030966AF919879B4062999AD019DF90403F4DE5071C879B40B0BF53281ADF9040F64AB1111E879B40882198A21ADF904076D97D1420879B40BADCDC3E1BDF9040C435020E22879B40C96F70FC1BDF9040072800FC23879B4091837BDA1CDF9040C68F46DC25879B40DDDF01D81DDF90404FE1B3AC27879B40E989E3F31EDF90406491386B29879B408DA12D881FDF9040B6945B352A879B40010200000002000000AAF1C7695DDF90400D20B9D962869B401BA18A1627DF90400D20B9D962869B40010200000003000000AAF1C7695DDF90400D20B9D962869B4038A18A1627DF90400C20B9D962869B401BA18A1627DF90400D20B9D962869B4001020000003A000000E8B13B9251DF90407F008B37D7879B40079477514FDF9040C86B3A3EE6879B40C03C88754CDF90403A705198F5879B402575B29449DF9040C600A46D0A889B401329811C48DF9040288F76681F889B406521A90E48DF90407A396D7034889B4012F00FA849DF9040B25541384E889B40E7E191D74CDF9040BE1C4ADA67889B4026B6149A51DF9040D08C903D81889B4062057FF654DF9040FC28CF7A8E889B4088B0D12C59DF9040AC3D25799B889B40945983385EDF90406C49942AA8889B40DAD4241464DF9040F49D7081B4889B40DA24F3EC6CDF9040403A4E7CC4889B406B1C99B676DF90405FA53FE8D3889B408DC0196881DF904052681BB7E2889B40D42BA3F78CDF9040044D48DBF0889B40F292975A99DF904020DBC947FE889B401504553EA0DF9040D6CB14DE04899B4015C5628CA7DF90405485A5FD0A899B4048C2C63CAFDF90404744CC9F10899B400D861B47B7DF9040B43862BE15899B40F86399A2BFDF9040A63DD0531A899B40450F2046C8DF904000F4145B1E899B400A924028D1DF9040B239CACF21899B40569A473FDADF904078F729AE24899B40F1114881E3DF9040CA3F12F326899B4032F525E4ECDF904098BA089C28899B40175DA15DF6DF9040F3593DA729899B4087B061E3FFDF9040CE548C132A899B40F603226909E09040F4593DA729899B40DB6B9DE212E0904099BA089C28899B401D4F7B451CE09040CC3F12F326899B40B7C67B8725E0904078F729AE24899B4003CF829E2EE09040B439CACF21899B40C851A38037E0904002F4145B1E899B4016FD292440E09040A83DD0531A899B4001DBA77F48E09040B63862BE15899B40C69EFC8950E090404A44CC9F10899B40FA9B603A58E090405785A5FD0A899B40FA5C6E885FE09040D8CB14DE04899B401DCE2B6C66E0904022DBC947FE889B403B3520CF72E09040074D48DBF0889B4082A0A95E7EE0904056681BB7E2889B40A5442A1089E0904062A53FE8D3889B40363CD0D992E09040443A4E7CC4889B40378C9EB29BE09040F89D7081B4889B408807408EA1E090407249942AA8889B409EB0F199A6E09040B43D25799B889B40CF5B44D0AAE090400229CF7A8E889B4016ABAE2CAEE09040D68C903D81889B403A7F31EFB2E09040C21C4ADA67889B40F470B31EB6E09040B65541384E889B40873F1AB8B7E0904080396D7034889B40E83742AAB7E090402E8F76681F889B40E4EB1032B6E09040CC00A46D0A889B4057243B51B3E090403E705198F5879B4034F6A514AEE09040AEFFBEE5D6879B40010200000041000000E8B13B9251DF90407F008B37D7879B4048562CB74EDF9040B5212D8BDE879B407E09FEDC4ADF9040D73B68AEEA879B40AB9997CC47DF904022139B0AF7879B4076AB378945DF904078EAAE9203889B40C1C6431544DF9040808D5E3910889B40FBCC457243DF9040225E44F11C889B4024D428A343DF904079A90E9C36889B40BAC7422045DF904080F1F73B50889B4076029AE847DF9040760D37C069889B4062F5FA504ADF9040798A466578889B40793CE8914DDF90407E4B3EE086889B40B6FF92A851DF9040B4139F2495889B400EF0739156DF90402AC31826A3889B4005534E485CDF904033F794D8B0889B402207439663DF904012224EBEBF889B40973569D16BDF904090274726CE889B40A5DE55F174DF90403A4FC401DC889B401E0AB4EC7EDF9040248D9942E9889B409F524EB989DF9040660039DBF5889B404E56194C95DF9040B6CFC0BE01899B4070023F99A1DF9040355608E10C899B40DB621EE5A8DF904087D05AAF12899B403698E88BB0DF904074FAA00318899B40D455A785B8DF90402A2D4FD81C899B407CFC0DCAC0DF9040B1875E2821899B40433D8250C9DF9040022A52EF24899B40440D2510D2DF90408AE03B2928899B40D9E0DBFFDADF90403C3BC0D22A899B40BE245A16E4DF9040DA0B1AE92C899B4048EB2A4AEDDF9040F2471D6A2E899B4097C3BA91F6DF90407E4B39542F899B4087B061E3FFDF9040C2797AA62F899B40779D083509E090407E4B39542F899B40C575987C12E09040F3471D6A2E899B40503C69B01BE09040DA0B1AE92C899B403580E7C624E090403D3BC0D22A899B40CA539EB62DE090408CE03B2928899B40CB23417636E09040032A52EF24899B409264B5FC3EE09040B3875E2821899B403A0B1C4147E090402C2D4FD81C899B40D8C8DA3A4FE0904076FAA00318899B4034FEA4E156E090408AD05AAF12899B409F5E842D5EE09040385608E10C899B40C10AAA7A6AE09040BACFC0BE01899B40700E750D76E090406A0039DBF5889B40F2560FDA80E09040298D9942E9889B406B826DD58AE090403E4FC401DC889B40792B5AF593E0904096274726CE889B40EF5980309CE0904018224EBEBF889B400C0E757EA3E0904038F794D8B0889B4004714F35A9E0904030C31826A3889B405C61301EAEE09040B9139F2495889B409924DB34B2E09040834B3EE086889B40B16BC875B5E090407E8A466578889B409D5E29DEB7E090407C0D37C069889B405A9980A6BAE0904085F1F73B50889B40F18C9A23BCE090407EA90E9C36889B401B947D54BCE09040285E44F11C889B40539A7FB1BBE09040778D5E3910889B409AB58B3DBAE0904062EAAE9203889B405FC72BFAB7E09040FE129B0AF7879B408457C5E9B4E09040A43B68AEEA879B40B20A970FB1E0904076212D8BDE879B4034F6A514AEE09040AEFFBEE5D6879B40010200000002000000E8B13B9251DF90407F008B37D7879B4058AB3EA251DF90409A4AC1CCD6879B40010200000005000000B31ADD115DDF9040B857691ABF879B405A69794C59DF90400E9DEFFEC5879B406D2E083556DF90402219DA48CC879B403A2E0E5753DF90405C2EC4ADD2879B40E8B13B9251DF90407F008B37D7879B40010200000002000000A8ED127C72DF90405948B2E13B879B40B31ADD115DDF9040B857691ABF879B4001020000000E0000000EBE682CAADF904060AEA07C80879B40C603F4A3A3DF904069E5847482879B40496A033D9DDF904099F394D084879B40FD4F95FD96DF90408D539B8E87879B40221683EB90DF9040AAC906AC8A879B40F9A67B0C8BDF904068CBEC258E879B40B123FE6585DF9040413A0CF991879B400BBF54FD7FDF90409C6FD02196879B403709E12E79DF90403E18AC0C9C879B40A0D4F6BD72DF90404C42D85CA2879B4017B677B06CDF9040603E910CA9879B40B57BEA0B67DF90408C1EBC15B0879B40052176D561DF90406849EC71B7879B40B31ADD115DDF9040B857691ABF879B4001020000000300000020EFAED7C3E19040DBB95273FC8B9B4020EFAED7C3E190400D20B9D962869B40AAF1C7695DDF90400D20B9D962869B400102000000250000005524D23EE1E09040BF945B352A879B40F93B1CD3E1E090407091386B29879B4008E6FDEEE2E090405AE1B3AC27879B40564284ECE3E09040D18F46DC25879B4021568FCAE4E09040122800FC23879B4034E92288E5E09040D035020E22879B4068A46724E6E0904081D97D1420879B404306AC9EE6E09040004BB1111E879B40932C65F6E6E09040484DE5071C879B4037722F2BE7E0904036966AF919879B4048E0CE3CE7E090404F2D97E817879B404BE0CE3CE7E090409ADB126670869B404AFBB834E7E09040E09262796F869B40E1F2801CE7E0904082CCCC8D6E869B405EAF43F4E6E09040A5B96AA46D869B403C3831BCE6E090409EEA52BE6C869B40D67A8C74E6E09040700298DC6B869B407EFAAA1DE6E09040FC6E47006B869B40726AF4B7E5E090406E27682A6A869B401032E243E5E090405E72F95B69869B40F3DBFEC1E4E090401BB5F19568869B409470E532E4E09040954D3DD967869B403BBD4097E3E090403C78BD2667869B402788CAEFE2E090402743477F66869B40CDB24A3DE2E09040CE8FA2E365869B40474B9680E1E090406E24895465869B40048E8EBAE0E0904051CEA5D264869B40F4D81FECDFE09040EF95935E64869B4067914016DFE09040E205DDF863869B40F3FDEF39DEE090408A85FBA163869B40C4153558DDE0904024C8565A63869B40BE461D72DCE090400251442263869B40E133BB88DBE090407E0D07FA62869B40826D259DDAE090401605CFE162869B40C82475B0D9E090401420B9D962869B4000E37F6300E090401020B9D962869B40AAF1C7695DDF90400D20B9D962869B4001020000000E000000E2C0D3D1B0DF90401F1E50B88A879B405E4AA839B0DF90406A1EF9B78A879B4047EBB278A8DF9040CA54F80E8C879B40089669D2A0DF9040816C02E78D879B40D47F2D4F99DF9040E84C123E90879B40187839F791DF9040B1B7971193879B409CE498D28ADF9040CA177A5E96879B4082F11EE983DF904098E51B219A879B40EAFE5D427DDF9040D29C5E559E879B408C559FE576DF9040B83FA7F6A2879B40622BDBD970DF90408D62E3FFA7879B402601B1256BDF9040FDB98E6BAD879B40F96060CF65DF90403026B933B3879B402E06C2DC60DF904005340D52B9879B4001020000000E000000A8ED127C72DF90405948B2E13B879B40FDE27F6300E090401852D8C840879B409A6849BECAE09040ECD5A65538879B408570D0BCCDE09040A016A06C37879B40110599ABD0E09040A544005536879B401BBBCE87D3E09040042ED50F35879B406513AF4ED6E090409C92589E33879B4048248CFDD8E0904064F5EE0132879B40C238D3B0DAE0904090A219D530879B402CF11B4FDCE0904060ACF48B2F879B4067B78FD6DDE0904017F3F5272E879B409FE47145DFE09040E2D6B1AA2C879B4061BA219AE0E09040856CD9152B879B405524D23EE1E09040BF945B352A879B400102000000020000000EBE682CAADF904060AEA07C80879B40E2C0D3D1B0DF904060AEA07C80879B400102000000030000000EBE682CAADF904060AEA07C80879B400EBE682CAADF904080407DC966879B40405C602EAADF90405F85279166879B40010200000002000000405C602EAADF90405F85279166879B4084B9D22CAADF90409DBAFF9066879B40010200000003000000E3C0D3D1B0DF904007C4C26275879B40B0865261ACDF904080407DC966879B40405C602EAADF90405F85279166879B4001020000002E000000405C602EAADF90405F85279166879B400150CC35AADF90406C02A0BC65879B401A50EB51AADF90409C1812B164879B40B6ABA280AADF90401A3521A863879B400B1FB8C1AADF904084C717A362879B40D67DDA14ABDF9040F3603BA361879B409518A279ABDF9040EA1DCBA960879B40DA3D91EFABDF90405618FEB75F879B4010D71476ACDF904090E301CF5E879B40EB1F850CADDF90403814F9EF5D879B40A77726B2ADDF9040CDD5F91B5D879B400E4B2A66AEDF9040C08F0C545C879B401416B027AFDF9040AB9B2A995B879B40E57BC6F5AFDF9040560E3DEC5A879B40E5736CCFB0DF904006951B4E5A879B40498A92B3B1DF90407A688BBF59879B409F321CA1B2DF9040F4563E4159879B40B82AE196B3DF904074E6D1D358879B4025ECAE93B4DF90404490CE7758879B40812A4A96B5DF9040C416A72D58879B40B25C709DB6DF904040F6B7F557879B402D4FD9A7B7DF9040A2F146D057879B404DBD38B4B8DF904066BB82BD57879B40B9EF3FC1B9DF904066BB82BD57879B40D95D9FCDBADF9040A2F146D057879B40555008D8BBDF904040F6B7F557879B4086822EDFBCDF9040C416A72D58879B40E1C0C9E1BDDF90404490CE7758879B404E8297DEBEDF904074E6D1D358879B40677A5CD4BFDF9040F4563E4159879B40BD22E6C1C0DF90407A688BBF59879B4021390CA6C1DF904006951B4E5A879B402131B27FC2DF9040560E3DEC5A879B40F296C84DC3DF9040AB9B2A995B879B40F8614E0FC4DF9040C08F0C545C879B405F3552C3C4DF9040CDD5F91B5D879B401B8DF368C5DF90403814F9EF5D879B40F6D563FFC5DF904090E301CF5E879B402C6FE785C6DF90405618FEB75F879B407194D6FBC6DF9040EA1DCBA960879B40302F9E60C7DF9040F3603BA361879B40FB8DC0B3C7DF904084C717A362879B405001D6F4C7DF90401A3521A863879B40EC5C8D23C8DF90409C1812B164879B40055DAC3FC8DF90406C02A0BC65879B40F8EE0F49C8DF904080407DC966879B400102000000020000002C540143CFDF9040C9A6B7C98A879B40E2C0D3D1B0DF90401F1E50B88A879B40010200000002000000E2C0D3D1B0DF9040201E50B88A879B40E2C0D3D1B0DF90401F1E50B88A879B40010200000002000000E2C0D3D1B0DF90401F1E50B88A879B40E3C0D3D1B0DF904007C4C26275879B40010200000002000000E3C0D3D1B0DF904007C4C26275879B408AAF74A8B3DF904007C4C26275879B400102000000020000008AAF74A8B3DF904007C4C26275879B4098590239BFDF904008C4C26275879B4001020000004300000098590239BFDF904008C4C26275879B40A4B8ED3ABFDF9040F65B0C6575879B40B7EA1888BFDF9040A60D43CF75879B404B43ABCDBFDF9040A490993E76879B4033FD4D0BC0DF90406F0885B276879B401B39B440C0DF904098E1742A77879B406A5D9B6DC0DF90401886D3A577879B404E69CB91C0DF9040DE17072478879B409B3A17ADC0DF9040B33072A478879B4011C65CBFC0DF904092A6742679879B40D34185C8C0DF904064536CA979879B40D34185C8C0DF904039DFB52C7A879B4011C65CBFC0DF90400A8CADAF7A879B409B3A17ADC0DF9040E901B0317B879B404E69CB91C0DF9040BE1A1BB27B879B406A5D9B6DC0DF904084AC4E307C879B401B39B440C0DF90400451ADAB7C879B4033FD4D0BC0DF90402D2A9D237D879B404B43ABCDBFDF9040F8A188977D879B40B7EA1888BFDF9040F624DF067E879B40A4B8ED3ABFDF9040A6D615717E879B40DFEB89E6BEDF90409D3EA8D57E879B40CDC4568BBEDF9040CAED18347F879B402502C629BEDF9040DC1AF28B7F879B40145351C2BDDF90402E35C6DC7F879B4077BF7955BDDF90406F6D302680879B40ED06C7E3BCDF90405A33D56780879B408EF7C66DBCDF9040EAA762A180879B4007BD0CF4BBDF9040770391D280879B4012293077BBDF90403AEF22FB80879B401CF6CCF7BADF9040D2D1E51A81879B4008058276BADF90405C0EB23181879B400D97F0F3B9DF9040D6356B3F81879B409184BB70B9DF9040A22A004481879B40157286EDB8DF9040D6356B3F81879B401A04F56AB8DF90405C0EB23181879B400613AAE9B7DF9040D2D1E51A81879B4010E0466AB7DF90403AEF22FB80879B401B4C6AEDB6DF9040770391D280879B409411B073B6DF9040EAA762A180879B403502B0FDB5DF90405A33D56780879B40AB49FD8BB5DF90406F6D302680879B400EB6251FB5DF90402E35C6DC7F879B40FD06B1B7B4DF9040DC1AF28B7F879B4055442056B4DF9040CAED18347F879B40441DEDFAB3DF90409D3EA8D57E879B407E5089A6B3DF9040A6D615717E879B406B1E5E59B3DF9040F624DF067E879B40D7C5CB13B3DF9040F8A188977D879B40EF0B29D6B2DF90402D2A9D237D879B4007D0C2A0B2DF90400451ADAB7C879B40B9ABDB73B2DF904084AC4E307C879B40D49FAB4FB2DF9040BE1A1BB27B879B4087CE5F34B2DF9040E901B0317B879B4011431A22B2DF90400A8CADAF7A879B404FC7F118B2DF904039DFB52C7A879B404FC7F118B2DF904064536CA979879B4011431A22B2DF904092A6742679879B4087CE5F34B2DF9040B33072A478879B40D49FAB4FB2DF9040DE17072478879B40B9ABDB73B2DF90401886D3A577879B4007D0C2A0B2DF904098E1742A77879B40EF0B29D6B2DF90406F0885B276879B40D7C5CB13B3DF9040A490993E76879B406B1E5E59B3DF9040A60D43CF75879B407E5089A6B3DF9040F65B0C6575879B408AAF74A8B3DF904007C4C26275879B4001020000001B0000008AAF74A8B3DF904007C4C26275879B40441DEDFAB3DF9040FFF3790075879B4055442056B4DF9040D24409A274879B40FD06B1B7B4DF9040C017304A74879B400EB6251FB5DF90406EFD5BF973879B40AB49FD8BB5DF90402EC5F1AF73879B403502B0FDB5DF904042FF4C6E73879B409411B073B6DF9040B28ABF3473879B401B4C6AEDB6DF9040262F910373879B4010E0466AB7DF90406243FFDA72879B400613AAE9B7DF9040CA603CBB72879B401A04F56AB8DF9040412470A472879B40157286EDB8DF9040C6FCB69672879B409184BB70B9DF9040FA07229272879B400D97F0F3B9DF9040C6FCB69672879B4008058276BADF9040412470A472879B401CF6CCF7BADF9040CA603CBB72879B4012293077BBDF90406243FFDA72879B4007BD0CF4BBDF9040262F910373879B408EF7C66DBCDF9040B28ABF3473879B40ED06C7E3BCDF904042FF4C6E73879B4077BF7955BDDF90402EC5F1AF73879B40145351C2BDDF90406EFD5BF973879B402502C629BEDF9040C017304A74879B40CDC4568BBEDF9040D24409A274879B40DFEB89E6BEDF9040FFF3790075879B4098590239BFDF904008C4C26275879B4001020000000200000098590239BFDF904008C4C26275879B40F75EA8E9C0DF904008C4C26275879B40010200000002000000F75EA8E9C0DF904008C4C26275879B40F7EE0F49C8DF904008C4C26275879B40010200000002000000F75EA8E9C0DF9040C60EA7C08A879B40F75EA8E9C0DF904008C4C26275879B40010200000003000000F75EA8E9C0DF904008C4C26275879B409EDFFE61C6DF904080407DC966879B40F8EE0F49C8DF904080407DC966879B40010200000002000000F7EE0F49C8DF904008C4C26275879B402C540143CFDF904008C4C26275879B40010200000002000000F8EE0F49C8DF904080407DC966879B40F7EE0F49C8DF904008C4C26275879B400102000000030000002C540143CFDF904008C4C26275879B408DB061E3FFDF904008C4C26275879B404C72B37D37E0904009C4C26275879B400102000000020000002C540143CFDF904008C4C26275879B402C540143CFDF9040C9A6B7C98A879B400102000000030000002C540143CFDF9040C9A6B7C98A879B408DB061E3FFDF90408BAA84E58A879B40EE0CC28330E09040CBA6B7C98A879B400102000000020000002C540143CFDF9040C9A6B7C98A879B402C540143CFDF9040CCA6B7C98A879B40010200000002000000EE0CC28330E0904009C4C26275879B40EE0CC28330E09040CBA6B7C98A879B40010200000002000000EE0CC28330E09040CBA6B7C98A879B40EE0CC28330E09040CEA6B7C98A879B4001020000000E000000EE0CC28330E09040CBA6B7C98A879B40E5161B8D4FE090406D1EF9B78A879B40F975104E57E09040CE54F80E8C879B4034CB59F45EE09040866C02E78D879B4065E1957766E09040EE4C123E90879B401DE989CF6DE09040B8B7971193879B40967C2AF474E09040D2177A5E96879B40AC6FA4DD7BE09040A0E51B219A879B404062658482E09040DA9C5E559E879B409B0B24E188E09040C03FA7F6A2879B40C135E8EC8EE090409462E3FFA7879B40FA5F12A194E0904004BA8E6BAD879B40230063F799E090403626B933B3879B40EB5A01EA9EE090400A340D52B9879B4001020000000300000024021BDD3EE0904009C4C26275879B40A681C46439E0904082407DC966879B404C72B37D37E0904082407DC966879B400102000000020000004C72B37D37E0904082407DC966879B404C72B37D37E0904009C4C26275879B4001020000002E000000DB04639855E090406285279166879B401A11F79055E090407002A0BC65879B400111D87455E09040A21812B164879B4066B5204655E09040203521A863879B4011420B0555E090408BC717A362879B4047E3E8B154E09040FC603BA361879B408848214D54E09040F41DCBA960879B40442332D753E090406218FEB75F879B400E8AAE5053E090409CE301CF5E879B4034413EBA52E090404614F9EF5D879B4079E99C1452E09040DCD5F91B5D879B401316996051E09040D08F0C545C879B400E4B139F50E09040BC9B2A995B879B403EE5FCD04FE09040680E3DEC5A879B403FED56F74EE0904019951B4E5A879B40DDD630134EE090408E688BBF59879B40882EA7254DE0904008573E4159879B407036E22F4CE0904088E6D1D358879B40047514334BE090405A90CE7758879B40AA3679304AE09040D916A72D58879B407B04532949E0904056F6B7F557879B400012EA1E48E09040B8F146D057879B40E2A38A1247E090407CBB82BD57879B407871830546E090407CBB82BD57879B40590324F944E09040B8F146D057879B40DF10BBEE43E0904056F6B7F557879B40AFDE94E742E09040D916A72D58879B4055A0F9E441E090405A90CE7758879B40EADE2BE840E0904088E6D1D358879B40D2E666F23FE0904008573E4159879B407C3EDD043FE090408E688BBF59879B401A28B7203EE0904019951B4E5A879B401B3011473DE09040680E3DEC5A879B404BCAFA783CE09040BC9B2A995B879B4046FF74B73BE09040D08F0C545C879B40E12B71033BE09040DCD5F91B5D879B4025D4CF5D3AE090404614F9EF5D879B404B8B5FC739E090409CE301CF5E879B4016F2DB4039E090406218FEB75F879B40D1CCECCA38E09040F41DCBA960879B401332256638E09040FC603BA361879B4048D3021338E090408BC717A362879B40F35FEDD137E09040203521A863879B40580436A337E09040A21812B164879B403F04178737E090407002A0BC65879B404C72B37D37E0904082407DC966879B4001020000000200000024021BDD3EE0904009C4C26275879B404C72B37D37E0904009C4C26275879B4001020000000200000023021BDD3EE09040C90EA7C08A879B4024021BDD3EE0904009C4C26275879B40010200000002000000626CFD8D41E0904009C4C26275879B4024021BDD3EE0904009C4C26275879B400102000000020000006C168B1E4DE0904009C4C26275879B40626CFD8D41E0904009C4C26275879B400102000000430000006C168B1E4DE0904009C4C26275879B407A7576204DE09040FA5B0C6575879B408EA7A16D4DE09040A80D43CF75879B40220034B34DE09040A690993E76879B4009BAD6F04DE09040720885B276879B40F1F53C264EE090409CE1742A77879B40401A24534EE090401C86D3A577879B40242654774EE09040E017072478879B4071F79F924EE09040B63072A478879B40E782E5A44EE0904094A6742679879B40A9FE0DAE4EE0904066536CA979879B40A9FE0DAE4EE090403CDFB52C7A879B40E782E5A44EE090400D8CADAF7A879B4071F79F924EE09040EC01B0317B879B40242654774EE09040C11A1BB27B879B40401A24534EE0904086AC4E307C879B40F1F53C264EE090400651ADAB7C879B4009BAD6F04DE09040302A9D237D879B40220034B34DE09040FBA188977D879B408EA7A16D4DE09040FA24DF067E879B407A7576204DE09040A8D615717E879B40B5A812CC4CE09040A03EA8D57E879B40A381DF704CE09040CDED18347F879B40FBBE4E0F4CE09040DE1AF28B7F879B40EA0FDAA74BE090403035C6DC7F879B404D7C023B4BE09040726D302680879B40C4C34FC94AE090405C33D56780879B4064B44F534AE09040ECA762A180879B40DD7995D949E090407A0391D280879B40E8E5B85C49E090403DEF22FB80879B40F2B255DD48E09040D6D1E51A81879B40DFC10A5C48E090405E0EB23181879B40E35379D947E09040D8356B3F81879B406741445647E09040A62A004481879B40EB2E0FD346E09040D8356B3F81879B40F0C07D5046E090405E0EB23181879B40DCCF32CF45E09040D6D1E51A81879B40E69CCF4F45E090403DEF22FB80879B40F108F3D244E090407A0391D280879B406ACE385944E09040ECA762A180879B400BBF38E343E090405C33D56780879B408106867143E09040726D302680879B40E472AE0443E090403035C6DC7F879B40D3C3399D42E09040DE1AF28B7F879B402B01A93B42E09040CDED18347F879B401ADA75E041E09040A03EA8D57E879B40540D128C41E09040A8D615717E879B4041DBE63E41E09040FA24DF067E879B40AD8254F940E09040FBA188977D879B40C5C8B1BB40E09040302A9D237D879B40DD8C4B8640E090400651ADAB7C879B408F68645940E0904086AC4E307C879B40AA5C343540E09040C11A1BB27B879B405D8BE81940E09040EC01B0317B879B40E7FFA20740E090400D8CADAF7A879B4025847AFE3FE090403CDFB52C7A879B4025847AFE3FE0904066536CA979879B40E7FFA20740E0904094A6742679879B405D8BE81940E09040B63072A478879B40AA5C343540E09040E017072478879B408F68645940E090401C86D3A577879B40DD8C4B8640E090409CE1742A77879B40C5C8B1BB40E09040720885B276879B40AD8254F940E09040A690993E76879B4041DBE63E41E09040A80D43CF75879B40540D128C41E09040FA5B0C6575879B40626CFD8D41E0904009C4C26275879B4001020000001B000000626CFD8D41E0904009C4C26275879B401ADA75E041E0904002F4790075879B402B01A93B42E09040D54409A274879B40D3C3399D42E09040C317304A74879B40E472AE0443E0904071FD5BF973879B408106867143E0904030C5F1AF73879B400BBF38E343E0904046FF4C6E73879B406ACE385944E09040B58ABF3473879B40F108F3D244E09040282F910373879B40E69CCF4F45E090406443FFDA72879B40DCCF32CF45E09040CC603CBB72879B40F0C07D5046E09040442470A472879B40EB2E0FD346E09040C9FCB69672879B406741445647E09040FC07229272879B40E35379D947E09040C9FCB69672879B40DFC10A5C48E09040442470A472879B40F2B255DD48E09040CC603CBB72879B40E8E5B85C49E090406443FFDA72879B40DD7995D949E09040282F910373879B4064B44F534AE09040B58ABF3473879B40C4C34FC94AE0904046FF4C6E73879B404D7C023B4BE0904030C5F1AF73879B40EA0FDAA74BE0904071FD5BF973879B40FBBE4E0F4CE09040C317304A74879B40A381DF704CE09040D54409A274879B40B5A812CC4CE0904002F4790075879B406C168B1E4DE0904009C4C26275879B4001020000000200000038A0EFF44EE0904009C4C26275879B406C168B1E4DE0904009C4C26275879B400102000000020000000CA35A9A55E0904062AEA07C80879B4037A0EFF44EE0904062AEA07C80879B4001020000000200000037A0EFF44EE09040221E50B88A879B4037A0EFF44EE0904062AEA07C80879B4001020000000200000037A0EFF44EE0904062AEA07C80879B4038A0EFF44EE0904009C4C26275879B4001020000000300000038A0EFF44EE0904009C4C26275879B4093DA706553E0904082407DC966879B40DB04639855E090406285279166879B400102000000030000000CA35A9A55E0904062AEA07C80879B400DA35A9A55E0904082407DC966879B40DB04639855E090406285279166879B40010200000002000000DB04639855E090406285279166879B4097A7F09955E09040A0BAFF9066879B4001020000000E00000013D21C20A4E090409EBE0299C1879B40276205409FE0904028668B72B9879B402EE93FDF99E090402A9DA79EB1879B40F74C3E0394E09040D4344425AA879B40E537EFB18DE09040BD5DF20DA3879B406117B8F186E09040A2FEDF5F9C879B400EA26EC97FE09040A06FD02196879B40683DC5607AE09040443A0CF991879B4020BA47BA74E090406CCBEC258E879B40F84A40DB6EE09040ACC906AC8A879B401D112EC968E090408F539B8E87879B40D1F6BF8962E090409CF394D084879B40545DCF225CE090406CE5847482879B400CA35A9A55E0904062AEA07C80879B4001020000001600000075088D3B99E090406A5B3E4051879B406FCC2FB796E090404444A45B51879B4060CF951096E09040B864E21E51879B400FC9856E95E0904032C2E3D650879B40FC7FC1D194E09040E171FE8350879B409C65043B94E09040B891952650879B4040B602AB93E09040EBD118BF4F879B408CA1682293E0904063EF034E4F879B409B7CD9A192E09040CC1FDED34E879B40B5FEEE2992E09040E76F39514E879B407D8938BB91E09040EE14B2C64D879B40877D3A5691E09040C8B1ED344D879B400C9C6DFB90E0904002919A9C4C879B408B763EAB90E0904062D46EFE4B879B40F7EC0C6690E090402C9B275B4B879B4011BB2B2C90E09040F61F88B34A879B408315E0FD8FE090403ECF58084A879B401B5761DB8FE09040CA57665A49879B409CBED8C48FE09040E4B580AA48879B406E3D61BA8FE09040AC3A7AF947879B40695707BC8FE09040A890264847879B40695707BC8FE09040CCAD29413C879B4001020000000200000079088D3B99E090406A5B3E4051879B4075088D3B99E090406A5B3E4051879B4001020000000300000013D21C20A4E090409EBE0299C1879B402018B5EB90E09040B1C2551E52879B4075088D3B99E090406A5B3E4051879B4001020000000200000075088D3B99E090406A5B3E4051879B405B41B6F1B0E090409D4BADC64E879B4001020000000500000034F6A514AEE09040AEFFBEE5D6879B40B532B56FACE09040122EC4ADD2879B409432BB91A9E09040FF18DA48CC879B40BEF7497AA6E09040119DEFFEC5879B4013D21C20A4E090409EBE0299C1879B4001020000000200000034F6A514AEE09040AEFFBEE5D6879B4008DC8A01AEE090407C14BF75D6879B400102000000020000005B41B6F1B0E09040A1BEB5313A879B405B41B6F1B0E090409D4BADC64E879B400102000000020000005B41B6F1B0E090409D4BADC64E879B405B41B6F1B0E090409E4BADC64E879B400102000000300000005B41B6F1B0E090409D4BADC64E879B40D5BF9CF7CFE0904047DDBF894B879B40EEC21327D0E090408964798D4B879B40AF41AF56D0E09040403F0B8E4B879B40AC9B3986D0E0904022C9748B4B879B40C7437DB5D0E0904066ECB8854B879B4086FC44E4D0E09040801EDE7C4B879B4009145C12D1E09040D858EE704B879B40649F8E3FD1E09040900DF7614B879B4020B5A96BD1E090405C1809504B879B4090A67B96D1E0904088AB383B4B879B40C837D4BFD1E0904032399D234B879B40F3D584E7D1E09040E95851094B879B40CACB600DD2E09040B2A972EC4A879B40EF733D31D2E09040ADB021CD4A879B40F768F252D2E0904076B481AB4A879B40EDB25972D2E090406295B8874A879B4012F24F8FD2E09040DCA2EE614A879B40BB86B4A9D2E09040F66D4E3A4A879B400FB669C1D2E090407C9904114A879B4082CB54D6D2E09040A8A73FE649879B406E7DF863D6E09040EAD3A6FA41879B4006C6AA4AD6E09040D6C07B6F3D879B405071F848D6E090400F7AE7503D879B400E433845D6E090409A2D82323D879B40CF956E3FD6E09040D0236F143D879B407821A237D6E090408C45D1F63C879B4079F3DB2DD6E09040ACF3CAD93C879B404A642722D6E090401FDF7DBD3C879B40420A9214D6E09040D1E10AA23C879B40CFA92B05D6E0904084D891873C879B40272306F4D5E09040DA7D316E3C879B408D5D35E1D5E09040A24607563C879B403430CFCCD5E09040AE3F2F3F3C879B40E348EBB6D5E090403EEDC3293C879B407B10A39FD5E090403A2CDE153C879B40788D1187D5E090405A1595033C879B409244536DD5E090404EE2FDF23B879B40A2178652D5E0904026D52BE43B879B40F222C936D5E09040EA2130D73B879B4022993C1AD5E09040B0DA19CC3B879B40C69D01FDD4E0904012DEF5C23B879B40F01E3ADFD4E0904042C8CEBB3B879B40CDAD08C1D4E09040BEE6ACB63B879B40845690A2D4E09040A42E96B33B879B408977F483D4E09040CC358EB23B879B40E3CBD8A4CDE09040CC358EB23B879B4036FE8381CAE09040DDF64B5A38879B4001020000000200000023DFD944E1E0904056A98D342A879B405524D23EE1E09040BF945B352A879B4001020000000500000020EFAED7C3E19040DBB95273FC8B9B40D4921F154EDA9040B4B95273FC8B9B40D4921F154EDA90404D53EC0C968C9B40AC921F154EDA90404D53EC0C96909B401FEFAED743E290406853EC0C96909B4001020000000200000029C6524801E29040CDB95273FC8F9B401FEFAED743E29040CEB95273FC8F9B40010200000004000000B88848715DE29040CEB95273FC8F9B40B88848715DE2904006BA5273FC8F9B4029C6524801E2904006BA5273FC8F9B4029C6524801E29040CDB95273FC8F9B4001020000000400000029C6524801E29040CDB95273FC8F9B404A2CB9AEE7DA9040B4B95273FC8F9B406D2CB9AEE7DA90405253EC0C968C9B40F6A7B14445E29040A053EC0C968C9B4001020000000600000029C6524801E29040CDB95273FC8F9B4029C6524801E29040597271F8E78F9B4071A7CD5C2FE29040597271F8E78F9B4071A7CD5C2FE2904082CE00BBDD8F9B40B88848715DE2904082CE00BBDD8F9B40B88848715DE29040F715E235F28F9B400102000000020000001FEFAED743E29040CEB95273FC8F9B40B88848715DE29040CEB95273FC8F9B400102000000030000001FEFAED743E29040CEB95273FC8F9B401FEFAED743E29040F715E235F28F9B40B88848715DE29040F715E235F28F9B400102000000020000001FEFAED743E290406853EC0C96909B40B98848715DE290406853EC0C96909B400102000000040000001FEFAED743E290406853EC0C96909B401FEFAED743E290403EF75C4AA0909B405322E20A77E290403EF75C4AA0909B405322E20A77E290406853EC0C96909B40010200000003000000B98848715DE290406753EC0C96909B401FEFAED743E290406753EC0C96909B401FEFAED743E290406853EC0C96909B40010200000003000000B88848715DE29040A153EC0C968C9B40B88848715DE29040A053EC0C968C9B40F6A7B14445E29040A053EC0C968C9B40010200000002000000F6A7B14445E29040A053EC0C968C9B40B88848715DE29040A153EC0C968C9B40010200000007000000F6A7B14445E29040A053EC0C968C9B4029C6524801E29040A053EC0C968C9B4029C6524801E290404E9BCD87AA8C9B4071A7CD5C2FE290404E9BCD87AA8C9B4071A7CD5C2FE29040263F3EC5B48C9B40B88848715DE29040263F3EC5B48C9B40B88848715DE29040A153EC0C968C9B40010200000003000000B88848715DE29040A153EC0C968C9B40B98848715DE29040A153EC0C968C9B40B98848715DE2904052A00184AA889B40010200000003000000B88848715DE29040F715E235F28F9B405322E20A77E29040F715E235F28F9B405322E20A77E29040CEB95273FC8F9B40010200000002000000B88848715DE29040F715E235F28F9B40B88848715DE29040CEB95273FC8F9B40010200000002000000B88848715DE29040CEB95273FC8F9B40B98848715DE29040CEB95273FC8F9B40010200000002000000B98848715DE890406F861F40C9859B40B98848715DE290406F861F40C9859B40010200000002000000B98848715DE290406F861F40C9859B40B98848715DE5904094C64315ED869B40010200000002000000B98848715DE29040B80668EA10889B40B98848715DE290406F861F40C9859B40010200000002000000B98848715DE29040B80668EA10889B40B98848715DE89040B80668EA10889B40010200000002000000B98848715DE2904052A00184AA889B40B98848715DE29040B80668EA10889B40010200000002000000B98848715DE29040B80668EA10889B40B98848715DE5904094C64315ED869B40010200000002000000B98848715DE2904052A00184AA889B40B98848715DE8904052A00184AA889B400102000000020000005322E20A77E29040CEB95273FC8F9B40B98848715DE29040CEB95273FC8F9B40010200000002000000B98848715DE29040CEB95273FC8F9B40B98848715DE290406753EC0C96909B400102000000020000005322E20A77E290406753EC0C96909B40B98848715DE290406753EC0C96909B40010200000002000000B98848715DE290406753EC0C96909B40B98848715DE290406853EC0C96909B40010200000002000000B98848715DE290406853EC0C96909B405322E20A77E290406853EC0C96909B400102000000020000005322E20A77E290409B861F4049909B405322E20A77E29040CEB95273FC8F9B40010200000002000000B9884871DDE290409B861F4049909B405322E20A77E290409B861F4049909B400102000000020000005322E20A77E290403520B9D962909B405322E20A77E290409B861F4049909B400102000000020000005322E20A77E290403520B9D962909B40B9884871DDE290403520B9D962909B400102000000020000005322E20A77E290406753EC0C96909B405322E20A77E290403520B9D962909B400102000000020000005322E20A77E290406853EC0C96909B405322E20A77E290406753EC0C96909B400102000000020000008655153EAAE390409B861F4049909B40B9884871DDE290409B861F4049909B40010200000002000000B9884871DDE290406853EC0C56909B40B9884871DDE290409B861F4049909B400102000000020000008655153EAAE390406853EC0C56909B40B9884871DDE290406853EC0C56909B40010200000002000000B9884871DDE290403520B9D962909B40B9884871DDE290406853EC0C56909B40010200000002000000B9884871DDE290403520B9D962909B40ECBB7BA410E590403420B9D962909B400102000000020000005322E20AF7E29040CCED013692A29B405322E20AF7E29040220D0C069EA29B400102000000050000005322E20AF7E29040CCED013692A29B403093C109E2E290403B93893894A29B4082F87C87E2E290407C1E2DF69EA29B40C7832045EDE290402AB971789EA29B405322E20AF7E29040220D0C069EA29B40010200000005000000D39497A91CE39040A98AAA4D9CA29B400E3C52F922E3904079BEC8039CA29B40BCD6967B22E390403933254691A29B40BDCBE82F02E390401463012591A29B405322E20AF7E29040CCED013692A29B400102000000020000005322E20AF7E29040220D0C069EA29B405322E20AF7E29040D360B2C29FA29B400102000000020000005322E20AF7E29040220D0C069EA29B405BB12DA3F7E29040054715FF9DA29B400102000000020000005322E20AF7E29040D360B2C29FA29B405322E20AF7E290406707E7F4A5A29B400102000000090000005322E20AF7E29040D360B2C29FA29B40BE821EE9F6E29040DB0E1E4AA0A29B40AB5EC7C2F6E29040F97C8E23A1A29B40AB17B3ABF6E2904000FE23FFA1A29B409376FEA3F6E290401AB4CCDBA2A29B40AA17B3ABF6E29040356A75B8A3A29B40AB5EC7C2F6E290403CEB0A94A4A29B40BD821EE9F6E290405B597B6DA5A29B405322E20AF7E290406707E7F4A5A29B4001020000001C00000024B8E82C09E39040A456522898A29B40E2BEF56908E390406F54AAC097A29B40D24841A007E39040CD4BDC6697A29B4045E7C6D006E390400C3E581B97A29B40D45E89FC05E390403D5A7CDE96A29B409D64912405E39040B68794B096A29B402254EC4904E390406807DA9196A29B405BDFAA6D03E390407A2C738296A29B4090BADF9002E390407A2C738296A29B40C9459EB401E390406707DA9196A29B404E35F9D900E39040B58794B096A29B40173B010200E390403C5A7CDE96A29B40A5B2C32DFFE290400B3E581B97A29B401951495EFEE29040CB4BDC6697A29B4008DB9494FDE290406D54AAC097A29B40C5E1A1D1FCE29040A156522898A29B4099896316FCE29040870A539D98A29B40895AC363FBE29040EC821A1F99A29B400F1DA0BAFAE290404AE306AD99A29B4040C4CC1BFAE29040AA2967469AA29B40B3660F88F9E29040650B7CEA9AA29B4074472000F9E29040BCE378989BA29B4033F0A884F8E290400EB3844F9CA29B40CD5D4316F8E29040842DBB0E9DA29B40474079B5F7E29040C4D72DD59DA29B400B4FC362F7E290406930E5A19EA29B4060B2881EF7E29040ACE4E1739FA29B405322E20AF7E29040D360B2C29FA29B4001020000000D0000005322E20AF7E290406707E7F4A5A29B405FB2881EF7E290408A83B743A6A29B40094FC362F7E29040CD37B415A7A29B40454079B5F7E2904071906BE2A7A29B40CB5D4316F8E29040B23ADEA8A8A29B4030F0A884F8E2904027B51468A9A29B4071472000F9E290407A84201FAAA29B40B0660F88F9E29040D15C1DCDAAA29B403CC4CC1BFAE290408D3E3271ABA29B400B1DA0BAFAE29040ED84920AACA29B40855AC363FBE290404BE57E98ACA29B4095896316FCE29040B05D461AADA29B40C1E1A1D1FCE290409611478FADA29B400102000000020000005322E20AF7E290406707E7F4A5A29B405322E20AF7E29040816B6FC9A8A29B400102000000020000005322E20AF7E29040816B6FC9A8A29B405322E20AF7E290409AD87E85B4A29B400102000000050000005322E20AF7E290409AD87E85B4A29B4030C3F382E3E2904001357471B4A29B40DD5D3805E3E29040C1A9D0B3A9A29B4019E9DBC2EDE290406A441536A9A29B405322E20AF7E29040816B6FC9A8A29B400102000000020000005322E20AF7E29040816B6FC9A8A29B40B216E920F8E290404AD2B8BCA8A29B40010200000002000000CE0D10D2FFE2904068C5808EB4A29B405322E20AF7E290409AD87E85B4A29B400102000000020000005322E20AF7E290409AD87E85B4A29B405322E20AF7E290404A398CEFEFA39B400102000000020000005322E20AF7E290404A398CEFEFA39B405322E20AF7E29040D5989E7FFBA39B400102000000060000005322E20AF7E290404A398CEFEFA39B4018D25740F3E29040DF761E71F6A39B40CE054AD7E5E29040A62068D213A49B4020896963EFE290400CCC56C418A49B4081345855F4E29040BA4837380FA49B405322E20AF7E290401A1935FD09A49B40010200000004000000210E20270AE39040C6CECD17E5A39B40798D010F0DE390402EB8997BDFA39B402C0AE28203E39040CD0CAB89DAA39B405322E20AF7E290404A398CEFEFA39B400102000000020000005322E20AF7E29040D5989E7FFBA39B405322E20AF7E29040392643B701A49B4001020000000A0000005322E20AF7E29040D5989E7FFBA39B401A049CF5F6E290404BC903CFFBA39B40A1E412CCF6E29040C5A6FAA2FCA39B40589619B1F6E29040B6A54879FDA39B40594BD0A4F6E2904060FBED50FEA39B40D7AD45A7F6E290403643E928FFA39B4095CE76B8F6E290401AB2380000A49B4071284FD8F6E29040054ADBD500A49B40D9B8A806F7E29040D20CD2A801A49B405322E20AF7E29040392643B701A49B4001020000000D000000C1E1A1D1FCE29040593A75E5F3A39B40FDF45E1AFCE29040CC72C757F4A39B406299566BFBE29040C30757D6F4A39B40C1B959C5FAE290406BE98C60F5A39B402F752E29FAE290404C20C4F5F5A39B4086328F97F9E2904032924A95F6A39B40F0C12911F9E29040BED6613EF7A39B406B8D9E96F8E29040AF1A40F0F7A39B4055D97F28F8E29040C51011AAF8A39B40D21551C7F7E2904027EFF66AF9A39B40EF418673F7E290401E780B32FAA39B402C61832DF7E29040E60C61FEFAA39B405322E20AF7E29040D5989E7FFBA39B4001020000001C0000005322E20AF7E29040392643B701A49B402D2D4C43F7E29040902C217802A49B40CA24F18DF7E290401238D14203A49B406A873EE6F7E290404942F00704A49B407AEFCA4BF8E29040040393C604A49B40ED271DBEF8E29040C8EFD57D05A49B40E4BCAC3CF9E29040634BDE2C06A49B408C9EE2C6F9E29040042BDBD206A49B406DD5195CFAE29040966F066F07A49B405347A0FBFAE290403FB2A50008A49B40DF8BB7A4FBE29040D5220B8708A49B40D0CF9556FCE290405A57960109A49B40E6C56610FDE29040700BB56F09A49B4048A44CD1FDE29040F3CEE3D009A49B403F2D6198FEE29040D6A2AE240AA49B4007C2B664FFE290409983B16A0AA49B406C7E593500E39040ABE098A20AA49B40E65B500901E39040240022CC0AA49B40D75A9EDF01E390406D4E1BE70AA49B4081B043B702E390406C9964F30AA49B4057F83E8F03E39040EE36EFF00AA49B403B678E6604E390403016BEDF0AA49B4026FF303C05E3904054BCE5BF0AA49B40F3C1270F06E39040EC2B8C910AA49B40B1E176DE06E3904098B7E8540AA49B4033ED26A907E39040FBBF430A0AA49B406AF7456E08E390405B5DF6B109A49B4025B8E82C09E390404BF5694C09A49B400102000000020000005322E20AF7E29040392643B701A49B405322E20AF7E290401A1935FD09A49B4001020000000400000039458B5041E69040B26B5BD9BBA79B4043723DEE30E69040B26B5BD9BBA79B405322E20AF7E29040B26B5BD9BBA79B405322E20AF7E290401A1935FD09A49B400102000000020000005322E20AF7E290401A1935FD09A49B4016BB441BF9E2904067340F0106A49B40010200000002000000CBFAE2EEFAE290405CE46AD3B0A29B402AFFE2EEFAE29040A2E76AD3B0A29B400102000000020000002AFFE2EEFAE29040486451A1F0A39B40CBFAE2EEFAE290408F6751A1F0A39B400102000000020000002AFFE2EEFAE29040A2E76AD3B0A29B406DFFE2EEFAE29040D5E76AD3B0A29B400102000000030000002AFFE2EEFAE29040A2E76AD3B0A29B4025FFE2EEFAE29040ABE76AD3B0A29B406DFFE2EEFAE29040D5E76AD3B0A29B400102000000020000002AFFE2EEFAE29040A2E76AD3B0A29B4024B8E82C09E39040A456522898A29B4001020000000200000025B8E82C09E390404BF5694C09A49B402AFFE2EEFAE29040486451A1F0A39B400102000000030000002AFFE2EEFAE29040486451A1F0A39B4025FFE2EEFAE290403F6451A1F0A39B4073FFE2EEFAE29040126451A1F0A39B4001020000000200000073FFE2EEFAE29040126451A1F0A39B402AFFE2EEFAE29040486451A1F0A39B400102000000020000006DFFE2EEFAE29040D5E76AD3B0A29B402EE36E0A1DE39040D30A9484C4A29B400102000000020000006DFFE2EEFAE29040D5E76AD3B0A29B40B772D8A31BE390407EA04554C9A29B40010200000002000000B872D8A31BE390406DAB7620D8A39B4073FFE2EEFAE29040126451A1F0A39B4001020000000200000073FFE2EEFAE29040126451A1F0A39B402EE36E0A1DE390401C4128F0DCA39B4001020000002E000000901166AF05E39040984DED339EA29B4079E5945A05E390406334D4069EA29B405F45D30205E3904021DDC1DF9DA29B4088A48EA804E39040CC02E7BE9DA29B402E98374C04E39040779F6CA49DA29B40144B41EE03E390402EB973909DA29B40E9ED208F03E39040C83815839DA29B4017254D2F03E39040D6CA617C9DA29B40D1743DCF02E39040D6CA617C9DA29B40FFAB696F02E39040C83815839DA29B40D44E491002E390402EB973909DA29B40BA0153B201E39040779F6CA49DA29B4060F5FB5501E39040CC02E7BE9DA29B408954B7FB00E3904020DDC1DF9DA29B406FB4F5A300E390406234D4069EA29B405888244F00E39040974DED339EA29B401299ADFDFFE29040A0E9D4669EA29B400381F6AFFFE29040628B4B9F9EA29B40762D6066FFE29040F5C60ADD9EA29B40B1654621FFE290407899C51F9FA29B408358FFE0FEE290401CC928679FA29B40C430DBA5FEE29040F64CDBB29FA29B4058B12370FEE2904003BC7E02A0A29B4035D91B40FEE29040EEC2AF55A0A29B40CF8FFF15FEE29040ED9F06ACA0A29B40625A03F2FDE290402DA41705A1A29B40771A54D4FDE290401BBA7360A1A29B40E1D516BDFDE29040F2EFA8BDA1A29B40978868ACFDE29040DA05431CA2A29B408C005EA2FDE29040DEFECB7BA2A29B40BCC3039FFDE290401CB4CCDBA2A29B408C005EA2FDE290405A69CD3BA3A29B40978868ACFDE290405E62569BA3A29B40E0D516BDFDE290404678F0F9A3A29B40761A54D4FDE290401DAE2557A4A29B40625A03F2FDE290400BC481B2A4A29B40CE8FFF15FEE290404BC8920BA5A29B4034D91B40FEE290404AA5E961A5A29B4057B12370FEE2904035AC1AB5A5A29B40C230DBA5FEE29040421BBE04A6A29B408258FFE0FEE290401C9F7050A6A29B40B0654621FFE29040C1CED397A6A29B40742D6066FFE2904044A18EDAA6A29B400181F6AFFFE29040D7DC4D18A7A29B401099ADFDFFE29040997EC450A7A29B405688244F00E39040A21AAC83A7A29B4001020000002F0000005688244F00E390404D3110F1F9A39B40A61E69FFFFE29040DD21CD22FAA39B40963742B3FFE290400850DD59FAA39B4012B80A6BFFE29040BF02FF95FAA39B4099D21827FFE290403C74EAD6FAA39B405AA0BDE7FEE29040B327521CFBA39B4069C044ADFEE29040C945E365FBA39B4078FDF377FEE2904077FF45B3FBA39B408FFA0A48FEE29040DAF61D04FCA39B4013E7C21DFEE2904073AD0A58FCA39B40883A4EF9FDE290404FF7A7AEFCA39B405078D8DAFDE290409D728E07FDA39B40C0FB85C2FDE2904010035462FDA39B40B7CC73B0FDE2904087508CBEFDA39B40FA7CB7A4FDE290405F48C91BFEA39B40720E5F9FFDE29040D4A09B79FEA39B407AE270A0FDE29040D65D93D7FEA39B403AB2EBA7FDE29040B3564035FFA39B403290C6B5FDE29040F9BB3292FFA39B40E1F2F0C9FDE29040E49CFBEDFFA39B4081C852E4FDE29040D16B2D4800A49B40C393CC04FEE29040FB805CA000A49B406391372BFEE29040FC9A1FF600A49B406EE66557FEE290406F5C104901A49B40FED62289FEE290401FC6CB9801A49B40290533C0FEE290402FADF2E401A49B40E0B754FCFEE29040B32C2A2D02A49B405D29403DFFE290402C121C7102A49B40D4DCA782FFE290406B4477B002A49B40EAFA38CCFFE290405C24F0EA02A49B4098B49B1900E390404DE7402003A49B40FBAB736A00E3904036EA295003A49B40946260BE00E39040B2FD717A03A49B4070ACFD1401E390403DAAE69E03A49B40BE27E46D01E39040756C5CBD03A49B4031B8A9C801E3904005E9AED503A49B40A805E22402E390400E18C1E703A49B4080FD1E8202E39040CB677DF303A49B40F555F1DF02E3904053D6D5F803A49B40F712E93D03E390404B02C4F703A49B40D40B969B03E390408B3249F003A49B401A7188F803E3904093546EE203A49B400552515404E39040E4F143CE03A49B40F22083AE04E39040441CE2B303A49B401C36B20605E390400251689303A49B401D50755C05E390406253FD6C03A49B40901166AF05E3904057FECE4003A49B40010200000005000000E9F55EBC10E39040FFDF8B320AA49B40BB8FA87B02E39040D32234A822A49B406E0C89EFF8E290406D7745B61DA49B40D3B777E1FDE2904020F4252A14A49B40643E64A702E39040CDDFFDF20AA49B4001020000000200000025B8E82C09E39040A456522898A29B4024B8E82C09E39040A456522898A29B4001020000000200000024B8E82C09E39040A456522898A29B40BD9AA70F0BE390409F802EE494A29B40010200000002000000BC9AA70F0BE390404ECB8D900CA49B4025B8E82C09E390404BF5694C09A49B40010200000002000000BD9AA70F0BE390409F802EE494A29B40CB91A70F0BE39040D27C2EE494A29B40010200000002000000CC91A70F0BE390401BCF8D900CA49B40BC9AA70F0BE390404ECB8D900CA49B40010200000003000000BC9AA70F0BE390404ECB8D900CA49B40C69AA70F0BE3904060CB8D900CA49B40579BA70F0BE390400CCB8D900CA49B40010200000002000000BC9AA70F0BE390404ECB8D900CA49B40579BA70F0BE390400CCB8D900CA49B400102000000020000004D9BA70F0BE39040DD802EE494A29B40BD9AA70F0BE390409F802EE494A29B40010200000003000000BD9AA70F0BE390409F802EE494A29B40C69AA70F0BE390408F802EE494A29B404D9BA70F0BE39040DD802EE494A29B400102000000020000007F5738DA28E3904096E9C68EA1A29B404D9BA70F0BE39040DD802EE494A29B400102000000020000004D9BA70F0BE39040DD802EE494A29B4041700D7427E390405BD39748A5A29B40010200000002000000579BA70F0BE390400CCB8D900CA49B4041700D7427E390408F78242CFCA39B40010200000002000000579BA70F0BE390400CCB8D900CA49B40805738DA28E390405762F5E5FFA39B4001020000000F0000003ED6911C42E390404F895ACD69A29B401E7F281933E3904095FDCFAB88A29B40A93CF64426E390404AED8F82A8A29B409714E7AF1BE39040326F162AC9A29B40D93E1D6713E39040717DDC79EAA29B40C2D8E0740DE39040F8418A480CA39B404D2293E009E390402C662A6C2EA39B405C55A5AE08E39040FA255EBA50A39B404D2293E009E39040C8E5910873A39B40C2D8E0740DE39040FC09322C95A39B40D93E1D6713E3904083CEDFFAB6A39B409714E7AF1BE39040C2DCA54AD8A39B40A93CF64426E39040AA5E2CF2F8A39B401E7F281933E390405F4EECC818A49B403ED6911C42E39040A5C261A737A49B4001020000002E000000986006BB4AE390407535DB8170A29B405EDB9CF24AE39040C567BC3270A29B40B10D99244BE39040594AF6DF6FA29B4042BDBD504BE390406241EE896FA29B40A3D7D4764BE3904087AE0D316FA29B4085B4AF964BE39040D86FC1D56EA29B40DD4E27B04BE390406C5A79786EA29B40B0741CC34BE3904070B1A7196EA29B4046ED77CF4BE39040249AC0B96DA29B40A2952AD54BE39040A28D39596DA29B4006732DD44BE39040F0C888F86CA29B4084BB81CC4BE3904030BC24986CA29B4082D430BE4BE39040897983386CA29B4033474CA94BE390408B241ADA6BA29B4024ABED8D4BE39040AC625C7D6BA29B40DB86366C4BE39040A7CDBB226BA29B40CB2650444BE390405068A7CA6AA29B40BA6A6B164BE390409A168B756AA29B40EA89C0E24AE390407119CF236AA29B4032CE8EA94AE39040068FD7D569A29B4083461C6B4AE3904029F8038C69A29B400F71B5274AE3904051C3AE4669A29B409CDDACDF49E39040D4DD2C0669A29B4060C85A9349E39040DF4BCDCA68A29B40EAAD1C4349E39040B1C7D89468A29B40A3D854EF48E390407F68916468A29B4065E8699848E390408351323A68A29B40C954C63E48E390408C69EF1568A29B40B9EAD7E247E39040661BF5F767A29B40F4450F8547E390407A1F68E067A29B401D47DF2547E39040CB4E65CF67A29B400687BCC546E39040A47F01C567A29B40DAC71C6546E39040136C49C167A29B40E064760446E390404EA241C467A29B4082C13FA445E39040247FE6CD67A29B404AB8EE4445E390406B322CDE67A29B407F0AF8E644E3904080CDFEF467A29B402AD1CE8A44E39040AA5B421268A29B4012F0E33044E390405E04D33568A29B407A8BA5D943E390402337855F68A29B4033817E8543E39040F4E0258F68A29B40B7E5D53443E39040C9AA7AC468A29B40E2850EE842E39040164142FF68A29B40F36D869F42E39040C7A3343F69A29B405076965B42E39040777E038469A29B40BAD6911C42E3904064885ACD69A29B4001020000002E000000BAD6911C42E390408AC361A737A49B405076965B42E3904077CDB8F037A49B40F36D869F42E3904027A8873538A49B40E2850EE842E39040D80A7A7538A49B40B7E5D53443E3904025A141B038A49B4033817E8543E39040FA6A96E538A49B407A8BA5D943E39040CB14371539A49B4012F0E33044E390409047E93E39A49B402AD1CE8A44E3904044F0796239A49B407F0AF8E644E390406E7EBD7F39A49B404AB8EE4445E390408319909639A49B4082C13FA445E39040CACCD5A639A49B40E064760446E39040A0A97AB039A49B40DAC71C6546E39040DBDF72B339A49B400687BCC546E390404ACCBAAF39A49B401D47DF2547E3904023FD56A539A49B40F4450F8547E39040742C549439A49B40B9EAD7E247E390408830C77C39A49B40C954C63E48E3904062E2CC5E39A49B4065E8699848E390406BFA893A39A49B40A3D854EF48E390406FE32A1039A49B40EAAD1C4349E390403D84E3DF38A49B4060C85A9349E390400F00EFA938A49B409CDDACDF49E390401B6E8F6E38A49B400F71B5274AE390409D880D2E38A49B4083461C6B4AE39040C553B8E837A49B4032CE8EA94AE39040E8BCE49E37A49B40EA89C0E24AE390407D32ED5037A49B40BA6A6B164BE39040543531FF36A49B40CB2650444BE390409EE314AA36A49B40DB86366C4BE39040477E005236A49B4024ABED8D4BE3904042E95FF735A49B4033474CA94BE390406327A29A35A49B4082D430BE4BE3904065D2383C35A49B4084BB81CC4BE39040BE8F97DC34A49B4006732DD44BE39040FE82337C34A49B40A2952AD54BE390404CBE821B34A49B4046ED77CF4BE39040CAB1FBBA33A49B40B0741CC34BE390407E9A145B33A49B40DE4E27B04BE3904081F142FC32A49B4085B4AF964BE3904016DCFA9E32A49B40A3D7D4764BE39040679DAE4332A49B4042BDBD504BE390408C0ACEEA31A49B40B10D99244BE390409501C69431A49B405EDB9CF24AE3904029E4FF4131A49B409E6006BB4AE390408116E1F230A49B40010200000002000000946006BB4AE390407B35DB8170A29B40986006BB4AE390407535DB8170A29B400102000000020000009E6006BB4AE390408116E1F230A49B40946006BB4AE390407316E1F230A49B4001020000000F000000986006BB4AE390407535DB8170A29B401C0C7B453CE39040892873838EA29B402B1703EB2FE39040253F3B72ADA29B40E1BAB4BA25E3904015846C28CDA29B40456801C11DE39040A6794C7FEDA29B402296A60718E39040A6655C4F0EA39B40D9DBA19514E39040518D89702FA39B40CD67286F13E39040F5255EBA50A39B40D9DBA19514E3904099BE320472A39B402296A60718E3904044E65F2593A39B40456801C11DE3904044D26FF5B3A39B40E1BAB4BA25E39040D5C74F4CD4A39B402B1703EB2FE39040C50C8102F4A39B401C0C7B453CE39040612349F112A49B409E6006BB4AE390408116E1F230A49B40010200000002000000B76006BB4AE390403535DB8170A29B40986006BB4AE390407535DB8170A29B400102000000020000009E6006BB4AE390408116E1F230A49B40B76006BB4AE39040B516E1F230A49B40010200000002000000618E155B4EE3904086F5550E54A29B400579155B4EE3904068F4550E54A29B400102000000020000000579155B4EE39040835766664DA49B40618E155B4EE39040655666664DA49B40010200000002000000618E155B4EE39040CEF4550E54A29B40618E155B4EE3904086F5550E54A29B40010200000002000000FD91FA5A21E59040F8FD5E856CA29B40618E155B4EE3904086F5550E54A29B40010200000003000000618E155B4EE3904086F5550E54A29B40618E155B4EE3904073B4D1DD8DA29B40997CF83A70E3904073B4D1DD8DA29B40010200000002000000618E155B4EE39040655666664DA49B40618E155B4EE390401C5766664DA49B40010200000003000000967CF83A70E390407B97EA9613A49B40618E155B4EE390407B97EA9613A49B40618E155B4EE39040655666664DA49B40010200000002000000618E155B4EE39040655666664DA49B400092FA5A21E59040F34D5DEF34A49B4001020000000200000077A28B8361E39040F3F22628A4A29B403A44EC7661E390408B63EFFFA3A29B400102000000020000003A44EC7661E390405FE8CC74FDA39B4077A28B8361E39040F758954CFDA39B4001020000000B00000077A28B8361E39040F758954CFDA39B406D75CB016CE39040CCC0D7DDDBA39B40CCD1CD4174E39040589941A4B9A39B409CC64E2D7AE390401F390BF096A39B4054F762BD7DE3904051BBC4E973A39B400154E0ED7EE39040F5255EBA50A39B4054F762BD7DE390409990F78A2DA39B409CC64E2D7AE39040CB12B1840AA39B40CCD1CD4174E3904092B27AD0E7A29B406D75CB016CE390401E8BE496C5A29B4077A28B8361E39040F3F22628A4A29B4001020000001200000077A28B8361E39040F3F22628A4A29B400FA6E5DD58E390407812D6F0B2A29B400445D6124FE390406E78048EC6A29B4033E7319946E39040F7E0F2C5DAA29B40567C767A3FE390405A67FC81EFA29B40AE6C9DBE39E390406F32E8AA04A39B40B9AA126C35E39040AF7603291AA39B400282AD8732E39040D3003CE42FA39B40262BAB1431E39040562B3BC445A39B40262BAB1431E39040942081B05BA39B400282AD8732E39040174B809071A39B40B9AA126C35E390403BD5B84B87A39B40AE6C9DBE39E390407B19D4C99CA39B40567C767A3FE3904090E4BFF2B1A39B4033E7319946E39040F36AC9AEC6A39B400445D6124FE390407CD3B7E6DAA39B400FA6E5DD58E390407239E683EEA39B4077A28B8361E39040F758954CFDA39B40010200000003000000A37CF83A70E3904083B4D1DD8DA29B409E3468EF63E3904005435F04A0A29B4077A28B8361E39040F3F22628A4A29B4001020000000300000077A28B8361E39040F758954CFDA39B409E3468EF63E39040E5085D7001A49B40A37CF83A70E390406797EA9613A49B40010200000002000000997CF83A70E3904073B4D1DD8DA29B40487CF83A70E39040EBB3D1DD8DA29B40010200000002000000487CF83A70E39040FF97EA9613A49B40967CF83A70E390407B97EA9613A49B40010200000002000000B07CF83A70E390407B97EA9613A49B40967CF83A70E390407B97EA9613A49B40010200000002000000967CF83A70E390407B97EA9613A49B40A37CF83A70E390406797EA9613A49B40010200000002000000AE7CF83A70E3904073B4D1DD8DA29B40997CF83A70E3904073B4D1DD8DA29B40010200000002000000A37CF83A70E3904083B4D1DD8DA29B40997CF83A70E3904073B4D1DD8DA29B40010200000012000000A37CF83A70E390406797EA9613A49B40E0F1BB967CE39040900458C6FEA39B40162BCA8687E3904031A2FB2DE9A39B40CEF894FE90E3904064729FE6D2A39B4099153EF398E390405B58D609BCA39B40729FA35B9FE39040D0BDDEB1A4A39B406E936A30A4E39040F27284F98CA39B40393F076CA7E3904004EC01FC74A39B40C19EC30AA9E39040F8FFE0D45CA39B40C19EC30AA9E39040F24BDB9F44A39B40393F076CA7E39040E65FBA782CA39B406E936A30A4E39040F8D8377B14A39B40729FA35B9FE390401A8EDDC2FCA29B4099153EF398E390408FF3E56AE5A29B40CEF894FE90E3904086D91C8ECEA29B40162BCA8687E39040B9A9C046B8A29B40E0F1BB967CE390405A4764AEA2A29B40A37CF83A70E3904083B4D1DD8DA29B40010200000002000000AE7CF83A70E3904073B4D1DD8DA29B40A37CF83A70E3904083B4D1DD8DA29B40010200000002000000A37CF83A70E390406797EA9613A49B40B07CF83A70E390407B97EA9613A49B40010200000002000000FB6813B40FE5904073B4D1DD8DA29B40AE7CF83A70E3904073B4D1DD8DA29B40010200000002000000AB7DF83A70E39040FDB2D1DD8DA29B40AE7CF83A70E3904073B4D1DD8DA29B40010200000002000000FA6813B40FE590407B97EA9613A49B40B07CF83A70E390407B97EA9613A49B40010200000002000000B07CF83A70E390407B97EA9613A49B40AB7DF83A70E39040ED98EA9613A49B40010200000002000000ECBB7BA410E490409B861F4049909B408655153EAAE390409B861F4049909B400102000000020000008655153EAAE390409B861F4049909B408655153EAAE390406853EC0C56909B40010200000003000000ECBB7BA410E490409A861F4049909B408655153EAAE390409A861F4049909B408655153EAAE390409B861F4049909B400102000000030000008655153EAAE390406853EC0C56909B408655153EAAE390403420B9D962909B40ECBB7BA410E490403420B9D962909B40010200000002000000ECBB7BA410E490406753EC0C56909B408655153EAAE390406853EC0C56909B400102000000020000001FEFAED743E690409B861F4049909B40ECBB7BA410E490409A861F4049909B40010200000002000000ECBB7BA410E490409B861F4049909B40ECBB7BA410E490409A861F4049909B40010200000002000000ECBB7BA410E590409B861F4049909B40ECBB7BA410E490409B861F4049909B40010200000002000000ECBB7BA410E490406753EC0C56909B40ECBB7BA410E490409B861F4049909B40010200000002000000ECBB7BA410E590406753EC0C56909B40ECBB7BA410E490406753EC0C56909B40010200000002000000ECBB7BA410E490403420B9D962909B40ECBB7BA410E490406753EC0C56909B40010200000002000000ECBB7BA410E490403420B9D962909B40ECBB7BA410E590403420B9D962909B40010200000002000000A375110520E4904078433BFDF4A19B400783717715E49040A0E2ACA25AA29B400102000000020000000883717715E490404F690FD246A49B40A475110520E4904077088177ACA49B4001020000000900000067EE57661EE490404EA70EB601A29B4039A05B2E1EE49040682482F801A29B40130DDF4017E4904047BA84310AA29B403977DC070FE490401D27084403A29B40E34D2F9622E4904090E35690E9A19B401AEAC79838E49040F7A3F8EDD1A19B40F97FCAD140E490401D3775DBD8A19B40CFEC4DE439E49040F7CC7714E1A19B402877783433E4904011E24C04E9A19B400102000000050000005829873B1FE490409040695EA6A49B40E744212D11E49040C7131EF1BEA49B40DE62853B1AE49040A6F3D2BCC4A49B40BD423A0720E49040ABD56EAEBBA49B40BDE95A9F25E490407D33A3F0B2A49B40010200000003000000CD75110520E4904053C0C5245BA29B40CD75110520E4904045423BFDF4A19B40133B8FCA23E4904045423BFDF4A19B40010200000003000000133B8FCA23E49040AA098177ACA49B40CD75110520E49040AA098177ACA49B40CD75110520E490409C8BF64F46A49B40010200000002000000133B8FCA23E4904045423BFDF4A19B403C8894C52AE4904045423BFDF4A19B4001020000002E000000D3E71C813CE4904045423BFDF4A19B40BC4668793CE490402B8C9220F4A19B40BBFF53623CE49040230BFD44F3A19B40A9DBFC3B3CE49040059D8C6BF2A19B4007AC92063CE49040D6725095F1A19B405C0F58C23BE4904093BE53C3F0A19B40201EA26F3BE49040EF659CF6EFA19B409A00D80E3BE49040AEBB2930EFA19B40356E72A03AE490403941F370EEA19B40F316FB243AE49040E671E7B9EDA19B40B5F70B9D39E490408F99EA0BEDA19B40289A4E0939E49040D4B7D567ECA19B4059417B6A38E49040747175CEEBA19B40DF0358C137E4904015118940EBA19B40CFD4B70E37E49040B198C1BEEAA19B40A37C795336E49040CBE4C049EAA19B406083869035E4904096E218E2E9A19B404F0DD2C634E49040F4D94A88E9A19B40C3AB57F733E4904034CCC63CE9A19B4051231A2333E4904065E8EAFFE8A19B401A29224B32E49040DD1503D2E8A19B40A0187D7031E49040909548B3E8A19B40D8A33B9430E49040A2BAE1A3E8A19B400E7F70B72FE49040A2BAE1A3E8A19B40460A2FDB2EE49040909548B3E8A19B40CCF989002EE49040DD1503D2E8A19B4095FF91282DE4904065E8EAFFE8A19B40237754542CE4904034CCC63CE9A19B409715DA842BE49040F4D94A88E9A19B40869F25BB2AE4904096E218E2E9A19B4043A632F829E49040CBE4C049EAA19B40174EF43C29E49040B198C1BEEAA19B40071F548A28E4904015118940EBA19B408DE130E127E49040747175CEEBA19B40BE885D4227E49040D4B7D567ECA19B40312BA0AE26E490408F99EA0BEDA19B40F30BB12626E49040E671E7B9EDA19B40B1B439AB25E490403941F370EEA19B404C22D43C25E49040AEBB2930EFA19B40C6040ADC24E49040EF659CF6EFA19B408A13548924E4904093BE53C3F0A19B40DF76194524E49040D6725095F1A19B403D47AF0F24E49040059D8C6BF2A19B402B2358E923E49040230BFD44F3A19B402ADC43D223E490402B8C9220F4A19B40133B8FCA23E4904045423BFDF4A19B400102000000020000003C8894C52AE49040AA098177ACA49B40133B8FCA23E49040AA098177ACA49B4001020000002E000000133B8FCA23E49040AA098177ACA49B402ADC43D223E49040C4BF2954ADA49B402B2358E923E49040CC40BF2FAEA49B403D47AF0F24E49040EAAE2F09AFA49B40DF76194524E4904019D96BDFAFA49B408A13548924E490405C8D68B1B0A49B40C6040ADC24E4904000E61F7EB1A49B404C22D43C25E4904041909244B2A49B40B1B439AB25E49040B60AC903B3A49B40F30BB12626E4904009DAD4BAB3A49B40312BA0AE26E4904060B2D168B4A49B40BE885D4227E490401B94E60CB5A49B408DE130E127E490407BDA46A6B5A49B40071F548A28E49040DA3A3334B6A49B40174EF43C29E490403EB3FAB5B6A49B4043A632F829E490402467FB2AB7A49B40869F25BB2AE490405969A392B7A49B409715DA842BE49040FB7171ECB7A49B40237754542CE49040BB7FF537B8A49B4095FF91282DE490408A63D174B8A49B40CCF989002EE490401236B9A2B8A49B40460A2FDB2EE490405FB673C1B8A49B400E7F70B72FE490404D91DAD0B8A49B40D8A33B9430E490404D91DAD0B8A49B40A0187D7031E490405FB673C1B8A49B401A29224B32E490401236B9A2B8A49B4051231A2333E490408A63D174B8A49B40C3AB57F733E49040BB7FF537B8A49B404F0DD2C634E49040FB7171ECB7A49B406083869035E490405969A392B7A49B40A37C795336E490402467FB2AB7A49B40CFD4B70E37E490403EB3FAB5B6A49B40DF0358C137E49040DA3A3334B6A49B4059417B6A38E490407BDA46A6B5A49B40289A4E0939E490401B94E60CB5A49B40B5F70B9D39E4904060B2D168B4A49B40F316FB243AE4904009DAD4BAB3A49B40356E72A03AE49040B60AC903B3A49B409A00D80E3BE4904041909244B2A49B40201EA26F3BE4904000E61F7EB1A49B405C0F58C23BE490405C8D68B1B0A49B4007AC92063CE4904019D96BDFAFA49B40A9DBFC3B3CE49040EAAE2F09AFA49B40BBFF53623CE49040CC40BF2FAEA49B40BC4668793CE49040C4BF2954ADA49B40D3E71C813CE49040AA098177ACA49B400102000000020000003C8894C52AE4904045423BFDF4A19B40AA9A178635E4904045423BFDF4A19B4001020000002E000000AA9A178635E4904045423BFDF4A19B40DA5DBD8235E49040078D3A9DF4A19B40CFD5B27835E490400394B13DF4A19B408588046835E490401B7E17DFF3A19B40EF43C75035E490404448E281F3A19B400404183335E4904056328626F3A19B4098CE1B0F35E49040162E75CDF2A19B403185FFE434E4904017511E77F2A19B400EADF7B434E490402C4AED23F2A19B40A32D407F34E490401FDB49D4F1A19B40E4051C4434E4904045579788F1A19B40B6F8D40334E49040A0273441F1A19B40F130BBBE33E490401E5579FEF0A19B4064DD247533E490408B19BAC0F0A19B4055C56D2733E49040C8774388F0A19B400FD6F6D532E49040BFDB5B55F0A19B40F8A9258132E490408AC24228F0A19B40DE09642932E49040486B3001F0A19B4007691FCF31E49040F49055E0EFA19B40AD5CC87231E490409F2DDBC5EFA19B40930FD21431E490405647E2B1EFA19B4068B2B1B530E49040F0C683A4EFA19B4096E9DD5530E49040FE58D09DEFA19B405039CEF52FE49040FE58D09DEFA19B407E70FA952FE49040F0C683A4EFA19B405313DA362FE490405647E2B1EFA19B4039C6E3D82EE490409F2DDBC5EFA19B40DFB98C7C2EE49040F49055E0EFA19B40081948222EE49040486B3001F0A19B40EE7886CA2DE490408AC24228F0A19B40D74CB5752DE49040BFDB5B55F0A19B40915D3E242DE49040C8774388F0A19B40824587D62CE490408B19BAC0F0A19B40F5F1F08C2CE490401E5579FEF0A19B40302AD7472CE49040A0273441F1A19B40021D90072CE4904045579788F1A19B4043F56BCC2BE490401FDB49D4F1A19B40D875B4962BE490402C4AED23F2A19B40B59DAC662BE4904017511E77F2A19B404E54903C2BE49040162E75CDF2A19B40E21E94182BE4904056328626F3A19B40F7DEE4FA2AE490404448E281F3A19B40619AA7E32AE490401B7E17DFF3A19B40174DF9D22AE490400394B13DF4A19B400CC5EEC82AE49040078D3A9DF4A19B403C8894C52AE4904045423BFDF4A19B40010200000002000000AA9A178635E49040AA098177ACA49B403C8894C52AE49040AA098177ACA49B4001020000002E0000003C8894C52AE49040AA098177ACA49B400CC5EEC82AE49040E8BE81D7ACA49B40174DF9D22AE49040ECB70A37ADA49B40619AA7E32AE49040D4CDA495ADA49B40F7DEE4FA2AE49040AB03DAF2ADA49B40E21E94182BE490409919364EAEA49B404E54903C2BE49040D91D47A7AEA49B40B59DAC662BE49040D8FA9DFDAEA49B40D875B4962BE49040C301CF50AFA49B4043F56BCC2BE49040D07072A0AFA49B40021D90072CE49040AAF424ECAFA49B40302AD7472CE490404F248833B0A49B40F5F1F08C2CE49040D1F64276B0A49B40824587D62CE49040643202B4B0A49B40915D3E242DE4904027D478ECB0A49B40D74CB5752DE490403070601FB1A49B40EE7886CA2DE490406589794CB1A49B40081948222EE49040A7E08B73B1A49B40DFB98C7C2EE49040FBBA6694B1A49B4039C6E3D82EE49040501EE1AEB1A49B405313DA362FE490409904DAC2B1A49B407E70FA952FE49040FF8438D0B1A49B405039CEF52FE49040F1F2EBD6B1A49B4096E9DD5530E49040F1F2EBD6B1A49B4068B2B1B530E49040FF8438D0B1A49B40930FD21431E490409904DAC2B1A49B40AD5CC87231E49040501EE1AEB1A49B4007691FCF31E49040FBBA6694B1A49B40DE09642932E49040A7E08B73B1A49B40F8A9258132E490406589794CB1A49B400FD6F6D532E490403070601FB1A49B4055C56D2733E4904027D478ECB0A49B4064DD247533E49040643202B4B0A49B40F130BBBE33E49040D1F64276B0A49B40B6F8D40334E490404F248833B0A49B40E4051C4434E49040AAF424ECAFA49B40A32D407F34E49040D07072A0AFA49B400EADF7B434E49040C301CF50AFA49B403185FFE434E49040D8FA9DFDAEA49B4098CE1B0F35E49040D91D47A7AEA49B400404183335E490409919364EAEA49B40EF43C75035E49040AB03DAF2ADA49B408588046835E49040D4CDA495ADA49B40CFD5B27835E49040ECB70A37ADA49B40DA5DBD8235E49040E8BE81D7ACA49B40AA9A178635E49040AA098177ACA49B4001020000000800000021984DA842E49040176A818499A49B4008C0261046E49040AF1F2F3294A49B40FFDD8A1E4FE490408EFFE3FD99A49B401D0B67153FE49040C5397B06B6A49B40D09E4D582CE4904060B33C54D0A49B40DA80E94923E4904081D38788CAA49B40B4609E1529E490408AB5237AC1A49B40B807BFAD2EE490405C1358BCB8A49B40010200000002000000AA9A178635E4904045423BFDF4A19B40D3E71C813CE4904045423BFDF4A19B40010200000002000000D3E71C813CE49040AA098177ACA49B40AA9A178635E49040AA098177ACA49B40010200000005000000A75DCC2941E49040A61DE5DFFBA19B40ADABCF4351E49040685D6EB6E6A19B40D315CD0A49E4904042CAF1C8DFA19B40AD82501D42E490401C60F401E8A19B40020D7B6D3BE490403675C9F1EFA19B40010200000003000000D3E71C813CE4904045423BFDF4A19B4014AD9A4640E4904045423BFDF4A19B4014AD9A4640E490408722EECB5CA29B40010200000003000000D3E71C813CE49040AA098177ACA49B4014AD9A4640E49040AA098177ACA49B4014AD9A4640E490406429CEA844A49B400102000000020000006639E7094BE49040CA29AF615DA29B4042AD9A4640E4904078433BFDF4A19B4001020000000200000043AD9A4640E4904077088177ACA49B406739E7094BE4904025220D1344A49B400102000000020000001782133007E590403D07D9CE5EA29B40A3B12C1764E490403D07D9CE5EA29B40010200000002000000A3B12C1764E49040AE44E3A542A49B401782133007E59040AE44E3A542A49B40010200000002000000AB8B517B09E59040170B3D816AA29B406F82133007E59040FB08D9CE5EA29B400102000000020000007082133007E59040F042E3A542A49B40AB8B517B09E59040D3407FF336A49B40010200000002000000FB6813B40FE5904073B4D1DD8DA29B40F36813B40FE5904036B4D1DD8DA29B40010200000002000000F36813B40FE59040B497EA9613A49B40FA6813B40FE590407B97EA9613A49B400102000000020000003C5F72E326E590407B97EA9613A49B40FA6813B40FE590407B97EA9613A49B40010200000006000000FA6813B40FE590407B97EA9613A49B40E1D214AA19E59040D8CB8CF6C5A39B40062FAFA71EE59040E14605DC77A39B40062FAFA71EE590400905B79829A39B40E1D214AA19E5904012802F7EDBA29B40FB6813B40FE5904073B4D1DD8DA29B400102000000020000003C5F72E326E5904073B4D1DD8DA29B40FB6813B40FE5904073B4D1DD8DA29B40010200000003000000ECBB7BA410E590409B861F4049909B405322E20A77E590409B861F4049909B405322E20A77E590406753EC0C56909B40010200000002000000ECBB7BA410E590406753EC0C56909B40ECBB7BA410E590409B861F4049909B400102000000020000005322E20A77E590406753EC0C56909B40ECBB7BA410E590406753EC0C56909B40010200000002000000ECBB7BA410E590403420B9D962909B40ECBB7BA410E590406753EC0C56909B400102000000020000005322E20A77E590403420B9D962909B40ECBB7BA410E590403420B9D962909B40010200000002000000E986043C55E5904042812EE494A29B40CA29B0D614E590406668A305B1A29B40010200000002000000CE29B0D614E5904087E3186FF0A39B40CB86043C55E590409BCA8D900CA49B40010200000002000000E986043C55E5904042812EE494A29B4022EF5AEA15E59040B8ABD572B9A29B40010200000002000000CB86043C55E590409BCA8D900CA49B4022EF5AEA15E5904037A0E601E8A39B40010200000002000000CE22C95C65E5904037E86AD3B0A29B402EA523C219E5904012F4D379DCA29B40010200000002000000C822C95C65E59040AF6351A1F0A39B402EA523C219E59040DC57E8FAC4A39B4001020000000200000068973FBB1AE590400CA72B32E7A29B40CE22C95C65E5904037E86AD3B0A29B40010200000002000000C822C95C65E59040AF6351A1F0A39B4068973FBB1AE59040DFA49042BAA39B40010200000002000000FD91FA5A21E59040F8FD5E856CA29B405691FA5A21E59040CAFC5E856CA29B400102000000020000005691FA5A21E59040254F5DEF34A49B400092FA5A21E59040F34D5DEF34A49B40010200000002000000DBB1FA5A21E59040A3FF5E856CA29B40FD91FA5A21E59040F8FD5E856CA29B4001020000000C0000003D5F72E326E5904070B4D1DD8DA29B402E55117227E59040FDD522C58AA29B40B5101BCA27E59040A20C8DA487A29B4083E325EB27E590404D5ED17F84A29B409D230AD527E59040A0CBB55A81A29B40FA5AE28727E5904058C800397EA29B40AB270B0427E590402BB3741E7BA29B40A8CC224A26E590409252CB0E78A29B40DB73085B25E59040D95BB10D75A29B403B22DB3724E59040EA09C21E72A29B40415FF8E122E590400AC982456FA29B40FD91FA5A21E59040F8FD5E856CA29B4001020000000C0000000092FA5A21E59040F34D5DEF34A49B40415FF8E122E59040E582392F32A49B403B22DB3724E590400542FA552FA49B40DB73085B25E5904016F00A672CA49B40A8CC224A26E590405DF9F06529A49B40AA270B0427E59040C498475626A49B40FA5AE28727E590409783BB3B23A49B409D230AD527E590404F80061A20A49B4083E325EB27E59040A2EDEAF41CA49B40B5101BCA27E590404D3F2FD019A49B402D55117227E59040F27599AF16A49B403D5F72E326E590407F97EA9613A49B400102000000020000000092FA5A21E59040F34D5DEF34A49B40DBB1FA5A21E59040484C5DEF34A49B40010200000002000000037C033524E590407F3828A688A19B40037C033524E5904093E66F8703A09B40010200000004000000037C033524E590407F3828A688A19B402CD892F719E590407F3828A688A19B402CD892F719E5904093E66F8703A09B40037C033524E5904093E66F8703A09B40010200000003000000037C033524E5904093E66F8703A09B40037C033524E59040BC42FF49F99F9B40886755ED42E59040BC42FF49F99F9B40010200000003000000886755ED42E5904056DC98E392A19B40037C033524E5904056DC98E392A19B40037C033524E590407F3828A688A19B40010200000002000000886755ED42E59040BC42FF49F99F9B408D62838268E59040BC42FF49F99F9B40010200000002000000886755ED42E5904056DC98E392A19B40886755ED42E59040BC42FF49F99F9B40010200000002000000AFAB15A7B1E5904056DC98E392A19B40886755ED42E5904056DC98E392A19B40010200000008000000138E14A243E5904041C1112705A49B40D8E659523DE59040718DF37005A49B402A4C15D03DE59040B618972E10A49B402957C31B5EE59040DBE8BA4F10A49B40B68FEA417EE59040AFB8323C0DA49B40642A2FC47DE590406F2D8F7E02A49B401F9F8B0673E59040C5924AFC02A49B408B717EA868E59040EA04A77503A49B40010200000005000000FD2C4D8F4FE59040EB6B304297A29B40269303D05DE59040182988CC7EA29B407816235C67E590407DD476BE83A29B40136B346A62E59040CF57964A8DA29B407EE447A45DE590401D6CBE8196A29B40010200000002000000CB86043C55E590409BCA8D900CA49B403688043C55E590403ACB8D900CA49B400102000000030000003688043C55E590403ACB8D900CA49B402088043C55E5904060CB8D900CA49B40CB86043C55E590409BCA8D900CA49B40010200000003000000E986043C55E5904042812EE494A29B402088043C55E590408F802EE494A29B403488043C55E59040B2802EE494A29B400102000000020000003488043C55E59040B2802EE494A29B40E986043C55E5904042812EE494A29B400102000000020000003488043C55E59040B2802EE494A29B40C06AC31E57E59040A256522898A29B400102000000020000001591043C55E59040D17C2EE494A29B403488043C55E59040B2802EE494A29B400102000000020000003688043C55E590403ACB8D900CA49B401A91043C55E590401CCF8D900CA49B40010200000002000000C06AC31E57E590404DF5694C09A49B403688043C55E590403ACB8D900CA49B40010200000008000000C0148C2456E59040247DEE5CBCA29B406D95AA3C53E59040BC9322F9C1A29B40B618CAC85CE59040223F11EBC6A29B40CE50540B6DE590400CD59D03ABA29B40131D62747AE59040492B54A28DA29B40C69942E870E59040E37F65B088A29B4065EE53F66BE590403503853C92A29B40D067673067E590408317AD739BA29B40010200000002000000C06AC31E57E59040A256522898A29B40BC6AC31E57E59040A456522898A29B40010200000002000000BC6AC31E57E590404BF5694C09A49B40C06AC31E57E590404DF5694C09A49B40010200000002000000C06AC31E57E59040A256522898A29B405411469C5AE59040964DED339EA29B4001020000002E00000020410A7A63E590409611478FADA29B404C99483564E59040B05D461AADA29B405CC8E8E764E590404BE57E98ACA29B40D6050C9165E59040ED84920AACA29B40A55EDF2F66E590408D3E3271ABA29B4031BC9CC366E59040D15C1DCDAAA29B4070DB8B4B67E590407A84201FAAA29B40B13203C767E5904027B51468A9A29B4016C5683568E59040B23ADEA8A8A29B409CE2329668E5904071906BE2A7A29B40D8D3E8E868E59040CD37B415A7A29B408270232D69E590408A83B743A6A29B4024A08D6269E590405B597B6DA5A29B4036C4E48869E590403CEB0A94A4A29B40370BF99F69E59040356A75B8A3A29B404EACADA769E590401AB4CCDBA2A29B40360BF99F69E5904000FE23FFA1A29B4036C4E48869E59040F97C8E23A1A29B4023A08D6269E59040DB0E1E4AA0A29B408170232D69E59040ACE4E1739FA29B40D6D3E8E868E590406930E5A19EA29B409AE2329668E59040C4D72DD59DA29B4014C5683568E59040842DBB0E9DA29B40AE3203C767E590400EB3844F9CA29B406DDB8B4B67E59040BCE378989BA29B402EBC9CC366E59040650B7CEA9AA29B40A15EDF2F66E59040AA2967469AA29B40D2050C9165E590404AE306AD99A29B4058C8E8E764E59040EC821A1F99A29B404899483564E59040870A539D98A29B401C410A7A63E59040A156522898A29B40D94717B762E590406D54AAC097A29B40C8D162ED61E59040CB4BDC6697A29B403C70E81D61E590400B3E581B97A29B40CAE7AA4960E590403C5A7CDE96A29B4093EDB2715FE59040B58794B096A29B4018DD0D975EE590406707DA9196A29B405168CCBA5DE590407A2C738296A29B40864301DE5CE590407A2C738296A29B40BFCEBF015CE590406807DA9196A29B4044BE1A275BE59040B68794B096A29B400DC4224F5AE590403D5A7CDE96A29B409C3BE57A59E590400C3E581B97A29B400FDA6AAB58E59040CD4BDC6697A29B40FF63B6E157E590406F54AAC097A29B40C06AC31E57E59040A256522898A29B4001020000002E000000C06AC31E57E590404DF5694C09A49B40FF63B6E157E5904080F711B409A49B400FDA6AAB58E590402200E00D0AA49B409C3BE57A59E59040E30D64590AA49B400DC4224F5AE59040B2F13F960AA49B4044BE1A275BE5904039C427C40AA49B40BFCEBF015CE590408744E2E20AA49B40864301DE5CE59040751F49F20AA49B405168CCBA5DE59040751F49F20AA49B4018DD0D975EE590408844E2E20AA49B4093EDB2715FE590403AC427C40AA49B40CAE7AA4960E59040B3F13F960AA49B403C70E81D61E59040E40D64590AA49B40C8D162ED61E590402400E00D0AA49B40D94717B762E5904082F711B409A49B401C410A7A63E590404EF5694C09A49B404899483564E59040684169D708A49B4058C8E8E764E5904003C9A15508A49B40D2050C9165E59040A568B5C707A49B40A15EDF2F66E590404522552E07A49B402EBC9CC366E590408A40408A06A49B406DDB8B4B67E59040336843DC05A49B40AE3203C767E59040E198372505A49B4014C5683568E590406B1E016604A49B409AE2329668E590402B748E9F03A49B40D6D3E8E868E59040861BD7D202A49B408170232D69E590404367DA0002A49B4023A08D6269E59040143D9E2A01A49B4036C4E48869E59040F6CE2D5100A49B40360BF99F69E59040EF4D9875FFA39B404EACADA769E59040D597EF98FEA39B40370BF99F69E59040BAE146BCFDA39B4036C4E48869E59040B360B1E0FCA39B4024A08D6269E5904094F24007FCA39B408270232D69E5904065C80431FBA39B40D8D3E8E868E590402214085FFAA39B409CE2329668E590407EBB5092F9A39B4016C5683568E590403D11DECBF8A39B40B13203C767E59040C896A70CF8A39B4070DB8B4B67E5904075C79B55F7A39B4031BC9CC366E590401EEF9EA7F6A39B40A55EDF2F66E59040620D8A03F6A39B40D6050C9165E5904002C7296AF5A39B405CC8E8E764E59040A4663DDCF4A39B404C99483564E590403FEE755AF4A39B4020410A7A63E59040593A75E5F3A39B400102000000020000005411469C5AE5904058FECE4003A49B40C06AC31E57E590404DF5694C09A49B400102000000020000005411469C5AE59040964DED339EA29B405111469C5AE59040984DED339EA29B400102000000020000005111469C5AE5904057FECE4003A49B405411469C5AE5904058FECE4003A49B400102000000020000005411469C5AE59040964DED339EA29B408B9A87FC5FE59040A21AAC83A7A29B4001020000002E0000008B9A87FC5FE59040A21AAC83A7A29B40D189FE4D60E59040997EC450A7A29B40E0A1B59B60E59040D7DC4D18A7A29B406DF54BE560E5904044A18EDAA6A29B4031BD652A61E59040C1CED397A6A29B405FCAAC6A61E590401C9F7050A6A29B401FF2D0A561E59040421BBE04A6A29B408A7188DB61E5904035AC1AB5A5A29B40AD49900B62E590404AA5E961A5A29B401393AC3562E590404BC8920BA5A29B407FC8A85962E590400BC481B2A4A29B406B08587762E590401DAE2557A4A29B40014D958E62E590404678F0F9A3A29B404A9A439F62E590405E62569BA3A29B4055224EA962E590405A69CD3BA3A29B40255FA8AC62E590401CB4CCDBA2A29B4055224EA962E59040DEFECB7BA2A29B404A9A439F62E59040DA05431CA2A29B40004D958E62E59040F2EFA8BDA1A29B406A08587762E590401BBA7360A1A29B407FC8A85962E590402DA41705A1A29B401293AC3562E59040ED9F06ACA0A29B40AC49900B62E59040EEC2AF55A0A29B40897188DB61E5904003BC7E02A0A29B401DF2D0A561E59040F64CDBB29FA29B405ECAAC6A61E590401CC928679FA29B4030BD652A61E590407899C51F9FA29B406BF54BE560E59040F5C60ADD9EA29B40DEA1B59B60E59040628B4B9F9EA29B40CF89FE4D60E59040A0E9D4669EA29B40899A87FC5FE59040974DED339EA29B40726EB6A75FE590406234D4069EA29B4058CEF44F5FE5904020DDC1DF9DA29B40812DB0F55EE59040CC02E7BE9DA29B40272159995EE59040779F6CA49DA29B400DD4623B5EE590402EB973909DA29B40E27642DC5DE59040C83815839DA29B4010AE6E7C5DE59040D6CA617C9DA29B40CAFD5E1C5DE59040D6CA617C9DA29B40F8348BBC5CE59040C83815839DA29B40CDD76A5D5CE590402EB973909DA29B40B38A74FF5BE59040779F6CA49DA29B40597E1DA35BE59040CC02E7BE9DA29B4082DDD8485BE5904021DDC1DF9DA29B40683D17F15AE590406334D4069EA29B405411469C5AE59040964DED339EA29B4001020000002E0000005411469C5AE5904058FECE4003A49B40683D17F15AE590408C17E86D03A49B4082DDD8485BE59040CE6EFA9403A49B40597E1DA35BE590402349D5B503A49B40B38A74FF5BE5904078AC4FD003A49B40CDD76A5D5CE59040C19248E403A49B40F8348BBC5CE590402713A7F103A49B40CAFD5E1C5DE5904019815AF803A49B4010AE6E7C5DE5904019815AF803A49B40E27642DC5DE590402713A7F103A49B400DD4623B5EE59040C19248E403A49B40272159995EE5904078AC4FD003A49B40812DB0F55EE590402349D5B503A49B4058CEF44F5FE59040CF6EFA9403A49B40726EB6A75FE590408D17E86D03A49B40899A87FC5FE5904058FECE4003A49B40CF89FE4D60E590404F62E70D03A49B40DEA1B59B60E590408DC070D502A49B406BF54BE560E59040FA84B19702A49B4030BD652A61E5904077B2F65402A49B405ECAAC6A61E59040D382930D02A49B401DF2D0A561E59040F9FEE0C101A49B40897188DB61E59040EC8F3D7201A49B40AC49900B62E5904001890C1F01A49B401293AC3562E5904002ACB5C800A49B407FC8A85962E59040C2A7A46F00A49B406A08587762E59040D491481400A49B40004D958E62E59040FD5B13B7FFA39B404A9A439F62E5904015467958FFA39B4055224EA962E59040114DF0F8FEA39B40255FA8AC62E59040D397EF98FEA39B4055224EA962E5904095E2EE38FEA39B404A9A439F62E5904091E965D9FDA39B40014D958E62E59040A9D3CB7AFDA39B406B08587762E59040D29D961DFDA39B407FC8A85962E59040E4873AC2FCA39B401393AC3562E59040A4832969FCA39B40AD49900B62E59040A5A6D212FCA39B408A7188DB61E59040BA9FA1BFFBA39B401FF2D0A561E59040AD30FE6FFBA39B405FCAAC6A61E59040D3AC4B24FBA39B4031BD652A61E590402E7DE8DCFAA39B406DF54BE560E59040ABAA2D9AFAA39B40E0A1B59B60E59040186F6E5CFAA39B40D189FE4D60E5904056CDF723FAA39B408B9A87FC5FE590404D3110F1F9A39B40010200000002000000B223C95C65E590405A6451A1F0A39B405411469C5AE5904058FECE4003A49B40010200000002000000B98848715DE5904094C64315ED869B40B98848715DE89040B80668EA10889B40010200000002000000B98848715DE5904094C64315ED869B40B98848715DE890406F861F40C9859B400102000000020000008B9A87FC5FE59040A21AAC83A7A29B40B223C95C65E5904091E76AD3B0A29B4001020000000500000018159C7960E5904082863BE6ECA39B40B65FB8C87CE59040EE164803EDA39B400DC573467DE590402EA2EBC0F7A39B40CD39D08872E590408507A73EF8A39B40390CC32A68E59040A57903B8F8A39B40010200000003000000C822C95C65E59040AF6351A1F0A39B40C123C95C65E590403F6451A1F0A39B40B223C95C65E590405A6451A1F0A39B40010200000002000000B223C95C65E590405A6451A1F0A39B40C822C95C65E59040AF6351A1F0A39B40010200000002000000CE22C95C65E5904037E86AD3B0A29B40B223C95C65E5904091E76AD3B0A29B40010200000003000000B223C95C65E5904091E76AD3B0A29B40C123C95C65E59040ABE76AD3B0A29B40CE22C95C65E5904037E86AD3B0A29B40010200000002000000B223C95C65E5904091E76AD3B0A29B401C28C95C65E590405AE46AD3B0A29B400102000000020000001C28C95C65E59040916751A1F0A39B40B223C95C65E590405A6451A1F0A39B40010200000002000000552F504F35E69040D1F0462B74A49B408D62838268E59040BC42FF49F99F9B40010200000018000000E9F1457891E5904060B33C54D09F9B40891CB3AC8EE59040FD8CAE6CD09F9B402A6176E48BE5904085ECE6B5D09F9B405ADEE12289E59040E06C8E2FD19F9B4085C03F6B86E5904078D913D9D19F9B40BB54CEC083E5904091DBACB1D29F9B40A829BC2681E59040C7EB56B8D39F9B40564324A07EE59040A286D8EBD49F9B403E660A307CE59040CDA2C24AD69F9B401D7E57D979E590402B6772D3D79F9B40D324D69E77E59040C81E1384D99F9B40724D2F8375E590404968A05ADB9F9B407617E78873E59040459EE854DD9F9B40F5CD59B271E59040A6758F70DF9F9B405816B90170E59040F0CE10ABE19F9B40FA5109796EE5904011B7C301E49F9B40CF351F1A6DE590402994DD71E69F9B40F49A9DE66BE590407B7A75F8E89F9B40BE8AF3DF6AE590408EA58792EB9F9B40A5885A076AE590405811F93CEE9F9B400D1CD55D69E590402D2F9BF4F09F9B40B29B2DE468E59040FDB12FB6F39F9B402A3CF59A68E590405C6D6C7EF69F9B408D62838268E59040BC42FF49F99F9B400102000000020000008655153EAAE7904001ED85A62F909B405322E20A77E5904001ED85A62F909B400102000000020000005322E20A77E59040CEB952733C909B405322E20A77E5904001ED85A62F909B400102000000040000005322E20A77E5904001ED85A62F909B40ECBB7BA410E5904001ED85A62F909B40ECBB7BA410E590409A861F4049909B405322E20A77E590409A861F4049909B400102000000020000008655153EAAE79040CEB952733C909B405322E20A77E59040CEB952733C909B400102000000020000005322E20A77E590409A861F4049909B405322E20A77E59040CEB952733C909B400102000000020000005322E20A77E590409A861F4049909B408655153EAAE790409B861F4049909B400102000000020000001FEFAED743E690406753EC0C56909B405322E20A77E590406753EC0C56909B400102000000020000005322E20A77E590406753EC0C56909B405322E20A77E590403420B9D962909B400102000000020000005322E20A77E590403420B9D962909B401FEFAED743E690403420B9D962909B400102000000020000005F06F4BF72E8904060B33C54D09F9B40E9F1457891E5904060B33C54D09F9B40010200000007000000E9F1457891E5904060B33C54D09F9B40584FAAF9FEE3904060B33C54D09F9B4073E39E7DFDE39040B26B5BD9BB9F9B4073E39E7DFDE3904004247A5EA79F9B404EB461949BE8904004247A5EA79F9B404EB461949BE8904060B33C54D09F9B405F06F4BF72E8904060B33C54D09F9B40010200000018000000522F504F35E69040EAF0462B74A49B4035028B1735E6904074E42DB976A49B40976B680D35E69040018B604979A49B4047FFF43035E690408A91B0D87BA49B40B39F048235E6904044BEF0637EA49B40A0B4320036E69040D2E1F8E780A49B4006A8E2AA36E6904034C2A96183A49B405CA8408137E6904098FAF0CD85A49B407BAF428238E6904041CBCC2988A49B40B7CCA9AC39E69040C2D44F728AA49B40B3B003FF3AE69040F4B9A4A48CA49B40E778AC773CE690401AA411BE8EA49B40B3B8D0143EE69040E6A4FBBB90A49B406DBD6FD43FE690401CF2E99B92A49B40A20A5EB441E69040D5F6885B94A49B406F0B48B243E69040A036ADF895A49B4095F5B4CB45E69040D3FE557197A49B40C7DA09FE47E69040CFE2AFC398A49B4049E48C464AE690400B0017EE99A49B40F2B468A24CE69040290719EF9AA49B4056EDAF0E4FE690407F0777C59BA49B40B8CD608851E69040E4FA26709CA49B4046F1680C54E69040D00F55EE9CA49B4026CBC6A355E690402D8009219DA49B40010200000002000000C2DCF96244E69040DBC7EA9BB1A49B4039458B5041E69040DBC7EA9BB1A49B4001020000000200000039458B5041E69040DBC7EA9BB1A49B4039458B5041E69040B26B5BD9BBA79B4001020000000400000039458B5041E69040DBC7EA9BB1A49B4043723DEE30E69040DBC7EA9BB1A49B4043723DEE30E690402D8009219DA49B4026CBC6A355E690402D8009219DA49B40010200000002000000C2DCF96244E69040B26B5BD9BBA79B4039458B5041E69040B26B5BD9BBA79B400102000000040000001FEFAED743E690409B861F4049909B408655153EAAE690409B861F4049909B408655153EAAE690403420B9D962909B401FEFAED743E690403420B9D962909B400102000000020000001FEFAED743E690406753EC0C56909B401FEFAED743E690409B861F4049909B400102000000020000001FEFAED743E690403420B9D962909B401FEFAED743E690406753EC0C56909B40010200000002000000AE2EB28149E69040DBC7EA9BB1A49B40C2DCF96244E69040DBC7EA9BB1A49B40010200000002000000C2DCF96244E69040DBC7EA9BB1A49B40C2DCF96244E69040B26B5BD9BBA79B40010200000002000000AE2EB28149E69040B26B5BD9BBA79B40C2DCF96244E69040B26B5BD9BBA79B4001020000000200000099806AA04EE69040DBC7EA9BB1A49B40AE2EB28149E69040DBC7EA9BB1A49B40010200000002000000AE2EB28149E69040DBC7EA9BB1A49B40AE2EB28149E69040B26B5BD9BBA79B4001020000000200000099806AA04EE69040B26B5BD9BBA79B40AE2EB28149E69040B26B5BD9BBA79B400102000000020000007024DBDD58E69040DBC7EA9BB1A49B4099806AA04EE69040DBC7EA9BB1A49B4001020000000200000099806AA04EE69040DBC7EA9BB1A49B4099806AA04EE69040B26B5BD9BBA79B400102000000020000007024DBDD58E69040B26B5BD9BBA79B4099806AA04EE69040B26B5BD9BBA79B40010200000003000000D39FB34CBAE790402D8009219DA49B40B1BE12455EE690402D8009219DA49B4026CBC6A355E690402D8009219DA49B4001020000000500000026CBC6A355E690402D8009219DA49B40001EA99756E690403BB0643F9DA49B408A24F92659E69040EB43F1629DA49B4017CB2BB75BE690404CADCE589DA49B40A1BE12455EE690402F8009219DA49B40010200000002000000D95FBA2D66E69040DBC7EA9BB1A49B407024DBDD58E69040DBC7EA9BB1A49B400102000000020000007024DBDD58E69040DBC7EA9BB1A49B407024DBDD58E69040B26B5BD9BBA79B40010200000002000000D95FBA2D66E69040B26B5BD9BBA79B407024DBDD58E69040B26B5BD9BBA79B4001020000000200000029ED519C78E69040DBC7EA9BB1A49B40D95FBA2D66E69040DBC7EA9BB1A49B40010200000002000000D95FBA2D66E69040DBC7EA9BB1A49B40D95FBA2D66E69040B26B5BD9BBA79B4001020000000200000029ED519C78E69040B26B5BD9BBA79B40D95FBA2D66E69040B26B5BD9BBA79B40010200000002000000D33433178DE69040DBC7EA9BB1A49B4029ED519C78E69040DBC7EA9BB1A49B4001020000000200000029ED519C78E69040DBC7EA9BB1A49B4029ED519C78E69040B26B5BD9BBA79B40010200000002000000D33433178DE69040B26B5BD9BBA79B4029ED519C78E69040B26B5BD9BBA79B40010200000002000000857C1492A1E69040DBC7EA9BB1A49B40D33433178DE69040DBC7EA9BB1A49B40010200000002000000D33433178DE69040DBC7EA9BB1A49B40D33433178DE69040B26B5BD9BBA79B40010200000002000000857C1492A1E69040B26B5BD9BBA79B40D33433178DE69040B26B5BD9BBA79B400102000000020000002FC4F50CB6E69040DBC7EA9BB1A49B40857C1492A1E69040DBC7EA9BB1A49B40010200000002000000857C1492A1E69040DBC7EA9BB1A49B40857C1492A1E69040B26B5BD9BBA79B400102000000020000002FC4F50CB6E69040B26B5BD9BBA79B40857C1492A1E69040B26B5BD9BBA79B40010200000002000000DD0BD787CAE69040DBC7EA9BB1A49B402FC4F50CB6E69040DBC7EA9BB1A49B400102000000020000002FC4F50CB6E69040DBC7EA9BB1A49B402FC4F50CB6E69040B26B5BD9BBA79B40010200000002000000DD0BD787CAE69040B26B5BD9BBA79B402FC4F50CB6E69040B26B5BD9BBA79B400102000000190000001582D59EC3E690409B42F7F16CA09B40106B57F3ECE690409048DA1769A09B4010071DEDEEE690405F39D7D668A09B405E461EE1F0E6904013CEB47268A09B40068DEBCCF2E6904012EAEFEB67A09B402B7A1FAEF4E6904018A3304367A09B400DE56182F6E690408E6F497966A09B408AC96A47F8E690400D20368F65A09B40892005FBF9E6904050A51A8664A09B40A6A0119BFBE6904015A4415F63A09B40D0638925FDE69040BFD81A1C62A09B40726E8098FEE69040AE4C39BE60A09B40101528F2FFE69040965F51475FA09B404D3DD13001E790403CA736B95DA09B40A177EE5202E790404FA8D9155CA09B40FFEE155703E79040206B455F5AA09B40212C033C04E790404FEF9C9758A09B4036AA980005E79040968118C156A09B40F83AE1A305E79040FAF602DE54A09B407938112506E79040E9D0B6F052A09B402383878306E79040C44D9BFB50A09B40A64ACEBE06E790408C6921014FA09B40EFA09BD606E7904063D2C0034DA09B4057D6D1CA06E79040B7D4F4054BA09B4082BA28B306E79040CF0B17084AA09B4001020000004700000082BA28B306E79040CF0B17084AA09B40AD9E7F9B06E79040EC42390A49A09B40DFFEDF4806E79040575C071347A09B405D035AD305E7904076B7D22245A09B40943F803B05E790403433063C43A09B401E17108204E7904010F3006141A09B408FD1F0A703E79040DD6913943FA09B40FC7932AE02E79040E0767CD73DA09B40B68B0C9601E79040D098662D3CA09B40CB6DDC6000E79040483AE5973AA09B403FBF2310FFE69040F91AF21839A09B40187686A5FDE69040E8D86AB237A09B409DD3C822FCE69040BD9C0E6636A09B403F30CD89FAE690400FEC7B3535A09B400AA291DCF8E6904067A42E2234A09B4073802D1DF7E6904079217E2D33A09B40ACC8CE4DF5E69040E8909B5832A09B40B465B770F3E69040A97590A431A09B40905F3A88F1E69040D95C3D1231A09B4029F5B896EFE69040B0C558A230A09B4076A49F9EEDE69040E53D6E5530A09B40922463A2EBE690409FB3DD2B30A09B40A2557DA4E9E69040D1FDDA2530A09B403A2A6AA7E7E69040929B6D4330A09B403F41E852BEE690409E958A1D34A09B408BF31364BCE69040AEDBC35C34A09B404E7BB77ABAE69040CC189CBD34A09B404BF11A99B8E6904032B59F3F35A09B40442E7DC1B6E69040E38133E235A09B40DD1C11F6B4E69040E37195A436A09B40B119FB38B3E69040D681DD8537A09B40D1644E8CB1E69040EDCCFE8438A09B40AAA70AF2AFE69040DACDC8A039A09B405092196CAEE6904048CAE8D73AA09B4002934CFCACE690402A67EB283CA09B409BAA5AA4ABE69040F9633E923DA09B409F60DE65AAE69040D17A32123FA09B402FD95342A9E690403A63FDA640A09B40570F173BA8E6904026F5BB4E42A09B40B0356251A7E690409F69740744A09B40593F4C86A6E690407DB618CF45A09B400993C7DAA5E69040410289A347A09B40B4E9A04FA5E690403D2D968249A09B40385A7EE5A4E69040EA6C046A4BA09B401793DE9CA4E690406CF68D574DA09B4048431876A4E69040F8B4E5484FA09B40BEB25971A4E69040F508BA3B51A09B402B8BA88EA4E69040878CB72D53A09B403BD1E1CDA4E690403BDA8B1C55A09B40590EBA2EA5E690407852E80557A09B40BFAABDB0A5E690407CDC84E758A09B4070775153A6E69040829F22BF5AA09B407067B315A7E69040E9B08E8A5CA09B406377FBF6A7E6904015B4A4475EA09B407AC21CF6A8E69040F66851F45FA09B4067C3E611AAE690401D26958E61A09B40D5BF0649ABE69040763B861463A09B40B85C099AACE69040C53A538464A09B4086595C03AEE690402B2345DC65A09B405E705083AFE69040286DC11A67A09B40C8581B18B1E6904097F44B3E68A09B40B3EAD9BFB2E690406FBE884569A09B402D5F9278B4E6904016983D2F6AA09B400AAC3640B6E690406D8E53FA6AA09B40CFF7A614B8E69040BE3AD8A56BA09B40CA22B4F3B9E6904012E4FE306CA09B40776222DBBBE690408E73219B6CA09B40F9EBABC8BDE69040AF3AC1E36CA09B4085AA03BABFE690407E8A870A6DA09B4082FED7ACC1E69040081B460F6DA09B401582D59EC3E690409C42F7F16CA09B400102000000020000008B53B802DFE69040DBC7EA9BB1A49B40DD0BD787CAE69040DBC7EA9BB1A49B40010200000002000000DD0BD787CAE69040DBC7EA9BB1A49B40DD0BD787CAE69040B26B5BD9BBA79B400102000000020000008B53B802DFE69040B26B5BD9BBA79B40DD0BD787CAE69040B26B5BD9BBA79B40010200000002000000399B997DF3E69040DBC7EA9BB1A49B408B53B802DFE69040DBC7EA9BB1A49B400102000000020000008B53B802DFE69040DBC7EA9BB1A49B408B53B802DFE69040B26B5BD9BBA79B40010200000002000000399B997DF3E69040B26B5BD9BBA79B408B53B802DFE69040B26B5BD9BBA79B4001020000000200000011E0A356E3E69040DCE864AA30A09B40AFF9B39DE5E6904023FA5E1A49A09B400102000000020000004A07815BE6E690409284D70E51A09B40E72091A2E8E69040D995D17E69A09B400102000000050000004A07815BE6E690409284D70E51A09B408FC1B5B4DCE6904045471FF551A09B40F2B3E8F6DBE69040D6BCA6004AA09B4071851D80FAE69040B693142847A09B403F0C04DFFAE69040EDD850224BA09B400102000000030000003F0C04DFFAE69040EDD850224BA09B400E93EA3DFBE69040251E8D1C4FA09B404A07815BE6E690409284D70E51A09B40010200000002000000E7E27AF807E79040DBC7EA9BB1A49B40399B997DF3E69040DBC7EA9BB1A49B40010200000002000000399B997DF3E69040DBC7EA9BB1A49B40399B997DF3E69040B26B5BD9BBA79B40010200000002000000E7E27AF807E79040B26B5BD9BBA79B40399B997DF3E69040B26B5BD9BBA79B400102000000020000003F0C04DFFAE69040EDD850224BA09B4082BA28B306E79040CF0B17084AA09B4001020000000200000082BA28B306E79040CF0B17084AA09B40242197B706E79040A451AD074AA09B40010200000002000000992A5C731CE79040DBC7EA9BB1A49B40E7E27AF807E79040DBC7EA9BB1A49B40010200000002000000E7E27AF807E79040DBC7EA9BB1A49B40E7E27AF807E79040B26B5BD9BBA79B40010200000002000000992A5C731CE79040B26B5BD9BBA79B40E7E27AF807E79040B26B5BD9BBA79B4001020000000200000043723DEE30E79040DBC7EA9BB1A49B40992A5C731CE79040DBC7EA9BB1A49B40010200000002000000992A5C731CE79040DBC7EA9BB1A49B40992A5C731CE79040B26B5BD9BBA79B4001020000000200000043723DEE30E79040B26B5BD9BBA79B40992A5C731CE79040B26B5BD9BBA79B40010200000002000000F1B91E6945E79040DBC7EA9BB1A49B4043723DEE30E79040DBC7EA9BB1A49B4001020000000200000043723DEE30E79040DBC7EA9BB1A49B4043723DEE30E79040B26B5BD9BBA79B40010200000002000000F1B91E6945E79040B26B5BD9BBA79B4043723DEE30E79040B26B5BD9BBA79B400102000000020000009F0100E459E79040DBC7EA9BB1A49B40F1B91E6945E79040DBC7EA9BB1A49B40010200000002000000F1B91E6945E79040DBC7EA9BB1A49B40F1B91E6945E79040B26B5BD9BBA79B400102000000020000009F0100E459E79040B26B5BD9BBA79B40F1B91E6945E79040B26B5BD9BBA79B400102000000020000004D49E15E6EE79040DBC7EA9BB1A49B409F0100E459E79040DBC7EA9BB1A49B400102000000020000009F0100E459E79040DBC7EA9BB1A49B409F0100E459E79040B26B5BD9BBA79B400102000000020000004D49E15E6EE79040B26B5BD9BBA79B409F0100E459E79040B26B5BD9BBA79B40010200000002000000D39FB34CBAE79040DBC7EA9BB1A49B404D49E15E6EE79040DBC7EA9BB1A49B400102000000020000004D49E15E6EE79040DBC7EA9BB1A49B404D49E15E6EE79040B26B5BD9BBA79B40010200000002000000143F0ABB7DE89040B26B5BD9BBA79B404D49E15E6EE79040B26B5BD9BBA79B40010200000002000000332AA5D198E79040FD7DA69D38A09B40342AA5D198E79040FD7DA69D38A09B40010200000003000000342AA5D198E79040FD7DA69D38A09B4021CAE542C3E79040F7CD566642A09B402015B815EEE790408A11F086D4A09B40010200000002000000342AA5D198E79040FD7DA69D38A09B406BA7837D16E89040989D3272E5A19B40010200000004000000067CEA26B4E79040314A3281E5A09B4003E8515B7DE79040F3399F862AA09B405D0E29D892E79040D20E913A24A09B40342AA5D198E79040FD7DA69D38A09B400102000000020000008655153EAAE7904001ED85A62F909B40ECBB7BA410E8904001ED85A62F909B400102000000020000008655153EAAE79040CEB952733C909B408655153EAAE7904001ED85A62F909B400102000000020000008655153EAAE790409B861F4049909B408655153EAAE79040CEB952733C909B40010200000002000000ECBB7BA410E890409B861F4049909B408655153EAAE790409B861F4049909B400102000000040000006BA7837D16E89040989D3272E5A19B4042C3FF761CE89040C30C48D5F9A19B40E89C28FA06E89040E437562100A29B40067CEA26B4E79040314A3281E5A09B40010200000032000000E508902ED0E79040A627C32645A19B40FDF0FB1DCDE79040BA1AB00C46A19B4087A93A8BCCE7904088334E3246A19B40E2C83FF6CBE79040AA07D24D46A19B403C21BD5FCBE79040AEBF1A5F46A19B40675866C8CAE7904046BA136646A19B406311F030CAE79040EBA4B46246A19B40C9140F9AC9E79040C785015546A19B4002797704C9E79040ECB60A3D46A19B404FCBDB70C8E79040CAD2EC1A46A19B40B23AECDFC7E790401392D0EE45A19B409EC55552C7E79040199BEAB845A19B407D6BC1C8C6E79040F8427B7945A19B40FA62D343C6E79040D140CE3045A19B40FE552AC4C5E7904065533ADF44A19B4052A45E4AC5E790408CD9208544A19B40BCAD01D7C4E79040035EED2244A19B407D249D6AC4E79040041715B943A19B40F768B205C4E790406A5A164843A19B4040EFB9A8C3E79040E10678D042A19B4059AF2254C3E79040EAE2C85242A19B40C2A05108C3E7904074F29ECF41A19B40F141A1C5C2E79040CBC3964741A19B404F2C618CC2E79040BCB452BB40A19B4037B5D55CC2E79040CA307A2B40A19B402E7A2035ABE790400B794528F1A09B405F61820FABE7904096318495F0A09B403D8DFEF3AAE79040F0508900F0A09B403AD5B5E2AAE790404AA9066AEFA09B40A1DABCDBAAE7904075E0AFD2EEA09B40FCEF1BDFAAE790407199393BEEA09B40200FCFECAAE79040D79C58A4EDA09B40FCDDC504ABE790401001C10EEDA09B401DC2E326ABE790405E53257BECA09B40D4020053ABE79040C1C235EAEBA09B40CFF9E588ABE79040AC4D9F5CEBA09B40EF5155C8ABE790408BF30AD3EAA09B4016540211ACE7904008EB1C4EEAA09B4083419662ACE790400CDE73CEE9A09B405BBBAFBCACE79040602CA854E9A09B40E536E31EADE79040CA354BE1E8A09B40E47DBB88ADE790408BACE674E8A09B407D3ABAF9ADE7904006F1FB0FE8A09B40068E5871AEE790404E7703B3E7A09B40FDB107EFAEE7904067376C5EE7A09B4074A23172AFE79040D0289B12E7A09B401DD139FAAFE79040FFC9EACFE6A09B402BE07D86B0E790405DB4AA96E6A09B401E645616B1E79040453D1F67E6A09B40067CEA26B4E79040314A3281E5A09B40010200000002000000D39FB34CBAE79040DBC7EA9BB1A49B40D39FB34CBAE790402D8009219DA49B40010200000003000000D39FB34CBAE790402D8009219DA49B40D39FB34CBAE790402846B93EFCA29B40A06C801987E890402846B93EFCA29B40010200000003000000143F0ABB7DE89040729E2A1CD4A49B40D39FB34CBAE79040729E2A1CD4A49B40D39FB34CBAE79040DBC7EA9BB1A49B400102000000020000001B1D1589BEE790409E7788FF92A09B40BBD6CC8FD1E790404C9C236C8DA09B40010200000002000000F3F7D855C0E7904025FCCE2399A09B4094B1905CD3E79040D3206A9093A09B40010200000002000000CBD29C22C2E79040AD8015489FA09B406C8C5429D5E790405BA5B0B499A09B40010200000002000000A4AD60EFC3E7904034055C6CA5A09B40446718F6D6E79040E229F7D89FA09B400102000000020000007C8824BCC5E79040BB89A290ABA09B401D42DCC2D8E7904069AE3DFDA5A09B400102000000020000005463E888C7E79040430EE9B4B1A09B40F51CA08FDAE79040F1328421ACA09B400102000000020000002C3EAC55C9E79040CA922FD9B7A09B40CDF7635CDCE7904078B7CA45B2A09B4001020000000200000005197022CBE79040521776FDBDA09B40A6D22729DEE79040003C116AB8A09B40010200000002000000DDF333EFCCE79040D99BBC21C4A09B407EADEBF5DFE7904087C0578EBEA09B40010200000002000000B5CEF7BBCEE7904061200346CAA09B405688AFC2E1E790400E459EB2C4A09B400102000000020000008EA9BB88D0E79040E8A4496AD0A09B402E63738FE3E7904096C9E4D6CAA09B4001020000000200000066847F55D2E790407029908ED6A09B40073E375CE5E790401D4E2BFBD0A09B400102000000020000003E5F4322D4E79040F7ADD6B2DCA09B40DF18FB28E7E79040A5D2711FD7A09B40010200000002000000163A07EFD5E790407E321DD7E2A09B40B7F3BEF5E8E790402C57B843DDA09B40010200000002000000EF14CBBBD7E7904006B763FBE8A09B4090CE82C2EAE79040B3DBFE67E3A09B40010200000002000000C7EF8E88D9E790408D3BAA1FEFA09B4068A9468FECE790403B60458CE9A09B400102000000020000009FCA5255DBE7904015C0F043F5A09B4040840A5CEEE79040C2E48BB0EFA09B4001020000000200000078A51622DDE790409C443768FBA09B40185FCE28F0E790404A69D2D4F5A09B400102000000020000005080DAEEDEE7904023C97D8C01A19B40F13992F5F1E79040D1ED18F9FBA09B40010200000002000000285B9EBBE0E79040AB4DC4B007A19B40C91456C2F3E7904058725F1D02A19B4001020000000200000000366288E2E7904032D20AD50DA19B40A1EF198FF5E79040E0F6A54108A19B40010200000002000000D9102655E4E79040BA5651F913A19B407ACADD5BF7E79040687BEC650EA19B40010200000002000000B1EBE921E6E7904041DB971D1AA19B4052A5A128F9E79040EFFF328A14A19B4001020000000200000089C6ADEEE7E79040C85FDE4120A19B402A8065F5FAE79040768479AE1AA19B4001020000000200000062A171BBE9E7904050E4246626A19B40025B29C2FCE79040FE08C0D220A19B400102000000020000003A7C3588EBE79040D7686B8A2CA19B40DB35ED8EFEE79040858D06F726A19B400102000000020000001257F954EDE790405FEDB1AE32A19B40B310B15B00E890400D124D1B2DA19B400102000000020000002015B815EEE790408A11F086D4A09B40FFA15D1D0AE89040FEEE802C34A19B4001020000001A0000002015B815EEE790408A11F086D4A09B403BB4CE75F6E790401A729912D2A09B40B0FB8F08F7E790404B59FBECD1A09B4056DC8A9DF7E79040298577D1D1A09B40FC830D34F8E7904026CD2EC0D1A09B40D14C64CBF8E790408DD235B9D1A09B40D593DA62F9E79040E8E794BCD1A09B406E90BBF9F9E790400C0748CAD1A09B40362C538FFAE79040E8D53EE2D1A09B40E8D9EE22FBE7904009BA5C04D2A09B40856ADEB3FBE79040C1FA7830D2A09B4099DF7441FCE79040BBF15E66D2A09B40BA3909CBFCE79040DB49CEA5D2A09B403E42F74FFDE79040034C7BEED2A09B40394FA0CFFDE790406F390F40D3A09B40E6006C49FEE7904047B3289AD3A09B407CF7C8BCFEE79040D12E5CFCD3A09B40BA802D29FFE79040D0753466D4A09B40403C188EFFE79040693233D7D4A09B40F8B510EBFFE79040F385D14ED5A09B40DFF5A73F00E89040E9A980CCD5A09B407604798B00E89040609AAA4FD6A09B40476329CE00E8904009C9B2D7D6A09B40E978690701E8904017D8F663D7A09B4000F0F43601E890400A5CCFF3D7A09B40DD7D88330CE89040ADCA3471FDA09B40010200000002000000EB31BD21EFE79040E671F8D238A19B408BEB742802E890409496933F33A19B40010200000002000000C30C81EEF0E790406DF63EF73EA19B4064C638F503E890401B1BDA6339A19B400102000000020000009BE744BBF2E79040F57A851B45A19B403CA1FCC105E89040A39F20883FA19B4001020000000200000073C20888F4E790407CFFCB3F4BA19B40147CC08E07E890402A2467AC45A19B400102000000020000004C9DCC54F6E790400484126451A19B40ED56845B09E89040B2A8ADD04BA19B4001020000000200000024789021F8E790408B08598857A19B40C53148280BE89040392DF4F451A19B40010200000002000000FC5254EEF9E79040128D9FAC5DA19B409D0C0CF50CE89040C0B13A1958A19B40010200000002000000D52D18BBFBE790409A11E6D063A19B4075E7CFC10EE890404836813D5EA19B4001020000000A00000090DB8A19FCE790404480B85904A19B405D0F720EFEE79040BAB8885E03A19B406301610300E890401151936602A19B40DD6F5FF801E890402CA9127501A19B40041975ED03E89040ED20418D00A19B4011BBA9E205E89040341859B2FFA09B403E1405D807E89040E4EE94E7FEA09B40C5E28ECD09E89040DE042F30FEA09B40E0E44EC30BE8904004BA618FFDA09B40DD7D88330CE89040ADCA3471FDA09B40010200000002000000AD08DC87FDE7904021962CF569A19B404EC2938E10E89040CFBAC76164A19B4001020000000200000085E39F54FFE79040A91A731970A19B40269D575B12E89040573F0E866AA19B400102000000020000005DBE632101E89040309FB93D76A19B40FE771B2814E89040DEC354AA70A19B40010200000002000000369927EE02E89040B82300627CA19B40D752DFF415E8904065489BCE76A19B400102000000020000000E74EBBA04E890403FA8468682A19B40AF2DA3C117E89040EDCCE1F27CA19B40010200000003000000FFA15D1D0AE89040FEEE802C34A19B40FFEC2FF034E8904092321A4DC6A19B406BA7837D16E89040989D3272E5A19B4001020000001A000000DD7D88330CE89040ADCA3471FDA09B400A2BAA5E18E89040C91304F726A19B40D943488418E890403E5BC58927A19B40FB17CC9F18E89040E43BC01E28A19B40FECF14B118E8904089E342B528A19B4097CA0DB818E890405FAC994C29A19B403CB5AEB418E8904063F30FE429A19B401896FBA618E89040FCEFF07A2AA19B403CC7048F18E89040C48B88102BA19B401BE3E66C18E89040763924A42BA19B4063A2CA4018E8904013CA13352CA19B4069ABE40A18E89040273FAAC22CA19B40495375CB17E8904048993E4C2DA19B402151C88217E89040CBA12CD12DA19B40B563343117E89040C7AED5502EA19B40DDE91AD716E890407360A1CA2EA19B40536EE77416E890400957FE3D2FA19B4054270F0B16E8904048E062AA2FA19B40BB6A109A15E89040CE9B4D0F30A19B403117722215E890408615466C30A19B403BF3C2A414E890406C55DDC030A19B40C402992114E890400364AE0C31A19B401BD4909913E89040D5C25E4F31A19B400DC54C0D13E8904077D89E8831A19B401A41747D12E890408E4F2AB831A19B40FFA15D1D0AE89040FEEE802C34A19B4001020000001E000000DD7D88330CE89040ADCA3471FDA09B40C7D84CB90DE89040386E6708FDA09B40B67C90AF0FE890405C817A9EFCA09B40E48E21A611E890405153D554FCA09B408DCD079D13E89040F943B22EFCA09B40E9F64A9415E8904036B34B2FFCA09B40ADC8F28B17E89040FEEEDB59FCA09B40135BF78319E89040990E84AFFCA09B405F6D1B7C1BE890401C7E3D2AFDA09B40B96216741DE89040A5A07BC2FDA09B404A9E9F6B1FE8904053D9B170FEA09B403A836E6221E89040418B532DFFA09B40B1743A5823E890408F19D4F0FFA09B40D8D5BA4C25E8904058E7A6B300A19B40D709A73F27E89040BB573F6E01A19B40D673B63029E89040D6CD101902A19B40FD76A01F2BE89040C4AC8EAC02A19B4075761C0C2DE89040A5572C2103A19B40B20BE3F52EE8904018E1786F03A19B40B4C6D9DC30E89040AA5D069403A19B403B681FC132E89040762D819003A19B40C264D6A234E89040883FEA6603A19B40C230218236E89040EA82421903A19B40B440225F38E89040A4E68AA902A19B401109FC393AE89040C259C41902A19B4053FED0123CE890404CCBEF6B01A19B40F294C3E93DE890404C2A0EA200A19B406941F6BE3FE89040CD6520BEFFA09B4031788B9241E89040D86C27C2FEA09B40F5C1C85A43E89040C888F0B5FDA09B40010200000002000000ECBB7BA410E89040CEB95273FC8F9B408655153E2AE89040CEB95273FC8F9B40010200000002000000ECBB7BA410E8904001ED85A62F909B40ECBB7BA410E89040CEB95273FC8F9B400102000000050000008655153E2AE89040CEB95273FC8F9B4020EFAED743E89040CEB95273FC8F9B4020EFAED743E89040F715E235F28F9B40ECBB7BA410E89040F715E235F28F9B40ECBB7BA410E89040CEB95273FC8F9B40010200000002000000ECBB7BA410E890409B861F4049909B40ECBB7BA410E8904001ED85A62F909B40010200000002000000ECBB7BA410E890406753EC0C96909B40ECBB7BA410E890409B861F4049909B40010200000002000000ECBB7BA410E890406753EC0C96909B408655153E2AE890406753EC0C96909B40010200000002000000ECBB7BA410E890406853EC0C96909B40ECBB7BA410E890406753EC0C96909B400102000000020000008655153E2AE890406853EC0C96909B40ECBB7BA410E890406853EC0C96909B4001020000000400000020EFAED743E890406853EC0C96909B4020EFAED743E890403EF75C4AA0909B40ECBB7BA410E890403EF75C4AA0909B40ECBB7BA410E890406853EC0C96909B400102000000030000008655153E2AE89040CEB95273FC8F9B408655153E2AE89040D2B95273FC8F9B408655153E2AE8904019BA5273FC8F9B400102000000050000008655153E2AE8904019BA5273FC8F9B409B7E71CD6CF6904019BA5273FC8F9B409B7E71CD6CF690400D20B9D962869B409B7E71CD6CF090400D20B9D962869B409B7E71CD6CF09040A053EC0C968C9B400102000000020000008655153E2AE890406753EC0C96909B408655153E2AE8904019BA5273FC8F9B400102000000030000008655153E2AE890406753EC0C96909B4020EFAED743E890406753EC0C96909B4020EFAED743E890406853EC0C96909B400102000000020000008655153E2AE890406853EC0C96909B408655153E2AE890406753EC0C96909B400102000000020000008655153E2AE890406853EC0C96909B4020EFAED743E890406853EC0C96909B4001020000005C000000F5C1C85A43E89040C888F0B5FDA09B4070BC8E9943E8904008554A0BFEA09B403D7BF79F44E89040F4775840FFA09B40FA964BBB45E8904043DD576200A19B4026B129EA46E890401ED5DE6F01A19B40BE0C182B48E8904094379D6702A19B405465867C49E89040D8075E4803A19B4050E2CFDC4AE89040A4F5081104A19B40CA233D4A4CE89040D3BAA3C004A19B40886606C34DE890408753535605A19B4073BC55454FE890404D0F5DD105A19B40A75649CF50E89040FC79273106A19B4065DEF55E52E890400F1B3B7506A19B40DCD968F253E89040AE0A439D06A19B40DC19AB8755E890408E5B0DA906A19B406D2DC31C57E8904038598B9806A19B402FD8B7AF58E89040629AD16B06A19B407D88923E5AE890403DE7172306A19B403ECA61C75BE89040E6F3B8BE05A19B404EB33B485DE8904044EF313F05A19B40894640BF5EE89040E7E621A504A19B406DCA9B2A60E89040AB0049F103A19B407510898861E89040108B872403A19B404CAA53D762E8904077E5DC3F02A19B40230A5A1564E89040A541664401A19B40778B0F4165E890400F405D3300A19B40BE61FE5866E89040B068160EFFA09B40A36AC95B67E890405582FFD5FDA09B4070E12D4868E890406ACA9D8CFCA09B40A2F1041D69E89040830F8C33FBA09B409E2645D969E89040FEB078CCF9A09B40C3B6037C6AE8904041862359F8A09B4044A875046BE8904031B05BDBF6A09B4048CEF0716BE890408A57FD54F5A09B402C9DECC36BE890400C5BEFC7F3A09B40D1D402FA6BE890403AF02036F2A09B401E00F0136CE89040BB3987A1F0A09B4029C993116CE8904053D61A0CEFA09B408721F1F26BE890408B6BD577EDA09B40A03E2EB86BE89040062FAFE6EBA09B40096A94616BE89040A8719C5AEAA09B401CA68FEF6AE890409B2F8BD5E8A09B404327AE626AE890402DA86059E7A09B4099A29FBB69E89040A300F7E7E5A09B40CA7234FB68E89040DCF41A83E4A09B4035945C2268E89040AC98892CE3A09B409A79263267E89040C62CEEE5E1A09B40CCBABD2B66E89040DA09E0B0E0A09B40109F691065E890408BA4E08EDFA09B40E3848BE163E89040B0AC5981DEA09B404C299DA062E890403A4A9B89DDA09B40B5D02E4F61E89040F679DAA8DCA09B40BA53E5EE5FE890402A8C2FE0DBA09B40401278815EE89040FBC69430DBA09B4082CFAE085DE89040482EE59ADAA09B4097795F865BE890408172DB1FDAA09B4063DF6BFC59E89040D20711C0D9A09B40A557BF6C58E89040BF66FD7BD9A09B402E5C4CD956E890402077F553D9A09B402E1C0A4455E8904040262B48D9A09B409D08F2AE53E890409628AD58D9A09B40DB5DFD1B52E890406CE76685D9A09B408DAD228D50E89040919A20CED9A09B40CC6B53044FE89040E88D7F32DAA09B40BC8279834DE890408A9206B2DAA09B4081EF740C4CE89040E79A164CDBA09B409C6B19A14AE890402381EFFFDBA09B4095252C4349E89040BEF6B0CCDCA09B40BE8B61F447E89040579C5BB1DDA09B40E62B5BB646E890402940D2ACDEA09B4093AAA58A45E89040BF41DBBDDFA09B404BD4B67244E890401E1922E3E0A09B4067CBEB6F43E8904079FF381BE2A09B409A54878342E8904064B79A64E3A09B406844B0AE41E890404B72ACBDE4A09B406C0F70F240E89040D0D0BF24E6A09B40467FB14F40E890408DFB1498E7A09B40C58D3FC73FE890409ED1DC15E9A09B40C267C4593FE89040442A3B9CEAA09B40DD98C8073FE89040C2264929ECA09B403961B2D13EE89040949117BBEDA09B40EC35C5B73EE890401348B14FEFA09B40E16C21BA3EE890407BAB1DE5F0A09B408314C4D83EE8904043166379F2A09B406AF786133FE89040C852890AF4A09B4001CC206A3FE8904026109C96F5A09B40EE8F25DC3FE890403352AD1BF7A09B40C70E076940E89040A1D9D797F8A09B407193151041E890402B814109FAA09B403FC380D041E89040F28C1D6EFBA09B40D5A158A942E8904022E9AEC4FCA09B40F5C1C85A43E89040C888F0B5FDA09B4001020000000C000000F5C1C85A43E89040C888F0B5FDA09B40C2ADA56443E89040772E24B0FDA09B409656673545E89040B399178AFCA09B4027E7F20447E89040989D0252FBA09B40EDD36AD348E890402E29E609FAA09B406291F1A04AE890407F2BC3B3F8A09B400094A96D4CE8904095939A51F7A09B403F50B5394EE890407A506DE5F5A09B40993A370550E8904037513C71F4A09B4087C751D051E89040D88408F7F2A09B40836B279B53E8904064DAD278F1A09B40059BDA6555E89040E7409CF8EFA09B4001020000000300000020EFAED743E890406853EC0C96909B4034180B6706F79040A953EC0C96909B406CD4A6C2DCF89040A953EC0C96909B4001020000000800000091D1850137F590404C05F57255A89B402A6B1F9BD0F590404C05F57255A89B402A6B1F9BD0F59040A953EC0C969C9B40C8EF7B35750F9140A953EC0C969C9B40C8EF7B35750F91406F861F40C9859B4034180B6706F790406F861F40C9859B409B7E71CD6CF090406F861F40C9859B40B98848715DE890406F861F40C9859B40010200000002000000B98848715DE890406F861F40C9859B40B98848715DE89040B80668EA10889B40010200000002000000B98848715DE89040B80668EA10889B40B98848715DE8904052A00184AA889B40010200000005000000B98848715DE8904052A00184AA889B40B98848715DE89040B4B95273FC8B9B40B98848715DE890404D53EC0C968C9B40AA36FEB26DEA90406353EC0C968C9B40AA36FEB26DEA904070636F4A6B8C9B40010200000018000000BB95B6B59BE89040BC42FF49F99F9B401EBC449D9BE890405C6D6C7EF69F9B40965C0C549BE89040FDB12FB6F39F9B403BDC64DA9AE890402D2F9BF4F09F9B40A36FDF309AE890405811F93CEE9F9B408A6D465899E890408EA58792EB9F9B40545D9C5198E890407B7A75F8E89F9B4079C21A1E97E890402994DD71E69F9B404EA630BF95E8904011B7C301E49F9B40F0E1803694E89040F0CE10ABE19F9B40532AE08592E89040A6758F70DF9F9B40D2E052AF90E89040459EE854DD9F9B40D6AA0AB58EE890404968A05ADB9F9B4075D363998CE89040C81E1384D99F9B402B7AE25E8AE890402B6772D3D79F9B400A922F0888E89040CDA2C24AD69F9B40F2B4159885E89040A286D8EBD49F9B40A0CE7D1183E89040C7EB56B8D39F9B408DA36B7780E8904091DBACB1D29F9B40C337FACC7DE8904078D913D9D19F9B40EE1958157BE89040E06C8E2FD19F9B401E97C35378E8904085ECE6B5D09F9B40BFDB868B75E89040FD8CAE6CD09F9B405F06F4BF72E8904060B33C54D09F9B40010200000002000000A06C801987E89040729E2A1CD4A49B40143F0ABB7DE89040729E2A1CD4A49B40010200000002000000143F0ABB7DE89040B26B5BD9BBA79B40143F0ABB7DE89040729E2A1CD4A49B40010200000002000000BE86EB3592E89040B26B5BD9BBA79B40143F0ABB7DE89040B26B5BD9BBA79B40010200000002000000A06C801987E890402846B93EFCA29B404EB461949BE890402846B93EFCA29B40010200000002000000A06C801987E890402846B93EFCA29B40A06C801987E89040729E2A1CD4A49B40010200000002000000A06C801987E89040729E2A1CD4A49B40BE86EB3592E89040729E2A1CD4A49B40010200000003000000BE86EB3592E89040729E2A1CD4A49B404EB461949BE89040729E2A1CD4A49B404EB461949BE890402846B93EFCA29B40010200000002000000BE86EB3592E89040B26B5BD9BBA79B40BE86EB3592E89040729E2A1CD4A49B4001020000000300000090D1850137F19040B26B5BD9BBA79B40AAD8A35497E89040B26B5BD9BBA79B40BE86EB3592E89040B26B5BD9BBA79B400102000000020000004EB461949BE890402846B93EFCA29B40BC95B6B59BE890402846B93EFCA29B40010200000002000000BC95B6B59BE89040BC42FF49F99F9B40BC95B6B59BE890402846B93EFCA29B40010200000002000000BC95B6B59BE890402846B93EFCA29B40BC95B6B59BE890402846B93EFCA39B40010200000002000000992CB9AEA7EA90400D20B9D962869B404F22E20AF7E890400D20B9D962869B400102000000020000004F22E20AF7E890400D20B9D962869B405122E20AF7E890404953EC0C96889B400102000000030000005122E20AF7E890404953EC0C96889B404F22E20AF7E890404953EC0C96889B404F22E20AF7E890400D20B9D962869B400102000000030000004F22E20AF7E890400D20B9D962869B404F22E20AF7E890400820B9D962869B40992CB9AEA7EA90400820B9D962869B400102000000020000004F22E20AF7E89040B4B95273FC8B9B405322E20AF7E89040B4B95273FC8B9B40010200000002000000952CB9AEA7EA90404953EC0C96889B405122E20AF7E890404953EC0C96889B400102000000020000005122E20AF7E890404953EC0C96889B405322E20AF7E89040B4B95273FC8B9B400102000000020000005322E20AF7E89040B4B95273FC8B9B40AA36FEB26DEA9040BCB95273FC8B9B400102000000030000005322E20AF7E89040B4B95273FC8B9B405322E20AF7E89040B8B95273FC8B9B40AA36FEB26DEA9040BCB95273FC8B9B4001020000005F0000006FB695B102EA9040BD7A845F858A9B40FF611771F4E99040E082858A918A9B40072F126DE5E99040CF47C2C09C8A9B405277EAB5D5E990402579FDF5A68A9B406F22C85CC5E990407D56121FB08A9B403CEB8373B4E99040AFD90032B88A9B4069E4930CA3E9904074A1F825BF8A9B403B51F73A91E990409F9062F3C48A9B4085E821127FE990404F17E993C98A9B408698E6A56CE99040211D7F02CD8A9B408EAB313F6BE990401171AF2CCD8A9B402B1A6FD669E990407CCE143ECD8A9B40860D556D68E990408D149A36CD8A9B4006199A0567E99040CD584816CD8A9B40A625F3A065E9904016DC46DDCC8A9B404F5F114164E99040E9DADA8BCC8A9B40BD26A0E762E9904057396722CC8A9B406C0A439661E99040E60A6CA1CB8A9B4006C9934E60E99040FEF68509CB8A9B40BA5F20125FE99040AE7A6D5BCA8A9B40DE2669E25DE990409008F697C98A9B401DFFDEC05CE9904002080DC0C88A9B407691E1AE5BE99040CAB4B8D4C78A9B401DA4BDAD5AE9904097E016D7C68A9B405286ABBE59E99040E0975BC8C58A9B400C95CDE258E99040BCABCFA9C48A9B4057DA2E1B58E990408B22CF7CC38A9B40F7C8C16857E990403C91C742C28A9B40F5155FCC56E99040505F36FDC08A9B406FB1C44656E990409CF7A6ADBF8A9B40DEDF94D855E9904005E8B055BE8A9B400B75558255E9904084F2F5F6BC8A9B407E316F4455E99040C5112093BB8A9B4049432D1F55E99040C373DF2BBA8A9B40B3EABC1255E99040E36CE8C2B88A9B40B3EABC1255E9904018043582BE899B4049432D1F55E9904038FD3D19BD899B407E316F4455E99040365FFDB1BB899B400B75558255E99040777E274EBA899B40DEDF94D855E99040F6886CEFB8899B406FB1C44656E990405F797697B7899B40F5155FCC56E99040AB11E747B6899B40F7C8C16857E99040BFDF5502B5899B4057DA2E1B58E99040704E4EC8B3899B400C95CDE258E990403FC54D9BB2899B405286ABBE59E990401BD9C17CB1899B401DA4BDAD5AE990406490066EB0899B407691E1AE5BE9904031BC6470AF899B401DFFDEC05CE99040F9681085AE899B40DE2669E25DE990406B6827ADAD899B40BA5F20125FE990404DF6AFE9AC899B4006C9934E60E99040FD79973BAC899B406C0A439661E990401566B1A3AB899B40BD26A0E762E99040A437B622AB899B404F5F114164E99040129642B9AA899B40A625F3A065E99040E594D667AA899B4006199A0567E990402E18D52EAA899B40860D556D68E990406E5C830EAA899B402B1A6FD669E990407FA20807AA899B408EAB313F6BE99040EAFF6D18AA899B408698E6A56CE99040DA539E42AA899B4085E821127FE99040AC5934B1AD899B403B51F73A91E990405CE0BA51B2899B4069E4930CA3E9904087CF241FB8899B403CEB8373B4E990404D971C13BF899B406F22C85CC5E990407E1A0B26C7899B405277EAB5D5E99040D6F71F4FD0899B40072F126DE5E990402C295B84DA899B40FF611771F4E990401BEE97BAE5899B406FB695B102EA90403EF698E5F1899B403A5F5BB503EA9040E48F81E3F2899B407A4DEDA604EA90408447CAF2F3899B400FBB228505EA9040E4D52512F5899B4005ABEA4E06EA9040A2343340F6899B40F1384D0307EA9040E04F7F7BF7899B407EC96CA107EA90402CCE86C2F8899B40AA1A872808EA904059ECB713FA899B406F32F69708EA9040146B746DFB899B40A92A31EF08EA9040CC8B13CEFC899B4047D9CC2D09EA9040821AE433FE899B40F0537C5309EA9040FB812E9DFF899B40814E116009EA9040CAE73608018A9B40814E116009EA9040E742E63C768A9B40F0537C5309EA9040B6A8EEA7778A9B4047D9CC2D09EA90402F103911798A9B40A92A31EF08EA9040E59E09777A8A9B406F32F69708EA90409CBFA8D77B8A9B40AA1A872808EA9040573E65317D8A9B407EC96CA107EA9040845C96827E8A9B40F1384D0307EA9040D1DA9DC97F8A9B4005ABEA4E06EA90400FF6E904818A9B400FBB228505EA9040CC54F732828A9B407A4DEDA604EA90402DE35252838A9B403A5F5BB503EA9040CC9A9B61848A9B406FB695B102EA90407234845F858A9B400102000000130000009A19A75104EA90405CFC532FC8869B40653E994103EA9040F1855893C6869B40EA50734E02EA9040B35CABE5C4869B409CA65A7901EA904025DD5228C3869B40CA5350C300EA9040114B685DC1869B4076F52F2D00EA90405C491587BF869B406AA8AEB7FFE99040253E91A7BD869B40B72E5A63FFE990403CA61EC1BB869B40AF449830FFE99040455B08D6B9869B402C26A61FFFE99040B8CF9EE8B7869B40AF449830FFE990402B4435FBB5869B40B72E5A63FFE9904034F91E10B4869B406AA8AEB7FFE990404B61AC29B2869B4076F52F2D00EA90401456284AB0869B40CA5350C300EA90405F54D573AE869B409CA65A7901EA90404BC2EAA8AC869B40EA50734E02EA9040BD4292EBAA869B40653E994103EA90408019E53DA9869B409A19A75104EA904014A3E9A1A7869B40010200000002000000C3B4A8A90AEA90403B3EEBF9AD869B40C2B4A8A90AEA90403A3EEBF9AD869B40010200000002000000C2B4A8A90AEA90403A3EEBF9AD869B40C2B4A8A90AEA90403B3EEBF9AD869B40010200000004000000997AC9F00AEA90401542C702A1869B40C7F2636BFDE9904043BA617D93869B40C99141CCF6E99040411B841C9A869B40C2B4A8A90AEA90403A3EEBF9AD869B40010200000003000000C2B4A8A90AEA90403A3EEBF9AD869B40C115CB4811EA90403CDDC85AA7869B40997AC9F00AEA90401542C702A1869B40010200000013000000997AC9F00AEA90401542C702A1869B4005F1C48C0CEA9040DF66B9F29F869B40421A723A0EEA9040647993FF9E869B40D099CAF70FEA904017CF7A2A9E869B40E52BB5C211EA9040447C70749D869B40992D089913EA9040F01D50DE9C869B40D1388C7815EA9040E5D0CE689C869B40B9D0FE5E17EA904031577A149C869B40B01B154A19EA9040296DB8E19B869B403DA77E371BEA9040A64EC6D09B869B40CB32E8241DEA9040296DB8E19B869B40C27DFE0F1FEA904031577A149C869B40AA1571F620EA9040E4D0CE689C869B40E220F5D522EA9040F01D50DE9C869B40962248AC24EA9040447C70749D869B40ABB4327726EA904016CF7A2A9E869B4039348B3428EA9040647993FF9E869B40775D38E229EA9040DF66B9F29F869B40E2D3337E2BEA90401442C702A1869B40010200000013000000E3D3337E2BEA90405B5D76CECE869B40785D38E229EA9040903884DECF869B403A348B3428EA90400B26AAD1D0869B40ADB4327726EA904059D0C2A6D1869B40982248AC24EA90402C23CD5CD2869B40E320F5D522EA90408081EDF2D2869B40AC1571F620EA90408CCE6E68D3869B40C47DFE0F1FEA90403F48C3BCD3869B40CC32E8241DEA9040473285EFD3869B403FA77E371BEA9040CA507700D4869B40B21B154A19EA9040473285EFD3869B40BAD0FE5E17EA90403F48C3BCD3869B40D2388C7815EA90408CCE6E68D3869B409B2D089913EA90408081EDF2D2869B40E62BB5C211EA90402D23CD5CD2869B40D199CAF70FEA90405AD0C2A6D1869B40431A723A0EEA90400C26AAD1D0869B4005F1C48C0CEA9040913884DECF869B409A7AC9F00AEA90405C5D76CECE869B40010200000064000000E7C31DD928EA90402FDDA7253C8A9B40E7C31DD928EA904033D1D71F718A9B40368574C028EA9040588CA0EE738A9B40217A967628EA904098E107BA768A9B40DE91DCFB27EA9040F67CB07E798A9B40CE8EDA5027EA9040682945397C8A9B4092545E7626EA90400ED47CE67E8A9B4029F06E6D25EA9040D9801E83818A9B403D5B4B3724EA9040C82B050C848A9B4018FC68D522EA90402692237E868A9B4015E4714921EA904025DF87D6888A9B40A4CE42951FEA904075375F128B8A9B4052E3E8BA1DEA9040951FF92E8D8A9B4031B4140E10EA90407DCEC5C89A8A9B408D9C487F01EA9040EF298E6FA78A9B40B61B5A1FF2E99040F003B114B38A9B4056861000E2E99040C01CB7AABD8A9B4080771034D1E9904019B56225C78A9B40E041C6CEBFE99040E7B5BD79CF8A9B40F2794FE4ADE990401C5D269ED68A9B404BB363899BE99040FC605A8ADC8A9B40C28B3CD388E99040FA7C8037E18A9B4048207DD775E990401E5D30A0E48A9B40B50719AC62E99040CBDE78C0E68A9B4057182BCB5DE99040629643FBE68A9B40E86FF4E858E990405DFB88EBE68A9B406E58E60954E99040A55C5791E68A9B40653C6F324FE990404CC600EDE58A9B40CE9EF6664AE99040EBB61AFFE48A9B408219D9AB45E99040A7977DC8E38A9B400001F971FEE890406E88203CCF8A9B40DC11C1C8FDE890405DB50505CF8A9B4034ECA923FDE89040A09B90C2CE8A9B4059497683FCE89040239E0F75CE8A9B40721EE3E8FBE890405127DE1CCE8A9B409FBDA654FBE890403E3D64BACD8A9B40EBFE6FC7FAE89040F706164ECD8A9B401672E541FAE89040824373D8CC8A9B40189AA4C4F9E890402DB3065ACC8A9B4060334150F9E89040EC7365D3CB8A9B408E8544E5F8E8904072512E45CB8A9B4088C12C84F8E89040E70909B0CA8A9B40A46C6C2DF8E890400A88A514CA8A9B4091D969E1F7E89040B913BB73C98A9B40ACAF7EA0F7E89040BE7907CEC88A9B403981F76AF7E89040F12B4E24C88A9B401B711341F7E89040B35A5777C78A9B4055E80323F7E89040D008EFC7C68A9B40C65BEC10F7E89040D71AE416C68A9B405422E20AF7E890401C630765C58A9B405422E20AF7E8904073CE14E0B1899B40C65BEC10F7E89040B816382EB1899B4055E80323F7E89040BF282D7DB0899B401B711341F7E89040DBD6C4CDAF899B403981F76AF7E890409E05CE20AF899B40ACAF7EA0F7E89040D1B71477AE899B4091D969E1F7E89040D61D61D1AD899B40A46C6C2DF8E8904085A97630AD899B4088C12C84F8E89040A8271395AC899B408E8544E5F8E890401CE0EDFFAB899B4060334150F9E89040A3BDB671AB899B40189AA4C4F9E89040627E15EBAA899B401672E541FAE890400DEEA86CAA899B40EBFE6FC7FAE89040982A06F7A9899B409FBDA654FBE8904051F4B78AA9899B40721EE3E8FBE890403E0A3E28A9899B4059497683FCE890406C930CD0A8899B4034ECA923FDE89040EF958B82A8899B40DC11C1C8FDE89040327C1640A8899B400001F971FEE8904020A9FB08A8899B408219D9AB45E99040E8999E7C93899B40CE9EF6664AE99040A37A014692899B40653C6F324FE99040436B1B5891899B406E58E60954E99040EAD4C4B390899B40E86FF4E858E990403236935990899B4057182BCB5DE990402D9BD84990899B40B50719AC62E99040C452A38490899B4048207DD775E9904071D4EBA492899B40C28B3CD388E9904095B49B0D96899B404BB363899BE9904093D0C1BA9A899B40F2794FE4ADE9904073D4F5A6A0899B40E041C6CEBFE99040A87B5ECBA7899B4080771034D1E99040767CB91FB0899B4056861000E2E99040CF14659AB9899B40B61B5A1FF2E990409F2D6B30C4899B408D9C487F01EA9040A0078ED5CF899B4031B4140E10EA90401263567CDC899B4052E3E8BA1DEA9040FA112316EA899B40A4CE42951FEA90401AFABC32EC899B4015E4714921EA90406A52946EEE899B4018FC68D522EA9040699FF8C6F0899B403D5B4B3724EA9040C7051739F3899B4029F06E6D25EA9040B6B0FDC1F5899B4092545E7626EA9040815D9F5EF8899B40CE8EDA5027EA90402708D70BFB899B40DE91DCFB27EA904099B46BC6FD899B40217A967628EA9040F74F148B008A9B40368574C028EA904037A57B56038A9B40E7C31DD928EA90405C604425068A9B40E7C31DD928EA90406054741F3B8A9B40010200000002000000E4D3337E2BEA90405B5D76CECE869B40E3D3337E2BEA90405B5D76CECE869B40010200000004000000E3D3337E2BEA90405B5D76CECE869B40B65B990339EA90402EE5DB53DC869B40B4BCBBA23FEA90403084B9B4D5869B40E134561D32EA90405DFC532FC8869B40010200000004000000E3D3337E2BEA90405B5D76CECE869B40BC38322625EA904034C27476C8869B40BA9954C52BEA9040366152D7C1869B40E134561D32EA90405DFC532FC8869B40010200000013000000E234561D32EA904014A3E9A1A7869B401710642D33EA90408019E53DA9869B4092FD892034EA9040BE4292EBAA869B40E0A7A2F534EA90404BC2EAA8AC869B40B2FAACAB35EA90406054D573AE869B400659CD4136EA90401556284AB0869B4012A64EB736EA90404C61AC29B2869B40C51FA30B37EA904034F91E10B4869B40CD09653E37EA90402C4435FBB5869B405028574F37EA9040B9CF9EE8B7869B40CD09653E37EA9040465B08D6B9869B40C51FA30B37EA90403DA61EC1BB869B4011A64EB736EA9040263E91A7BD869B400659CD4136EA90405D491587BF869B40B2FAACAB35EA9040124B685DC1869B40DFA7A2F534EA904026DD5228C3869B4092FD892034EA9040B45CABE5C4869B401710642D33EA9040F2855893C6869B40E134561D32EA90405DFC532FC8869B40010200000002000000AA36FEB26DEA9040BCB95273FC8B9B40AA36FEB26DEA904074B97D771D8C9B40010200000002000000AA36FEB26DEA904074B97D771D8C9B406F5C50FE7EEA904074B97D771D8C9B40010200000002000000AA36FEB26DEA904070636F4A6B8C9B40AA36FEB26DEA904074B97D771D8C9B400102000000050000006F5C50FE7EEA904074B97D771D8C9B406F5C50FE7EEA9040728EF660448C9B40526FF9A387EA9040728EF660448C9B40526FF9A387EA904070636F4A6B8C9B40AA36FEB26DEA904070636F4A6B8C9B400102000000020000005046943472EA90409E7BD98558899B40C28D146770EA9040F4252B3773899B40010200000019000000C38D146770EA9040F4252B3773899B4088BE144A71EA9040AE62FD6874899B40A215AF4172EA90404C33628A75899B40272DB44C73EA90409CFCF69976899B404FD4DC6974EA904003F76E9677899B4061A0CB9775EA904042C6947E78899B40D6980ED576EA90408BF44B5179899B40B6FC202078EA90400B4F920D7A899B40EF1E6D7779EA9040522281B27A899B406E574ED97AEA9040FF544E3F7B899B40920613447CEA9040655F4DB37B899B4080A8FEB57DEA9040F31EF00D7C899B40D4F54B2D7FEA90405F84C74E7C899B40110F2FA880EA9040BB1B84757C899B4016B0D72482EA9040D26DF6817C899B400A6973A183EA90404E3A0F747C899B40E7D92F1C85EA90406C8ADF4B7C899B40ECED3C9386EA90401B9C98097C899B404A14CF0488EA9040A3A58BAD7B899B404473216F89EA9040247229387B899B40121378D08AEA904060D701AA7A899B40E9FD21278CEA90407D05C3037A899B4078527B718DEA90408FB1384679899B407346EFAD8EEA9040031C4B7278899B409B027D748FEA9040C0226BD877899B40010200000019000000D3E22A9991EA904060293D1C58899B403E5F1BE990EA9040C558106957899B405C0306CC8FEA90403995826C56899B4020F5289E8EEA9040A8B4458455899B405317F6608DEA9040284976B154899B403017F2158CEA90403BA316F553899B402890B2BE8AEA904053950D5053899B40DC1ADC5C89EA9040F35825C352899B40BE4920F287EA9040EA960A4F52899B40C8953B8086EA9040C0934BF451899B40E23DF30885EA9040618157B351899B40781B138E83EA9040DDF67D8C51899B40066F6B1182EA9040E48EEE7F51899B4039A7CE9480EA90406EADB88D51899B4066250F1A7FEA9040E06CCBB551899B400E02FDA27DEA9040C4B2F5F751899B4032D463317CEA9040EE6BE65352899B402E7E08C77AEA9040D8EF2CC952899B40C602A76579EA9040AD8A395753899B401265F00E78EA90405D2D5EFD53899B40F29588C476EA9040E842CFBA54899B407271048875EA9040D1A9A48E55899B40B8CEE75A74EA90408FD0DA7756899B40C2A4A33E73EA90409CF3537557899B405246943472EA90409E7BD98558899B400102000000030000006F5C50FE7EEA904074B97D771D8C9B40B72F25D1A5EA904029C5B916208C9B40E0BBCF80D4EA9040B5A5DFD06C899B400102000000020000006F5C50FE7EEA904074B97D771D8C9B403C9871F3ABEA9040B4102FCA83899B400102000000020000009B027D748FEA9040C0226BD877899B40F20A38748FEA9040715268DC77899B40010200000002000000D3E22A9991EA904060293D1C58899B409B027D748FEA9040C0226BD877899B400102000000060000009B027D748FEA9040C0226BD877899B408916FADA8FEA904004F4FD8877899B4093E12AF790EA904047196F8B76899B408B6C250192EA9040C43DD57A75899B4048CDA3F792EA9040FA687E5874899B40936742C193EA90403A01AF4673899B400102000000060000006F01A93E95EA9040BA695C375D899B403421B09B94EA90402D73ED0C5C899B4064C178CE93EA904084D714CC5A899B4056EF8FEB92EA90406843319A59899B40AFB50BF491EA90405E88B97858899B40D3E22A9991EA904060293D1C58899B400102000000020000007CDA6F9991EA9040AFF93F1858899B40D3E22A9991EA904060293D1C58899B40010200000002000000936742C193EA90403A01AF4673899B40B41C18C193EA90407A38214973899B400102000000020000006F01A93E95EA9040BA695C375D899B40936742C193EA90403A01AF4673899B40010200000003000000936742C193EA90403A01AF4673899B40D3F977D993EA9040AB5ECE2573899B40853A8DA594EA9040E6EA3CE471899B40010200000003000000007C38F195EA90406FB948B55E899B4000993A5295EA9040FDF0315B5D899B406F01A93E95EA9040BA695C375D899B400102000000020000004E4CD33E95EA90407E32EA345D899B406F01A93E95EA9040BA695C375D899B4001020000002D0000002F22EEE495EA9040B917388DD2869B406CBCD18286EA9040494A23FED3869B403665CE4977EA9040D430A04CD6869B404C52C04C68EA90405F35D375D9869B406F70399E59EA9040E9C8D175DD869B407F616A504BEA9040843DA747E2869B4025F30B753DEA90402FEA5AE5E7869B40EE29491D30EA9040C190F747EE869B4019FCA95923EA9040CEFC9367F5869B4064D6FE3917EA9040C3D05C3BFD869B403A044DCD0BEA904026759FB905879B409913BC2101EA9040681CD6D70E879B40A24B8444F7E9904060CCB48A18879B40A94BDE41EEE99040525D37C622879B40FDE6F324E6E99040225DB07D2D879B403250D2F7DEE9904047C4D8A338879B4014A55DC3D8E990400969E02A44879B40A2EA458FD3E99040A31C7F0450879B40CB86FD61CFE99040145D06225C879B40A743B140CCE99040C085737468879B4020E6412FCAE99040466882EC74879B40F45F3F30C9E990408F36C07A81879B4002A3E544C9E990409AA69E0F8E879B40DE191B6DCAE990405A38879B9A879B4083C770A7CCE99040C185EE0EA7879B40FE0D24F1CFE990400785675AB3879B40E8192246D4E9904054A5B66EBF879B4066EE0CA1D9E9904021AEE43CCB879B407A0B42FBDFE99040E84951B6D6879B405CA6E24CE7E990403225C5CCE1879B40B869DD8CEFE99040898B8372EC879B40ADB1F9B0F8E99040826C5B9AF6879B40B935E4AD02EA9040BBB3B73700889B40C5103D770DEA9040A5DFAE3E09889B400616A7FF18EA9040AEC311A411889B40A75FD83825EA90409F63795D19889B40BF02AC1332EA9040E0D6536120889B40A0D234803FEA9040D623F0A626889B40471CD16D4DEA9040790489262C889B4069413FCB5BEA9040FB864ED930889B40B419B3866AEA90406F7E6EB934889B40A1FFEB8D79EA904005B91BC237889B40AB6D4BCE88EA9040FAF293EF39889B40C50FEC3498EA9040CB7E243F3B889B40952CB9AEA7EA9040E89C2DAF3B889B40010200000002000000BCDF0E529BEA9040565D45125F899B40007C38F195EA90406FB948B55E899B40010200000003000000007C38F195EA90406FB948B55E899B40863A8DA594EA9040E6EA3CE471899B40419E63069AEA9040CE8E394172899B40010200000018000000972CB9AEA7EA9040E9BAED0F63879B408FBB4F1CA7EA9040E9BAED0F63879B40957433F8A5EA9040709580FB62879B40201B3AD6A4EA904050C4BFD262879B407D57CDB7A3EA9040691BDE9562879B40C664529EA2EA90404589274562879B405A53288BA1EA90405FB800E161879B400453A67FA0EA90409C91E66961879B40F2061A7D9FEA90407EA06DE060879B4099E5C5849EEA9040E059414560879B4088A6DF979DEA9040214623995F879B4021C08EB79CEA9040C00FEADC5E879B4015F7EAE49BEA9040A37780115E879B407A01FB209BEA90404D30E4375D879B40213FB36C9AEA904076A124515C879B40CC88F4C899EA90408895615E5B879B40C4178B3699EA9040B2D2C9605A879B401F872DB698EA90404AA1995959879B4004F07B4898EA90405341194A58879B40FB21FFED97EA904017519B3357879B4050F827A797EA9040D5267B1756879B404CCD4E7497EA90408E1F1BF754879B40060CB35597EA90400CE5E2D353879B404DE17A4B97EA904050AD3DAF52879B400102000000020000004DE17A4B97EA904050AD3DAF52879B404DE17A4B97EA90403A3655AF52879B400102000000020000004EE17A4B97EA90403CB5D980B8869B404DE17A4B97EA904050AD3DAF52879B4001020000002400000055E17A4B97EA90403BB5D980B8869B40D662032C96EA90406D08C352B7869B40BAB73F2295EA9040522B6A11B6869B40BB42792F94EA90402B645DBEB4869B407FE8DC5493EA904003EA405BB3869B40AD9A799392EA9040E8DBCCE9B1869B4020083FEC91EA90406C1FCB6BB0869B40D673FC5F91EA9040202915E3AE869B400FB45FEF90EA9040CBB19151AD869B40DC5AF49A90EA90402F5B32B9AB869B401F09236390EA90404047F11BAA869B40E2EC304890EA9040DEA4CE7BA8869B40996B3F4A90EA90400935CEDAA6869B40B9F84B6990EA9040A5CBF43AA5869B40EA1830A590EA9040F1CE459EA3869B40B091A1FD90EA9040BBB8C006A2869B406DC5327291EA90407B9C5E76A0869B40403B530292EA904050B50FEF9E869B400E5250AD92EA9040FEFEB8729D869B40EA1D567293EA9040D8DC31039C869B40BC6E705094EA904082D141A29A869B40E5FE8B4695EA9040674A9E5199869B4068C8775396EA90409081E81298869B40FA7EE67597EA90408C78ABE796869B40152D70AC98EA9040DD0E5AD195869B401AF293F599EA904051364DD194869B4052DFB94F9BEA90407D47C2E893869B4088F134B99CEA90406978D91893869B40BF2445309EEA90406177946292869B40739F19B39FEA9040922BD5C691869B40BFF2D23FA1EA9040129D5C4691869B408C6C85D4A2EA90409F05CAE190869B40FF783B6FA4EA90404A0B9A9990869B401710F80DA6EA9040FA25266E90869B40982CB9AEA7EA90408730A45F90869B40992CB9AEA7EA90408730A45F90869B40010200000002000000429E63069AEA9040CE8E394172899B40419E63069AEA9040CE8E394172899B40010200000003000000419E63069AEA9040CE8E394172899B409281A6F899EA90408EB5A60C73899B40D4666EC7A3EA9040998138B673899B40010200000003000000AEE1932EA5EA9040A0026AF05E899B406DFCCB5F9BEA90409536D8465E899B40419E63069AEA9040CE8E394172899B40010200000002000000DC8E0F9EA5EA904097C2B66E75899B40D4666EC7A3EA9040998138B673899B40010200000002000000AEE1932EA5EA9040A0026AF05E899B40D4666EC7A3EA9040998138B673899B40010200000002000000717C293CA7EA904097A8337B5D899B40AEE1932EA5EA9040A0026AF05E899B400102000000020000002ACA82CAA7EA90408B0E438283899B40DC8E0F9EA5EA904097C2B66E75899B40010200000002000000717C293CA7EA904097A8337B5D899B40DC8E0F9EA5EA904097C2B66E75899B40010200000002000000D8701748ABEA9040AF9632D34F899B40717C293CA7EA904097A8337B5D899B40010200000002000000942CB9AEA7EA90408223C07FDF889B40952CB9AEA7EA90404953EC0C96889B4001020000002E000000952CB9AEA7EA9040E89C2DAF3B889B40972CB9AEA7EA9040E89C2DAF3B889B4068498628B7EA9040CC7E243F3B889B4083EB268FC6EA9040FBF293EF39889B408C5986CFD5EA904006B91BC237889B407A3FBFD6E4EA9040707E6EB934889B40C4173392F3EA9040FD864ED930889B40E73CA1EF01EB90407B0489262C889B408E863DDD0FEB9040D823F0A626889B406F56C6491DEB9040E3D6536120889B4087F999242AEB9040A263795D19889B402843CB5D36EB9040B2C311A411889B40694835E641EB9040A8DFAE3E09889B4075238EAF4CEB9040BFB3B73700889B4081A778AC56EB9040866C5B9AF6879B4077EF94D05FEB90408E8B8372EC879B40D2B28F1068EB90403725C5CCE1879B40B44D30626FEB9040ED4951B6D6879B40C86A65BC75EB904026AEE43CCB879B40473F50177BEB90405AA5B66EBF879B40304B4E6C7FEB90400D85675AB3879B40AC9101B682EB9040C785EE0EA7879B40513F57F084EB90406038879B9A879B402EB68C1886EB9040A0A69E0F8E879B403CF9322D86EB90409536C07A81879B400F73302E85EB90404C6882EC74879B408915C11C83EB9040C585737468879B4065D274FB7FEB9040195D06225C879B408E6E2CCE7BEB9040A81C7F0450879B401CB4149A76EB90400E69E02A44879B40FE08A06570EB90404CC4D8A338879B4034727E3869EB9040275DB07D2D879B40870D941B61EB9040575D37C622879B408E0DEE1858EB904065CCB48A18879B409845B63B4EEB90406C1CD6D70E879B40F654259043EB90402A759FB905879B40CD82732338EB9040C7D05C3BFD869B40185DC8032CEB9040D2FC9367F5869B40432F29401FEB9040C590F747EE869B400C6666E811EB904031EA5AE5E7869B40B2F7070D04EB9040863DA747E2869B40C2E838BFF5EA9040EBC8D175DD869B40E506B210E7EA90406135D375D9869B40FBF3A313D8EA9040D530A04CD6869B40C59CA0DAC8EA90404A4A23FED3869B4002378478B9EA9040B917388DD2869B40010200000002000000952CB9AEA7EA90404953EC0C96889B40952CB9AEA7EA9040E89C2DAF3B889B40010200000002000000952CB9AEA7EA9040E89C2DAF3B889B40972CB9AEA7EA9040E9BAED0F63879B40010200000003000000ED36905258EC90400D20B9D962869B40F136905258EC90404953EC0C96889B40952CB9AEA7EA90404953EC0C96889B40010200000018000000E277F711B8EA904051AD3DAF52879B40284DBF07B8EA90400CE5E2D353879B40E38B23E9B7EA90408E1F1BF754879B40DE604AB6B7EA9040D5267B1756879B403337736FB7EA904017519B3357879B402B69F614B7EA90405341194A58879B4010D244A7B6EA90404AA1995959879B406B41E726B6EA9040B2D2C9605A879B4062D07D94B5EA90408895615E5B879B400E1ABFF0B4EA904076A124515C879B40B457773CB4EA90404E30E4375D879B4019628778B3EA9040A37780115E879B400D99E3A5B2EA9040C00FEADC5E879B40A6B292C5B1EA9040214623995F879B409573ACD8B0EA9040E159414560879B403C5258E0AFEA90407EA06DE060879B402A06CCDDAEEA90409C91E66961879B40D4054AD2ADEA90405FB800E161879B4068F41FBFACEA90404589274562879B40B101A5A5ABEA9040691BDE9562879B400E3E3887AAEA904050C4BFD262879B4099E43E65A9EA9040709580FB62879B409F9D2241A8EA9040E9BAED0F63879B40972CB9AEA7EA9040E9BAED0F63879B40010200000002000000972CB9AEA7EA9040E9BAED0F63879B40992CB9AEA7EA90408730A45F90869B40010200000003000000992CB9AEA7EA90400820B9D962869B40ED36905258EC90400820B9D962869B40ED36905258EC90400D20B9D962869B40010200000002000000992CB9AEA7EA90400D20B9D962869B40992CB9AEA7EA90400820B9D962869B40010200000002000000992CB9AEA7EA90400820B9D962869B409A2CB9AEA7EA9040FDC1E07615869B40010200000002000000ED36905258EC90400D20B9D962869B40992CB9AEA7EA90400D20B9D962869B40010200000002000000992CB9AEA7EA90408730A45F90869B40992CB9AEA7EA90400D20B9D962869B40010200000023000000992CB9AEA7EA90408730A45F90869B4019497A4FA9EA9040FA25266E90869B4032E036EEAAEA90404A0B9A9990869B40A4ECEC88ACEA90409F05CAE190869B4072669F1DAEEA9040129D5C4691869B40BEB958AAAFEA9040922BD5C691869B4072342D2DB1EA90406177946292869B40A8673DA4B2EA90406978D91893869B40DF79B80DB4EA90407D47C2E893869B401767DE67B5EA904051364DD194869B401B2C02B1B6EA9040DD0E5AD195869B4036DA8BE7B7EA90408C78ABE796869B40C990FA09B9EA90409081E81298869B404C5AE616BAEA9040674A9E5199869B4074EA010DBBEA904082D141A29A869B40463B1CEBBBEA9040D8DC31039C869B40230722B0BCEA9040FEFEB8729D869B40F11D1F5BBDEA904050B50FEF9E869B40C3933FEBBDEA90407B9C5E76A0869B4081C7D05FBEEA9040BBB8C006A2869B40464042B8BEEA9040F1CE459EA3869B40776026F4BEEA9040A5CBF43AA5869B4098ED3213BFEA90400935CEDAA6869B404E6C4115BFEA9040DFA4CE7BA8869B4011504FFABEEA90404047F11BAA869B4054FE7DC2BEEA90402F5B32B9AB869B4021A5126EBEEA9040CBB19151AD869B405BE575FDBDEA9040202915E3AE869B4010513371BDEA90406C1FCB6BB0869B4083BEF8C9BCEA9040E9DBCCE9B1869B40B2709508BCEA904003EA405BB3869B407516F92DBBEA90402B645DBEB4869B4076A1323BBAEA9040532B6A11B6869B405AF66E31B9EA90406D08C352B7869B40DB77F711B8EA90403BB5D980B8869B400102000000020000003C9871F3ABEA9040B4102FCA83899B402ACA82CAA7EA90408B0E438283899B40010200000002000000D8701748ABEA9040AF9632D34F899B402ACA82CAA7EA90408B0E438283899B40010200000002000000EB3E0671AFEA9040D9981E1B50899B40D8701748ABEA9040AF9632D34F899B40010200000004000000EB3E0671AFEA9040D9981E1B50899B40EC3E0671AFEA9040D9981E1B50899B403E9871F3ABEA9040B4102FCA83899B403C9871F3ABEA9040B4102FCA83899B400102000000020000003C9871F3ABEA9040B4102FCA83899B40EB3E0671AFEA9040D9981E1B50899B40010200000004000000EB3E0671AFEA9040D9981E1B50899B40C61F5A1AB1EA9040EB81618137899B400EF32EEDD7EA9040A18D9D203A899B403312DB43D6EA90408FA45ABA52899B40010200000002000000E377F711B8EA90403CB5D980B8869B40E277F711B8EA9040393655AF52879B40010200000003000000E0BBCF80D4EA9040B5A5DFD06C899B40856B46C6D2EA90406A1C6B6986899B40963935EFD6EA9040951E57B186899B40010200000003000000E0BBCF80D4EA9040B5A5DFD06C899B403212DB43D6EA90408FA45ABA52899B403312DB43D6EA90408FA45ABA52899B40010200000002000000E0BBCF80D4EA9040B5A5DFD06C899B403312DB43D6EA90408FA45ABA52899B400102000000020000003312DB43D6EA90408FA45ABA52899B4046E0C96CDAEA9040B9A6460253899B4001020000000200000046E0C96CDAEA9040B9A6460253899B40963935EFD6EA9040951E57B186899B40010200000002000000963935EFD6EA9040951E57B186899B40FC2D23FBDAEA9040AE0C560979899B4001020000000200000046E0C96CDAEA9040B9A6460253899B40941B3D99DCEA9040ADF2D21561899B40010200000002000000941B3D99DCEA9040ADF2D21561899B40FC2D23FBDAEA9040AE0C560979899B40010200000002000000FC2D23FBDAEA9040AE0C560979899B40BFC8B808DDEA9040A7B21F9477899B40010200000002000000941B3D99DCEA9040ADF2D21561899B409943DE6FDEEA9040AB3351CE62899B40010200000003000000BFC8B808DDEA9040A7B21F9477899B4004AE80D7E6EA9040B07EB13D78899B40B3CA3DE5E6EA9040EF57447277899B400102000000020000009943DE6FDEEA9040AB3351CE62899B40BFC8B808DDEA9040A7B21F9477899B400102000000030000009943DE6FDEEA9040AB3351CE62899B40DC28A63EE8EA9040B6FFE27763899B402D0CE930E8EA90407826504364899B40010200000016000000BAB41CA566ED904074B97D771D8C9B40AC882CEB64ED904014E136D3EA8B9B40EC4969BF5FED904016E3206BB88B9B406658F82757ED9040760F257B868B9B4072E00F2F4BED904077F69D3E558B9B40C8B7EAE23BED9040EBDC10F0248B9B40B673B75529ED90400D2EE8C8F58A9B40E0CC829D13ED90407F3D2F01C88A9B402C6A1DD4FAEC90409AAA4FCF9B8A9B40EA31FD16DFEC904036B4D067718A9B40DC451A87C0EC9040C0C918FD488A9B408CD3C7489FEC9040E8A331BF228A9B40AEE788837BEC9040FE2B8FDBFE899B40B677E16155EC9040F475D97CDD899B409FD923112DEC90402B0DBACABE899B40CCE53AC102EC904051D0ACE9A2899B401F0371A4D6EB90406394D4FA89899B40F06034EFA8EB904044C2D31B74899B40F6A5D8D779EB9040D91DA96661899B40245E569649EB904069E090F151899B404E74086418EB90400F4BEACE45899B409A06687BE6EA90409BD0210D3D899B40010200000002000000B2CA3DE5E6EA9040EF57447277899B40B3CA3DE5E6EA9040EF57447277899B40010200000002000000B3CA3DE5E6EA9040EF57447277899B406E2E1446ECEA9040D5FB40CF77899B400102000000020000002D0CE930E8EA90407826504364899B40B3CA3DE5E6EA9040EF57447277899B400102000000020000002C0CE930E8EA90407826504364899B402D0CE930E8EA90407826504364899B400102000000020000002D0CE930E8EA90407826504364899B40EA6FBF91EDEA90405DCA4CA064899B400102000000020000006E2E1446ECEA9040D4FB40CF77899B406E2E1446ECEA9040D5FB40CF77899B40010200000004000000EA6FBF91EDEA90405DCA4CA064899B40EB6FBF91EDEA90405DCA4CA064899B40722E1446ECEA9040D5FB40CF77899B406E2E1446ECEA9040D5FB40CF77899B400102000000030000006E2E1446ECEA9040D5FB40CF77899B406E1112E5ECEA904046C4572979899B4001A9A3F8ECEA90408C4B2D4D79899B4001020000000200000001A9A3F8ECEA90408C4B2D4D79899B40225E79F8ECEA9040C8829F4F79899B4001020000000600000001A9A3F8ECEA90408C4B2D4D79899B403A899C9BEDEA904016429C777A899B400AE9D368EEEA9040BFDD74B87B899B4018BBBC4BEFEA9040DC7158EA7C899B40C0F44043F0EA9040E62CD00B7E899B409DC7219EF0EA9040E58B4C687E899B40010200000002000000DD420A76EEEA904008B4DA3D63899B4001A9A3F8ECEA90408C4B2D4D79899B40010200000002000000EA6FBF91EDEA90405DCA4CA064899B40E96FBF91EDEA90405ECA4CA064899B40010200000003000000DD420A76EEEA904008B4DA3D63899B409CB0D45DEEEA90409856BB5E63899B40EA6FBF91EDEA90405DCA4CA064899B40010200000002000000BC8D3476EEEA9040CB7C683B63899B40DD420A76EEEA904008B4DA3D63899B40010200000006000000D6A7CFC2F2EA904082921EAC5E899B40E493525CF2EA904040C18BFB5E899B40DBC82140F1EA9040FC9B1AF95F899B40E33D2736F0EA90408077B40961899B4026DDA83FEFEA9040494C0B2C62899B40DD420A76EEEA904008B4DA3D63899B400102000000020000009DC7219EF0EA9040E58B4C687E899B40F4CFDC9DF0EA904095BB496C7E899B400102000000190000009DC7219EF0EA9040E58B4C687E899B40304B314EF1EA90407E5C791B7F899B4012A7466BF2EA90400B20071880899B404EB52399F3EA90409B00440081899B401C9356D6F4EA90401C6C13D381899B403E935A21F6EA90400812738F82899B40461A9A78F7EA9040F11F7C3483899B40928F70DAF8EA9040505C64C183899B40B0602C45FAEA9040591E7F3584899B40A61411B7FBEA904083213E9084899B408C6C592EFDEA9040E33332D184899B40F68E39A9FEEA904067BE0BF884899B40683BE12500EB904060269B0485899B4035037EA201EB9040D607D1F684899B4008853D1D03EB90406348BECE84899B4060A84F9404EB90407F02948C84899B403CD6E80506EB90405549A33084899B40402C447007EB90406BC55CBB83899B40A9A7A5D108EB9040972A502D83899B405C455C280AEB9040E7872B8782899B407C14C4720BEB90405C72BAC981899B40FC3848AF0CEB9040730BE5F580899B40B6DB64DC0DEB9040B5E4AE0C80899B40AC05A9F80EEB9040A8C1350F7F899B401C64B80210EB9040A539B0FE7D899B40010200000002000000D6A7CFC2F2EA904082921EAC5E899B409DC7219EF0EA9040E58B4C687E899B400102000000020000007E9F14C3F2EA9040D36221A85E899B40D6A7CFC2F2EA904082921EAC5E899B40010200000019000000AB1C38D011EB9040508F5E4D63899B40E6EB37ED10EB904095528C1B62899B40CC949DF50FEB9040F78127FA60899B40487D98EA0EEB9040A7B892EA5F899B401FD66FCD0DEB904040BE1AEE5E899B400E0A819F0CEB904001EFF4055E899B4098113E620BEB9040B9C03D335D899B40B8AD2B170AEB90403866F7765C899B407F8BDFBF08EB9040F19208D25B899B400053FE5D07EB904044603B455B899B40DCA339F305EB9040DE553CD15A899B40EF014E8104EB9040509699765A899B4099B4000A03EB9040E430C2355A899B405D9B1D8F01EB90408899050F5A899B4058FA741200EB9040724793025A899B406341D995FEEA9040F67A7A105A899B4087D01C1BFDEA9040D72AAA385A899B4082BC0FA4FBEA90402819F17A5A899B4024967D32FAEA9040A10FFED65A899B402A372BC8F8EA90402043604C5B899B405B97D466F7EA9040E3DD87DA5B899B4085AC2A10F6EA9040C7AFC6805C899B40F657D1C5F4EA9040B503513E5D899B40FB635D89F3EA904040993E125E899B40D6A7CFC2F2EA904082921EAC5E899B40010200000002000000AD1C38D011EB90404F8F5E4D63899B401E64B80210EB9040A639B0FE7D899B400102000000050000007AFDD85916EB904043BA617D93869B407C9CB6BA0FEB9040421B841C9A869B4077BF1D9823EB90403C3EEBF9AD869B40752040372AEB90403EDDC85AA7869B407AFDD85916EB904044BA617D93869B400102000000130000004F241C401DEB90405FFC532FC8869B401A490E301CEB9040F3855893C6869B409F5BE83C1BEB9040B55CABE5C4869B4051B1CF671AEB904028DD5228C3869B407E5EC5B119EB9040134B685DC1869B402B00A51B19EB90405E491587BF869B401FB323A618EB9040273E91A7BD869B406C39CF5118EB90403FA61EC1BB869B40644F0D1F18EB9040475B08D6B9869B40E0301B0E18EB9040BACF9EE8B7869B40634F0D1F18EB90402D4435FBB5869B406B39CF5118EB904036F91E10B4869B401FB323A618EB90404D61AC29B2869B402A00A51B19EB90401656284AB0869B407E5EC5B119EB90406154D573AE869B4051B1CF671AEB90404DC2EAA8AC869B409E5BE83C1BEB9040BF4292EBAA869B4019490E301CEB90408119E53DA9869B404E241C401DEB904016A3E9A1A7869B400102000000040000004D853EDF23EB90405C5D76CECE869B407AFDD85916EB90402FE5DB53DC869B407C9CB6BA0FEB90403184B9B4D5869B404F241C401DEB90405FFC532FC8869B4001020000000200000077BF1D9823EB9040376152D7C1869B404F241C401DEB90405FFC532FC8869B4001020000000200000077BF1D9823EB9040376152D7C1869B4076BF1D9823EB9040366152D7C1869B4001020000000300000077BF1D9823EB9040376152D7C1869B40752040372AEB904035C27476C8869B404D853EDF23EB90405C5D76CECE869B4001020000001300000096DEA86C44EB90405E5D76CECE869B402B68ADD042EB9040933884DECF869B40ED3E002341EB90400E26AAD1D0869B405FBFA7653FEB90405CD0C2A6D1869B404A2DBD9A3DEB90402E23CD5CD2869B40962B6AC43BEB90408281EDF2D2869B405E20E6E439EB90408ECE6E68D3869B40768873FE37EB90404148C3BCD3869B407E3D5D1336EB9040493285EFD3869B40F1B1F32534EB9040CC507700D4869B4064268A3832EB9040493285EFD3869B406DDB734D30EB90404048C3BCD3869B40844301672EEB90408DCE6E68D3869B404D387D872CEB90408181EDF2D2869B4098362AB12AEB90402D23CD5CD2869B4083A43FE628EB90405BD0C2A6D1869B40F624E72827EB90400D26AAD1D0869B40B8FB397B25EB9040923884DECF869B404D853EDF23EB90405C5D76CECE869B400102000000130000004F853EDF23EB90401642C702A1869B40BAFB397B25EB9040E066B9F29F869B40F824E72827EB9040657993FF9E869B4085A43FE628EB904018CF7A2A9E869B409A362AB12AEB9040457C70749D869B404F387D872CEB9040F21D50DE9C869B40864301672EEB9040E6D0CE689C869B406FDB734D30EB904033577A149C869B4066268A3832EB90402B6DB8E19B869B40F3B1F32534EB9040A84EC6D09B869B40803D5D1336EB90402B6DB8E19B869B40788873FE37EB904033577A149C869B406020E6E439EB9040E6D0CE689C869B40972B6AC43BEB9040F21D50DE9C869B404C2DBD9A3DEB9040467C70749D869B4061BFA7653FEB904018CF7A2A9E869B40EE3E002341EB9040667993FF9E869B402C68ADD042EB9040E166B9F29F869B4097DEA86C44EB90401642C702A1869B400102000000050000006DA4C9B344EB9040366152D7C1869B4068C7309158EB90403284B9B4D5869B406A660EF251EB904030E5DB53DC869B406F43A7143EEB904035C27476C8869B406DA4C9B344EB9040376152D7C1869B40010200000013000000973FCB0B4BEB904016A3E9A1A7869B40CC1AD91B4CEB90408119E53DA9869B404708FF0E4DEB9040BF4292EBAA869B4094B217E44DEB90404DC2EAA8AC869B406705229A4EEB90406154D573AE869B40BB6342304FEB90401656284AB0869B40C6B0C3A54FEB90404D61AC29B2869B40792A18FA4FEB904035F91E10B4869B408114DA2C50EB90402D4435FBB5869B400433CC3D50EB9040BACF9EE8B7869B408114DA2C50EB9040475B08D6B9869B40792A18FA4FEB90403EA61EC1BB869B40C6B0C3A54FEB9040273E91A7BD869B40BA6342304FEB90405E491587BF869B406705229A4EEB9040124B685DC1869B4094B217E44DEB904027DD5228C3869B404708FF0E4DEB9040B55CABE5C4869B40CC1AD91B4CEB9040F2855893C6869B40963FCB0B4BEB90405EFC532FC8869B400102000000050000006A660EF251EB904043BA617D93869B4068C7309158EB9040421B841C9A869B406DA4C9B344EB90403D3EEBF9AD869B406F43A7143EEB90403FDDC85AA7869B406A660EF251EB904044BA617D93869B40010200000002000000FE96B37236ED90400D20B9D962869B40ED36905258EC90400D20B9D962869B40010200000002000000BBDC4EDE2EED904050A98D342A879B40709756E42EED9040B6945B352A879B40010200000007000000709756E42EED9040B6945B352A879B40D09DFF7379ED9040F6977A2734879B4039C2D281C4ED9040983D5A8439879B40E1D8A8BF0FEE90406E5805463A879B4088EF7EFD5AEE90409A3D5A8439879B40F213520BA6EE9040FA977A2734879B40391AFB9AF0EE9040BF945B352A879B4001020000000D000000709756E42EED9040B6945B352A879B40610107892FED90407A6CD9152B879B4021D7B6DD30ED9040D7D6B1AA2C879B405604994C32ED90400EF3F5272E879B408ECA0CD433ED904058ACF48B2F879B40F582557235ED904088A219D530879B406D979C2537ED90405EF5EE0132879B4058A879D439ED90409692589E33879B40AA005A9B3CED9040002ED50F35879B40BCB68F773FED9040A044005536879B40504B586642ED90409A16A06C37879B404453DF6445ED9040E6D5A65538879B408BE33BD881ED90405948B2E13B879B40010200000023000000FE96B37236ED90400D20B9D962869B40614E038635ED90400E05CFE162869B4002886D9A34ED9040770D07FA62869B4026750BB133ED9040FA50442263869B401FA6F3CA32ED90401CC8565A63869B40F1BD38E931ED90408485FBA163869B407D2AE80C31ED9040DC05DDF863869B40EFE2083730ED9040E895935E64869B40DF2D9A682FED90404ACEA5D264869B409C7092A22EED90406624895465869B401609DEE52DED9040C68FA2E365869B40BD335E332DED90402043477F66869B40A9FEE78B2CED90403478BD2667869B40504B43F02BED90408E4D3DD967869B40F0DF29612BED904014B5F19568869B40D38946DF2AED90405872F95B69869B407251346B2AED90406827682A6A869B4065C17D052AED9040F56E47006B869B400E419CAE29ED90406A0298DC6B869B40A783F76629ED904098EA52BE6C869B40850CE52E29ED90409EB96AA46D869B4002C9A70629ED90407BCCCC8D6E869B409AC06FEE28ED9040DA9262796F869B4099DB59E628ED904094DB126670869B4096DB59E628ED9040492D97E817879B40A549F9F728ED904030966AF919879B40468FC32C29ED90403F4DE5071C879B4094B57C8429ED9040F64AB1111E879B406C17C1FE29ED904076D97D1420879B409DD2059B2AED9040C435020E22879B40AD6599582BED9040072800FC23879B407579A4362CED9040C68F46DC25879B40C1D52A342DED90404FE1B3AC27879B40CC7F0C502EED90406491386B29879B40709756E42EED9040B6945B352A879B40010200000002000000FF4269D835ED90404FB321117A979B4032769C0B690091404FB321117A979B40010200000004000000FF4269D835ED90404FB321117A979B40FF4269D835ED9040B1198877E0999B4032769C0B69009140B1198877E0999B4032769C0B690091404FB321117A979B4001020000000400000032769C0B690091404FB321117A979B4032769C0B69009140E44CBBAA13959B40FF4269D835ED9040E44CBBAA13959B40FF4269D835ED90404FB321117A979B400102000000020000008DE7F0C56CED90400D20B9D962869B40FE96B37236ED90400D20B9D962869B400102000000030000008DE7F0C56CED90400D20B9D962869B401B97B37236ED90400C20B9D962869B40FE96B37236ED90400D20B9D962869B4001020000003A000000CCA764EE60ED90407B008B37D7879B40EB89A0AD5EED9040C86B3A3EE6879B40A332B1D15BED90403A705198F5879B40086BDBF058ED9040C600A46D0A889B40F61EAA7857ED9040288F76681F889B404917D26A57ED90407A396D7034889B40F6E5380459ED9040B25541384E889B40CAD7BA335CED9040BE1C4ADA67889B4009AC3DF660ED9040D08C903D81889B4045FBA75264ED9040FC28CF7A8E889B406CA6FA8868ED9040AC3D25799B889B40774FAC946DED90406C49942AA8889B40BECA4D7073ED9040F49D7081B4889B40BE1A1C497CED9040403A4E7CC4889B404F12C21286ED90405FA53FE8D3889B4071B642C490ED904052681BB7E2889B40B721CC539CED9040044D48DBF0889B40D688C0B6A8ED904020DBC947FE889B40F8F97D9AAFED9040D6CB14DE04899B40F8BA8BE8B6ED90405485A5FD0A899B402BB8EF98BEED90404744CC9F10899B40F07B44A3C6ED9040B43862BE15899B40DC59C2FECEED9040A63DD0531A899B40290549A2D7ED904000F4145B1E899B40EE876984E0ED9040B239CACF21899B403A90709BE9ED904078F729AE24899B40D40771DDF2ED9040CA3F12F326899B4016EB4E40FCED904098BA089C28899B40FB52CAB905EE9040F3593DA729899B406AA68A3F0FEE9040CE548C132A899B40D9F94AC518EE9040F4593DA729899B40BE61C63E22EE904099BA089C28899B400045A4A12BEE9040CC3F12F326899B409BBCA4E334EE904078F729AE24899B40E7C4ABFA3DEE9040B439CACF21899B40AC47CCDC46EE904002F4145B1E899B40F9F252804FEE9040A83DD0531A899B40E5D0D0DB57EE9040B63862BE15899B40AA9425E65FEE90404A44CC9F10899B40DD91899667EE90405785A5FD0A899B40DD5297E46EEE9040D8CB14DE04899B4000C454C875EE904022DBC947FE889B401F2B492B82EE9040074D48DBF0889B406696D2BA8DEE904056681BB7E2889B40883A536C98EE904062A53FE8D3889B401A32F935A2EE9040443A4E7CC4889B401B82C70EABEE9040F89D7081B4889B406CFD68EAB0EE90407249942AA8889B4082A61AF6B5EE9040B43D25799B889B40B3516D2CBAEE90400229CF7A8E889B40F9A0D788BDEE9040D68C903D81889B401E755A4BC2EE9040C21C4ADA67889B40D866DC7AC5EE9040B65541384E889B406A354314C7EE904080396D7034889B40CB2D6B06C7EE90402E8F76681F889B40C7E1398EC5EE9040CC00A46D0A889B403B1A64ADC2EE90403E705198F5879B4019ECCE70BDEE9040B2FFBEE5D6879B40010200000041000000CCA764EE60ED90407B008B37D7879B402B4C55135EED9040B5212D8BDE879B4062FF26395AED9040D73B68AEEA879B408F8FC02857ED904022139B0AF7879B4059A160E554ED904078EAAE9203889B40A5BC6C7153ED9040808D5E3910889B40DFC26ECE52ED9040225E44F11C889B4007CA51FF52ED904079A90E9C36889B409EBD6B7C54ED904080F1F73B50889B405AF8C24457ED9040760D37C069889B4046EB23AD59ED9040798A466578889B405C3211EE5CED90407E4B3EE086889B4099F5BB0461ED9040B4139F2495889B40F1E59CED65ED90402AC31826A3889B40E94877A46BED904033F794D8B0889B4005FD6BF272ED904012224EBEBF889B407A2B922D7BED904090274726CE889B4088D47E4D84ED90403A4FC401DC889B400100DD488EED9040248D9942E9889B408348771599ED9040660039DBF5889B40324C42A8A4ED9040B6CFC0BE01899B4053F867F5B0ED9040355608E10C899B40BE584741B8ED904087D05AAF12899B40198E11E8BFED904074FAA00318899B40B84BD0E1C7ED90402A2D4FD81C899B405FF23626D0ED9040B1875E2821899B402633ABACD8ED9040022A52EF24899B4028034E6CE1ED90408AE03B2928899B40BDD6045CEAED90403C3BC0D22A899B40A21A8372F3ED9040DA0B1AE92C899B402CE153A6FCED9040F2471D6A2E899B407BB9E3ED05EE90407E4B39542F899B406AA68A3F0FEE9040C2797AA62F899B405A93319118EE90407E4B39542F899B40A96BC1D821EE9040F3471D6A2E899B403332920C2BEE9040DA0B1AE92C899B401876102334EE90403D3BC0D22A899B40AD49C7123DEE90408CE03B2928899B40AE196AD245EE9040032A52EF24899B40765ADE584EEE9040B3875E2821899B401D01459D56EE90402C2D4FD81C899B40BCBE03975EEE904076FAA00318899B4017F4CD3D66EE90408AD05AAF12899B408254AD896DEE9040385608E10C899B40A400D3D679EE9040BACFC0BE01899B4054049E6985EE90406A0039DBF5889B40D54C383690EE9040298D9942E9889B404F7896319AEE90403E4FC401DC889B405D218351A3EE904096274726CE889B40D34FA98CABEE904018224EBEBF889B40EF039EDAB2EE904038F794D8B0889B40E7667891B8EE904030C31826A3889B403F57597ABDEE9040B9139F2495889B407D1A0491C1EE9040834B3EE086889B409461F1D1C4EE90407E8A466578889B408154523AC7EE90407C0D37C069889B403D8FA902CAEE904085F1F73B50889B40D582C37FCBEE90407EA90E9C36889B40FE89A6B0CBEE9040285E44F11C889B403690A80DCBEE9040778D5E3910889B407EABB499C9EE904062EAAE9203889B4042BD5456C7EE9040FE129B0AF7879B40684DEE45C4EE9040A43B68AEEA879B409500C06BC0EE904076212D8BDE879B4019ECCE70BDEE9040B2FFBEE5D6879B40010200000002000000CCA764EE60ED90407B008B37D7879B403CA167FE60ED90409A4AC1CCD6879B400102000000050000009610066E6CED9040B857691ABF879B403D5FA2A868ED90400E9DEFFEC5879B405124319165ED90402219DA48CC879B401D2437B362ED90405C2EC4ADD2879B40CCA764EE60ED90407B008B37D7879B40010200000007000000BAB41CA566ED904074B97D771D8C9B40BAB41CA566ED9040728EF660448C9B40D6A173FF5DED9040728EF660448C9B40D6A173FF5DED904070636F4A6B8C9B4080DA6EF077ED904070636F4A6B8C9B4080DA6EF077ED904074B97D771D8C9B40BAB41CA566ED904074B97D771D8C9B400102000000020000008BE33BD881ED90405948B2E13B879B409610066E6CED9040B857691ABF879B4001020000000E000000F2B39188B9ED904060AEA07C80879B40AAF91C00B3ED904069E5847482879B402C602C99ACED904099F394D084879B40E045BE59A6ED90408D539B8E87879B40050CAC47A0ED9040AAC906AC8A879B40DC9CA4689AED904068CBEC258E879B40951927C294ED9040413A0CF991879B40EFB47D598FED90409C6FD02196879B401BFF098B88ED90403E18AC0C9C879B4084CA1F1A82ED90404C42D85CA2879B40FBABA00C7CED9040603E910CA9879B409871136876ED90408C1EBC15B0879B40E8169F3171ED90406849EC71B7879B409610066E6CED9040B857691ABF879B4001020000000400000081DA6EF077ED9040CEB95273FC8B9B4001E5D733D3EF9040DBB95273FC8B9B4001E5D733D3EF90400D20B9D962869B408DE7F0C56CED90400D20B9D962869B40010200000025000000391AFB9AF0EE9040BF945B352A879B40DD31452FF1EE90407091386B29879B40EBDB264BF2EE90405AE1B3AC27879B403A38AD48F3EE9040D18F46DC25879B40054CB826F4EE9040122800FC23879B4017DF4BE4F4EE9040D035020E22879B404B9A9080F5EE904081D97D1420879B4026FCD4FAF5EE9040004BB1111E879B4077228E52F6EE9040484DE5071C879B401B685887F6EE904036966AF919879B402CD6F798F6EE90404F2D97E817879B402ED6F798F6EE90409ADB126670869B402DF1E190F6EE9040E09262796F869B40C5E8A978F6EE904082CCCC8D6E869B4041A56C50F6EE9040A5B96AA46D869B40202E5A18F6EE90409EEA52BE6C869B40B970B5D0F5EE9040700298DC6B869B4061F0D379F5EE9040FC6E47006B869B4055601D14F5EE90406E27682A6A869B40F4270BA0F4EE90405E72F95B69869B40D7D1271EF4EE90401BB5F19568869B4077660E8FF3EE9040954D3DD967869B401EB369F3F2EE90403C78BD2667869B400A7EF34BF2EE90402743477F66869B40B1A87399F1EE9040CE8FA2E365869B402A41BFDCF0EE90406E24895465869B40E883B716F0EE904051CEA5D264869B40D8CE4848EFEE9040EF95935E64869B404A876972EEEE9040E205DDF863869B40D6F31896EDEE90408A85FBA163869B40A80B5EB4ECEE904024C8565A63869B40A13C46CEEBEE90400251442263869B40C529E4E4EAEE90407E0D07FA62869B4066634EF9E9EE90401605CFE162869B40AC1A9E0CE9EE90401420B9D962869B40E4D8A8BF0FEE90401020B9D962869B408DE7F0C56CED90400D20B9D962869B4001020000000E000000C6B6FC2DC0ED90401F1E50B88A879B404240D195BFED90406A1EF9B78A879B402AE1DBD4B7ED9040CA54F80E8C879B40EC8B922EB0ED9040816C02E78D879B40B77556ABA8ED9040E84C123E90879B40FC6D6253A1ED9040B1B7971193879B4080DAC12E9AED9040CA177A5E96879B4066E7474593ED904098E51B219A879B40CEF4869E8CED9040D29C5E559E879B40704BC84186ED9040B83FA7F6A2879B404521043680ED90408D62E3FFA7879B4009F7D9817AED9040FDB98E6BAD879B40DD56892B75ED90403026B933B3879B4011FCEA3870ED904005340D52B9879B4001020000000200000081DA6EF077ED9040BCB95273FC8B9B4081DA6EF077ED9040CEB95273FC8B9B4001020000000300000081DA6EF077ED9040CEB95273FC8B9B4081DA6EF077ED90408253EC0C968C9B40589A376354F09040A053EC0C968C9B4001020000000E0000008BE33BD881ED90405948B2E13B879B40E0D8A8BF0FEE90401852D8C840879B407D5E721ADAEE9040ECD5A65538879B406866F918DDEE9040A016A06C37879B40F4FAC107E0EE9040A544005536879B40FEB0F7E3E2EE9040042ED50F35879B404909D8AAE5EE90409C92589E33879B402B1AB559E8EE904064F5EE0132879B40A62EFC0CEAEE904090A219D530879B400FE744ABEBEE904060ACF48B2F879B404AADB832EDEE904017F3F5272E879B4083DA9AA1EEEE9040E2D6B1AA2C879B4045B04AF6EFEE9040856CD9152B879B40391AFB9AF0EE9040BF945B352A879B40010200000002000000F2B39188B9ED904060AEA07C80879B40C6B6FC2DC0ED904060AEA07C80879B40010200000003000000F2B39188B9ED904060AEA07C80879B40F2B39188B9ED904080407DC966879B402452898AB9ED90405F85279166879B400102000000020000002452898AB9ED90405F85279166879B4068AFFB88B9ED90409DBAFF9066879B40010200000003000000C6B6FC2DC0ED904007C4C26275879B40947C7BBDBBED904080407DC966879B402452898AB9ED90405F85279166879B4001020000002E0000002452898AB9ED90405F85279166879B40E545F591B9ED90406C02A0BC65879B40FE4514AEB9ED90409C1812B164879B4099A1CBDCB9ED90401A3521A863879B40EF14E11DBAED904084C717A362879B40B9730371BAED9040F3603BA361879B40780ECBD5BAED9040EA1DCBA960879B40BE33BA4BBBED90405618FEB75F879B40F3CC3DD2BBED904090E301CF5E879B40CE15AE68BCED90403814F9EF5D879B408B6D4F0EBDED9040CDD5F91B5D879B40F14053C2BDED9040C08F0C545C879B40F70BD983BEED9040AB9B2A995B879B40C871EF51BFED9040560E3DEC5A879B40C969952BC0ED904006951B4E5A879B402C80BB0FC1ED90407A688BBF59879B40822845FDC1ED9040F4563E4159879B409C200AF3C2ED904074E6D1D358879B4008E2D7EFC3ED90404490CE7758879B40642073F2C4ED9040C416A72D58879B40955299F9C5ED904040F6B7F557879B4011450204C7ED9040A2F146D057879B4031B36110C8ED904066BB82BD57879B409CE5681DC9ED904066BB82BD57879B40BC53C829CAED9040A2F146D057879B4038463134CBED904040F6B7F557879B406978573BCCED9040C416A72D58879B40C5B6F23DCDED90404490CE7758879B403178C03ACEED904074E6D1D358879B404A708530CFED9040F4563E4159879B40A1180F1ED0ED90407A688BBF59879B40042F3502D1ED904006951B4E5A879B400527DBDBD1ED9040560E3DEC5A879B40D68CF1A9D2ED9040AB9B2A995B879B40DC57776BD3ED9040C08F0C545C879B40422B7B1FD4ED9040CDD5F91B5D879B40FF821CC5D4ED90403814F9EF5D879B40DACB8C5BD5ED904090E301CF5E879B40106510E2D5ED90405618FEB75F879B40558AFF57D6ED9040EA1DCBA960879B401425C7BCD6ED9040F3603BA361879B40DE83E90FD7ED904084C717A362879B4034F7FE50D7ED90401A3521A863879B40CF52B67FD7ED90409C1812B164879B40E852D59BD7ED90406C02A0BC65879B40DBE438A5D7ED904080407DC966879B40010200000002000000C6B6FC2DC0ED904007C4C26275879B406EA59D04C3ED904007C4C26275879B40010200000002000000C6B6FC2DC0ED904060AEA07C80879B40C6B6FC2DC0ED904007C4C26275879B40010200000002000000C6B6FC2DC0ED90401F1E50B88A879B40C6B6FC2DC0ED904060AEA07C80879B400102000000020000000F4A2A9FDEED9040C9A6B7C98A879B40C6B6FC2DC0ED90401F1E50B88A879B40010200000002000000C6B6FC2DC0ED9040201E50B88A879B40C6B6FC2DC0ED90401F1E50B88A879B400102000000020000006EA59D04C3ED904007C4C26275879B407B4F2B95CEED904008C4C26275879B400102000000430000007B4F2B95CEED904008C4C26275879B4087AE1697CEED9040F65B0C6575879B409BE041E4CEED9040A60D43CF75879B402F39D429CFED9040A490993E76879B4017F37667CFED90406F0885B276879B40FF2EDD9CCFED904098E1742A77879B404D53C4C9CFED90401886D3A577879B40315FF4EDCFED9040DE17072478879B407F304009D0ED9040B33072A478879B40F5BB851BD0ED904092A6742679879B40B737AE24D0ED904064536CA979879B40B737AE24D0ED904039DFB52C7A879B40F5BB851BD0ED90400A8CADAF7A879B407F304009D0ED9040E901B0317B879B40315FF4EDCFED9040BE1A1BB27B879B404D53C4C9CFED904084AC4E307C879B40FF2EDD9CCFED90400451ADAB7C879B4017F37667CFED90402D2A9D237D879B402F39D429CFED9040F8A188977D879B409BE041E4CEED9040F624DF067E879B4087AE1697CEED9040A6D615717E879B40C2E1B242CEED90409D3EA8D57E879B40B0BA7FE7CDED9040CAED18347F879B4009F8EE85CDED9040DC1AF28B7F879B40F8487A1ECDED90402E35C6DC7F879B405AB5A2B1CCED90406F6D302680879B40D1FCEF3FCCED90405A33D56780879B4072EDEFC9CBED9040EAA762A180879B40EAB23550CBED9040770391D280879B40F61E59D3CAED90403AEF22FB80879B4000ECF553CAED9040D2D1E51A81879B40ECFAAAD2C9ED90405C0EB23181879B40F08C1950C9ED9040D6356B3F81879B40757AE4CCC8ED9040A22A004481879B40F967AF49C8ED9040D6356B3F81879B40FDF91DC7C7ED90405C0EB23181879B40EA08D345C7ED9040D2D1E51A81879B40F3D56FC6C6ED90403AEF22FB80879B40FF419349C6ED9040770391D280879B407807D9CFC5ED9040EAA762A180879B4018F8D859C5ED90405A33D56780879B408F3F26E8C4ED90406F6D302680879B40F1AB4E7BC4ED90402E35C6DC7F879B40E0FCD913C4ED9040DC1AF28B7F879B40393A49B2C3ED9040CAED18347F879B4027131657C3ED90409D3EA8D57E879B406246B202C3ED9040A6D615717E879B404E1487B5C2ED9040F624DF067E879B40BABBF46FC2ED9040F8A188977D879B40D2015232C2ED90402D2A9D237D879B40EAC5EBFCC1ED90400451ADAB7C879B409CA104D0C1ED904084AC4E307C879B40B895D4ABC1ED9040BE1A1BB27B879B406AC48890C1ED9040E901B0317B879B40F438437EC1ED90400A8CADAF7A879B4032BD1A75C1ED904039DFB52C7A879B4032BD1A75C1ED904064536CA979879B40F438437EC1ED904092A6742679879B406AC48890C1ED9040B33072A478879B40B895D4ABC1ED9040DE17072478879B409CA104D0C1ED90401886D3A577879B40EAC5EBFCC1ED904098E1742A77879B40D2015232C2ED90406F0885B276879B40BABBF46FC2ED9040A490993E76879B404E1487B5C2ED9040A60D43CF75879B406246B202C3ED9040F65B0C6575879B406EA59D04C3ED904007C4C26275879B4001020000001B0000006EA59D04C3ED904007C4C26275879B4027131657C3ED9040FFF3790075879B40393A49B2C3ED9040D24409A274879B40E0FCD913C4ED9040C017304A74879B40F1AB4E7BC4ED90406EFD5BF973879B408F3F26E8C4ED90402EC5F1AF73879B4018F8D859C5ED904042FF4C6E73879B407807D9CFC5ED9040B28ABF3473879B40FF419349C6ED9040262F910373879B40F3D56FC6C6ED90406243FFDA72879B40EA08D345C7ED9040CA603CBB72879B40FDF91DC7C7ED9040412470A472879B40F967AF49C8ED9040C6FCB69672879B40757AE4CCC8ED9040FA07229272879B40F08C1950C9ED9040C6FCB69672879B40ECFAAAD2C9ED9040412470A472879B4000ECF553CAED9040CA603CBB72879B40F61E59D3CAED90406243FFDA72879B40EAB23550CBED9040262F910373879B4072EDEFC9CBED9040B28ABF3473879B40D1FCEF3FCCED904042FF4C6E73879B405AB5A2B1CCED90402EC5F1AF73879B40F8487A1ECDED90406EFD5BF973879B4009F8EE85CDED9040C017304A74879B40B0BA7FE7CDED9040D24409A274879B40C2E1B242CEED9040FFF3790075879B407B4F2B95CEED904008C4C26275879B400102000000020000007B4F2B95CEED904008C4C26275879B40DA54D145D0ED904008C4C26275879B40010200000002000000DA54D145D0ED904008C4C26275879B40DBE438A5D7ED904008C4C26275879B40010200000002000000DA54D145D0ED9040C60EA7C08A879B40DA54D145D0ED904008C4C26275879B40010200000003000000DA54D145D0ED904008C4C26275879B4081D527BED5ED904080407DC966879B40DBE438A5D7ED904080407DC966879B40010200000002000000DBE438A5D7ED904080407DC966879B40DBE438A5D7ED904008C4C26275879B40010200000002000000DBE438A5D7ED904008C4C26275879B400F4A2A9FDEED904008C4C26275879B400102000000030000000F4A2A9FDEED904008C4C26275879B4071A68A3F0FEE904008C4C26275879B403068DCD946EE904009C4C26275879B400102000000020000000F4A2A9FDEED904008C4C26275879B400F4A2A9FDEED9040C9A6B7C98A879B400102000000030000000F4A2A9FDEED9040C9A6B7C98A879B4070A68A3F0FEE90408BAA84E58A879B40D102EBDF3FEE9040CBA6B7C98A879B400102000000020000000F4A2A9FDEED9040C9A6B7C98A879B400F4A2A9FDEED9040CCA6B7C98A879B40010200000002000000D102EBDF3FEE9040CBA6B7C98A879B40D102EBDF3FEE9040CEA6B7C98A879B40010200000002000000D202EBDF3FEE904009C4C26275879B40D102EBDF3FEE9040CBA6B7C98A879B4001020000000E000000D102EBDF3FEE9040CBA6B7C98A879B40C80C44E95EEE90406D1EF9B78A879B40DC6B39AA66EE9040CE54F80E8C879B4018C182506EEE9040866C02E78D879B4049D7BED375EE9040EE4C123E90879B4000DFB22B7DEE9040B8B7971193879B407972535084EE9040D2177A5E96879B408F65CD398BEE9040A0E51B219A879B4023588EE091EE9040DA9C5E559E879B407E014D3D98EE9040C03FA7F6A2879B40A52B11499EEE90409462E3FFA7879B40DD553BFDA3EE904004BA8E6BAD879B4006F68B53A9EE90403626B933B3879B40CE502A46AEEE90400A340D52B9879B4001020000000300000007F843394EEE904009C4C26275879B408A77EDC048EE904082407DC966879B403068DCD946EE904082407DC966879B400102000000020000003068DCD946EE904082407DC966879B403068DCD946EE904009C4C26275879B4001020000002E000000BFFA8BF464EE90406285279166879B40FE0620ED64EE90407002A0BC65879B40E50601D164EE9040A21812B164879B4049AB49A264EE9040203521A863879B40F437346164EE90408BC717A362879B402AD9110E64EE9040FC603BA361879B406C3E4AA963EE9040F41DCBA960879B4027195B3363EE90406218FEB75F879B40F27FD7AC62EE90409CE301CF5E879B401837671662EE90404614F9EF5D879B405CDFC57061EE9040DCD5F91B5D879B40F70BC2BC60EE9040D08F0C545C879B40F2403CFB5FEE9040BC9B2A995B879B4022DB252D5FEE9040680E3DEC5A879B4023E37F535EEE904019951B4E5A879B40C0CC596F5DEE90408E688BBF59879B406B24D0815CEE904008573E4159879B40532C0B8C5BEE904088E6D1D358879B40E86A3D8F5AEE90405A90CE7758879B408E2CA28C59EE9040D916A72D58879B405EFA7B8558EE904056F6B7F557879B40E407137B57EE9040B8F146D057879B40C599B36E56EE90407CBB82BD57879B405B67AC6155EE90407CBB82BD57879B403CF94C5554EE9040B8F146D057879B40C206E44A53EE904056F6B7F557879B4092D4BD4352EE9040D916A72D58879B403896224151EE90405A90CE7758879B40CDD4544450EE904088E6D1D358879B40B5DC8F4E4FEE904008573E4159879B40603406614EEE90408E688BBF59879B40FE1DE07C4DEE904019951B4E5A879B40FE253AA34CEE9040680E3DEC5A879B402FC023D54BEE9040BC9B2A995B879B4029F59D134BEE9040D08F0C545C879B40C4219A5F4AEE9040DCD5F91B5D879B4008CAF8B949EE90404614F9EF5D879B402E81882349EE90409CE301CF5E879B40F9E7049D48EE90406218FEB75F879B40B4C2152748EE9040F41DCBA960879B40F6274EC247EE9040FC603BA361879B402CC92B6F47EE90408BC717A362879B40D755162E47EE9040203521A863879B403BFA5EFF46EE9040A21812B164879B4023FA3FE346EE90407002A0BC65879B403068DCD946EE904082407DC966879B4001020000000200000007F843394EEE904009C4C26275879B403068DCD946EE904009C4C26275879B4001020000000200000006F843394EEE9040C90EA7C08A879B4007F843394EEE904009C4C26275879B40010200000002000000466226EA50EE904009C4C26275879B4007F843394EEE904009C4C26275879B400102000000020000004F0CB47A5CEE904009C4C26275879B40466226EA50EE904009C4C26275879B400102000000430000004F0CB47A5CEE904009C4C26275879B405D6B9F7C5CEE9040FA5B0C6575879B40719DCAC95CEE9040A80D43CF75879B4005F65C0F5DEE9040A690993E76879B40EDAFFF4C5DEE9040720885B276879B40D5EB65825DEE90409CE1742A77879B4023104DAF5DEE90401C86D3A577879B40081C7DD35DEE9040E017072478879B4055EDC8EE5DEE9040B63072A478879B40CB780E015EEE904094A6742679879B408DF4360A5EEE904066536CA979879B408DF4360A5EEE90403CDFB52C7A879B40CB780E015EEE90400D8CADAF7A879B4055EDC8EE5DEE9040EC01B0317B879B40081C7DD35DEE9040C11A1BB27B879B4023104DAF5DEE904086AC4E307C879B40D5EB65825DEE90400651ADAB7C879B40EDAFFF4C5DEE9040302A9D237D879B4005F65C0F5DEE9040FBA188977D879B40719DCAC95CEE9040FA24DF067E879B405D6B9F7C5CEE9040A8D615717E879B40989E3B285CEE9040A03EA8D57E879B40867708CD5BEE9040CDED18347F879B40DFB4776B5BEE9040DE1AF28B7F879B40CE0503045BEE90403035C6DC7F879B4030722B975AEE9040726D302680879B40A7B978255AEE90405C33D56780879B4048AA78AF59EE9040ECA762A180879B40C06FBE3559EE90407A0391D280879B40CCDBE1B858EE90403DEF22FB80879B40D6A87E3958EE9040D6D1E51A81879B40C2B733B857EE90405E0EB23181879B40C749A23557EE9040D8356B3F81879B404B376DB256EE9040A62A004481879B40CF24382F56EE9040D8356B3F81879B40D3B6A6AC55EE90405E0EB23181879B40C0C55B2B55EE9040D6D1E51A81879B40CA92F8AB54EE90403DEF22FB80879B40D5FE1B2F54EE90407A0391D280879B404EC461B553EE9040ECA762A180879B40EEB4613F53EE90405C33D56780879B4065FCAECD52EE9040726D302680879B40C768D76052EE90403035C6DC7F879B40B6B962F951EE9040DE1AF28B7F879B400FF7D19751EE9040CDED18347F879B40FDCF9E3C51EE9040A03EA8D57E879B4038033BE850EE9040A8D615717E879B4024D10F9B50EE9040FA24DF067E879B4090787D5550EE9040FBA188977D879B40A8BEDA1750EE9040302A9D237D879B40C08274E24FEE90400651ADAB7C879B40725E8DB54FEE904086AC4E307C879B408E525D914FEE9040C11A1BB27B879B40418111764FEE9040EC01B0317B879B40CAF5CB634FEE90400D8CADAF7A879B40087AA35A4FEE90403CDFB52C7A879B40087AA35A4FEE904066536CA979879B40CAF5CB634FEE904094A6742679879B40418111764FEE9040B63072A478879B408E525D914FEE9040E017072478879B40725E8DB54FEE90401C86D3A577879B40C08274E24FEE90409CE1742A77879B40A8BEDA1750EE9040720885B276879B4090787D5550EE9040A690993E76879B4024D10F9B50EE9040A80D43CF75879B4038033BE850EE9040FA5B0C6575879B40466226EA50EE904009C4C26275879B4001020000001B000000466226EA50EE904009C4C26275879B40FDCF9E3C51EE904002F4790075879B400FF7D19751EE9040D54409A274879B40B6B962F951EE9040C317304A74879B40C768D76052EE904071FD5BF973879B4065FCAECD52EE904030C5F1AF73879B40EEB4613F53EE904046FF4C6E73879B404EC461B553EE9040B58ABF3473879B40D5FE1B2F54EE9040282F910373879B40CA92F8AB54EE90406443FFDA72879B40C0C55B2B55EE9040CC603CBB72879B40D3B6A6AC55EE9040442470A472879B40CF24382F56EE9040C9FCB69672879B404B376DB256EE9040FC07229272879B40C749A23557EE9040C9FCB69672879B40C2B733B857EE9040442470A472879B40D6A87E3958EE9040CC603CBB72879B40CCDBE1B858EE90406443FFDA72879B40C06FBE3559EE9040282F910373879B4048AA78AF59EE9040B58ABF3473879B40A7B978255AEE904046FF4C6E73879B4030722B975AEE904030C5F1AF73879B40CE0503045BEE904071FD5BF973879B40DFB4776B5BEE9040C317304A74879B40867708CD5BEE9040D54409A274879B40989E3B285CEE904002F4790075879B404F0CB47A5CEE904009C4C26275879B400102000000020000001B9618515EEE904009C4C26275879B404F0CB47A5CEE904009C4C26275879B400102000000020000001B9618515EEE904062AEA07C80879B401B9618515EEE904009C4C26275879B400102000000030000001B9618515EEE904009C4C26275879B4077D099C162EE904082407DC966879B40BFFA8BF464EE90406285279166879B40010200000002000000EF9883F664EE904062AEA07C80879B401B9618515EEE904062AEA07C80879B400102000000020000001B9618515EEE9040221E50B88A879B401B9618515EEE904062AEA07C80879B40010200000003000000EF9883F664EE904062AEA07C80879B40F09883F664EE904082407DC966879B40BFFA8BF464EE90406285279166879B40010200000002000000BFFA8BF464EE90406285279166879B407A9D19F664EE9040A0BAFF9066879B4001020000000E000000F6C7457CB3EE90409EBE0299C1879B400A582E9CAEEE904028668B72B9879B4011DF683BA9EE90402A9DA79EB1879B40DA42675FA3EE9040D4344425AA879B40C82D180E9DEE9040BD5DF20DA3879B40440DE14D96EE9040A2FEDF5F9C879B40F19797258FEE9040A06FD02196879B404C33EEBC89EE9040443A0CF991879B4004B0701684EE90406CCBEC258E879B40DB4069377EEE9040ACC906AC8A879B400007572578EE90408F539B8E87879B40B4ECE8E571EE90409CF394D084879B403753F87E6BEE90406CE5847482879B40EF9883F664EE904062AEA07C80879B4001020000001600000059FEB597A8EE90406A5B3E4051879B4053C25813A6EE90404444A45B51879B4044C5BE6CA5EE9040B864E21E51879B40F3BEAECAA4EE904032C2E3D650879B40DF75EA2DA4EE9040E171FE8350879B40805B2D97A3EE9040B891952650879B4023AC2B07A3EE9040EBD118BF4F879B406F97917EA2EE904063EF034E4F879B407F7202FEA1EE9040CC1FDED34E879B4098F41786A1EE9040E76F39514E879B40607F6117A1EE9040EE14B2C64D879B406A7363B2A0EE9040C8B1ED344D879B40F0919657A0EE904002919A9C4C879B406F6C6707A0EE904062D46EFE4B879B40DAE235C29FEE90402C9B275B4B879B40F4B054889FEE9040F61F88B34A879B40670B095A9FEE90403ECF58084A879B40FE4C8A379FEE9040CA57665A49879B407FB401219FEE9040E4B580AA48879B4052338A169FEE9040AC3A7AF947879B404C4D30189FEE9040A890264847879B404D4D30189FEE9040CCAD29413C879B400102000000020000005DFEB597A8EE90406A5B3E4051879B4059FEB597A8EE90406A5B3E4051879B40010200000003000000F6C7457CB3EE90409EBE0299C1879B40040EDE47A0EE9040B1C2551E52879B4059FEB597A8EE90406A5B3E4051879B4001020000000200000059FEB597A8EE90406A5B3E4051879B403F37DF4DC0EE90409D4BADC64E879B4001020000000500000019ECCE70BDEE9040B2FFBEE5D6879B409828DECBBBEE9040122EC4ADD2879B407828E4EDB8EE9040FF18DA48CC879B40A2ED72D6B5EE9040119DEFFEC5879B40F6C7457CB3EE90409EBE0299C1879B4001020000000200000019ECCE70BDEE9040B2FFBEE5D6879B40ECD1B35DBDEE90407C14BF75D6879B400102000000020000003F37DF4DC0EE9040A1BEB5313A879B403F37DF4DC0EE90409D4BADC64E879B400102000000020000003F37DF4DC0EE90409D4BADC64E879B403F37DF4DC0EE90409E4BADC64E879B400102000000300000003F37DF4DC0EE90409D4BADC64E879B40B9B5C553DFEE904047DDBF894B879B40D1B83C83DFEE90408964798D4B879B409237D8B2DFEE9040403F0B8E4B879B408F9162E2DFEE904022C9748B4B879B40AB39A611E0EE904066ECB8854B879B406AF26D40E0EE9040801EDE7C4B879B40EC09856EE0EE9040D858EE704B879B404895B79BE0EE9040900DF7614B879B4004ABD2C7E0EE90405C1809504B879B40749CA4F2E0EE904088AB383B4B879B40AC2DFD1BE1EE904032399D234B879B40D7CBAD43E1EE9040E95851094B879B40AEC18969E1EE9040B2A972EC4A879B40D369668DE1EE9040ADB021CD4A879B40DB5E1BAFE1EE904076B481AB4A879B40D0A882CEE1EE90406295B8874A879B40F5E778EBE1EE9040DCA2EE614A879B409F7CDD05E2EE9040F66D4E3A4A879B40F3AB921DE2EE90407C9904114A879B4066C17D32E2EE9040A8A73FE649879B40517321C0E5EE9040EAD3A6FA41879B40E9BBD3A6E5EE9040D6C07B6F3D879B40336721A5E5EE90400F7AE7503D879B40F13861A1E5EE90409A2D82323D879B40B28B979BE5EE9040D0236F143D879B405C17CB93E5EE90408C45D1F63C879B405CE9048AE5EE9040ACF3CAD93C879B402E5A507EE5EE90401FDF7DBD3C879B402600BB70E5EE9040D1E10AA23C879B40B29F5461E5EE904084D891873C879B400A192F50E5EE9040DA7D316E3C879B4071535E3DE5EE9040A24607563C879B401726F828E5EE9040AE3F2F3F3C879B40C63E1413E5EE90403EEDC3293C879B405E06CCFBE4EE90403A2CDE153C879B405B833AE3E4EE90405A1595033C879B40753A7CC9E4EE90404EE2FDF23B879B40850DAFAEE4EE904026D52BE43B879B40D518F292E4EE9040EA2130D73B879B40058F6576E4EE9040B0DA19CC3B879B40AA932A59E4EE904012DEF5C23B879B40D414633BE4EE904042C8CEBB3B879B40B0A3311DE4EE9040BEE6ACB63B879B40674CB9FEE3EE9040A42E96B33B879B406C6D1DE0E3EE9040CC358EB23B879B40C7C10101DDEE9040CC358EB23B879B4019F4ACDDD9EE9040DDF64B5A38879B400102000000040000007E9E1031CFEE904056759FB4419A9B400B411187CFEE904056759FB4419A9B400B411187CFEE9040DE30BDDF469B9B400B411187CFEE9040DF30BDDF469B9B400102000000340000007E9E1031CFEE904056759FB4419A9B40D8BF1A40A3EE904056759FB4419A9B40D8BF1A40A3EE9040DE30BDDF469B9B40EF8A748BA3EE904018BE7D7D4F9B9B401AFC276DA4EE9040B587F510589B9B405DAE27E4A5EE90408B10E88F609B9B406F09B4EEA7EE9040AA5931F0689B9B40F0575D8AAAEE9040ECFCD127719B9B40E2AF06B4ADEE9040D31BFB2C799B9B40D9A9E967B1EE90407D141AF6809B9B4076E29AA1B5EE9040B1EEE379889B9B40D2400F5CBAEE9040637360AF8F9B9B408AFBA191BFEE904070E1F48D969B9B4038551B3CC5EE9040CF326E0D9D9B9B405908B854CBEE9040F0E50A26A39B9B40B85931D4D1EE90409E3F84D0A89B9B40C5C7C5B2D8EE904056FA1606AE9B9B40774C42E8DFEE9040B2588BC0B29B9B40AB260C6CE7EE90404E913CFAB69B9B40551F2B35EFEE9040458B1FAEBA9B9B403C3E543AF7EE904038E3C8D7BD9B9B407DE1F471FFEE9040B9317273C09B9B409D2A3ED207EF9040CB8CFE7DC29B9B4073B3305110EF90400E3FFEF4C39B9B40107DA8E418EF904038B0B1D6C49B9B40490A698221EF9040507B0B22C59B9B407D4836FB16F09040507B0B22C59B9B40B6D5F6981FF0904038B0B1D6C49B9B40539F6E2C28F090400E3FFEF4C39B9B40292861AB30F09040CB8CFE7DC29B9B404971AA0B39F09040B9317273C09B9B408A144B4341F0904038E3C8D7BD9B9B407133744849F09040468B1FAEBA9B9B401B2C931151F090404F913CFAB69B9B4050065D9558F09040B2588BC0B29B9B40018BD9CA5FF0904056FA1606AE9B9B400EF96DA966F090409E3F84D0A89B9B406D4AE7286DF09040F0E50A26A39B9B408EFD834173F09040CF326E0D9D9B9B403D57FDEB78F0904070E1F48D969B9B40F41190217EF09040637360AF8F9B9B40507004DC82F09040B1EEE379889B9B40EDA8B51587F090407D141AF6809B9B40E4A298C98AF09040D31BFB2C799B9B40D6FA41F38DF09040ECFCD127719B9B405849EB8E90F09040AA5931F0689B9B4069A4779992F090408B10E88F609B9B40AD56771094F09040B587F510589B9B40D7C72AF294F0904018BE7D7D4F9B9B40EE92843D95F09040DF30BDDF469B9B40EE92843D95F0904056759FB4419A9B4048B48E4C69F0904056759FB4419A9B4001020000000400000048B48E4C69F0904056759FB4419A9B400B15FB6550F09040B6E171882B9A9B40BB3DA417E8EE9040B6E171882B9A9B407E9E1031CFEE904056759FB4419A9B40010200000004000000839E1031CFEE9040C6A53F9091949B40C03DA417E8EE904066396DBCA7949B401015FB6550F0904066396DBCA7949B404DB48E4C69F09040C6A53F9091949B400102000000340000004DB48E4C69F09040C6A53F9091949B40F392843D95F09040C6A53F9091949B40F392843D95F090403EEA21658C939B40DCC72AF294F09040045D61C783939B40B156771094F090406793E9337B939B406EA4779992F09040910AF7B472939B405C49EB8E90F0904072C1AD546A939B40DBFA41F38DF09040301E0D1D62939B40E9A298C98AF0904049FFE3175A939B40F2A8B51587F090409F06C54E52939B40557004DC82F090406B2CFBCA4A939B40F91190217EF09040B9A77E9543939B404157FDEB78F09040AC39EAB63C939B4093FD834173F090404DE8703736939B40724AE7286DF090402C35D41E30939B4013F96DA966F090407EDB5A742A939B40068BD9CA5FF09040C620C83E25939B4054065D9558F090406AC2538420939B40202C931151F09040CE89A24A1C939B407633744849F09040D78FBF9618939B408F144B4341F09040E437166D15939B404E71AA0B39F0904063E96CD112939B402E2861AB30F09040518EE0C610939B40589F6E2C28F090400EDCE04F0F939B40BBD5F6981FF09040E46A2D6E0E939B40824836FB16F09040CC9FD3220E939B404E0A698221EF9040CC9FD3220E939B40157DA8E418EF9040E46A2D6E0E939B4078B3305110EF90400EDCE04F0F939B40A22A3ED207EF9040518EE0C610939B4082E1F471FFEE904063E96CD112939B40413E543AF7EE9040E437166D15939B405A1F2B35EFEE9040D68FBF9618939B40B0260C6CE7EE9040CD89A24A1C939B407B4C42E8DFEE90406AC2538420939B40CAC7C5B2D8EE9040C620C83E25939B40BD5931D4D1EE90407EDB5A742A939B405E08B854CBEE90402C35D41E30939B403D551B3CC5EE90404DE8703736939B408EFBA191BFEE9040AC39EAB63C939B40D7400F5CBAEE9040B9A77E9543939B407BE29AA1B5EE90406B2CFBCA4A939B40DEA9E967B1EE90409F06C54E52939B40E7AF06B4ADEE904049FFE3175A939B40F5575D8AAAEE9040301E0D1D62939B407309B4EEA7EE904072C1AD546A939B4062AE27E4A5EE9040910AF7B472939B401EFC276DA4EE90406793E9337B939B40F48A748BA3EE9040045D61C783939B40DDBF1A40A3EE90403DEA21658C939B40DDBF1A40A3EE9040C6A53F9091949B40839E1031CFEE9040C6A53F9091949B4001020000000200000010411187CFEE90403DEA21658C939B40839E1031CFEE9040C6A53F9091949B400102000000200000000B411187CFEE9040DF30BDDF469B9B400E20D20DD4EE90405B0A35D34C9B9B401116D7FBD8EE9040BD584B72529B9B4088DEFF4ADEEE904048CE03B6579B9B408B7EB3F4E3EE9040FDA6D3975C9B9B40A277E8F1E9EE9040CCC9A911619B9B4076862D3BF0EE90408E52F61D659B9B4064E2B2C8F6EE90406B7BB1B7689B9B4090F25392FDEE904029DD61DA6B9B9B405C6CA18F04EF90407DFE21826E9B9B40ABCEEBB70BEF9040982BA5AB709B9B40F52C4E0213EF9040D48F3B54729B9B40BC3CB9651AEF9040708CD579739B9B40A697FED821EF90403948061B749B9B403E24DC5229EF9040F0740537749B9B40349707CA30EF90402D48B0CD739B9B4092BB97B307F090402D48B0CD739B9B40882EC32A0FF09040F0740537749B9B4020BBA0A416F090403948061B749B9B400A16E6171EF09040708CD579739B9B40D125517B25F09040D48F3B54729B9B401B84B3C52CF09040982BA5AB709B9B406AE6FDED33F090407DFE21826E9B9B4036604BEB3AF0904029DD61DA6B9B9B406370ECB441F090406B7BB1B7689B9B4050CC714248F090408E52F61D659B9B4024DBB68B4EF09040CCC9A911619B9B403BD4EB8854F09040FDA6D3975C9B9B403E749F325AF0904048CE03B6579B9B40B53CC8815FF09040BD584B72529B9B40B832CD6F64F090405B0A35D34C9B9B40BB118EF668F09040DF30BDDF469B9B400102000000300000000B411187CFEE9040DF30BDDF469B9B40B065FEB7CFEE9040FE48F7774C9B9B40BC6D8B4AD0EE90402BE38309529B9B403A6D093ED1EE9040DF79BD8D579B9B40E9C25591D2EE9040F36E0EFE5C9B9B402673DB42D4EE904084E7F853629B9B40490B9550D6EE9040908B1E89679B9B40480B0FB8D8EE9040E61F48976C9B9B40AED26A76DBEE904072F16C78719B9B40740D6288DEEE9040F508BA26769B9B40A29C4AEAE1EE9040A21E999C7A9B9B4008F61A98E5EE90404A45B7D47E9B9B40DEF56E8DE9EE90401F450BCA829B9B40851C8DC5EDEE9040859EDB77869B9B4032326C3BF2EE9040B42DC4D9899B9B40B549B9E9F6EE90407A68BBEB8C9B9B40411BDECAFBEE9040E02F17AA8F9B9B4098AF07D900EF9040DE2F9111929B9B40A4532D0E06EF904002C84A1F949B9B4035CC17640BEF90403F78D0D0959B9B4048C168D410EF9040EECD1C24979B9B40FD57A25816EF90406BCD9A17989B9B402AF22EEA1BEF904078D527AA989B9B40490A698221EF90401DFA14DB989B9B407D4836FB16F090401DFA14DB989B9B409C6070931CF0904078D527AA989B9B40C9FAFC2422F090406CCD9A17989B9B407E9136A927F09040EECD1C24979B9B40918687192DF090403F78D0D0959B9B4022FF716F32F0904002C84A1F949B9B402EA397A437F09040DF2F9111929B9B408537C1B23CF09040E02F17AA8F9B9B401109E69341F090407A68BBEB8C9B9B409420334246F09040B42DC4D9899B9B40413612B84AF09040859EDB77869B9B40E85C30F04EF090401F450BCA829B9B40BE5C84E552F090404A45B7D47E9B9B4024B6549356F09040A31E999C7A9B9B4052453DF559F09040F508BA26769B9B40188034075DF0904073F16C78719B9B407E4790C55FF09040E71F48976C9B9B407D470A2D62F09040908B1E89679B9B40A0DFC33A64F0904084E7F853629B9B40DD8F49EC65F09040F36E0EFE5C9B9B408CE5953F67F09040E079BD8D579B9B400AE5133368F090402BE38309529B9B4016EDA0C568F09040FE48F7774C9B9B40BB118EF668F09040DF30BDDF469B9B40010200000030000000C0118EF668F090403DEA21658C939B401BEDA0C568F090401ED2E7CC86939B400FE5133368F09040F1375B3B81939B4091E5953F67F090403DA121B77B939B40E28F49EC65F0904029ACD04676939B40A5DFC33A64F090409833E6F070939B4082470A2D62F090408C8FC0BB6B939B40834790C55FF0904036FB96AD66939B401D8034075DF09040AA2972CC61939B4057453DF559F090402712251E5D939B4029B6549356F090407AFC45A858939B40C35C84E552F09040D2D5277054939B40ED5C30F04EF09040FDD5D37A50939B40463612B84AF09040977C03CD4C939B409920334246F0904068ED1A6B49939B401609E69341F09040A2B2235946939B408A37C1B23CF090403CEBC79A43939B4033A397A437F090403EEB4D3341939B4027FF716F32F090401A5394253F939B40968687192DF09040DDA20E743D939B40839136A927F090402E4DC2203C939B40CEFAFC2422F09040B14D442D3B939B40A16070931CF09040A445B79A3A939B40824836FB16F09040FF20CA693A939B404E0A698221EF9040FF20CA693A939B402FF22EEA1BEF9040A445B79A3A939B400258A25816EF9040B04D442D3B939B404DC168D410EF90402E4DC2203C939B403ACC17640BEF9040DDA20E743D939B40A9532D0E06EF90401A5394253F939B409DAF07D900EF90403DEB4D3341939B40461BDECAFBEE90403CEBC79A43939B40BA49B9E9F6EE9040A2B2235946939B4037326C3BF2EE904068ED1A6B49939B408A1C8DC5EDEE9040977C03CD4C939B40E3F56E8DE9EE9040FDD5D37A50939B400DF61A98E5EE9040D2D5277054939B40A79C4AEAE1EE904079FC45A858939B40790D6288DEEE90402712251E5D939B40B3D26A76DBEE9040A92972CC61939B404D0B0FB8D8EE904035FB96AD66939B404E0B9550D6EE90408C8FC0BB6B939B402B73DB42D4EE90409833E6F070939B40EEC25591D2EE904029ACD04676939B403F6D093ED1EE90403CA121B77B939B40C16D8B4AD0EE9040F1375B3B81939B40B565FEB7CFEE90401ED2E7CC86939B4010411187CFEE90403DEA21658C939B40010200000020000000C0118EF668F090403DEA21658C939B40BD32CD6F64F09040C110AA7186939B40BA3CC8815FF090405FC293D280939B4043749F325AF09040D44CDB8E7B939B4040D4EB8854F090401F740BAD76939B4029DBB68B4EF090405051353372939B4055CC714248F090408EC8E8266E939B406770ECB441F09040B19F2D8D6A939B403B604BEB3AF09040F33D7D6A67939B406FE6FDED33F090409F1CBDC264939B402084B3C52CF0904084EF399962939B40D625517B25F09040488BA3F060939B400F16E6171EF09040AC8E09CB5F939B4025BBA0A416F09040E3D2D8295F939B408D2EC32A0FF090402CA6D90D5F939B4097BB97B307F09040EFD22E775F939B40399707CA30EF9040EFD22E775F939B404324DC5229EF90402CA6D90D5F939B40AB97FED821EF9040E3D2D8295F939B40C13CB9651AEF9040AC8E09CB5F939B40FA2C4E0213EF9040488BA3F060939B40B0CEEBB70BEF904084EF399962939B40616CA18F04EF90409F1CBDC264939B4095F25392FDEE9040F33D7D6A67939B4068E2B2C8F6EE9040B19F2D8D6A939B407B862D3BF0EE90408EC8E8266E939B40A777E8F1E9EE90405051353372939B40907EB3F4E3EE90401F740BAD76939B408DDEFF4ADEEE9040D44CDB8E7B939B401616D7FBD8EE90405FC293D280939B401320D20DD4EE9040C110AA7186939B4010411187CFEE90403DEA21658C939B4001020000000200000006D502A1F0EE904056A98D342A879B40391AFB9AF0EE9040BF945B352A879B40010200000002000000589A376354F09040A053EC0C968C9B409B7E71CD6CF09040A053EC0C968C9B40010200000003000000589A376354F09040A053EC0C968C9B409B7E71CD6CF09040A153EC0C968C9B409B7E71CD6CF09040A053EC0C968C9B400102000000080000009B7E71CD6CF09040A053EC0C968C9B409E7E71CD6CF09040A053EC0C968C9B409E7E71CD6CF090404D9BCD87AA8C9B40569DF6B83EF090404D9BCD87AA8C9B40569DF6B83EF09040243F3EC5B48C9B400EBC7BA410F09040243F3EC5B48C9B400EBC7BA410F09040A053EC0C968C9B40589A376354F09040A053EC0C968C9B40010200000002000000BB118EF668F09040DF30BDDF469B9B4048B48E4C69F0904056759FB4419A9B400102000000040000004DB48E4C69F09040C6A53F9091949B40C0118EF668F09040C6A53F9091949B40C0118EF668F090403EEA21658C939B40C0118EF668F090403DEA21658C939B400102000000160000009E7E71CD6CF090404E9BCD87AA8C9B406978A928A5F0904037BF7F72AC8C9B40BB303341DDF09040D4935130B28C9B40964BAFD414F19040B40278BABB8C9B40A1DA5BA14BF19040CC7FA905C98C9B40042B626681F190405A642B02DA8C9B40F37C23E4B5F19040378BE49BEE8C9B40264A84DCE8F19040961875BA068D9B401AC235131AF29040FA505341228D9B404625FD4D49F290405D5DED0F418D9B40B6AAF85476F2904080D4CF01638D9B40A49EE1F2A0F29040CCDBD0EE878D9B40BD6B4BF5C8F29040D4AC3FABAF8D9B408D44DF2CEEF290401C471808DA8D9B406B26946D10F3904015113BD3068E9B40B6F3E28E2FF390406C26A8D7358E9B409D67F66B4BF390408E0DBEDD668E9B40D3AAD6E363F39040268A7BAB998E9B40935590D978F39040AE3EC404CE8E9B40C3B056348AF39040E9CBA7AB038F9B40C40DA1DF97F39040261AAB603A8F9B401D1243CBA1F390407A7513E3718F9B400102000000020000003D19677C4BF19040B26B5BD9BBA79B4090D1850137F19040B26B5BD9BBA79B400102000000060000003D19677C4BF19040B26B5BD9BBA79B403D19677C4BF19040F84CD6EDE9A79B4015BDD7B955F19040F84CD6EDE9A79B4015BDD7B955F190403F2E510218A89B4090D1850137F190403F2E510218A89B4090D1850137F19040B26B5BD9BBA79B4001020000000300000090D1850137F19040B26B5BD9BBA79B4090D1850137F19040B06B5BD9BBA79B403D19677C4BF19040B06B5BD9BBA79B400102000000020000003D19677C4BF19040B06B5BD9BBA79B403D19677C4BF19040B26B5BD9BBA79B400102000000160000003D19677C4BF19040B06B5BD9BBA79B40212811C94DF1904055D482A678A79B40B1524EAC54F190407F1025C435A79B40F3DEDE1D60F19040EB905C82F3A69B40263C0E1070F1904036748330B2A69B40C26CC36F84F19040DA7DD41C72A69B40B9E597249DF190404E650D9433A69B4091C7F410BAF190408AED12E1F6A59B40624E3612DBF19040EB32974CBCA59B403B4ED50000F29040039BC21C84A59B403E8A96B028F2904078CEDF944EA59B40D3ADBFF054F29040B0210BF51BA59B4065A8518C84F29040BBCCE579ECA49B40DC25484AB7F29040804E4D5CC0A49B40C8D7DDEDECF29040135217D197A49B406A3DD53625F39040D567D20873A49B408793C5E15FF3904018DE8B2F52A49B40CB8F6BA89CF39040FAFE9A6C35A49B401887FD41DBF3904096F271E21CA49B40FA9982631BF490400F7E74AE08A49B40C97E2CC05CF49040C7D0D4E8F8A39B400B7EB3099FF49040F78976A4EDA39B400102000000020000003F19677C4BF19040B26B5BD9BBA79B403D19677C4BF19040B26B5BD9BBA79B40010200000004000000881F648D85F390406056CD666F8F9B4001D38DFB85F390406E41F851748F9B40332741DF48F390409329ABAA798F9B40BA73177148F39040843E80BF748F9B40010200000002000000BA73177148F39040843E80BF748F9B405F5EF48358F39040A015E2A26F8F9B40010200000002000000881F648D85F390406056CD666F8F9B40BA73177148F39040843E80BF748F9B4001020000000200000054628C514DF3904068556D7DAC8F9B4012EC22095EF390402727A0BBAE8F9B40010200000004000000220ED96D8AF39040436DBA24A78F9B40A95AAFFF89F3904036828F39A28F9B40DBAE62E34CF390405A6A4292A78F9B4054628C514DF3904068556D7DAC8F9B40010200000002000000220ED96D8AF39040436DBA24A78F9B4054628C514DF3904068556D7DAC8F9B40010200000002000000C83FEBF570F39040B6A2A0342E8F9B402886426651F39040FE8C81F7308F9B40010200000019000000397AF3A551F39040B38D2025568F9B40F45CADCD50F390403C13E258558F9B4025DAF69B4FF39040871C480D548F9B40B931E9814EF39040380056AD528F9B404700DE804DF3904042FFBA3A518F9B40323D109A4CF39040EE373DB74F8F9B40B4B89ACE4BF390406079B7244E8F9B4059C1761F4BF39040D6FD16854C8F9B4080F27A8D4AF39040380E59DA4A8F9B40642D5A194AF390401C928826498F9B40E8BDA2C349F39040008FBB6B478F9B4041ACBD8C49F39040F09910AC458F9B403D3CEE7449F39040AE3EACE9438F9B40DB9A517C49F39040895FB626428F9B4087BADEA249F390401E915765408F9B40365E66E849F390403F75B6A73E8F9B404653934C4AF390403D18F5EF3C8F9B40E0D9EACE4AF39040CE532E403B8F9B40693BCD6E4BF39040C83A739A398F9B402F8E762B4CF39040D490C800388F9B407BA5FF034DF390403A512475368F9B40D62C5FF74DF39040C2476BF9348F9B4027ED6A044FF39040B2BE6E8F338F9B401E3AD92950F39040A244EA38328F9B402886426651F39040008D81F7308F9B40010200000002000000397AF3A551F39040B38D2025568F9B400C093CA151F39040E6308A25568F9B400102000000060000007C037AC757F390406340AA575A8F9B40A6924F6256F390407AD3B79D598F9B4092EB9DE154F39040040548B2588F9B40D8551F7253F39040BA22CFAC578F9B40DA1F961552F3904028918D8E568F9B40397AF3A551F39040B38D2025568F9B400102000000020000003AB3E92B77F3904009E3B6DC528F9B40397AF3A551F39040B38D2025568F9B400102000000020000007C037AC757F390406340AA575A8F9B40D29495C457F39040EC07EB575A8F9B4001020000000300000091BCDB8F59F390403A871B225B8F9B406BE95CF257F390409010FE6D5A8F9B407C037AC757F390406340AA575A8F9B4001020000000200000073D2D2DC71F39040330F790F588F9B407C037AC757F390406340AA575A8F9B400102000000020000005F5EF48358F39040A015E2A26F8F9B40B39A7C315AF39040EEA2D62B6D8F9B40010200000002000000CA95CDD574F39040A1849A286D8F9B405F5EF48358F39040A015E2A26F8F9B400102000000030000000357491E5AF39040918F117E618F9B40B9C0C12D59F3904004BA1C93618F9B40B39A7C315AF39040EEA2D62B6D8F9B40010200000004000000B808F5CC70F3904045FD0C825F8F9B40476E873E70F39040EEF41626598F9B4092BCDB8F59F390403A871B225B8F9B400357491E5AF39040918F117E618F9B40010200000002000000B808F5CC70F3904045FD0C825F8F9B400357491E5AF39040918F117E618F9B40010200000002000000FA7837C172F39040BCBBBB056B8F9B40B39A7C315AF39040EEA2D62B6D8F9B40010200000002000000A3CE06B35BF39040BFC88307C98F9B40725D4FAE5BF39040F26BED07C98F9B4001020000001A000000B5FBAD7881F39040CA1EB9ECEA8F9B40144205E961F3904012099AAFED8F9B40FBA79A7960F39040201305AAEC8F9B405C52271D5FF39040CEE0A88BEB8F9B40C13956D55DF39040AF55E455EA8F9B402A0EB9A35CF390400204330AE98F9B40D94AC6895BF39040955B2BAAE78F9B406D6BD7885AF39040C5B77C37E68F9B40964427A259F39040E84EEDB3E48F9B404882D0D658F39040BE055821E38F9B405C4DCC2758F390408E29AA81E18F9B40471AF19557F39040A813E1D6DF8F9B404EA2F12157F3904049B90723DE8F9B4088085CCC56F39040CD2A3468DC8F9B40B42B999556F39040440585A8DA8F9B40B525EC7D56F3904094D91EE6D88F9B405EF9718556F39040448C2923D78F9B40E56E21AC56F390403FB1CD61D58F9B402A1FCBF156F39040BAE631A4D38F9B40D1AD195657F390407F3278ECD18F9B40DC3192D857F39040E464BB3CD08F9B403FCC947858F390408A840C97CE8F9B40CD6B5D3559F390401E4670FDCC8F9B4077BD040E5AF390403D93DC71CB8F9B40B94781015BF39040692336F6C98F9B40A3CE06B35BF39040BFC88307C98F9B40010200000006000000A3CE06B35BF39040BFC88307C98F9B40F0AFA80E5CF390401C2A4E8CC88F9B40E62731345DF39040BC1CE035C78F9B40FA01B3705EF390403E938FF4C58F9B40D569AAC25FF39040FA45E6C9C48F9B4065AF1D0261F39040979CC1D4C38F9B40010200000002000000A007FD3881F39040151E1ABFC58F9B40A3CE06B35BF39040BFC88307C98F9B4001020000000200000012EC22095EF390402727A0BBAE8F9B40E208B91D60F390400CF07EDEB08F9B400102000000020000007D23FC5A7AF3904028965841AC8F9B4012EC22095EF390402727A0BBAE8F9B4001020000000400000029E773AD78F39040DA0864B8AE8F9B4022C12EB179F39040C2F11D51BA8F9B40DBE2732161F39040F6D83877BC8F9B40E208B91D60F390400CF07EDEB08F9B4001020000000200000029E773AD78F39040DA0864B8AE8F9B40E208B91D60F390400CF07EDEB08F9B4001020000000200000065AF1D0261F39040979CC1D4C38F9B40BC4039FF60F39040206402D5C38F9B4001020000000300000065AF1D0261F39040979CC1D4C38F9B40A73F792861F390403C2B52B7C38F9B40951369A062F39040DCB623BEC28F9B40010200000002000000597E76177BF39040636B908CC18F9B4065AF1D0261F39040979CC1D4C38F9B40010200000004000000D92AA7C078F39040361C2966BA8F9B404BC5144F79F390408E241FC2C08F9B40951369A062F39040DAB623BEC28F9B402479FB1162F3904083AE2D62BC8F9B4001020000000300000073D2D2DC71F39040330F790F588F9B40344277B671F390408C80E82C588F9B40466E873E70F39040EEF41626598F9B40010200000002000000B808F5CC70F3904046FD0C825F8F9B40B808F5CC70F3904045FD0C825F8F9B40010200000003000000FA7837C172F39040BCBBBB056B8F9B40019F7CBD71F39040D2D2016D5F8F9B40B808F5CC70F3904045FD0C825F8F9B40010200000019000000C83FEBF570F39040B7A2A0342E8F9B40E1D9556572F39040A998353A2F8F9B40802FC9C173F39040FBCA9158308F9B401B489A0975F390401A56568E318F9B40B173373B76F39040C8A707DA328F9B4003372A5577F3904034500F3A348F9B406E16195678F3904004F4BDAC358F9B40453DC93C79F39040E25C4D30378F9B4094FF1F087AF390400AA6E2C2388F9B40803424B77AF390403A8290623A8F9B409567FF487BF390402198590D3C8F9B408DDFFEBC7BF3904080F232C13D8F9B40537994127CF39040FC80067C3F8F9B40285657497CF3904084A6B53B418F9B40275C04617CF3904035D21BFE428F9B407D887E597CF39040851F11C1448F9B40F712CF327CF390408AFA6C82468F9B40B26225ED7BF3904010C50840488F9B400AD4D6887BF390404A79C2F7498F9B4000505E067BF39040E4467FA74B8F9B409DB55B667AF3904040272E4D4D8F9B400E1693A979F39040AB65CAE64E8F9B4065C4EBD078F390408C185E72508F9B40223A6FDD77F39040608804EE518F9B403AB3E92B77F3904009E3B6DC528F9B400102000000060000003AB3E92B77F3904009E3B6DC528F9B40ECD147D076F39040AE81EC57538F9B40F559BFAA75F390400C8F5AAE548F9B40E27F3D6E74F390408B18ABEF558F9B400618461C73F39040D065541A578F9B4073D2D2DC71F39040330F790F588F9B400102000000020000002041B7DF71F39040AA47380F588F9B4073D2D2DC71F39040330F790F588F9B40010200000002000000CA95CDD574F39040A1849A286D8F9B40FA7837C172F39040BCBBBB056B8F9B40010200000002000000881F648D85F390406056CD666F8F9B40CA95CDD574F39040A1849A286D8F9B400102000000020000006924A13077F39040D63F4DDC528F9B403AB3E92B77F3904009E3B6DC528F9B400102000000020000007D23FC5A7AF3904028965841AC8F9B4029E773AD78F39040DA0864B8AE8F9B400102000000030000004AC5144F79F390408F241FC2C08F9B40719893EC7AF390403A9B3C76C18F9B40597E76177BF39040636B908CC18F9B40010200000002000000220ED96D8AF39040436DBA24A78F9B407D23FC5A7AF3904028965841AC8F9B40010200000006000000597E76177BF39040636B908CC18F9B4036EFA07C7CF3904050D88246C28F9B40499652FD7DF39040C5A6F231C38F9B40042CD16C7FF390400E896B37C48F9B4001625AC980F39040A21AAD55C58F9B40A007FD3881F39040151E1ABFC58F9B400102000000020000000AED5A1A7BF39040DAA34F8CC18F9B40597E76177BF39040636B908CC18F9B40010200000019000000A007FD3881F39040151E1ABFC58F9B40E724431182F390408C98588BC68F9B40B7A7F94283F39040428FF2D6C78F9B402250075D84F3904092ABE436C98F9B409481125E85F3904087AC7FA9CA8F9B40AA44E04486F39040DC73FD2CCC8F9B4028C9551087F39040683283BFCD8F9B4082C079BF87F39040F4AD235FCF8F9B405B8F755188F39040909DE109D18F9B40785496C588F39040AC19B2BDD28F9B40F4C34D1B89F39040C81C7F78D48F9B409BD5325289F39040D8112A38D68F9B409F45026A89F390401A6D8EFAD78F9B4001E79E6289F39040404C84BDD98F9B4054C7113C89F39040AB1AE37EDB8F9B40A5238AF688F390408A36843CDD8F9B40962E5D9288F390408C9345F4DE8F9B40FCA7051088F39040FB570CA4E08F9B407346237087F390400171C749E28F9B40ADF379B386F39040F41A72E3E38F9B4061DCF0DA85F390408F5A166FE58F9B40065591E784F390400664CFEAE68F9B40B59485DA83F3904018EDCB54E88F9B40BE4717B582F39040286750ABE98F9B40B4FBAD7881F39040CA1EB9ECEA8F9B40010200000002000000D078B43D81F39040E27AB0BEC58F9B40A007FD3881F39040151E1ABFC58F9B400102000000040000004B6BDDFD9BF3904056759FB4419A9B40D80DDE539CF3904056759FB4419A9B40D80DDE539CF39040DE30BDDF469B9B40D80DDE539CF39040DF30BDDF469B9B400102000000340000004B6BDDFD9BF3904056759FB4419A9B40A58CE70C70F3904056759FB4419A9B40A58CE70C70F39040DE30BDDF469B9B40BC57415870F3904018BE7D7D4F9B9B40E7C8F43971F39040B587F510589B9B402A7BF4B072F390408B10E88F609B9B403CD680BB74F39040AA5931F0689B9B40BD242A5777F39040ECFCD127719B9B40AF7CD3807AF39040D31BFB2C799B9B40A676B6347EF390407D141AF6809B9B4043AF676E82F39040B1EEE379889B9B409F0DDC2887F39040637360AF8F9B9B4057C86E5E8CF3904070E1F48D969B9B400522E80892F39040CF326E0D9D9B9B4026D5842198F39040F0E50A26A39B9B408526FEA09EF390409E3F84D0A89B9B409294927FA5F3904056FA1606AE9B9B4044190FB5ACF39040B2588BC0B29B9B4078F3D838B4F390404E913CFAB69B9B4022ECF701BCF39040458B1FAEBA9B9B40090B2107C4F3904038E3C8D7BD9B9B404AAEC13ECCF39040B9317273C09B9B406AF70A9FD4F39040CB8CFE7DC29B9B404080FD1DDDF390400E3FFEF4C39B9B40DD4975B1E5F3904038B0B1D6C49B9B4016D7354FEEF39040507B0B22C59B9B404A1503C8E3F49040507B0B22C59B9B4083A2C365ECF4904038B0B1D6C49B9B40206C3BF9F4F490400E3FFEF4C39B9B40F6F42D78FDF49040CB8CFE7DC29B9B40163E77D805F59040B9317273C09B9B4057E117100EF5904038E3C8D7BD9B9B403E00411516F59040468B1FAEBA9B9B40E8F85FDE1DF590404F913CFAB69B9B401DD3296225F59040B2588BC0B29B9B40CE57A6972CF5904056FA1606AE9B9B40DBC53A7633F590409E3F84D0A89B9B403A17B4F539F59040F0E50A26A39B9B405BCA500E40F59040CF326E0D9D9B9B400A24CAB845F5904070E1F48D969B9B40C1DE5CEE4AF59040637360AF8F9B9B401D3DD1A84FF59040B1EEE379889B9B40BA7582E253F590407D141AF6809B9B40B16F659657F59040D31BFB2C799B9B40A3C70EC05AF59040ECFCD127719B9B402516B85B5DF59040AA5931F0689B9B40367144665FF590408B10E88F609B9B407A2344DD60F59040B587F510589B9B40A494F7BE61F5904018BE7D7D4F9B9B40BB5F510A62F59040DF30BDDF469B9B40BB5F510A62F5904056759FB4419A9B4015815B1936F5904056759FB4419A9B4001020000000400000015815B1936F5904056759FB4419A9B40D8E1C7321DF59040B6E171882B9A9B40880A71E4B4F39040B6E171882B9A9B404B6BDDFD9BF3904056759FB4419A9B400102000000040000004F6BDDFD9BF39040C6A53F9091949B408C0A71E4B4F3904066396DBCA7949B40DCE1C7321DF5904066396DBCA7949B4019815B1936F59040C6A53F9091949B4001020000003400000019815B1936F59040C6A53F9091949B40BF5F510A62F59040C6A53F9091949B40BF5F510A62F590403EEA21658C939B40A894F7BE61F59040045D61C783939B407D2344DD60F590406793E9337B939B403A7144665FF59040910AF7B472939B402816B85B5DF5904072C1AD546A939B40A7C70EC05AF59040301E0D1D62939B40B56F659657F5904049FFE3175A939B40BE7582E253F590409F06C54E52939B40213DD1A84FF590406B2CFBCA4A939B40C5DE5CEE4AF59040B9A77E9543939B400D24CAB845F59040AC39EAB63C939B405FCA500E40F590404DE8703736939B403E17B4F539F590402C35D41E30939B40DFC53A7633F590407EDB5A742A939B40D257A6972CF59040C620C83E25939B4020D3296225F590406AC2538420939B40ECF85FDE1DF59040CE89A24A1C939B404200411516F59040D78FBF9618939B405BE117100EF59040E437166D15939B401A3E77D805F5904063E96CD112939B40FAF42D78FDF49040518EE0C610939B40246C3BF9F4F490400EDCE04F0F939B4087A2C365ECF49040E46A2D6E0E939B404E1503C8E3F49040CC9FD3220E939B401AD7354FEEF39040CC9FD3220E939B40E14975B1E5F39040E46A2D6E0E939B404480FD1DDDF390400EDCE04F0F939B406EF70A9FD4F39040518EE0C610939B404EAEC13ECCF3904063E96CD112939B400D0B2107C4F39040E437166D15939B4026ECF701BCF39040D68FBF9618939B407CF3D838B4F39040CD89A24A1C939B4047190FB5ACF390406AC2538420939B409694927FA5F39040C620C83E25939B408926FEA09EF390407EDB5A742A939B402AD5842198F390402C35D41E30939B400922E80892F390404DE8703736939B405AC86E5E8CF39040AC39EAB63C939B40A30DDC2887F39040B9A77E9543939B4047AF676E82F390406B2CFBCA4A939B40AA76B6347EF390409F06C54E52939B40B37CD3807AF3904049FFE3175A939B40C1242A5777F39040301E0D1D62939B403FD680BB74F3904072C1AD546A939B402E7BF4B072F39040910AF7B472939B40EAC8F43971F390406793E9337B939B40C057415870F39040045D61C783939B40A98CE70C70F390403DEA21658C939B40A98CE70C70F39040C6A53F9091949B404F6BDDFD9BF39040C6A53F9091949B40010200000002000000DC0DDE539CF390403DEA21658C939B404F6BDDFD9BF39040C6A53F9091949B40010200000020000000D80DDE539CF39040DF30BDDF469B9B40DBEC9EDAA0F390405B0A35D34C9B9B40DEE2A3C8A5F39040BD584B72529B9B4055ABCC17ABF3904048CE03B6579B9B40584B80C1B0F39040FDA6D3975C9B9B406F44B5BEB6F39040CCC9A911619B9B404353FA07BDF390408E52F61D659B9B4031AF7F95C3F390406B7BB1B7689B9B405DBF205FCAF3904029DD61DA6B9B9B4029396E5CD1F390407DFE21826E9B9B40789BB884D8F39040982BA5AB709B9B40C2F91ACFDFF39040D48F3B54729B9B4089098632E7F39040708CD579739B9B407364CBA5EEF390403948061B749B9B400BF1A81FF6F39040F0740537749B9B400164D496FDF390402D48B0CD739B9B405F886480D4F490402D48B0CD739B9B4055FB8FF7DBF49040F0740537749B9B40ED876D71E3F490403948061B749B9B40D7E2B2E4EAF49040708CD579739B9B409EF21D48F2F49040D48F3B54729B9B40E8508092F9F49040982BA5AB709B9B4037B3CABA00F590407DFE21826E9B9B40032D18B807F5904029DD61DA6B9B9B40303DB9810EF590406B7BB1B7689B9B401D993E0F15F590408E52F61D659B9B40F1A783581BF59040CCC9A911619B9B4008A1B85521F59040FDA6D3975C9B9B400B416CFF26F5904048CE03B6579B9B408209954E2CF59040BD584B72529B9B4085FF993C31F590405B0A35D34C9B9B4088DE5AC335F59040DF30BDDF469B9B40010200000030000000D80DDE539CF39040DF30BDDF469B9B407D32CB849CF39040FE48F7774C9B9B40893A58179DF390402BE38309529B9B40073AD60A9EF39040DF79BD8D579B9B40B68F225E9FF39040F36E0EFE5C9B9B40F33FA80FA1F3904084E7F853629B9B4016D8611DA3F39040908B1E89679B9B4015D8DB84A5F39040E61F48976C9B9B407B9F3743A8F3904072F16C78719B9B4041DA2E55ABF39040F508BA26769B9B406F6917B7AEF39040A21E999C7A9B9B40D5C2E764B2F390404A45B7D47E9B9B40ABC23B5AB6F390401F450BCA829B9B4052E95992BAF39040859EDB77869B9B40FFFE3808BFF39040B42DC4D9899B9B40821686B6C3F390407A68BBEB8C9B9B400EE8AA97C8F39040E02F17AA8F9B9B40657CD4A5CDF39040DE2F9111929B9B407120FADAD2F3904002C84A1F949B9B400299E430D8F390403F78D0D0959B9B40158E35A1DDF39040EECD1C24979B9B40CA246F25E3F390406BCD9A17989B9B40F7BEFBB6E8F3904078D527AA989B9B4016D7354FEEF390401DFA14DB989B9B404A1503C8E3F490401DFA14DB989B9B40692D3D60E9F4904078D527AA989B9B4096C7C9F1EEF490406CCD9A17989B9B404B5E0376F4F49040EECD1C24979B9B405E5354E6F9F490403F78D0D0959B9B40EFCB3E3CFFF4904002C84A1F949B9B40FB6F647104F59040DF2F9111929B9B4052048E7F09F59040E02F17AA8F9B9B40DED5B2600EF590407A68BBEB8C9B9B4061EDFF0E13F59040B42DC4D9899B9B400E03DF8417F59040859EDB77869B9B40B529FDBC1BF590401F450BCA829B9B408B2951B21FF590404A45B7D47E9B9B40F182216023F59040A31E999C7A9B9B401F120AC226F59040F508BA26769B9B40E54C01D429F5904073F16C78719B9B404B145D922CF59040E71F48976C9B9B404A14D7F92EF59040908B1E89679B9B406DAC900731F5904084E7F853629B9B40AA5C16B932F59040F36E0EFE5C9B9B4059B2620C34F59040E079BD8D579B9B40D7B1E0FF34F590402BE38309529B9B40E3B96D9235F59040FE48F7774C9B9B4088DE5AC335F59040DF30BDDF469B9B400102000000300000008CDE5AC335F590403DEA21658C939B40E7B96D9235F590401ED2E7CC86939B40DBB1E0FF34F59040F1375B3B81939B405DB2620C34F590403DA121B77B939B40AE5C16B932F5904029ACD04676939B4071AC900731F590409833E6F070939B404E14D7F92EF590408C8FC0BB6B939B404F145D922CF5904036FB96AD66939B40E94C01D429F59040AA2972CC61939B4023120AC226F590402712251E5D939B40F582216023F590407AFC45A858939B408F2951B21FF59040D2D5277054939B40B929FDBC1BF59040FDD5D37A50939B401203DF8417F59040977C03CD4C939B4065EDFF0E13F5904068ED1A6B49939B40E2D5B2600EF59040A2B2235946939B4056048E7F09F590403CEBC79A43939B40FF6F647104F590403EEB4D3341939B40F3CB3E3CFFF490401A5394253F939B40625354E6F9F49040DDA20E743D939B404F5E0376F4F490402E4DC2203C939B409AC7C9F1EEF49040B14D442D3B939B406D2D3D60E9F49040A445B79A3A939B404E1503C8E3F49040FF20CA693A939B401AD7354FEEF39040FF20CA693A939B40FBBEFBB6E8F39040A445B79A3A939B40CE246F25E3F39040B04D442D3B939B40198E35A1DDF390402E4DC2203C939B400699E430D8F39040DDA20E743D939B407520FADAD2F390401A5394253F939B40697CD4A5CDF390403DEB4D3341939B4012E8AA97C8F390403CEBC79A43939B40861686B6C3F39040A2B2235946939B4003FF3808BFF3904068ED1A6B49939B4056E95992BAF39040977C03CD4C939B40AFC23B5AB6F39040FDD5D37A50939B40D9C2E764B2F39040D2D5277054939B40736917B7AEF3904079FC45A858939B4045DA2E55ABF390402712251E5D939B407F9F3743A8F39040A92972CC61939B4019D8DB84A5F3904035FB96AD66939B401AD8611DA3F390408C8FC0BB6B939B40F73FA80FA1F390409833E6F070939B40BA8F225E9FF3904029ACD04676939B400B3AD60A9EF390403CA121B77B939B408D3A58179DF39040F1375B3B81939B408132CB849CF390401ED2E7CC86939B40DC0DDE539CF390403DEA21658C939B400102000000200000008CDE5AC335F590403DEA21658C939B4089FF993C31F59040C110AA7186939B408609954E2CF590405FC293D280939B400F416CFF26F59040D44CDB8E7B939B400CA1B85521F590401F740BAD76939B40F5A783581BF590405051353372939B4021993E0F15F590408EC8E8266E939B40333DB9810EF59040B19F2D8D6A939B40072D18B807F59040F33D7D6A67939B403BB3CABA00F590409F1CBDC264939B40EC508092F9F4904084EF399962939B40A2F21D48F2F49040488BA3F060939B40DBE2B2E4EAF49040AC8E09CB5F939B40F1876D71E3F49040E3D2D8295F939B4059FB8FF7DBF490402CA6D90D5F939B4063886480D4F49040EFD22E775F939B400564D496FDF39040EFD22E775F939B400FF1A81FF6F390402CA6D90D5F939B407764CBA5EEF39040E3D2D8295F939B408D098632E7F39040AC8E09CB5F939B40C6F91ACFDFF39040488BA3F060939B407C9BB884D8F3904084EF399962939B402D396E5CD1F390409F1CBDC264939B4061BF205FCAF39040F33D7D6A67939B4034AF7F95C3F39040B19F2D8D6A939B404753FA07BDF390408EC8E8266E939B407344B5BEB6F390405051353372939B405C4B80C1B0F390401F740BAD76939B4059ABCC17ABF39040D44CDB8E7B939B40E2E2A3C8A5F390405FC293D280939B40DFEC9EDAA0F39040C110AA7186939B40DC0DDE539CF390403DEA21658C939B40010200000003000000EB84F211A3F39040BEA77EC6718F9B40EC84F211A3F39040BEA77EC6718F9B40930C1416A7F3904084E815AE9F8F9B40010200000002000000930C1416A7F3904084E815AE9F8F9B40EB84F211A3F39040BEA77EC6718F9B40010200000004000000930C1416A7F3904084E815AE9F8F9B409E7E71CD6CF09040577271F8E78F9B40F5F64FC968F090409031DA10BA8F9B40EB84F211A3F39040BEA77EC6718F9B40010200000002000000664BB95F5BF49040447DE9AC1EA49B40664BB95F5BF49040457DE9AC1EA49B40010200000002000000664BB95F5BF49040457DE9AC1EA49B40AD359A225EF49040E636923C3EA49B40010200000019000000664BB95F5BF49040457DE9AC1EA49B4058414E655CF490402DE37E3D1DA49B40AA73AA835DF490408D8D0BE11BA49B40C9FE6EB95EF49040F2743A991AA49B407650200560F490405C499D6719A49B40E3F8276561F490400A86AA4D18A49B40B39CD6D762F490409FA6BB4C17A49B409005665B64F49040C87F0B6616A49B40B94EFBED65F4904079BDB49A15A49B40E92AA98D67F490408D88B0EB14A49B40D040723869F490407955D55914A49B402F9B4BEC6AF4904080DDD5E513A49B40AB291FA76CF49040BA43409013A49B40334FCE666EF49040E5667D5913A49B40E47A342970F49040E660D04113A49B4034C829EC71F490409034564913A49B4039A385AD73F4904016AA057013A49B40BF6D216B75F490405B5AAFB513A49B40F921DB2277F4904003E9FD1914A49B4093EF97D278F490400D6D769C14A49B40EECF46787AF490407007793C15A49B405A0EE3117CF49040FFA641F915A49B403BC1769D7DF49040A8F8E8D116A49B400F311D197FF49040EB8265C517A49B40B88BCF0780F49040D309EB7618A49B400102000000190000006236395083F49040D342E1FC3DA49B40EBBBFA8382F49040196027D53EA49B4036C5603881F49040E8E2DD0640A49B40E6A86ED87FF49040548BEB2041A49B40F1A7D3657EF49040C6BCF62142A49B409CE055E27CF49040DC7FC40843A49B400F22D04F7BF490405A043AD443A49B4084A62FB079F49040B4FB5D8344A49B40E7B6710578F490408DCA591545A49B40CB3AA15176F49040A98F7A8945A49B40AF37D49674F4904025FF31DF45A49B409F4229D772F49040CC10171646A49B405DE7C41471F49040D080E62D46A49B403808CF516FF490403222832646A49B40CD3970906DF490408602F6FF45A49B40EE1DCFD26BF49040D75E6EBA45A49B40ECC00D1B6AF49040C869415645A49B407DFC466B68F490402DE3E9D344A49B4077E38BC566F49040A481073444A49B408339E12B65F49040DE2E5E7743A49B40E9F93CA063F490409217D59E42A49B4071F0832462F49040379075AB41A49B40606787BA60F49040E6CF699E40A49B4050ED02645FF49040F082FB783FA49B40AE359A225EF49040E536923C3EA49B4001020000000200000085E8650780F49040A498337218A49B40B88BCF0780F49040D309EB7618A49B40010200000006000000B88BCF0780F49040D309EB7618A49B405C2A058380F4904021EB8CD218A49B40BB3773D981F49040186315F819A49B403AC1C31A83F490402C3D97341BA49B407E0E6D4584F4904007A58E861CA49B40E2B7913A85F490409AEA01C61DA49B40010200000002000000B88BCF0780F49040D309EB7618A49B406236395083F49040D342E1FC3DA49B400102000000020000006236395083F49040D342E1FC3DA49B4095D9A25083F4904001B498013EA49B4001020000000600000012E9C28287F4904090B95ADB37A49B40287CD0C886F49040682A854039A49B40B3AD60DD85F490407BD136C13AA49B4069CBE7D784F490403667B5303CA49B40D639A6B983F49040339D3E8D3DA49B406236395083F49040D342E1FC3DA49B4001020000000200000059F0503A85F49040EC7B1DC31DA49B40E2B7913A85F490409AEA01C61DA49B40010200000003000000E2B7913A85F490409AEA01C61DA49B403B29015885F49040D97A5DEC1DA49B409C9D2F5186F49040C74E4D641FA49B40010200000002000000E2B7913A85F490409AEA01C61DA49B4012E9C28287F4904090B95ADB37A49B4001020000000200000012E9C28287F4904090B95ADB37A49B409BB0038387F490403B283FDE37A49B40010200000003000000E92F344D88F490407C00F91236A49B403EB9169987F49040A2D377B037A49B4012E9C28287F4904090B95ADB37A49B40010200000003000000F4A525AD8CF4904055B4DFD51EA49B40B36235BE8EF4904053FC127536A49B409D4BEF569AF490405A22587135A49B40010200000004000000F4A525AD8CF4904055B4DFD51EA49B409C9D2F5186F49040C64E4D641FA49B40E92F344D88F490407B00F91236A49B4040382AA98EF490400A668B8435A49B400102000000030000006B64D43098F4904014449DE11CA49B40817B1A988CF490400C1E58E51DA49B40F4A525AD8CF4904055B4DFD51EA49B400102000000020000006B64D43098F4904014449DE11CA49B409D4BEF569AF490405A22587135A49B40010200000002000000502DB3539AF49040442707CD1AA49B406B64D43098F4904014449DE11CA49B40010200000002000000502DB3539AF49040442707CD1AA49B404EBEFACD9CF49040AE5EE01E37A49B400102000000020000000FFFE5919CF49040859D70150AA49B40502DB3539AF49040442707CD1AA49B400102000000020000004EBEFACD9CF49040AE5EE01E37A49B409D4BEF569AF490405A22587135A49B400102000000020000000FFFE5919CF49040859D70150AA49B4034E798EAA1F490405349BD3147A49B400102000000020000001EEA107DA1F490400CEA46A709A49B400FFFE5919CF49040859D70150AA49B4001020000000200000034E798EAA1F490405349BD3147A49B404EBEFACD9CF49040AE5EE01E37A49B400102000000030000001EEA107DA1F490400CEA46A709A49B4044D2C3D5A6F49040DA9593C346A49B4043D2C3D5A6F49040DA9593C346A49B4001020000000200000043D2C3D5A6F49040DA9593C346A49B401EEA107DA1F490400CEA46A709A49B400102000000040000001EEA107DA1F490400CEA46A709A49B406D5097F19EF490402138E290ECA39B4034912ED9CCF490407AB0C08CE8A39B40E52AA864CFF49040646225A305A49B4001020000000200000043D2C3D5A6F49040DA9593C346A49B4034E798EAA1F490405349BD3147A49B40010200000003000000E189A48622F59040B06B5BD9BBA79B401A490D9FF4F4904058F37CDDBFA79B4043D2C3D5A6F49040DA9593C346A49B400102000000020000000A135BBDD4F49040320E72BF42A49B40E52AA864CFF49040646225A305A49B40010200000004000000E52AA864CFF49040646225A305A49B40E32AA864CFF49040646225A305A49B4008135BBDD4F49040320E72BF42A49B400A135BBDD4F49040320E72BF42A49B40010200000002000000E52AA864CFF49040646225A305A49B40F215D34FD4F49040EBAEFB3405A49B40010200000002000000F215D34FD4F49040EBAEFB3405A49B40D83E716CD9F490409099D84715A49B40010200000002000000F215D34FD4F49040EBAEFB3405A49B4018FE85A8D9F49040B95A485142A49B40010200000002000000E189A48622F59040B06B5BD9BBA79B400A135BBDD4F49040320E72BF42A49B400102000000020000000A135BBDD4F49040320E72BF42A49B4018FE85A8D9F49040B95A485142A49B40010200000002000000D83E716CD9F490409099D84715A49B4089B17CE3DBF49040E4D560F516A49B40010200000002000000D83E716CD9F490409099D84715A49B40D6CFB8E6DBF49040FBD0B19931A49B4001020000000200000018FE85A8D9F49040B95A485142A49B40D6CFB8E6DBF49040FBD0B19931A49B4001020000000200000089B17CE3DBF49040E4D560F516A49B40BC989709DEF490402BB41B852FA49B4001020000000300000089B17CE3DBF49040E4D560F516A49B40729A367CE7F49040EBFBA5F115A49B40E5C44191E7F4904034922DE216A49B40010200000002000000D6CFB8E6DBF49040FBD0B19931A49B40BC989709DEF490402BB41B852FA49B40010200000003000000BC989709DEF490402BB41B852FA49B40A68151A2E9F4904032DA60812EA49B40E5C44191E7F4904034922DE216A49B40010200000002000000E5C44191E7F4904034922DE216A49B403ECD37EDEDF49040C3F7BF5316A49B400102000000020000003357468DE9F49040E943D9902DA49B408A5F3CE9EFF4904078A96B022DA49B400102000000020000003ECD37EDEDF49040C3F7BF5316A49B408A5F3CE9EFF4904078A96B022DA49B400102000000030000003ECD37EDEDF49040C3F7BF5316A49B40E84355A1EEF490409C2441B614A49B401414A9B7EEF49040AF3E5E8B14A49B400102000000020000008B4C68B7EEF4904003D0798814A49B401414A9B7EEF49040AF3E5E8B14A49B400102000000020000001414A9B7EEF49040AF3E5E8B14A49B404645DAFFF0F49040A70DB7A02EA49B400102000000060000001414A9B7EEF49040AF3E5E8B14A49B40FE809B71EFF49040D7CD332613A49B40744F0B5DF0F49040C42682A511A49B40BD318462F1F490400991033610A49B4050C3C580F2F490400C5B7AD90EA49B40C4C632EAF2F490406CB5D7690EA49B400102000000030000004645DAFFF0F49040A70DB7A02EA49B40EBD36AE2F0F49040667D5B7A2EA49B408A5F3CE9EFF4904078A96B022DA49B400102000000060000006F719C32F6F490406CEECDEF33A49B40CAD266B7F5F490401D0D2C9433A49B406BC5F860F4F490402795A36E32A49B40ED3BA81FF3F4904013BB213231A49B40A9EEFEF4F1F4904038532AE02FA49B404645DAFFF0F49040A70DB7A02EA49B400102000000020000004645DAFFF0F49040A70DB7A02EA49B40CF0C1B00F1F49040527C9BA32EA49B400102000000020000009123C9E9F2F490403D4420650EA49B40C4C632EAF2F490406CB5D7690EA49B40010200000002000000C4C632EAF2F490406CB5D7690EA49B406F719C32F6F490406CEECDEF33A49B40010200000019000000C4C632EAF2F490406CB5D7690EA49B403B4171B6F3F49040269891910DA49B40F1370B02F5F490405615DB5F0CA49B404054FD61F6F49040EB6CCD450BA49B40365598D4F7F49040793BC2440AA49B408A1C1658F9F490406378F45D09A49B4017DB9BEAFAF49040E5F37E9208A49B40A2563C8AFCF490408BFC5AE307A49B403F46FA34FEF49040B22D5F5107A49B405BC2CAE8FFF4904095683EDD06A49B4077C597A301F590401AF9868706A49B4087BA426303F5904072E7A15006A49B40C915A72505F590406E77D23806A49B40EFF49CE806F590400CD6354006A49B405AC3FBA908F59040B9F5C26606A49B4039DF9C670AF5904068994AAC06A49B403B3C5E1F0CF59040778E771007A49B40AA0025CF0DF590401215CF9207A49B40B019E0740FF590409A76B13208A49B40A3C38A0E11F5904060C95AEF08A49B403E032F9A12F59040ACE0E3C709A49B40B50CE81514F59040076843BB0AA49B40C695E47F15F5904058284FC80BA49B40D60F69D616F590404F75BDED0CA49B4078C7D11718F5904059C1262A0EA49B4001020000001A00000079C7D11718F5904058C1262A0EA49B40C1B1B2DA1AF59040F97ACFB92DA49B40CFBB1DD519F5904012153A292FA49B407D89C1B618F59040B26AAD8530A49B405EFEFC8017F590404D837ECD31A49B40B0AC4B3516F59040E3AE1BFF32A49B40440444D514F5904034720E1934A49B407460956213F59040A051FD1935A49B4096F705DF11F590407778AD0036A49B406DAE704C10F59040C63A04CC36A49B403DD2C2AC0EF59040B16F087B37A49B4057BCF9010DF59040C6A2E30C38A49B40F861204E0BF59040BF1AE38038A49B407CD34C9309F5904085B478D638A49B40F3AD9DD307F590405A913B0D39A49B404382371106F590405997E82439A49B40F334424E04F59040AFC3621D39A49B40EE59E68C02F59040284EB3F638A49B40688F4ACF00F59040E49D09B138A49B402EDB9017FFF490403C0FBB4C38A49B40930DD467FDF49040328B42CA37A49B40392D25C2FBF49040CFF03F2A37A49B40CDEE8828FAF490404051776D36A49B40EC3BF59CF8F4904097FFCF9435A49B4018CC4E21F7F49040547553A134A49B406F719C32F6F490406CEECDEF33A49B400102000000020000006F719C32F6F490406CEECDEF33A49B40A2140633F6F490409A5F85F433A49B400102000000030000008FD1850137F59040B26B5BD9BBA79B408FD1850137F59040B06B5BD9BBA79B40E189A48622F59040B06B5BD9BBA79B40010200000006000000E189A48622F59040B06B5BD9BBA79B40E189A48622F59040F84CD6EDE9A79B400AE6334918F59040F84CD6EDE9A79B400AE6334918F590403F2E510218A89B408FD1850137F590403F2E510218A89B408FD1850137F59040B26B5BD9BBA79B400102000000020000008FD1850137F59040B26B5BD9BBA79B40E389A48622F59040B26B5BD9BBA79B4001020000000200000088DE5AC335F59040DF30BDDF469B9B4015815B1936F5904056759FB4419A9B4001020000000400000019815B1936F59040C6A53F9091949B408CDE5AC335F59040C6A53F9091949B408CDE5AC335F590403EEA21658C939B408CDE5AC335F590403DEA21658C939B4001020000000200000091D1850137F59040412E510218A89B408CD1850137F590404C05F57255A89B40010200000007000000D33A0D29C30291407620B9D9E2989B40D33A0D29C302914010BA5273FC9B9B40FF4269D835ED904010BA5273FC9B9B40FF4269D835ED9040A953EC0C969C9B4091D1850137F59040A953EC0C969C9B4091D1850137F59040B26B5BD9BBA79B408FD1850137F59040B26B5BD9BBA79B400102000000020000004B8B49D4E9FD9040E5C12AB5EF889B407ABE7C071DF79040E5C12AB5EF889B400102000000020000007ABE7C071DF79040E5C12AB5EF889B40ADF1AF3A50F7904018F55DE822899B400102000000020000007ABE7C071DF79040E5C12AB5EF889B407ABE7C071DF790407F5BC44E898C9B400102000000020000007ABE7C071DF790407F5BC44E898C9B404B8B49D4E9FD90407F5BC44E898C9B40010200000002000000ADF1AF3A50F790404B28911B568C9B407ABE7C071DF790407F5BC44E898C9B40010200000002000000135816A1B6FD904018F55DE822899B40ADF1AF3A50F7904018F55DE822899B40010200000002000000ADF1AF3A50F7904018F55DE822899B40ADF1AF3A50F790404B28911B568C9B40010200000002000000ADF1AF3A50F790404B28911B568C9B40135816A1B6FD90404B28911B568C9B400102000000040000001838AACA68F8904056759FB4419A9B40A5DAAA2069F8904056759FB4419A9B40A5DAAA2069F89040DE30BDDF469B9B40A5DAAA2069F89040DF30BDDF469B9B400102000000340000001838AACA68F8904056759FB4419A9B407259B4D93CF8904056759FB4419A9B407259B4D93CF89040DE30BDDF469B9B4089240E253DF8904018BE7D7D4F9B9B40B495C1063EF89040B587F510589B9B40F747C17D3FF890408B10E88F609B9B4009A34D8841F89040AA5931F0689B9B408AF1F62344F89040ECFCD127719B9B407C49A04D47F89040D31BFB2C799B9B40734383014BF890407D141AF6809B9B40107C343B4FF89040B1EEE379889B9B406CDAA8F553F89040637360AF8F9B9B4024953B2B59F8904070E1F48D969B9B40D2EEB4D55EF89040CF326E0D9D9B9B40F3A151EE64F89040F0E50A26A39B9B4052F3CA6D6BF890409E3F84D0A89B9B405F615F4C72F8904056FA1606AE9B9B4011E6DB8179F89040B2588BC0B29B9B4045C0A50581F890404E913CFAB69B9B40EFB8C4CE88F89040458B1FAEBA9B9B40D6D7EDD390F8904038E3C8D7BD9B9B40177B8E0B99F89040B9317273C09B9B4037C4D76BA1F89040CB8CFE7DC29B9B400D4DCAEAA9F890400E3FFEF4C39B9B40AA16427EB2F8904038B0B1D6C49B9B40E3A3021CBBF89040507B0B22C59B9B4017E2CF94B0F99040507B0B22C59B9B40506F9032B9F9904038B0B1D6C49B9B40ED3808C6C1F990400E3FFEF4C39B9B40C3C1FA44CAF99040CB8CFE7DC29B9B40E30A44A5D2F99040B9317273C09B9B4024AEE4DCDAF9904038E3C8D7BD9B9B400BCD0DE2E2F99040468B1FAEBA9B9B40B5C52CABEAF990404F913CFAB69B9B40EA9FF62EF2F99040B2588BC0B29B9B409B247364F9F9904056FA1606AE9B9B40A892074300FA90409E3F84D0A89B9B4007E480C206FA9040F0E50A26A39B9B4028971DDB0CFA9040CF326E0D9D9B9B40D7F0968512FA904070E1F48D969B9B408EAB29BB17FA9040637360AF8F9B9B40EA099E751CFA9040B1EEE379889B9B4087424FAF20FA90407D141AF6809B9B407E3C326324FA9040D31BFB2C799B9B407094DB8C27FA9040ECFCD127719B9B40F2E284282AFA9040AA5931F0689B9B40033E11332CFA90408B10E88F609B9B4047F010AA2DFA9040B587F510589B9B407161C48B2EFA904018BE7D7D4F9B9B40882C1ED72EFA9040DF30BDDF469B9B40882C1ED72EFA904056759FB4419A9B40E24D28E602FA904056759FB4419A9B40010200000004000000E24D28E602FA904056759FB4419A9B40A5AE94FFE9F99040B6E171882B9A9B4055D73DB181F89040B6E171882B9A9B401838AACA68F8904056759FB4419A9B400102000000040000001C38AACA68F89040C6A53F9091949B4059D73DB181F8904066396DBCA7949B40A9AE94FFE9F9904066396DBCA7949B40E64D28E602FA9040C6A53F9091949B40010200000034000000E64D28E602FA9040C6A53F9091949B408C2C1ED72EFA9040C6A53F9091949B408C2C1ED72EFA90403EEA21658C939B407561C48B2EFA9040045D61C783939B404AF010AA2DFA90406793E9337B939B40073E11332CFA9040910AF7B472939B40F5E284282AFA904072C1AD546A939B407494DB8C27FA9040301E0D1D62939B40823C326324FA904049FFE3175A939B408B424FAF20FA90409F06C54E52939B40EE099E751CFA90406B2CFBCA4A939B4092AB29BB17FA9040B9A77E9543939B40DAF0968512FA9040AC39EAB63C939B402C971DDB0CFA90404DE8703736939B400BE480C206FA90402C35D41E30939B40AC92074300FA90407EDB5A742A939B409F247364F9F99040C620C83E25939B40ED9FF62EF2F990406AC2538420939B40B9C52CABEAF99040CE89A24A1C939B400FCD0DE2E2F99040D78FBF9618939B4028AEE4DCDAF99040E437166D15939B40E70A44A5D2F9904063E96CD112939B40C7C1FA44CAF99040518EE0C610939B40F13808C6C1F990400EDCE04F0F939B40546F9032B9F99040E46A2D6E0E939B401BE2CF94B0F99040CC9FD3220E939B40E7A3021CBBF89040CC9FD3220E939B40AE16427EB2F89040E46A2D6E0E939B40114DCAEAA9F890400EDCE04F0F939B403BC4D76BA1F89040518EE0C610939B401B7B8E0B99F8904063E96CD112939B40DAD7EDD390F89040E437166D15939B40F3B8C4CE88F89040D68FBF9618939B4049C0A50581F89040CD89A24A1C939B4014E6DB8179F890406AC2538420939B4063615F4C72F89040C620C83E25939B4056F3CA6D6BF890407EDB5A742A939B40F7A151EE64F890402C35D41E30939B40D6EEB4D55EF890404DE8703736939B4027953B2B59F89040AC39EAB63C939B4070DAA8F553F89040B9A77E9543939B40147C343B4FF890406B2CFBCA4A939B40774383014BF890409F06C54E52939B408049A04D47F8904049FFE3175A939B408EF1F62344F89040301E0D1D62939B400CA34D8841F8904072C1AD546A939B40FB47C17D3FF89040910AF7B472939B40B795C1063EF890406793E9337B939B408D240E253DF89040045D61C783939B407659B4D93CF890403DEA21658C939B407659B4D93CF89040C6A53F9091949B401C38AACA68F89040C6A53F9091949B40010200000002000000A9DAAA2069F890403DEA21658C939B401C38AACA68F89040C6A53F9091949B40010200000020000000A5DAAA2069F89040DF30BDDF469B9B40A8B96BA76DF890405B0A35D34C9B9B40ABAF709572F89040BD584B72529B9B40227899E477F8904048CE03B6579B9B4025184D8E7DF89040FDA6D3975C9B9B403C11828B83F89040CCC9A911619B9B401020C7D489F890408E52F61D659B9B40FE7B4C6290F890406B7BB1B7689B9B402A8CED2B97F8904029DD61DA6B9B9B40F6053B299EF890407DFE21826E9B9B4045688551A5F89040982BA5AB709B9B408FC6E79BACF89040D48F3B54729B9B4056D652FFB3F89040708CD579739B9B4040319872BBF890403948061B749B9B40D8BD75ECC2F89040F0740537749B9B40CE30A163CAF890402D48B0CD739B9B402C55314DA1F990402D48B0CD739B9B4022C85CC4A8F99040F0740537749B9B40BA543A3EB0F990403948061B749B9B40A4AF7FB1B7F99040708CD579739B9B406BBFEA14BFF99040D48F3B54729B9B40B51D4D5FC6F99040982BA5AB709B9B4004809787CDF990407DFE21826E9B9B40D0F9E484D4F9904029DD61DA6B9B9B40FD09864EDBF990406B7BB1B7689B9B40EA650BDCE1F990408E52F61D659B9B40BE745025E8F99040CCC9A911619B9B40D56D8522EEF99040FDA6D3975C9B9B40D80D39CCF3F9904048CE03B6579B9B404FD6611BF9F99040BD584B72529B9B4052CC6609FEF990405B0A35D34C9B9B4055AB279002FA9040DF30BDDF469B9B40010200000030000000A5DAAA2069F89040DF30BDDF469B9B404AFF975169F89040FE48F7774C9B9B40560725E469F890402BE38309529B9B40D406A3D76AF89040DF79BD8D579B9B40835CEF2A6CF89040F36E0EFE5C9B9B40C00C75DC6DF8904084E7F853629B9B40E3A42EEA6FF89040908B1E89679B9B40E2A4A85172F89040E61F48976C9B9B40486C041075F8904072F16C78719B9B400EA7FB2178F89040F508BA26769B9B403C36E4837BF89040A21E999C7A9B9B40A28FB4317FF890404A45B7D47E9B9B40788F082783F890401F450BCA829B9B401FB6265F87F89040859EDB77869B9B40CCCB05D58BF89040B42DC4D9899B9B404FE3528390F890407A68BBEB8C9B9B40DBB4776495F89040E02F17AA8F9B9B403249A1729AF89040DE2F9111929B9B403EEDC6A79FF8904002C84A1F949B9B40CF65B1FDA4F890403F78D0D0959B9B40E25A026EAAF89040EECD1C24979B9B4097F13BF2AFF890406BCD9A17989B9B40C48BC883B5F8904078D527AA989B9B40E3A3021CBBF890401DFA14DB989B9B4017E2CF94B0F990401DFA14DB989B9B4036FA092DB6F9904078D527AA989B9B40639496BEBBF990406CCD9A17989B9B40182BD042C1F99040EECD1C24979B9B402B2021B3C6F990403F78D0D0959B9B40BC980B09CCF9904002C84A1F949B9B40C83C313ED1F99040DF2F9111929B9B401FD15A4CD6F99040E02F17AA8F9B9B40ABA27F2DDBF990407A68BBEB8C9B9B402EBACCDBDFF99040B42DC4D9899B9B40DBCFAB51E4F99040859EDB77869B9B4082F6C989E8F990401F450BCA829B9B4058F61D7FECF990404A45B7D47E9B9B40BE4FEE2CF0F99040A31E999C7A9B9B40ECDED68EF3F99040F508BA26769B9B40B219CEA0F6F9904073F16C78719B9B4018E1295FF9F99040E71F48976C9B9B4017E1A3C6FBF99040908B1E89679B9B403A795DD4FDF9904084E7F853629B9B407729E385FFF99040F36E0EFE5C9B9B40267F2FD900FA9040E079BD8D579B9B40A47EADCC01FA90402BE38309529B9B40B0863A5F02FA9040FE48F7774C9B9B4055AB279002FA9040DF30BDDF469B9B4001020000003000000059AB279002FA90403DEA21658C939B40B4863A5F02FA90401ED2E7CC86939B40A87EADCC01FA9040F1375B3B81939B402A7F2FD900FA90403DA121B77B939B407B29E385FFF9904029ACD04676939B403E795DD4FDF990409833E6F070939B401BE1A3C6FBF990408C8FC0BB6B939B401CE1295FF9F9904036FB96AD66939B40B619CEA0F6F99040AA2972CC61939B40F0DED68EF3F990402712251E5D939B40C24FEE2CF0F990407AFC45A858939B405CF61D7FECF99040D2D5277054939B4086F6C989E8F99040FDD5D37A50939B40DFCFAB51E4F99040977C03CD4C939B4032BACCDBDFF9904068ED1A6B49939B40AFA27F2DDBF99040A2B2235946939B4023D15A4CD6F990403CEBC79A43939B40CC3C313ED1F990403EEB4D3341939B40C0980B09CCF990401A5394253F939B402F2021B3C6F99040DDA20E743D939B401C2BD042C1F990402E4DC2203C939B40679496BEBBF99040B14D442D3B939B403AFA092DB6F99040A445B79A3A939B401BE2CF94B0F99040FF20CA693A939B40E7A3021CBBF89040FF20CA693A939B40C88BC883B5F89040A445B79A3A939B409BF13BF2AFF89040B04D442D3B939B40E65A026EAAF890402E4DC2203C939B40D365B1FDA4F89040DDA20E743D939B4042EDC6A79FF890401A5394253F939B403649A1729AF890403DEB4D3341939B40DFB4776495F890403CEBC79A43939B4053E3528390F89040A2B2235946939B40D0CB05D58BF8904068ED1A6B49939B4023B6265F87F89040977C03CD4C939B407C8F082783F89040FDD5D37A50939B40A68FB4317FF89040D2D5277054939B404036E4837BF8904079FC45A858939B4012A7FB2178F890402712251E5D939B404C6C041075F89040A92972CC61939B40E6A4A85172F8904035FB96AD66939B40E7A42EEA6FF890408C8FC0BB6B939B40C40C75DC6DF890409833E6F070939B40875CEF2A6CF8904029ACD04676939B40D806A3D76AF890403CA121B77B939B405A0725E469F89040F1375B3B81939B404EFF975169F890401ED2E7CC86939B40A9DAAA2069F890403DEA21658C939B4001020000002000000059AB279002FA90403DEA21658C939B4056CC6609FEF99040C110AA7186939B4053D6611BF9F990405FC293D280939B40DC0D39CCF3F99040D44CDB8E7B939B40D96D8522EEF990401F740BAD76939B40C2745025E8F990405051353372939B40EE650BDCE1F990408EC8E8266E939B40000A864EDBF99040B19F2D8D6A939B40D4F9E484D4F99040F33D7D6A67939B4008809787CDF990409F1CBDC264939B40B91D4D5FC6F9904084EF399962939B406FBFEA14BFF99040488BA3F060939B40A8AF7FB1B7F99040AC8E09CB5F939B40BE543A3EB0F99040E3D2D8295F939B4026C85CC4A8F990402CA6D90D5F939B403055314DA1F99040EFD22E775F939B40D230A163CAF89040EFD22E775F939B40DCBD75ECC2F890402CA6D90D5F939B4044319872BBF89040E3D2D8295F939B405AD652FFB3F89040AC8E09CB5F939B4093C6E79BACF89040488BA3F060939B4049688551A5F8904084EF399962939B40FA053B299EF890409F1CBDC264939B402E8CED2B97F89040F33D7D6A67939B40017C4C6290F89040B19F2D8D6A939B401420C7D489F890408EC8E8266E939B404011828B83F890405051353372939B4029184D8E7DF890401F740BAD76939B40267899E477F89040D44CDB8E7B939B40AFAF709572F890405FC293D280939B40ACB96BA76DF89040C110AA7186939B40A9DAAA2069F890403DEA21658C939B40010200000002000000066E405CF6F8904010BA5273FC8F9B406CD4A6C2DCF8904010BA5273FC8F9B400102000000050000006CD4A6C2DCF8904010BA5273FC8F9B4034180B6706F7904010BA5273FC8F9B4034180B6706F790400D20B9D962869B40D33A0D29C30291400D20B9D962869B40D33A0D29C30291403416E235F28C9B400102000000040000006CD4A6C2DCF8904010BA5273FC8F9B406CD4A6C2DCF890403916E235F28F9B40A007DAF50FF990403916E235F28F9B40A007DAF50FF9904010BA5273FC8F9B40010200000002000000066E405CF6F89040A953EC0C96909B406CD4A6C2DCF89040A953EC0C96909B400102000000040000006CD4A6C2DCF89040A953EC0C96909B406CD4A6C2DCF8904080F75C4AA0909B40A007DAF50FF9904080F75C4AA0909B40A007DAF50FF99040AA53EC0C96909B40010200000002000000A007DAF50FF9904010BA5273FC8F9B40066E405CF6F8904010BA5273FC8F9B40010200000002000000066E405CF6F8904010BA5273FC8F9B40066E405CF6F89040A953EC0C96909B40010200000002000000A007DAF50FF99040A953EC0C96909B40066E405CF6F89040A953EC0C96909B40010200000003000000066E405CF6F89040A953EC0C96909B40066E405CF6F89040AA53EC0C96909B40A007DAF50FF99040AA53EC0C96909B40010200000002000000A007DAF50FF99040DD861F4049909B40A007DAF50FF9904010BA5273FC8F9B40010200000002000000066E405C76F99040DD861F4049909B40A007DAF50FF99040DD861F4049909B40010200000002000000A007DAF50FF990407720B9D962909B40A007DAF50FF99040DD861F4049909B40010200000002000000A007DAF50FF990407720B9D962909B40066E405C76F990407720B9D962909B40010200000002000000A007DAF50FF99040A953EC0C96909B40A007DAF50FF990407720B9D962909B40010200000002000000A007DAF50FF99040AA53EC0C96909B40A007DAF50FF99040A953EC0C96909B40010200000002000000EAFB86DE40F990406B9AB0D351879B40EAFB86DE40F99040A9AF60C651879B40010200000002000000EAFB86DE40F99040EA0F469764879B40EAFB86DE40F990406B9AB0D351879B4001020000000A000000EAFB86DE40F990406B9AB0D351879B4083AB55B440F99040D7160F5C52879B40A588E02C40F99040E38D089B54879B40C4B933CD3FF9904090F7F2E156879B4093C2C2953FF990407A890E2E59879B402093D0863FF990407834957C5B879B4003376FA03FF99040E9FDBDCA5D879B4094BF7FE23FF99040815CC01560879B404469B24C40F990409D94D75A62879B40EAFB86DE40F99040EA0F469764879B40010200000027000000816A996181F990406B9AB0D351879B40EECF30DD80F990404CC6BC2750879B406FEB440880F990407BF3BA004E879B403520080E7FF9904054E2A2E94B879B40DB8EA8EF7DF9904045A0FAE449879B4006F97FAE7CF990403AF831F547879B40EF1F124C7BF9904071819F1C46879B403FF00ACA79F99040CACC7D5D44879B405F7D3C2A78F99040E1B3E8B942879B40C4CE9C6E76F9904042CDDA3341879B40CD81439974F99040CB082BCD3F879B40134367AC72F9904010778A873E879B403B225BAA70F990407F3E82643D879B4082C38B956EF99040B4C071653C879B4068727C706CF9904039F28C8B3B879B40FA18C43D6AF99040B7E6DAD73A879B40771F0A0068F990405393344B3A879B40043803BA65F99040BEC843E639879B40521A6E6E63F990402C6682A939879B403533102061F9904030C6399539879B40194CB2D15EF990402C6682A939879B40672E1D865CF99040BEC843E639879B40F34616405AF990405393344B3A879B40714D5C0258F99040B7E6DAD73A879B4003F4A3CF55F9904039F28C8B3B879B40E8A294AA53F99040B4C071653C879B403044C59551F990407F3E82643D879B405823B9934FF9904010778A873E879B409EE4DCA64DF99040CB082BCD3F879B40A79783D14BF9904042CDDA3341879B400CE9E3154AF99040E1B3E8B942879B402C76157648F99040CACC7D5D44879B407B460EF446F9904071819F1C46879B40656DA09145F990403AF831F547879B4090D7775044F9904045A0FAE449879B403646183243F9904054E2A2E94B879B40FC7ADB3742F990407BF3BA004E879B407D96EF6241F990404CC6BC2750879B40EAFB86DE40F990406B9AB0D351879B40010200000002000000EAFB86DE40F990406CA5892251889B40EAFB86DE40F99040EA0F469764879B40010200000002000000EAFB86DE40F99040EB1A1FE663889B40EAFB86DE40F990406CA5892251889B4001020000000A000000EAFB86DE40F990406CA5892251889B404469B24C40F99040B920F85E53889B4094BF7FE23FF99040D4580FA455889B4003376FA03FF990406DB711EF57889B402093D0863FF99040DE803A3D5A889B4093C2C2953FF99040DC2BC18B5C889B40C4B933CD3FF99040C6BDDCD75E889B40A588E02C40F990407327C71E61889B4083AB55B440F990407F9EC05D63889B40EAFB86DE40F99040EB1A1FE663889B40010200000027000000EAFB86DE40F99040EB1A1FE663889B407D96EF6241F990400AEF129265889B40FC7ADB3742F99040DBC114B967889B403646183243F9904002D32CD069889B4090D7775044F990401115D5D46B889B40656DA09145F990401CBD9DC46D889B407B460EF446F99040E433309D6F889B402C76157648F990408BE8515C71889B400CE9E3154AF990407501E7FF72889B40A79783D14BF9904014E8F48574889B409EE4DCA64DF990408BACA4EC75889B405823B9934FF99040463E453277889B403044C59551F99040D7764D5578889B40E8A294AA53F99040A2F45D5479889B4003F4A3CF55F990401CC3422E7A889B40714D5C0258F990409FCEF4E17A889B40F34616405AF9904003229B6E7B889B40672E1D865CF9904098EC8BD37B889B40194CB2D15EF990402A4F4D107C889B403533102061F9904026EF95247C889B40521A6E6E63F990402A4F4D107C889B40043803BA65F9904098EC8BD37B889B40771F0A0068F9904003229B6E7B889B40FA18C43D6AF990409FCEF4E17A889B4068727C706CF990401CC3422E7A889B4082C38B956EF99040A2F45D5479889B403B225BAA70F99040D7764D5578889B40134367AC72F99040463E453277889B40CD81439974F990408BACA4EC75889B40C4CE9C6E76F9904014E8F48574889B405F7D3C2A78F990407501E7FF72889B403FF00ACA79F990408BE8515C71889B40EF1F124C7BF99040E433309D6F889B4006F97FAE7CF990401CBD9DC46D889B40DB8EA8EF7DF990401115D5D46B889B403520080E7FF9904002D32CD069889B406FEB440880F99040DBC114B967889B40EECF30DD80F990400AEF129265889B40816A996181F99040EB1A1FE663889B40010200000002000000EAFB86DE40F99040AD056FF363889B40EAFB86DE40F99040EB1A1FE663889B40010200000002000000D33A0D2943FB9040DD861F4049909B40066E405C76F99040DD861F4049909B40010200000002000000066E405C76F99040AA53EC0C56909B40066E405C76F99040DD861F4049909B40010200000002000000D33A0D2943FB9040AA53EC0C56909B40066E405C76F99040AA53EC0C56909B40010200000002000000066E405C76F990407720B9D962909B40066E405C76F99040AA53EC0C56909B40010200000002000000066E405C76F990407720B9D962909B4039A1738FA9FD90407620B9D962909B4001020000000A000000816A996181F99040EA0F469764879B4027FD6DF381F990409D94D75A62879B40D6A6A05D82F99040815CC01560879B40682FB19F82F99040E9FDBDCA5D879B404BD34FB982F990407834957C5B879B40D8A35DAA82F990407A890E2E59879B40A7ACEC7282F9904090F7F2E156879B40C6DD3F1382F99040E38D089B54879B40E8BACA8B81F99040D7160F5C52879B40816A996181F990406B9AB0D351879B40010200000002000000816A996181F99040EA0F469764879B40816A996181F990406B9AB0D351879B40010200000009000000816A996181F990406B9AB0D351879B40816A996181F9904052A1331424879B40C3F4A48881F9904017363DA51F879B40305098FD81F99040D9A2A43B1B879B40EFEBE5BF82F990409440C1DC16879B400A95A2CE83F990402172DD8D12879B401B93862885F99040BF3C30540E879B400335EFCB86F9904015F8D6340A879B40B9CBE0B688F990403F1DCF3406879B40010200000002000000816A996181F990406CA5892251889B40816A996181F99040EA0F469764879B4001020000000A000000816A996181F99040EB1A1FE663889B40E8BACA8B81F990407F9EC05D63889B40C6DD3F1382F990407327C71E61889B40A7ACEC7282F99040C6BDDCD75E889B40D8A35DAA82F99040DC2BC18B5C889B404BD34FB982F99040DE803A3D5A889B40682FB19F82F990406DB711EF57889B40D6A6A05D82F99040D4580FA455889B4027FD6DF381F99040B920F85E53889B40816A996181F990406CA5892251889B40010200000002000000816A996181F99040EB1A1FE663889B40816A996181F990406CA5892251889B400102000000320000003FDF2C7A85FB904075D6EDD85F889B403FDF2C7A85FB904003149CA591889B401AC2AC5385FB90404857A30C96889B40D75E5AE084FB9040CA64696E9A889B40155BBF2084FB90406B4CB3C59E889B40A669C01583FB9040CDA1520DA3889B408B399CC081FB904092AB2B40A7889B409DF9E92280FB9040367C3B59AB889B408472973E7EFB90405EED9D53AF889B405AB9E6157CFB90406476932AB3889B40AC7D6BAB79FB904031D786D9B6889B4015F6070277FB90409F90125CBA889B401D6FE91C74FB9040D82306AEBD889B407C8084FF70FB904079126BCBC0889B4043ED90AD6DFB9040719989B0C3889B40D533052B6AFB90400821ED59C6889B4008D3117C66FB9040B65C68C4C8889B40024A1CA562FB9040E01519EDCA889B40DAD8B9AA5EFB9040F99C6BD1CC889B403608AA915AFB9040E7DC1D6FCE889B4071FED05E56FB9040020D42C4CF889B400EA9311752FB904072FE40CFD0889B406EC1E7BF4DFB90403302DC8ED1889B40ECB3215E49FB904077652E02D2889B40A7701AF744FB90409B82AE28D2889B4019D9ABE4C1F990409B82AE28D2889B40D495A47DBDF9904077652E02D2889B405288DE1BB9F990403302DC8ED1889B40B2A094C4B4F9904072FE40CFD0889B404F4BF57CB0F99040020D42C4CF889B408A411C4AACF99040E7DC1D6FCE889B40E6700C31A8F99040F99C6BD1CC889B40BEFFA936A4F99040E01519EDCA889B40B876B45FA0F99040B65C68C4C8889B40EB15C1B09CF990400821ED59C6889B407D5C352E99F99040719989B0C3889B4044C941DC95F9904079126BCBC0889B40A3DADCBE92F99040D82306AEBD889B40AB53BED98FF990409F90125CBA889B4014CC5A308DF9904031D786D9B6889B406690DFC58AF990406476932AB3889B403CD72E9D88F990405EED9D53AF889B402350DCB886F99040367C3B59AB889B4035102A1B85F9904092AB2B40A7889B401AE005C683F99040CDA1520DA3889B40ABEE06BB82F990406B4CB3C59E889B40E9EA6BFB81F99040CA64696E9A889B40A687198881F990404857A30C96889B40816A996181F9904003149CA591889B40816A996181F99040EB1A1FE663889B40010200000064000000B497700E66FB90402D509CA705879B409ABA557867FB904039B6EA7806879B405198D8EF68FB90408BCAAD3007879B4075532C736AFB90402C0504CE07879B40398E75006CFB9040A74C2C5008879B40D0B1CC956DFB904004E386B608879B40D94440316FFB9040D529960009879B40EA4DD7D070FB9040633CFF2D09879B4053BF937272FB90403B5F8A3E09879B4018E9741474FB90409644233209879B4030EE79B475FB90404125D90809879B40EE39A45077FB9040F1ADDEC208879B40A8F2F9E678FB904012C1896008879B40876688757AFB90405D0D53E207879B409B6F66FA7BFB9040BE79D54807879B4028CCB6737DFB90403267CD9406879B406668AADF7EFB90409AC917C705879B40D896823C80FB90408E18B1E004879B407D34938881FB90407D19B4E203879B4049B644C282FB9040A98458CE02879B404F1D16E883FB90408E86F1A401879B4041CF9EF884FB9040A11FEC6700879B40085190F285FB90405664CD18FF869B403CE1B7D486FB9040A09F30B9FD869B40AAF0FF9D87FB9040235AC54AFC869B40F076714D88FB90409A484DCFFA869B40B32135E288FB9040E9239A48F9869B40E15C945B89FB9040886D8BB8F7869B40C332FAB889FB904003230C21F6869B40D002F4F989FB904064631084F4869B405C0E321E8AFB9040650993E3F2869B4074DA87258AFB9040613D9341F1869B407C66EC0F8AFB9040FD0112A0EF869B4031377ADD89FB904086BE0F01EE869B4029366F8E89FB904017CA8966EC869B40CE652C2389FB904079FA77D2EA869B40506A359C88FB9040C639CA46E9869B401AE82FFA87FB9040C92566C5E7869B4081B8E23D87FB904001BC2450E6869B40BCF5346886FB90401A15D0E8E4869B403FDF2C7A85FB9040BB322191E3869B4062FEF1986DFB90400EE8D1E3D2869B400A00C4A454FB9040346F13DEC3869B40269AEFBA3AFB9040B2478991B6869B4000F1E1F91FFB904042E6D00DAB869B4099DD048104FB9040355F6F60A1869B40450B9A70E8FA90409586C19499869B40E71795E9CBFA9040C398EEB393869B4036E3740DAFFA90401C7BDDC48F869B40873A1CFE91FA904066A12CCC8D869B40390FAADD74FA904066A12CCC8D869B408A6651CE57FA90401C7BDDC48F869B40D93131F23AFA9040C398EEB393869B407B3E2C6B1EFA90409586C19499869B40276CC15A02FA9040355F6F60A1869B40C058E4E1E6F9904042E6D00DAB869B409AAFD620CCF99040B2478991B6869B40B6490237B2F99040346F13DEC3869B405E4BD44299F990400EE8D1E3D2869B40816A996181F99040BB322191E3869B400454917380F990401A15D0E8E4869B403F91E39D7FF9904001BC2450E6869B40A66196E17EF99040C92566C5E7869B4070DF903F7EF99040C639CA46E9869B40F2E399B87DF9904079FA77D2EA869B409713574D7DF9904017CA8966EC869B408F124CFE7CF9904086BE0F01EE869B4044E3D9CB7CF99040FD0112A0EF869B404C6F3EB67CF99040613D9341F1869B40643B94BD7CF99040650993E3F2869B40F046D2E17CF9904064631084F4869B40FD16CC227DF9904003230C21F6869B40DFEC31807DF99040886D8BB8F7869B400D2891F97DF99040E9239A48F9869B40D0D2548E7EF990409A484DCFFA869B401659C63D7FF99040235AC54AFC869B4084680E0780F99040A09F30B9FD869B40B8F835E980F990405664CD18FF869B407F7A27E381F99040A11FEC6700879B40712CB0F382F990408E86F1A401879B407793811984F99040A98458CE02879B404315335385F990407D19B4E203879B40E8B2439F86F990408E18B1E004879B405AE11BFC87F990409AC917C705879B40987D0F6889F990403267CD9406879B4025DA5FE18AF99040BE79D54807879B4039E33D668CF990405D0D53E207879B401857CCF48DF9904012C1896008879B40D20F228B8FF99040F1ADDEC208879B40905B4C2791F990404125D90809879B40A86051C792F990409644233209879B406D8A326994F990403B5F8A3E09879B40D6FBEE0A96F99040633CFF2D09879B40E70486AA97F99040D529960009879B40F097F94599F9904004E386B608879B4087BB50DB9AF99040A74C2C5008879B404BF699689CF990402C0504CE07879B406FB1EDEB9DF990408BCAAD3007879B40268F70639FF9904039B6EA7806879B400CB255CDA0F990402D509CA705879B4001020000000400000012BC3EF9E3F99040BB322191E3869B40D3EB624FD2F99040BF161806EB869B40D67CE631B9F9904018781DA8F7869B403824D0F9A0F990400E0DB7EE05879B400102000000040000005B0D6A28A3F99040E2BB3FB4F28C9B40E8AF6A7EA3F99040E2BB3FB4F28C9B40E8AF6A7EA3F990406A775DDFF78D9B40E8AF6A7EA3F990406B775DDFF78D9B400102000000340000005B0D6A28A3F99040E2BB3FB4F28C9B40B52E743777F99040E2BB3FB4F28C9B40B52E743777F990406A775DDFF78D9B40CCF9CD8277F99040A4041E7D008E9B40F76A816478F9904041CE9510098E9B403A1D81DB79F990401757888F118E9B404C780DE67BF9904036A0D1EF198E9B40CDC6B6817EF9904078437227228E9B40BF1E60AB81F990405F629B2C2A8E9B40B618435F85F99040095BBAF5318E9B405351F49889F990403D358479398E9B40AFAF68538EF99040EFB900AF408E9B40676AFB8893F99040FC27958D478E9B4015C4743399F990405B790E0D4E8E9B403677114C9FF990407C2CAB25548E9B4095C88ACBA5F990402A8624D0598E9B40A2361FAAACF99040E240B7055F8E9B4054BB9BDFB3F990403E9F2BC0638E9B4088956563BBF99040DAD7DCF9678E9B40328E842CC3F99040D1D1BFAD6B8E9B4019ADAD31CBF99040C42969D76E8E9B405A504E69D3F9904045781273718E9B407A9997C9DBF9904057D39E7D738E9B4050228A48E4F990409A859EF4748E9B40EDEB01DCECF99040C4F651D6758E9B402679C279F5F99040DCC1AB21768E9B405AB78FF2EAFA9040DCC1AB21768E9B4093445090F3FA9040C4F651D6758E9B40300EC823FCFA90409A859EF4748E9B400697BAA204FB904057D39E7D738E9B4026E003030DFB904045781273718E9B406783A43A15FB9040C42969D76E8E9B404EA2CD3F1DFB9040D2D1BFAD6B8E9B40F89AEC0825FB9040DBD7DCF9678E9B402D75B68C2CFB90403E9F2BC0638E9B40DEF932C233FB9040E240B7055F8E9B40EB67C7A03AFB90402A8624D0598E9B404AB9402041FB90407C2CAB25548E9B406B6CDD3847FB90405B790E0D4E8E9B401AC656E34CFB9040FC27958D478E9B40D180E91852FB9040EFB900AF408E9B402DDF5DD356FB90403D358479398E9B40CA170F0D5BFB9040095BBAF5318E9B40C111F2C05EFB90405F629B2C2A8E9B40B3699BEA61FB904078437227228E9B4035B8448664FB904036A0D1EF198E9B404613D19066FB90401757888F118E9B408AC5D00768FB904041CE9510098E9B40B43684E968FB9040A4041E7D008E9B40CB01DE3469FB90406B775DDFF78D9B40CB01DE3469FB9040E2BB3FB4F28C9B402523E8433DFB9040E2BB3FB4F28C9B400102000000040000002523E8433DFB9040E2BB3FB4F28C9B40E883545D24FB904042281288DC8C9B4098ACFD0EBCF9904042281288DC8C9B405B0D6A28A3F99040E2BB3FB4F28C9B40010200000020000000E8AF6A7EA3F990406B775DDFF78D9B40EB8E2B05A8F99040E750D5D2FD8D9B40EE8430F3ACF99040499FEB71038E9B40654D5942B2F99040D414A4B5088E9B4068ED0CECB7F9904089ED73970D8E9B407FE641E9BDF9904058104A11128E9B4053F58632C4F990401A99961D168E9B4041510CC0CAF99040F7C151B7198E9B406D61AD89D1F99040B52302DA1C8E9B4039DBFA86D8F990400945C2811F8E9B40883D45AFDFF99040247245AB218E9B40D29BA7F9E6F9904060D6DB53238E9B4099AB125DEEF99040FCD27579248E9B40830658D0F5F99040C58EA61A258E9B401B93354AFDF990407CBBA536258E9B40110661C104FA9040B98E50CD248E9B406F2AF1AADBFA9040B98E50CD248E9B40659D1C22E3FA90407CBBA536258E9B40FD29FA9BEAFA9040C58EA61A258E9B40E7843F0FF2FA9040FCD27579248E9B40AE94AA72F9FA904060D6DB53238E9B40F8F20CBD00FB9040247245AB218E9B40475557E507FB90400945C2811F8E9B4013CFA4E20EFB9040B52302DA1C8E9B4040DF45AC15FB9040F7C151B7198E9B402D3BCB391CFB90401A99961D168E9B40014A108322FB904058104A11128E9B401843458028FB904089ED73970D8E9B401BE3F8292EFB9040D414A4B5088E9B4092AB217933FB9040499FEB71038E9B4095A1266738FB9040E750D5D2FD8D9B409880E7ED3CFB90406B775DDFF78D9B40010200000030000000E8AF6A7EA3F990406B775DDFF78D9B408DD457AFA3F990408A8F9777FD8D9B4099DCE441A4F99040B7292409038E9B4017DC6235A5F990406BC05D8D088E9B40C631AF88A6F990407FB5AEFD0D8E9B4003E2343AA8F99040102E9953138E9B40267AEE47AAF990401CD2BE88188E9B40257A68AFACF990407266E8961D8E9B408B41C46DAFF99040FE370D78228E9B40517CBB7FB2F99040814F5A26278E9B407F0BA4E1B5F990402E65399C2B8E9B40E564748FB9F99040D68B57D42F8E9B40BB64C884BDF99040AB8BABC9338E9B40628BE6BCC1F9904011E57B77378E9B400FA1C532C6F99040407464D93A8E9B4092B812E1CAF9904006AF5BEB3D8E9B401E8A37C2CFF990406C76B7A9408E9B40751E61D0D4F990406A763111438E9B4081C28605DAF990408E0EEB1E458E9B40123B715BDFF99040CBBE70D0468E9B402530C2CBE4F990407A14BD23488E9B40DAC6FB4FEAF99040F7133B17498E9B40076188E1EFF99040041CC8A9498E9B402679C279F5F99040A940B5DA498E9B405AB78FF2EAFA9040A940B5DA498E9B4079CFC98AF0FA9040041CC8A9498E9B40A669561CF6FA9040F8133B17498E9B405B0090A0FBFA90407A14BD23488E9B406EF5E01001FB9040CBBE70D0468E9B40FF6DCB6606FB90408E0EEB1E458E9B400B12F19B0BFB90406B763111438E9B4062A61AAA10FB90406C76B7A9408E9B40EE773F8B15FB904006AF5BEB3D8E9B40718F8C391AFB9040407464D93A8E9B401EA56BAF1EFB904011E57B77378E9B40C5CB89E722FB9040AB8BABC9338E9B409BCBDDDC26FB9040D68B57D42F8E9B400125AE8A2AFB90402F65399C2B8E9B402FB496EC2DFB9040814F5A26278E9B40F5EE8DFE30FB9040FF370D78228E9B405BB6E9BC33FB90407366E8961D8E9B405AB6632436FB90401CD2BE88188E9B407D4E1D3238FB9040102E9953138E9B40BAFEA2E339FB90407FB5AEFD0D8E9B406954EF363BFB90406CC05D8D088E9B40E7536D2A3CFB9040B7292409038E9B40F35BFABC3CFB90408A8F9777FD8D9B409880E7ED3CFB90406B775DDFF78D9B400102000000020000005A87E06FE3F99040BB322191E3869B4012BC3EF9E3F99040BB322191E3869B4001020000000200000012BC3EF9E3F99040BB322191E3869B40AE8D87E222FB9040BB322191E3869B4001020000000E000000AE8D87E222FB9040BB322191E3869B408FF3FDA51AFB90409154FB16E0869B405E8E101400FB904094492EE7D6869B4033C1BEF4E4FA9040AEA81C81CF869B404881CC66C9FA90409DED2AEDC9869B4057407B89ADFA9040E6D7AC31C6869B406278667C91FA9040873DDE52C4869B405ED15F5F75FA9040873DDE52C4869B4069094B5259FA9040E6D7AC31C6869B4078C8F9743DFA90409DED2AEDC9869B408D8807E721FA9040AEA81C81CF869B4062BBB5C706FA904094492EE7D6869B403156C835ECF990409154FB16E0869B4012BC3EF9E3F99040BB322191E3869B4001020000000200000055AB279002FA9040DF30BDDF469B9B40E24D28E602FA904056759FB4419A9B40010200000004000000E64D28E602FA9040C6A53F9091949B4059AB279002FA9040C6A53F9091949B4059AB279002FA90403EEA21658C939B4059AB279002FA90403DEA21658C939B40010200000002000000AE8D87E222FB9040BB322191E3869B4066C2E56B23FB9040BB322191E3869B400102000000040000008825F6E165FB90400E0DB7EE05879B40EACCDFA94DFB904018781DA8F7869B40ED5D638C34FB9040BF161806EB869B40AE8D87E222FB9040BB322191E3869B400102000000020000009880E7ED3CFB90406B775DDFF78D9B402523E8433DFB9040E2BB3FB4F28C9B4001020000000200000039A1738FA9FB9040DD861F4049909B40D33A0D2943FB9040DD861F4049909B40010200000002000000D33A0D2943FB9040DD861F4049909B40D33A0D2943FB9040AA53EC0C56909B4001020000000300000039A1738FA9FB9040DC861F4049909B40D33A0D2943FB9040DC861F4049909B40D33A0D2943FB9040DD861F4049909B40010200000003000000D33A0D2943FB9040AA53EC0C56909B40D33A0D2943FB90407620B9D962909B4039A1738FA9FB90407620B9D962909B4001020000000200000039A1738FA9FB9040A953EC0C56909B40D33A0D2943FB9040AA53EC0C56909B40010200000009000000077EE5247EFB90403F1DCF3406879B40BD14D70F80FB904015F8D6340A879B40A5B63FB381FB9040BF3C30540E879B40B6B4230D83FB90402172DD8D12879B40D15DE01B84FB90409440C1DC16879B4090F92DDE84FB9040D9A2A43B1B879B40FD54215385FB904017363DA51F879B403FDF2C7A85FB904052A1331424879B403FDF2C7A85FB9040E1DEE1E055879B400102000000020000003FDF2C7A85FB9040E1DEE1E055879B403FDF2C7A85FB9040DFC3168860879B400102000000070000003FDF2C7A85FB9040E1DEE1E055879B40BF80FB4F85FB904090F7F2E156879B408E898A1885FB90407A890E2E59879B401B5A980985FB90407834957C5B879B40FEFD362385FB9040E9FDBDCA5D879B408F86476585FB9040815CC01560879B403FDF2C7A85FB9040DFC3168860879B400102000000290000007C3161E4C6FB90406B9AB0D351879B40E996F85FC6FB90404CC6BC2750879B4069B20C8BC5FB90407BF3BA004E879B402FE7CF90C4FB904054E2A2E94B879B40D6557072C3FB904045A0FAE449879B4000C04731C2FB90403AF831F547879B40EAE6D9CEC0FB904071819F1C46879B403AB7D24CBFFB9040CACC7D5D44879B40594404ADBDFB9040E1B3E8B942879B40BF9564F1BBFB904042CDDA3341879B40C8480B1CBAFB9040CB082BCD3F879B400E0A2F2FB8FB904010778A873E879B4036E9222DB6FB90407F3E82643D879B407D8A5318B4FB9040B4C071653C879B40633944F3B1FB904039F28C8B3B879B40F5DF8BC0AFFB9040B7E6DAD73A879B4072E6D182ADFB90405393344B3A879B40FEFECA3CABFB9040BEC843E639879B404DE135F1A8FB90402C6682A939879B4030FAD7A2A6FB904030C6399539879B4014137A54A4FB90402C6682A939879B4062F5E408A2FB9040BEC843E639879B40EE0DDEC29FFB90405393344B3A879B406C1424859DFB9040B7E6DAD73A879B40FEBA6B529BFB904039F28C8B3B879B40E3695C2D99FB9040B4C071653C879B402B0B8D1897FB90407F3E82643D879B4053EA801695FB904010778A873E879B4099ABA42993FB9040CB082BCD3F879B40A25E4B5491FB904042CDDA3341879B4007B0AB988FFB9040E1B3E8B942879B40273DDDF88DFB9040CACC7D5D44879B40760DD6768CFB904071819F1C46879B40603468148BFB90403AF831F547879B408B9E3FD389FB904045A0FAE449879B40310DE0B488FB904054E2A2E94B879B40F741A3BA87FB90407BF3BA004E879B40785DB7E586FB90404CC6BC2750879B407D721D3786FB9040D7160F5C52879B409F4FA8AF85FB9040E38D089B54879B403FDF2C7A85FB9040E1DEE1E055879B400102000000030000003FDF2C7A85FB9040DFC3168860879B403F307ACF85FB90409D94D75A62879B40E4C24E6186FB9040EA0F469764879B400102000000020000003FDF2C7A85FB9040DFC3168860879B403FDF2C7A85FB904076F1B83155889B400102000000020000003FDF2C7A85FB904076F1B83155889B403FDF2C7A85FB904075D6EDD85F889B400102000000070000003FDF2C7A85FB904076F1B83155889B408F86476585FB9040D4580FA455889B40FEFD362385FB90406DB711EF57889B401B5A980985FB9040DE803A3D5A889B408E898A1885FB9040DC2BC18B5C889B40BF80FB4F85FB9040C6BDDCD75E889B403FDF2C7A85FB904075D6EDD85F889B40010200000003000000E4C24E6186FB90406CA5892251889B403F307ACF85FB9040B920F85E53889B403FDF2C7A85FB904076F1B83155889B400102000000290000003FDF2C7A85FB904075D6EDD85F889B409F4FA8AF85FB90407327C71E61889B407D721D3786FB90407F9EC05D63889B40785DB7E586FB90400AEF129265889B40F741A3BA87FB9040DBC114B967889B40310DE0B488FB904002D32CD069889B408B9E3FD389FB90401115D5D46B889B40603468148BFB90401CBD9DC46D889B40760DD6768CFB9040E433309D6F889B40273DDDF88DFB90408BE8515C71889B4007B0AB988FFB90407501E7FF72889B40A25E4B5491FB904014E8F48574889B4099ABA42993FB90408BACA4EC75889B4053EA801695FB9040463E453277889B402B0B8D1897FB9040D7764D5578889B40E3695C2D99FB9040A2F45D5479889B40FEBA6B529BFB90401CC3422E7A889B406C1424859DFB90409FCEF4E17A889B40EE0DDEC29FFB904003229B6E7B889B4062F5E408A2FB904098EC8BD37B889B4014137A54A4FB90402A4F4D107C889B4030FAD7A2A6FB904026EF95247C889B404DE135F1A8FB90402A4F4D107C889B40FEFECA3CABFB904098EC8BD37B889B4072E6D182ADFB904003229B6E7B889B40F5DF8BC0AFFB90409FCEF4E17A889B40633944F3B1FB90401CC3422E7A889B407D8A5318B4FB9040A2F45D5479889B4036E9222DB6FB9040D7764D5578889B400E0A2F2FB8FB9040463E453277889B40C8480B1CBAFB90408BACA4EC75889B40BF9564F1BBFB904014E8F48574889B40594404ADBDFB90407501E7FF72889B403AB7D24CBFFB90408BE8515C71889B40EAE6D9CEC0FB9040E433309D6F889B4000C04731C2FB90401CBD9DC46D889B40D6557072C3FB90401115D5D46B889B402FE7CF90C4FB904002D32CD069889B4069B20C8BC5FB9040DBC114B967889B40E996F85FC6FB90400AEF129265889B407C3161E4C6FB9040EB1A1FE663889B400102000000020000006CD4A6C2DCFF9040DD861F4049909B4039A1738FA9FB9040DC861F4049909B4001020000000200000039A1738FA9FB9040DD861F4049909B4039A1738FA9FB9040DC861F4049909B4001020000000200000039A1738FA9FD9040DD861F4049909B4039A1738FA9FB9040DD861F4049909B4001020000000200000039A1738FA9FB9040A953EC0C56909B4039A1738FA9FB9040DD861F4049909B4001020000000200000039A1738FA9FD9040A953EC0C56909B4039A1738FA9FB9040A953EC0C56909B4001020000000200000039A1738FA9FB90407620B9D962909B4039A1738FA9FB9040A953EC0C56909B4001020000000200000039A1738FA9FB90407620B9D962909B4039A1738FA9FD90407620B9D962909B400102000000020000007C3161E4C6FB90406B9AB0D351879B407C3161E4C6FB9040A9AF60C651879B4001020000000A0000007C3161E4C6FB9040EA0F469764879B4022C43576C7FB90409D94D75A62879B40D16D68E0C7FB9040815CC01560879B4062F67822C8FB9040E9FDBDCA5D879B40469A173CC8FB90407834957C5B879B40D36A252DC8FB90407A890E2E59879B40A273B4F5C7FB904090F7F2E156879B40C1A40796C7FB9040E38D089B54879B40E381920EC7FB9040D7160F5C52879B407C3161E4C6FB90406B9AB0D351879B400102000000020000007C3161E4C6FB9040EA0F469764879B407C3161E4C6FB90406B9AB0D351879B400102000000020000007C3161E4C6FB90406CA5892251889B407C3161E4C6FB9040EA0F469764879B4001020000000A0000007C3161E4C6FB9040EB1A1FE663889B40E381920EC7FB90407F9EC05D63889B40C1A40796C7FB90407327C71E61889B40A273B4F5C7FB9040C6BDDCD75E889B40D36A252DC8FB9040DC2BC18B5C889B40469A173CC8FB9040DE803A3D5A889B4062F67822C8FB90406DB711EF57889B40D16D68E0C7FB9040D4580FA455889B4022C43576C7FB9040B920F85E53889B407C3161E4C6FB90406CA5892251889B400102000000020000007C3161E4C6FB9040EB1A1FE663889B407C3161E4C6FB90406CA5892251889B400102000000020000007C3161E4C6FB9040AD056FF363889B407C3161E4C6FB9040EB1A1FE663889B40010200000004000000E504779735FD904056759FB4419A9B4072A777ED35FD904056759FB4419A9B4072A777ED35FD9040DE30BDDF469B9B4072A777ED35FD9040DF30BDDF469B9B40010200000034000000E504779735FD904056759FB4419A9B403F2681A609FD904056759FB4419A9B403F2681A609FD9040DE30BDDF469B9B4056F1DAF109FD904018BE7D7D4F9B9B4081628ED30AFD9040B587F510589B9B40C4148E4A0CFD90408B10E88F609B9B40D66F1A550EFD9040AA5931F0689B9B4057BEC3F010FD9040ECFCD127719B9B4049166D1A14FD9040D31BFB2C799B9B40401050CE17FD90407D141AF6809B9B40DD4801081CFD9040B1EEE379889B9B4039A775C220FD9040637360AF8F9B9B40F16108F825FD904070E1F48D969B9B409FBB81A22BFD9040CF326E0D9D9B9B40C06E1EBB31FD9040F0E50A26A39B9B401FC0973A38FD90409E3F84D0A89B9B402C2E2C193FFD904056FA1606AE9B9B40DEB2A84E46FD9040B2588BC0B29B9B40128D72D24DFD90404E913CFAB69B9B40BC85919B55FD9040458B1FAEBA9B9B40A3A4BAA05DFD904038E3C8D7BD9B9B40E4475BD865FD9040B9317273C09B9B400491A4386EFD9040CB8CFE7DC29B9B40DA1997B776FD90400E3FFEF4C39B9B4077E30E4B7FFD904038B0B1D6C49B9B40B070CFE887FD9040507B0B22C59B9B40E4AE9C617DFE9040507B0B22C59B9B401D3C5DFF85FE904038B0B1D6C49B9B40BA05D5928EFE90400E3FFEF4C39B9B40908EC71197FE9040CB8CFE7DC29B9B40B0D710729FFE9040B9317273C09B9B40F17AB1A9A7FE904038E3C8D7BD9B9B40D899DAAEAFFE9040468B1FAEBA9B9B408292F977B7FE90404F913CFAB69B9B40B76CC3FBBEFE9040B2588BC0B29B9B4068F13F31C6FE904056FA1606AE9B9B40755FD40FCDFE90409E3F84D0A89B9B40D4B04D8FD3FE9040F0E50A26A39B9B40F563EAA7D9FE9040CF326E0D9D9B9B40A4BD6352DFFE904070E1F48D969B9B405B78F687E4FE9040637360AF8F9B9B40B7D66A42E9FE9040B1EEE379889B9B40540F1C7CEDFE90407D141AF6809B9B404B09FF2FF1FE9040D31BFB2C799B9B403D61A859F4FE9040ECFCD127719B9B40BFAF51F5F6FE9040AA5931F0689B9B40D00ADEFFF8FE90408B10E88F609B9B4014BDDD76FAFE9040B587F510589B9B403E2E9158FBFE904018BE7D7D4F9B9B4055F9EAA3FBFE9040DF30BDDF469B9B4055F9EAA3FBFE904056759FB4419A9B40AF1AF5B2CFFE904056759FB4419A9B40010200000004000000AF1AF5B2CFFE904056759FB4419A9B40727B61CCB6FE9040B6E171882B9A9B4022A40A7E4EFD9040B6E171882B9A9B40E504779735FD904056759FB4419A9B40010200000004000000E904779735FD9040C6A53F9091949B4026A40A7E4EFD904066396DBCA7949B40767B61CCB6FE904066396DBCA7949B40B31AF5B2CFFE9040C6A53F9091949B40010200000034000000B31AF5B2CFFE9040C6A53F9091949B4059F9EAA3FBFE9040C6A53F9091949B4059F9EAA3FBFE90403EEA21658C939B40422E9158FBFE9040045D61C783939B4017BDDD76FAFE90406793E9337B939B40D40ADEFFF8FE9040910AF7B472939B40C2AF51F5F6FE904072C1AD546A939B404161A859F4FE9040301E0D1D62939B404F09FF2FF1FE904049FFE3175A939B40580F1C7CEDFE90409F06C54E52939B40BBD66A42E9FE90406B2CFBCA4A939B405F78F687E4FE9040B9A77E9543939B40A7BD6352DFFE9040AC39EAB63C939B40F963EAA7D9FE90404DE8703736939B40D8B04D8FD3FE90402C35D41E30939B40795FD40FCDFE90407EDB5A742A939B406CF13F31C6FE9040C620C83E25939B40BA6CC3FBBEFE90406AC2538420939B408692F977B7FE9040CE89A24A1C939B40DC99DAAEAFFE9040D78FBF9618939B40F57AB1A9A7FE9040E437166D15939B40B4D710729FFE904063E96CD112939B40948EC71197FE9040518EE0C610939B40BE05D5928EFE90400EDCE04F0F939B40213C5DFF85FE9040E46A2D6E0E939B40E8AE9C617DFE9040CC9FD3220E939B40B470CFE887FD9040CC9FD3220E939B407BE30E4B7FFD9040E46A2D6E0E939B40DE1997B776FD90400EDCE04F0F939B400891A4386EFD9040518EE0C610939B40E8475BD865FD904063E96CD112939B40A7A4BAA05DFD9040E437166D15939B40C085919B55FD9040D68FBF9618939B40168D72D24DFD9040CD89A24A1C939B40E1B2A84E46FD90406AC2538420939B40302E2C193FFD9040C620C83E25939B4023C0973A38FD90407EDB5A742A939B40C46E1EBB31FD90402C35D41E30939B40A3BB81A22BFD90404DE8703736939B40F46108F825FD9040AC39EAB63C939B403DA775C220FD9040B9A77E9543939B40E14801081CFD90406B2CFBCA4A939B40441050CE17FD90409F06C54E52939B404D166D1A14FD904049FFE3175A939B405BBEC3F010FD9040301E0D1D62939B40D96F1A550EFD904072C1AD546A939B40C8148E4A0CFD9040910AF7B472939B4084628ED30AFD90406793E9337B939B405AF1DAF109FD9040045D61C783939B40432681A609FD90403DEA21658C939B40432681A609FD9040C6A53F9091949B40E904779735FD9040C6A53F9091949B4001020000000200000076A777ED35FD90403DEA21658C939B40E904779735FD9040C6A53F9091949B4001020000002000000072A777ED35FD9040DF30BDDF469B9B40758638743AFD90405B0A35D34C9B9B40787C3D623FFD9040BD584B72529B9B40EF4466B144FD904048CE03B6579B9B40F2E4195B4AFD9040FDA6D3975C9B9B4009DE4E5850FD9040CCC9A911619B9B40DDEC93A156FD90408E52F61D659B9B40CB48192F5DFD90406B7BB1B7689B9B40F758BAF863FD904029DD61DA6B9B9B40C3D207F66AFD90407DFE21826E9B9B401235521E72FD9040982BA5AB709B9B405C93B46879FD9040D48F3B54729B9B4023A31FCC80FD9040708CD579739B9B400DFE643F88FD90403948061B749B9B40A58A42B98FFD9040F0740537749B9B409BFD6D3097FD90402D48B0CD739B9B40F921FE196EFE90402D48B0CD739B9B40EF94299175FE9040F0740537749B9B408721070B7DFE90403948061B749B9B40717C4C7E84FE9040708CD579739B9B40388CB7E18BFE9040D48F3B54729B9B4082EA192C93FE9040982BA5AB709B9B40D14C64549AFE90407DFE21826E9B9B409DC6B151A1FE904029DD61DA6B9B9B40CAD6521BA8FE90406B7BB1B7689B9B40B732D8A8AEFE90408E52F61D659B9B408B411DF2B4FE9040CCC9A911619B9B40A23A52EFBAFE9040FDA6D3975C9B9B40A5DA0599C0FE904048CE03B6579B9B401CA32EE8C5FE9040BD584B72529B9B401F9933D6CAFE90405B0A35D34C9B9B402278F45CCFFE9040DF30BDDF469B9B4001020000003000000072A777ED35FD9040DF30BDDF469B9B4017CC641E36FD9040FE48F7774C9B9B4023D4F1B036FD90402BE38309529B9B40A1D36FA437FD9040DF79BD8D579B9B405029BCF738FD9040F36E0EFE5C9B9B408DD941A93AFD904084E7F853629B9B40B071FBB63CFD9040908B1E89679B9B40AF71751E3FFD9040E61F48976C9B9B401539D1DC41FD904072F16C78719B9B40DB73C8EE44FD9040F508BA26769B9B400903B15048FD9040A21E999C7A9B9B406F5C81FE4BFD90404A45B7D47E9B9B40455CD5F34FFD90401F450BCA829B9B40EC82F32B54FD9040859EDB77869B9B409998D2A158FD9040B42DC4D9899B9B401CB01F505DFD90407A68BBEB8C9B9B40A881443162FD9040E02F17AA8F9B9B40FF156E3F67FD9040DE2F9111929B9B400BBA93746CFD904002C84A1F949B9B409C327ECA71FD90403F78D0D0959B9B40AF27CF3A77FD9040EECD1C24979B9B4064BE08BF7CFD90406BCD9A17989B9B409158955082FD904078D527AA989B9B40B070CFE887FD90401DFA14DB989B9B40E4AE9C617DFE90401DFA14DB989B9B4003C7D6F982FE904078D527AA989B9B403061638B88FE90406CCD9A17989B9B40E5F79C0F8EFE9040EECD1C24979B9B40F8ECED7F93FE90403F78D0D0959B9B408965D8D598FE904002C84A1F949B9B409509FE0A9EFE9040DF2F9111929B9B40EC9D2719A3FE9040E02F17AA8F9B9B40786F4CFAA7FE90407A68BBEB8C9B9B40FB8699A8ACFE9040B42DC4D9899B9B40A89C781EB1FE9040859EDB77869B9B404FC39656B5FE90401F450BCA829B9B4025C3EA4BB9FE90404A45B7D47E9B9B408B1CBBF9BCFE9040A31E999C7A9B9B40B9ABA35BC0FE9040F508BA26769B9B407FE69A6DC3FE904073F16C78719B9B40E5ADF62BC6FE9040E71F48976C9B9B40E4AD7093C8FE9040908B1E89679B9B4007462AA1CAFE904084E7F853629B9B4044F6AF52CCFE9040F36E0EFE5C9B9B40F34BFCA5CDFE9040E079BD8D579B9B40714B7A99CEFE90402BE38309529B9B407D53072CCFFE9040FE48F7774C9B9B402278F45CCFFE9040DF30BDDF469B9B400102000000300000002678F45CCFFE90403DEA21658C939B408153072CCFFE90401ED2E7CC86939B40754B7A99CEFE9040F1375B3B81939B40F74BFCA5CDFE90403DA121B77B939B4048F6AF52CCFE904029ACD04676939B400B462AA1CAFE90409833E6F070939B40E8AD7093C8FE90408C8FC0BB6B939B40E9ADF62BC6FE904036FB96AD66939B4083E69A6DC3FE9040AA2972CC61939B40BDABA35BC0FE90402712251E5D939B408F1CBBF9BCFE90407AFC45A858939B4029C3EA4BB9FE9040D2D5277054939B4053C39656B5FE9040FDD5D37A50939B40AC9C781EB1FE9040977C03CD4C939B40FF8699A8ACFE904068ED1A6B49939B407C6F4CFAA7FE9040A2B2235946939B40F09D2719A3FE90403CEBC79A43939B409909FE0A9EFE90403EEB4D3341939B408D65D8D598FE90401A5394253F939B40FCECED7F93FE9040DDA20E743D939B40E9F79C0F8EFE90402E4DC2203C939B403461638B88FE9040B14D442D3B939B4007C7D6F982FE9040A445B79A3A939B40E8AE9C617DFE9040FF20CA693A939B40B470CFE887FD9040FF20CA693A939B409558955082FD9040A445B79A3A939B4068BE08BF7CFD9040B04D442D3B939B40B327CF3A77FD90402E4DC2203C939B40A0327ECA71FD9040DDA20E743D939B400FBA93746CFD90401A5394253F939B4003166E3F67FD90403DEB4D3341939B40AC81443162FD90403CEBC79A43939B4020B01F505DFD9040A2B2235946939B409D98D2A158FD904068ED1A6B49939B40F082F32B54FD9040977C03CD4C939B40495CD5F34FFD9040FDD5D37A50939B40735C81FE4BFD9040D2D5277054939B400D03B15048FD904079FC45A858939B40DF73C8EE44FD90402712251E5D939B401939D1DC41FD9040A92972CC61939B40B371751E3FFD904035FB96AD66939B40B471FBB63CFD90408C8FC0BB6B939B4091D941A93AFD90409833E6F070939B405429BCF738FD904029ACD04676939B40A5D36FA437FD90403CA121B77B939B4027D4F1B036FD9040F1375B3B81939B401BCC641E36FD90401ED2E7CC86939B4076A777ED35FD90403DEA21658C939B400102000000200000002678F45CCFFE90403DEA21658C939B40239933D6CAFE9040C110AA7186939B4020A32EE8C5FE90405FC293D280939B40A9DA0599C0FE9040D44CDB8E7B939B40A63A52EFBAFE90401F740BAD76939B408F411DF2B4FE90405051353372939B40BB32D8A8AEFE90408EC8E8266E939B40CDD6521BA8FE9040B19F2D8D6A939B40A1C6B151A1FE9040F33D7D6A67939B40D54C64549AFE90409F1CBDC264939B4086EA192C93FE904084EF399962939B403C8CB7E18BFE9040488BA3F060939B40757C4C7E84FE9040AC8E09CB5F939B408B21070B7DFE9040E3D2D8295F939B40F394299175FE90402CA6D90D5F939B40FD21FE196EFE9040EFD22E775F939B409FFD6D3097FD9040EFD22E775F939B40A98A42B98FFD90402CA6D90D5F939B4011FE643F88FD9040E3D2D8295F939B4027A31FCC80FD9040AC8E09CB5F939B406093B46879FD9040488BA3F060939B401635521E72FD904084EF399962939B40C7D207F66AFD90409F1CBDC264939B40FB58BAF863FD9040F33D7D6A67939B40CE48192F5DFD9040B19F2D8D6A939B40E1EC93A156FD90408EC8E8266E939B400DDE4E5850FD90405051353372939B40F6E4195B4AFD90401F740BAD76939B40F34466B144FD9040D44CDB8E7B939B407C7C3D623FFD90405FC293D280939B40798638743AFD9040C110AA7186939B4076A777ED35FD90403DEA21658C939B4001020000000300000039A1738FA9FD9040DD861F4049909B40A007DAF50FFE9040DD861F4049909B40A007DAF50FFE9040A953EC0C56909B4001020000000200000039A1738FA9FD9040A953EC0C56909B4039A1738FA9FD9040DD861F4049909B40010200000002000000A007DAF50FFE9040A953EC0C56909B4039A1738FA9FD9040A953EC0C56909B4001020000000200000039A1738FA9FD90407620B9D962909B4039A1738FA9FD9040A953EC0C56909B40010200000002000000A007DAF50FFE90407620B9D962909B4039A1738FA9FD90407620B9D962909B40010200000002000000135816A1B6FD90404B28911B568C9B40135816A1B6FD904018F55DE822899B400102000000020000004B8B49D4E9FD9040E5C12AB5EF889B40135816A1B6FD904018F55DE822899B400102000000020000004B8B49D4E9FD90407F5BC44E898C9B40135816A1B6FD90404B28911B568C9B400102000000020000004B8B49D4E9FD90407F5BC44E898C9B404B8B49D4E9FD9040E5C12AB5EF889B40010200000002000000D33A0D294302914043ED85A62F909B40A007DAF50FFE904043ED85A62F909B40010200000002000000A007DAF50FFE904010BA52733C909B40A007DAF50FFE904043ED85A62F909B40010200000004000000A007DAF50FFE904043ED85A62F909B4039A1738FA9FD904043ED85A62F909B4039A1738FA9FD9040DC861F4049909B40A007DAF50FFE9040DC861F4049909B40010200000002000000D33A0D294302914010BA52733C909B40A007DAF50FFE904010BA52733C909B40010200000002000000A007DAF50FFE9040DC861F4049909B40A007DAF50FFE904010BA52733C909B40010200000002000000A007DAF50FFE9040DC861F4049909B40D33A0D2943029140DD861F4049909B400102000000020000006CD4A6C2DCFF9040A953EC0C56909B40A007DAF50FFE9040A953EC0C56909B40010200000002000000A007DAF50FFE9040A953EC0C56909B40A007DAF50FFE90407620B9D962909B40010200000002000000A007DAF50FFE90407620B9D962909B406CD4A6C2DCFF90407620B9D962909B400102000000020000002278F45CCFFE9040DF30BDDF469B9B40AF1AF5B2CFFE904056759FB4419A9B40010200000004000000B31AF5B2CFFE9040C6A53F9091949B402678F45CCFFE9040C6A53F9091949B402678F45CCFFE90403EEA21658C939B402678F45CCFFE90403DEA21658C939B400102000000040000006CD4A6C2DCFF9040DD861F4049909B40D33A0D2943009140DD861F4049909B40D33A0D29430091407620B9D962909B406CD4A6C2DCFF90407620B9D962909B400102000000020000006CD4A6C2DCFF9040A953EC0C56909B406CD4A6C2DCFF9040DD861F4049909B400102000000020000006CD4A6C2DCFF90407620B9D962909B406CD4A6C2DCFF9040A953EC0C56909B40010200000002000000D33A0D294302914043ED85A62F909B4039A1738FA902914043ED85A62F909B40010200000002000000D33A0D294302914010BA52733C909B40D33A0D294302914043ED85A62F909B40010200000002000000D33A0D2943029140DD861F4049909B40D33A0D294302914010BA52733C909B4001020000000200000039A1738FA9029140DD861F4049909B40D33A0D2943029140DD861F4049909B4001020000000200000039A1738FA902914010BA5273FC8F9B40D33A0D29C302914010BA5273FC8F9B4001020000000200000039A1738FA902914043ED85A62F909B4039A1738FA902914010BA5273FC8F9B40010200000003000000D13A0D29C30291403916E235F28F9B4039A1738FA90291403916E235F28F9B4039A1738FA902914010BA5273FC8F9B4001020000000200000039A1738FA9029140DD861F4049909B4039A1738FA902914043ED85A62F909B4001020000000200000039A1738FA9029140A953EC0C96909B4039A1738FA9029140DD861F4049909B40010200000002000000FD969CEBB8029140A953EC0C96909B4039A1738FA9029140A953EC0C96909B40010200000003000000FD969CEBB802914080F75C4AA0909B4039A1738FA902914080F75C4AA0909B4039A1738FA9029140A953EC0C96909B40010200000002000000D33A0D29C3029140A953EC0C96909B40FD969CEBB8029140A953EC0C96909B40010200000002000000FD969CEBB8029140A953EC0C96909B40FD969CEBB802914080F75C4AA0909B40010200000003000000D33A0D29C30291400FBA52737C909B40FD969CEBB80291400FBA52737C909B40FD969CEBB8029140A953EC0C96909B40010200000002000000D33A0D29C302914080F75C4AA0909B40FD969CEBB802914080F75C4AA0909B40010200000003000000FD969CEBB802914080F75C4AA0909B40FD969CEBB802914043ED85A6AF909B40D33A0D29C302914043ED85A6AF909B40010200000002000000D33A0D29C30291403916E235F28F9B40D13A0D29C30291403916E235F28F9B40010200000003000000D13A0D29C30291403916E235F28F9B40D13A0D29C30291400DBA5273FC8F9B40D33A0D29C30291400DBA5273FC8F9B40010200000005000000CEE4FEFB1003914048940028EB8F9B40D00F8612EA02914048940028EB8F9B40D00F8612EA02914065815782E28F9B40D13A0D29C302914065815782E28F9B40D13A0D29C30291403916E235F28F9B40010200000002000000D33A0D29C30291403916E235F28F9B40D33A0D29C3029140BA1DD57AEF8F9B400102000000030000006DD4A6C2DC0291400BBA5273FC8F9B406DD4A6C2DC0291403916E235F28F9B40D33A0D29C30291403916E235F28F9B40010200000002000000D33A0D29C30291400BBA5273FC8F9B40D33A0D29C30291403916E235F28F9B40010200000002000000D33A0D29C30291400BBA5273FC8F9B406DD4A6C2DC0291400BBA5273FC8F9B40010200000002000000D33A0D29C30291400DBA5273FC8F9B40D33A0D29C30291400BBA5273FC8F9B40010200000002000000D33A0D29C30291400DBA5273FC8F9B406DD4A6C2DC0291400DBA5273FC8F9B40010200000002000000D33A0D29C302914010BA5273FC8F9B40D33A0D29C30291400DBA5273FC8F9B40010200000003000000D33A0D29C302914010BA5273FC8F9B406DD4A6C2DC02914010BA5273FC8F9B406DD4A6C2DC0291400DBA5273FC8F9B40010200000002000000D33A0D29C302914010BA5273FC8F9B40D33A0D29C30291400FBA52737C909B40010200000003000000D43A0D29C3029140A953EC0C96909B40D43A0D29C30291400FBA52737C909B40D33A0D29C30291400FBA52737C909B40010200000002000000D33A0D29C30291400FBA52737C909B40D33A0D29C3029140A953EC0C96909B40010200000002000000D33A0D29C3029140A953EC0C96909B40D43A0D29C3029140A953EC0C96909B40010200000002000000D33A0D29C3029140A953EC0C96909B40D33A0D29C302914080F75C4AA0909B40010200000002000000D43A0D29C302914080F75C4AA0909B40D33A0D29C302914080F75C4AA0909B40010200000002000000D33A0D29C302914080F75C4AA0909B40D33A0D29C302914043ED85A6AF909B40010200000002000000D33A0D29C302914043ED85A6AF909B40D43A0D29C302914043ED85A6AF909B40010200000002000000D33A0D29C302914043ED85A6AF989B40D43A0D29C302914043ED85A6AF989B40010200000002000000D33A0D29C30291407620B9D9E2989B40D33A0D29C302914043ED85A6AF989B40010200000004000000D33A0D29C30291407620B9D9E2989B40FD969CEBB80291407620B9D9E2989B40FD969CEBB802914043ED85A6AF989B40D33A0D29C302914043ED85A6AF989B40010200000003000000D43A0D29C3029140DC861F40C9989B40D43A0D29C30291407620B9D9E2989B40D33A0D29C30291407620B9D9E2989B40010200000002000000D43A0D29C3029140A953EC0C96909B406DD4A6C2DC029140A953EC0C96909B40010200000002000000D43A0D29C302914080F75C4AA0909B40D43A0D29C3029140A953EC0C96909B400102000000030000006DD4A6C2DC029140A953EC0C96909B406DD4A6C2DC02914080F75C4AA0909B40D43A0D29C302914080F75C4AA0909B40010200000002000000D43A0D29C302914043ED85A6AF909B40D43A0D29C302914080F75C4AA0909B40010200000002000000D43A0D29C302914043ED85A6AF909B40066E405CF602914043ED85A6AF909B40010200000002000000D43A0D29C302914043ED85A6AF989B40A007DAF50F03914043ED85A6AF989B40010200000002000000D43A0D29C3029140DC861F40C9989B40D43A0D29C302914043ED85A6AF989B400102000000020000006DD4A6C25C039140DC861F40C9989B40D43A0D29C3029140DC861F40C9989B400102000000020000006DD4A6C2DC0291400BBA5273FC8F9B40CEE4FEFB100391400BBA5273FC8F9B400102000000020000006DD4A6C2DC0291400DBA5273FC8F9B406DD4A6C2DC0291400BBA5273FC8F9B400102000000030000006DD4A6C2DC0291400DBA5273FC8F9B40CEE4FEFB100391400DBA5273FC8F9B40CEE4FEFB100391400BBA5273FC8F9B400102000000020000006DD4A6C2DC029140A953EC0C96909B406DD4A6C25C039140A953EC0C96909B40010200000002000000066E405CF602914043ED85A6AF909B40A007DAF50F03914043ED85A6AF909B40010200000002000000066E405CF602914043ED85A6AF909B40066E405CF6029140A953EC0C16919B40010200000002000000066E405CF6029140A953EC0C16919B40D33A0D2903039140A953EC0C16919B40010200000002000000066E405CF6029140A953EC0C16919B40076E405CF60291400FBA52737C949B40010200000002000000076E405CF60291407620B9D9E2929B40D43A0D29030391407620B9D9E2929B40010200000002000000076E405CF60291407620B9D9E2929B40076E405CF60291400FBA52737C949B40010200000003000000D33A0D29030391400FBA52737C929B40076E405CF60291400FBA52737C929B40076E405CF60291407620B9D9E2929B40010200000002000000076E405CF60291400FBA52737C949B40D43A0D29030391400FBA52737C949B40010200000002000000076E405CF60291407620B9D9E2949B40076E405CF60291400FBA52737C949B40010200000002000000D43A0D29030391407620B9D9E2949B40076E405CF60291407620B9D9E2949B40010200000002000000076E405CF60291407620B9D9E2949B40076E405CF6029140DC861F4049969B40010200000002000000076E405CF6029140DC861F4049969B40D43A0D2903039140DC861F4049969B40010200000004000000A007DAF50F039140DC861F4049969B40A007DAF50F03914043ED85A6AF969B40076E405CF602914043ED85A6AF969B40076E405CF6029140DC861F4049969B40010200000002000000D33A0D2903039140A953EC0C16919B40A007DAF50F039140A953EC0C16919B40010200000002000000D33A0D29030391400FBA52737C929B40D33A0D2903039140A953EC0C16919B40010200000002000000A007DAF50F0391400FBA52737C929B40D33A0D29030391400FBA52737C929B40010200000002000000D43A0D29030391407620B9D9E2929B40D33A0D29030391400FBA52737C929B40010200000002000000D43A0D29030391407620B9D9E2929B40A007DAF50F0391407620B9D9E2929B40010200000002000000D43A0D29030391400FBA52737C949B40D43A0D29030391407620B9D9E2929B40010200000002000000D43A0D29030391400FBA52737C949B40A007DAF50F0391400FBA52737C949B40010200000002000000D43A0D29030391407620B9D9E2949B40D43A0D29030391400FBA52737C949B40010200000003000000A007DAF50F0391400FBA52737C949B40A007DAF50F0391407620B9D9E2949B40D43A0D29030391407620B9D9E2949B40010200000002000000D43A0D2903039140DC861F4049969B40D43A0D29030391407620B9D9E2949B40010200000002000000D43A0D2903039140DC861F4049969B40A007DAF50F039140DC861F4049969B40010200000002000000A007DAF50F03914043ED85A6AF909B406DD4A6C25C03914043ED85A6AF909B40010200000002000000A007DAF50F039140A953EC0C16919B40A007DAF50F03914043ED85A6AF909B40010200000002000000A007DAF50F0391400FBA52737C929B40A007DAF50F039140A953EC0C16919B40010200000003000000A107DAF50F0391407620B9D9E2929B40A107DAF50F0391400FBA52737C929B40A007DAF50F0391400FBA52737C929B40010200000002000000A007DAF50F0391407620B9D9E2929B40A007DAF50F0391400FBA52737C929B40010200000002000000A007DAF50F0391407620B9D9E2929B40A107DAF50F0391407620B9D9E2929B40010200000002000000A007DAF50F0391400FBA52737C949B40A007DAF50F0391407620B9D9E2929B40010200000002000000A007DAF50F039140DC861F4049969B40A107DAF50F0391407620B9D9E2929B40010200000002000000A007DAF50F039140DC861F4049989B406DD4A6C21C039140DC861F4049989B40010200000002000000A007DAF50F03914043ED85A6AF989B40A007DAF50F039140DC861F4049989B40010200000002000000A107DAF50F0391407620B9D9E2949B40A007DAF50F039140DC861F4049989B40010200000002000000A007DAF50F03914043ED85A6AF989B403AA1738F2903914043ED85A6AF989B40010200000002000000A107DAF50F0391407620B9D9E2949B406DD4A6C21C0391407620B9D9E2949B400102000000040000003AA1738F290391407620B9D9E2949B403AA1738F290391400FBA52737C949B40A107DAF50F0391400FBA52737C949B40A107DAF50F0391407620B9D9E2949B40010200000016000000CEE4FEFB10039140FC3B3481038D9B402DBD45A0430391400A68243B058D9B402BBB5B0876039140CAA6E7660A8D9B40CB8E57F8A7039140519858FE128D9B40CAA7DE34D9039140441041F71E8D9B4056C16B8309049140EE3866432E8D9B40347094AA38049140017D99D0408D9B40C2604D7266049140D623CE88568D9B40A7F32CA4920491408B8633526F8D9B400CEAAB0BBD049140CCBE530F8B8D9B4081D46376E5049140DBAA369FA98D9B4059FA4AB40B0591402A1D89DDCA8D9B404372ED972F0591400909C8A2EE8D9B404D28A3F65005914001796FC4148E9B401691C2A86F05914018172D153D8E9B40F0CDCF898B059140EA0A1665678E9B40DE09A878A405914098EDDF81938E9B40FDDBA857BA059140C68F1C37C18E9B406880D30CCD059140C14A784EF08E9B40D8BDEB81DC0591409392FA8F208F9B40325392A4E8059140687C48C2518F9B40A6CD5A66F10591401CEAE8AA838F9B40010200000007000000CEE4FEFB10039140FC3B3481038D9B40D00F8612EA029140FC3B3481038D9B40D00F8612EA029140E14EDD260C8D9B40D13A0D29C3029140E14EDD260C8D9B40D13A0D29C30291403616E235F28C9B40CEE4FEFB100391403616E235F28C9B40CEE4FEFB10039140FC3B3481038D9B40010200000002000000CEE4FEFB100391400BBA5273FC8F9B40CEE4FEFB1003914048940028EB8F9B40010200000003000000CEE4FEFB1003914048940028EB8F9B4018D9C25C0E03914000C12B55C48F9B40D781110AA805914032850A60978F9B40010200000002000000CEE4FEFB1003914048940028EB8F9B408D8D4DA9AA0591407A58DF32BE8F9B40010200000005000000CEE4FEFB100391400BBA5273FC8F9B40B79574B4CB0E91400BBA5273FC8F9B40B79574B4CB0E91400D20B9D962869B4039A1738F290391400D20B9D962869B4039A1738F290391403416E235F28C9B400102000000020000006DD4A6C21C0391407620B9D9E2949B403AA1738F290391407620B9D9E2949B400102000000020000006DD4A6C21C039140DC861F4049989B406DD4A6C21C0391407620B9D9E2949B400102000000020000006DD4A6C21C039140DC861F4049989B403AA1738F29039140DC861F4049989B400102000000020000003AA1738F29039140DC861F4049989B403AA1738F290391407620B9D9E2949B400102000000020000003AA1738F29039140DC861F4049989B403AA1738F2903914043ED85A6AF989B400102000000020000003AA1738F2903914043ED85A6AF989B406DD4A6C25C03914043ED85A6AF989B400102000000020000006DD4A6C25C039140A953EC0C96909B404478170067039140A953EC0C96909B400102000000020000006DD4A6C25C03914043ED85A6AF909B406DD4A6C25C039140A953EC0C96909B400102000000040000006DD4A6C25C039140A953EC0C96909B406DD4A6C25C0391400FBA52737C909B4044781700670391400FBA52737C909B404478170067039140A953EC0C96909B400102000000030000004478170067039140A953EC0C96909B40447817006703914043ED85A6AF909B406DD4A6C25C03914043ED85A6AF909B400102000000040000006DD4A6C25C0391407620B9D9E2989B4044781700670391407620B9D9E2989B40447817006703914043ED85A6AF989B406DD4A6C25C03914043ED85A6AF989B400102000000020000006DD4A6C25C03914043ED85A6AF989B406DD4A6C25C039140DC861F40C9989B400102000000030000006DD4A6C25C039140DC861F40C9989B406DD4A6C25C039140DD861F40C9989B406DD4A6C25C0391407620B9D9E2989B400102000000050000006DD4A6C25C0391407620B9D9E2989B406DD4A6C25C03914010BA5273FC9B9B40B79574B4CB0E914010BA5273FC9B9B40B79574B4CB0E9140A953EC0C96909B404478170067039140A953EC0C96909B40010200000002000000D781110AA805914032850A60978F9B40AC7F25C2A705914020B71B37938F9B40010200000002000000AC7F25C2A705914020B71B37938F9B409391266AB5059140BAC22D2B8F8F9B4001020000000200000088F73571DB059140701087B98F8F9B40AC7F25C2A705914020B71B37938F9B40010200000002000000D781110AA805914032850A60978F9B40B2F921B9DB05914083DE75E2938F9B40010200000003000000D781110AA805914032850A60978F9B40B2F921B9DB05914084DE75E2938F9B40B2F921B9DB05914083DE75E2938F9B400102000000020000008D8D4DA9AA0591407A58DF32BE8F9B40B68F39F1AA0591408C26CE5BC28F9B4001020000000400000068055E58DE059140CBB14AB5BA8F9B4068055E58DE059140CAB14AB5BA8F9B408D8D4DA9AA0591407858DF32BE8F9B408D8D4DA9AA0591407A58DF32BE8F9B400102000000020000008D8D4DA9AA0591407A58DF32BE8F9B4068055E58DE059140CBB14AB5BA8F9B40010200000002000000B68F39F1AA0591408C26CE5BC28F9B40AADBC504B9059140DA614188C48F9B4001020000000200000092074AA0DE059140DF7F39DEBE8F9B40B68F39F1AA0591408C26CE5BC28F9B400102000000020000005D12300BB00591401A292F88798F9B40ACE23207B0059140C3207488798F9B40010200000006000000B5524F26B5059140B547AD2D7D8F9B402B5CE0FBB30591407C67B48A7C8F9B4082C007BBB2059140AC077DBD7B8F9B40652C2489B10591409E3594DA7A8F9B405B71AC67B0059140F7FB0FE3798F9B405D12300BB00591401A292F88798F9B400102000000190000005D12300BB00591401A292F88798F9B40C3410358AF05914086A51FD8788F9B40367E755BAE059140A4490ABB778F9B40A69D3873AD059140693B2D8D768F9B40253269A0AC0591409A5DFA4F758F9B40398C09E4AB059140785DF604748F9B40507E003FAB05914070D6B6AD728F9B40F14118B2AA0591402561E04B718F9B40E87FFD3DAA059140069024E16F8F9B40BE7C3EE3A905914011DC3F6F6E8F9B405E6A4AA2A90591402A84F7F76C8F9B40DADF707BA9059140C061177D6B8F9B40E177E16EA90591404EB56F006A8F9B406B96AB7CA905914082EDD283688F9B40DE55BEA4A9059140AE6B1309678F9B40C29BE8E6A905914056480192658F9B40EC54D942AA0591407B1A6820648F9B40D6D81FB8AA05914077C40CB6628F9B40AA732C46AB0591400E49AB54618F9B405A1651ECAB0591405AABF4FD5F8F9B40E52BC2A9AC0591403ADC8CB35E8F9B40CE92977DAD059140BBB708775D8F9B408CB9CD66AE0591400015EC495C8F9B4099DC4664AF0591400AEBA72D5B8F9B409C64CC74B00591409A8C98235A8F9B40010200000002000000BF0B5EC7CF059140E2488163778F9B405D12300BB00591401A292F88798F9B40010200000002000000F20E1E26CB0591400AD41856588F9B409B64CC74B0059140988C98235A8F9B40010200000002000000B5524F26B5059140B547AD2D7D8F9B40791BDD23B50591409492D72D7D8F9B400102000000030000006CA23BA4B605914048C23CE07D8F9B40FBD9244AB505914048DF3E417D8F9B40B5524F26B5059140B547AD2D7D8F9B400102000000020000003BEAA135CB059140D9AD46B07B8F9B40B5524F26B5059140B547AD2D7D8F9B400102000000020000009391266AB5059140BAC22D2B8F8F9B409BEB5CDFB6059140F827981D8D8F9B4001020000000200000094ABA95DCD05914022D5138D8D8F9B409391266AB5059140BAC22D2B8F8F9B40010200000002000000827B119BB60591401BEED3B1DA8F9B40D04B1497B6059140C4E518B2DA8F9B400102000000190000004E78513CBB059140F4623CBFF98F9B40933B7F0ABA0591402E323CDCF88F9B40F56A1AE9B805914014DBA1E4F78F9B40A5A185D9B705914090C39CD9F68F9B403EA70DDDB6059140681C74BCF58F9B40FFD7E7F4B50591405650858EF48F9B40B6A93022B5059140E0574251F38F9B40364FEA65B405914000F42F06F28F9B40EF7BFBC0B3059140C8D1E3AEF08F9B4042492E34B30591404899024DEF8F9B40DC3E2FC0B205914025EA3DE2ED8F9B404E7F8C65B205914037485270EC8F9B40E219B524B2059140E2FA04F9EA8F9B408682F8FDB1059140A6E1217EE98F9B406F3086F1B1059140A0407901E88F9B40F3636DFFB1059140AC87DD84E68F9B40D5139D27B2059140D016210AE58F9B402602E469B2059140CB021493E38F9B409EF8F0C5B20591406CDC8121E28F9B401D2C533BB3059140727D2FB7E08F9B40E1C67AC9B3059140A4DDD855DF8F9B40C598B96FB4059140CEF22EFFDD8F9B40B2EC432DB50591403E9ED5B4DC8F9B403E823101B605914044AA6178DB8F9B40827B119BB60591401BEED3B1DA8F9B40010200000006000000827B119BB60591401BEED3B1DA8F9B403DAA7EEAB60591402EDA564BDA8F9B40FA840DE8B7059140240F262FD98F9B407D60A7F8B80591402C842B25D88F9B404735FE1ABA0591406E23AD2ED78F9B40079DCD2CBB05914024890E65D68F9B40010200000002000000E0743F57D6059140E30D268DD88F9B40827B119BB60591401BEED3B1DA8F9B400102000000020000006DA23BA4B605914048C23CE07D8F9B406CA23BA4B605914048C23CE07D8F9B4001020000000200000052463801B705914004261341838F9B406CA23BA4B605914048C23CE07D8F9B40010200000004000000E4D32FD3C9059140CD8091947C8F9B40E4D32FD3C9059140CC8091947C8F9B406CA23BA4B605914045C23CE07D8F9B406CA23BA4B605914048C23CE07D8F9B400102000000030000009BEB5CDFB6059140F827981D8D8F9B40911FCB35B6059140B342D04E838F9B4052463801B705914004261341838F9B40010200000002000000966A2BA5CB0591401EAD72B68B8F9B409BEB5CDFB6059140F827981D8D8F9B40010200000003000000966A2BA5CB0591401EAD72B68B8F9B408B9E99FBCA059140DBC7AAE7818F9B4052463801B705914004261341838F9B40010200000002000000AADBC504B9059140DA614188C48F9B40A81C44BDBA059140E289E25EC68F9B40010200000002000000AAF548F8D0059140467427EAC28F9B40AADBC504B9059140DA614188C48F9B40010200000003000000A81C44BDBA059140E289E25EC68F9B40B3E8D566BB059140246FAA2DD08F9B40740F4332BC0591407552ED1FD08F9B40010200000002000000A29B1283CF059140090FBDF7C48F9B40A81C44BDBA059140E289E25EC68F9B40010200000002000000079DCD2CBB05914024890E65D68F9B40C7655B2ABB05914003D43865D68F9B40010200000003000000079DCD2CBB05914024890E65D68F9B40963FAE4DBB059140E4F6D84CD68F9B405BB33F8FBC05914032B6C380D58F9B400102000000020000008534203CD105914047EFA7E7D48F9B40079DCD2CBB05914024890E65D68F9B40010200000002000000A322A3EDD505914066AABCF1F78F9B404D78513CBB059140F5623CBFF98F9B40010200000002000000740F4332BC0591407452ED1FD08F9B40740F4332BC0591407552ED1FD08F9B40010200000003000000740F4332BC0591407552ED1FD08F9B405CB33F8FBC05914031B6C380D58F9B40D2E433BECF059140B6741835D48F9B40010200000003000000A29B1283CF059140090FBDF7C48F9B40AC67A42CD00591404AF484C6CE8F9B40740F4332BC0591407552ED1FD08F9B40010200000002000000E4D32FD3C9059140CD8091947C8F9B40E3D32FD3C9059140CE8091947C8F9B40010200000002000000C9772C30CA0591408AE467F5818F9B40E4D32FD3C9059140CD8091947C8F9B400102000000030000003BEAA135CB059140D9AD46B07B8F9B40A947C114CB0591401B407CC87B8F9B40E4D32FD3C9059140CD8091947C8F9B40010200000019000000F10E1E26CB0591400CD41856588F9B40AC4BF057CC059140D0041939598F9B404A1C5579CD059140EA5BB3305A8F9B409AE5E988CE0591406F73B83B5B8F9B4001E06185CF059140981AE1585C8F9B4040AF876DD0059140A9E6CF865D8F9B4088DD3E40D10591401EDF12C45E8F9B40093885FCD1059140FE42250F608F9B40500B74A1D205914038657166618F9B40FD3D412ED3059140B69D52C8628F9B40634840A2D3059140DA4C1733648F9B40F107E3FCD3059140C8EE02A5658F9B405D6DBA3DD40591401E3C501C678F9B40B9047764D40591405A553397688F9B40CF56E970D40591405EF6DB136A8F9B404C230263D405914054AF77906B8F9B406A73D23AD40591403020340B6D8F9B4019858BF8D3059140343441826E8F9B40A08E7E9CD3059140925AD3F36F8F9B40215B1C27D30591408CB9255E718F9B405EC0F498D20591405C597CBF728F9B407AEEB5F2D105914032442616748F9B408C9A2B35D1059140C1987F60758F9B4001053E61D0059140BC8CF39C768F9B40BF0B5EC7CF059140E2488163778F9B40010200000006000000BF0B5EC7CF059140E2488163778F9B4001DDF077CF059140D25CFEC9778F9B404502627ACE059140DC272FE6788F9B40C126C869CD059140D4B229F0798F9B40F8517147CC0591409013A8E67A8F9B403BEAA135CB059140D9AD46B07B8F9B4001020000000200000076211438CB059140FA621CB07B8F9B403BEAA135CB059140D9AD46B07B8F9B4001020000000200000094ABA95DCD05914022D5138D8D8F9B40966A2BA5CB0591401EAD72B68B8F9B4001020000000200000088F73571DB059140701087B98F8F9B4094ABA95DCD05914022D5138D8D8F9B40010200000002000000EC403761CF059140FA1042D4CE8F9B40D2E433BECF059140B6741835D48F9B40010200000002000000AAF548F8D0059140467427EAC28F9B40A29B1283CF059140090FBDF7C48F9B40010200000003000000D2E433BECF059140B6741835D48F9B4044AD4A18D1059140B75716D4D48F9B408534203CD105914047EFA7E7D48F9B400102000000020000006E3B5BCBCF05914039513C63778F9B40BF0B5EC7CF059140E2488163778F9B4001020000000200000092074AA0DE059140DF7F39DEBE8F9B40AAF548F8D0059140467427EAC28F9B400102000000060000008534203CD105914047EFA7E7D48F9B40142B8F66D205914083CFA08AD58F9B40BDC667A7D3059140522FD857D68F9B40D95A4BD9D40591406001C13AD78F9B40E415C3FAD5059140083B4532D88F9B40E0743F57D6059140E30D268DD88F9B40010200000002000000C36B923ED105914068A47DE7D48F9B408534203CD105914047EFA7E7D48F9B40010200000019000000E0743F57D6059140E30D268DD88F9B407C456C0AD70591407991353DD98F9B400809FA06D80591405AED4A5ADA8F9B4099E936EFD805914096FB2788DB8F9B40195506C2D905914064D95AC5DC8F9B4006FB657EDA05914086D95E10DE8F9B40EE086F23DB0591408E609E67DF8F9B404E4557B0DB059140DAD574C9E08F9B4057077224DC059140F9A63034E28F9B40810A317FDC059140EE5A15A6E38F9B40E01C25C0DC059140D4B25D1DE58F9B4064A7FEE6DC0591403FD53D98E68F9B405E0F8EF3DC059140B181E514E88F9B40D4F0C3E5DC0591407E498291E98F9B406131B1BDDC05914050CB410CEB8F9B407DEB867BDC059140A8EE5383EC8F9B405332961FDC059140841CEDF4ED8F9B4069AE4FAADB0591408872485FEF8F9B409413431CDB059140F1EDA9C0F08F9B40E4701E76DA059140A48B6017F28F9B40595BADB8D9059140C45AC861F38F9B4070F4D7E4D8059140447F4C9EF48F9B40B2CDA1FBD7059140FF2169CBF58F9B40A5AA28FED6059140F54BADE7F68F9B40A322A3EDD505914065AABCF1F78F9B4001020000000200000092A43C5BD60591403A16E18CD88F9B40E0743F57D6059140E30D268DD88F9B40010200000002000000B2F921B9DB05914083DE75E2938F9B4088F73571DB059140701087B98F8F9B4001020000000400000068055E58DE059140CBB14AB5BA8F9B40561C1BF2F6059140F0D0F60BB98F9B40A010DF52F4059140A8FD2139928F9B40B2F921B9DB05914083DE75E2938F9B4001020000000200000068055E58DE059140CBB14AB5BA8F9B4092074AA0DE059140DF7F39DEBE8F9B4001020000000400000000592D1739079140D6F725811A899B4000592D1739079140639A26D71A899B40789D0FEC33069140639A26D71A899B40779D0FEC33069140639A26D71A899B40010200000020000000779D0FEC33069140639A26D71A899B40FBC397F82D0691406679E75D1F899B409975815928069140696FEC4B24899B400E00C91523069140E037159B29899B405927F9331E069140E3D7C8442F899B408A0423BA19069140FAD0FD4135899B40C87BD6AD15069140CEDF428B3B899B40EB521B1412069140BC3BC81842899B402DF16AF10E069140E84B69E248899B40D9CFAA490C069140B4C5B6DF4F899B40BEA227200A0691400328010857899B40823E9177080691404D8663525E899B40E641F751070691401496CEB565899B401D86C6B006069140FEF013296D899B406659C79406069140967DF1A274899B4029861CFE060691408CF01C1A7C899B4029861CFE06069140EA14AD03538A9B406659C79406069140E087D87A5A8A9B401D86C6B0060691407814B6F4618A9B40E641F75107069140626FFB67698A9B40823E917708069140297F66CB708A9B40BEA227200A06914073DDC815788A9B40D9CFAA490C069140C23F133E7F8A9B402DF16AF10E0691408EB9603B868A9B40EB521B1412069140BBC901058D8A9B40C87BD6AD15069140A8258792938A9B408A0423BA190691407C34CCDB998A9B405927F9331E069140932D01D99F8A9B400E00C9152306914096CDB482A58A9B4099758159280691400D96DDD1AA8A9B40FBC397F82D069140108CE2BFAF8A9B40779D0FEC33069140136BA346B48A9B40010200000030000000779D0FEC33069140639A26D71A899B405885D5532E06914008BF13081B899B402BEB48C22806914014C7A09A1B899B4077540F3E2306914092C61E8E1C899B40635FBECD1D069140411C6BE11D899B40D2E6D377180691407ECCF0921F899B40C642AE4213069140A164AAA021899B4070AE84340E069140A064240824899B40E4DC5F5309069140062C80C626899B4061C512A504069140CC6677D829899B40B4AF332F00069140FAF55F3A2D899B400C8915F7FB059140604F30E830899B403789C101F8059140364F84DD34899B40D12FF153F4059140DD75A21539899B40A2A008F2F00591408A8B818B3D899B40DC6511E0ED0591400DA3CE3942899B40769EB521EB0591409974F31A47899B40789E3BBAE8059140F0081D294C899B40540682ACE6059140FCAC425E51899B401756FCFAE40591408D252DB456899B406800B0A7E3059140A01A7E245C899B40EB0032B4E205914055B1B7A861899B40DEF8A421E2059140824B443A67899B4039D4B7F0E1059140A1637ED26C899B4039D4B7F0E1059140D5A14B4B628A9B40DEF8A421E2059140F4B985E3678A9B40EA0032B4E2059140215412756D8A9B406800B0A7E3059140D6EA4BF9728A9B401756FCFAE4059140E9DF9C69788A9B40540682ACE60591407A5887BF7D8A9B40779E3BBAE805914086FCACF4828A9B40769EB521EB059140DD90D602888A9B40DC6511E0ED0591406962FBE38C8A9B40A2A008F2F0059140EC794892918A9B40D12FF153F4059140998F2708968A9B403789C101F805914040B645409A8A9B400C8915F7FB05914016B699359E8A9B40B3AF332F000691407C0F6AE3A18A9B4061C512A504069140AA9E5245A58A9B40E3DC5F530906914070D94957A88A9B406FAE84340E069140D6A0A515AB8A9B40C642AE4213069140D5A01F7DAD8A9B40D2E6D37718069140F838D98AAF8A9B40635FBECD1D06914035E95E3CB18A9B4076540F3E23069140E43EAB8FB28A9B402BEB48C228069140623E2983B38A9B405885D5532E0691406E46B615B48A9B40779D0FEC33069140136BA346B48A9B40010200000002000000779D0FEC33069140136BA346B48A9B4000592D1739079140A00DA49CB48A9B4001020000000400000000592D1739079140E4F6D503FF969B4000592D17390791407199D659FF969B40789D0FEC330691407199D659FF969B40779D0FEC330691407199D659FF969B40010200000020000000779D0FEC330691407199D659FF969B40FBC397F82D069140747897E003979B409975815928069140776E9CCE08979B400E00C91523069140EE36C51D0E979B405927F9331E069140F1D678C713979B408A0423BA1906914008D0ADC419979B40C87BD6AD15069140DCDEF20D20979B40EB521B1412069140CA3A789B26979B402DF16AF10E069140F64A19652D979B40D9CFAA490C069140C2C4666234979B40BEA227200A0691401127B18A3B979B40823E9177080691405B8513D542979B40E641F7510706914022957E384A979B401D86C6B0060691400CF0C3AB51979B406659C79406069140A47CA12559979B4029861CFE060691409AEFCC9C60979B4029861CFE06069140F8135D8637989B406659C79406069140EE8688FD3E989B401D86C6B0060691408613667746989B40E641F75107069140706EABEA4D989B40823E917708069140377E164E55989B40BEA227200A06914081DC78985C989B40D9CFAA490C069140D03EC3C063989B402DF16AF10E0691409CB810BE6A989B40EB521B1412069140C9C8B18771989B40C87BD6AD15069140B624371578989B408A0423BA190691408A337C5E7E989B405927F9331E069140A12CB15B84989B400E00C91523069140A4CC64058A989B4099758159280691401B958D548F989B40FBC397F82D0691401E8B924294989B40779D0FEC33069140216A53C998989B40010200000030000000779D0FEC330691407199D659FF969B405885D5532E06914016BEC38AFF969B402BEB48C22806914022C6501D00979B4077540F3E23069140A0C5CE1001979B40635FBECD1D0691404F1B1B6402979B40D2E6D377180691408CCBA01504979B40C642AE4213069140AF635A2306979B4070AE84340E069140AE63D48A08979B40E4DC5F5309069140142B30490B979B4061C512A504069140DA65275B0E979B40B4AF332F0006914008F50FBD11979B400C8915F7FB0591406E4EE06A15979B403789C101F8059140444E346019979B40D12FF153F4059140EB7452981D979B40A2A008F2F0059140988A310E22979B40DC6511E0ED0591401BA27EBC26979B40769EB521EB059140A773A39D2B979B40789E3BBAE8059140FE07CDAB30979B40540682ACE60591400AACF2E035979B401756FCFAE40591409B24DD363B979B406800B0A7E3059140AE192EA740979B40EB0032B4E205914063B0672B46979B40DEF8A421E2059140904AF4BC4B979B4039D4B7F0E1059140AF622E5551979B4039D4B7F0E1059140E3A0FBCD46989B40DEF8A421E205914002B935664C989B40EA0032B4E20591402F53C2F751989B406800B0A7E3059140E4E9FB7B57989B401756FCFAE4059140F7DE4CEC5C989B40540682ACE60591408857374262989B40779E3BBAE805914094FB5C7767989B40769EB521EB059140EB8F86856C989B40DC6511E0ED0591407761AB6671989B40A2A008F2F0059140FA78F81476989B40D12FF153F4059140A78ED78A7A989B403789C101F80591404EB5F5C27E989B400C8915F7FB05914024B549B882989B40B3AF332F000691408A0E1A6686989B4061C512A504069140B89D02C889989B40E3DC5F53090691407ED8F9D98C989B406FAE84340E069140E49F55988F989B40C642AE4213069140E39FCFFF91989B40D2E6D377180691400638890D94989B40635FBECD1D06914043E80EBF95989B4076540F3E23069140F23D5B1297989B402BEB48C228069140703DD90598989B405885D5532E0691407C45669898989B40779D0FEC33069140216A53C998989B40010200000002000000779D0FEC33069140216A53C998989B4000592D1739079140AE0C541F99989B4001020000000400000000592D1739079140A00DA49CB48A9B40A0EC5A434F079140636E10B69B8A9B40A0EC5A434F0791401397B96733899B4000592D1739079140D6F725811A899B4001020000003400000000592D1739079140D6F725811A899B4000592D173907914030193090EE889B40789D0FEC3306914030193090EE889B403E104F4E2B06914047E489DBEE889B40A146D7BA2206914072553DBDEF889B40CBBDE43B1A069140B5073D34F1889B40AC749BDB11069140C762C93EF3889B406AD1FAA30906914048B172DAF5889B4083B2D19E010691403A091C04F9889B40D9B9B2D5F90591403103FFB7FC889B40A5DFE851F2059140CE3BB0F100899B40F35A6C1CEB0591402A9A24AC05899B40E6ECD73DE4059140E254B7E10A899B40879B5EBEDD05914090AE308C10899B4066E8C1A5D7059140B161CDA416899B40B88E48FBD105914010B346241D899B4000D4B5C5CC0591401D21DB0224899B40A475410BC8059140CFA557382B899B40083D90D1C3059140038021BC32899B401143AD1DC0059140AD7840853A899B401EEB03F4BC0591409497698A42899B409D9C5A58BA059140D53A0AC24A899B408B41CE4DB8059140F583532253899B40488FCED6B6059140CB0C46A15B899B401E1E1BF5B505914068D6BD3464899B400653C1A9B5059140A1637ED26C899B400653C1A9B5059140D5A14B4B628A9B401E1E1BF5B50591400E2F0CE96A8A9B40488FCED6B6059140ABF8837C738A9B408B41CE4DB8059140818176FB7B8A9B409D9C5A58BA059140A1CABF5B848A9B401EEB03F4BC059140E26D60938C8A9B401043AD1DC0059140C98C8998948A9B40073D90D1C30591407385A8619C8A9B40A475410BC8059140A85F72E5A38A9B4000D4B5C5CC05914059E4EE1AAB8A9B40B88E48FBD1059140665283F9B18A9B4066E8C1A5D7059140C5A3FC78B88A9B40879B5EBEDD059140E6569991BE8A9B40E6ECD73DE405914095B0123CC48A9B40F35A6C1CEB0591404C6BA571C98A9B40A5DFE851F2059140A8C9192CCE8A9B40D9B9B2D5F90591404502CB65D28A9B4083B2D19E010691403CFCAD19D68A9B406AD1FAA3090691402E545743D98A9B40AC749BDB11069140B0A200DFDB8A9B40CBBDE43B1A069140C1FD8CE9DD8A9B40A146D7BA2206914005B08C60DF8A9B403E104F4E2B0691402F214042E08A9B40779D0FEC3306914046EC998DE08A9B4000592D173907914046EC998DE08A9B4000592D1739079140A00DA49CB48A9B4001020000000400000000592D1739079140AE0C541F99989B40A0EC5A434F079140716DC03880989B40A0EC5A434F079140219669EA17979B4000592D1739079140E4F6D503FF969B4001020000003400000000592D1739079140E4F6D503FF969B4000592D17390791403E18E012D3969B40789D0FEC330691403E18E012D3969B403E104F4E2B06914055E3395ED3969B40A146D7BA220691408054ED3FD4969B40CBBDE43B1A069140C306EDB6D5969B40AC749BDB11069140D56179C1D7969B406AD1FAA30906914056B0225DDA969B4083B2D19E010691404808CC86DD969B40D9B9B2D5F90591403F02AF3AE1969B40A5DFE851F2059140DC3A6074E5969B40F35A6C1CEB0591403899D42EEA969B40E6ECD73DE4059140F0536764EF969B40879B5EBEDD0591409EADE00EF5969B4066E8C1A5D7059140BF607D27FB969B40B88E48FBD10591401EB2F6A601979B4000D4B5C5CC0591402B208B8508979B40A475410BC8059140DDA407BB0F979B40083D90D1C3059140117FD13E17979B401143AD1DC0059140BB77F0071F979B401EEB03F4BC059140A296190D27979B409D9C5A58BA059140E339BA442F979B408B41CE4DB8059140038303A537979B40488FCED6B6059140D90BF62340979B401E1E1BF5B505914076D56DB748979B400653C1A9B5059140AF622E5551979B400653C1A9B5059140E3A0FBCD46989B401E1E1BF5B50591401C2EBC6B4F989B40488FCED6B6059140B9F733FF57989B408B41CE4DB80591408F80267E60989B409D9C5A58BA059140AFC96FDE68989B401EEB03F4BC059140F06C101671989B401043AD1DC0059140D78B391B79989B40073D90D1C3059140818458E480989B40A475410BC8059140B65E226888989B4000D4B5C5CC05914067E39E9D8F989B40B88E48FBD10591407451337C96989B4066E8C1A5D7059140D3A2ACFB9C989B40879B5EBEDD059140F4554914A3989B40E6ECD73DE4059140A3AFC2BEA8989B40F35A6C1CEB0591405A6A55F4AD989B40A5DFE851F2059140B6C8C9AEB2989B40D9B9B2D5F905914053017BE8B6989B4083B2D19E010691404AFB5D9CBA989B406AD1FAA3090691403C5307C6BD989B40AC749BDB11069140BEA1B061C0989B40CBBDE43B1A069140CFFC3C6CC2989B40A146D7BA2206914013AF3CE3C3989B403E104F4E2B0691403D20F0C4C4989B40779D0FEC3306914054EB4910C5989B4000592D173907914054EB4910C5989B4000592D1739079140AE0C541F99989B400102000000020000001F0D0032890B91404A7BDFB06C869B4085736698EF0791404A7BDFB06C869B40010200000002000000B8A699CB220891407DAE12E49F869B4085736698EF0791404A7BDFB06C869B4001020000000200000085736698EF0791404A7BDFB06C869B4085736698EF0791401748AC7D398D9B4001020000000200000085736698EF0791401748AC7D398D9B401F0D0032890B91401748AC7D398D9B4001020000000200000085736698EF0791401748AC7D398D9B40B8A699CB22089140E314794A068D9B400102000000020000001F0D0032890B9140587A8F3351949B4085736698EF079140587A8F3351949B40010200000002000000B8A699CB220891408BADC26684949B4085736698EF079140587A8F3351949B4001020000000200000085736698EF079140587A8F3351949B4085736698EF07914029475C001E9B9B4001020000000200000085736698EF07914029475C001E9B9B401F0D0032890B914029475C001E9B9B4001020000000200000085736698EF07914029475C001E9B9B40B8A699CB22089140F61329CDEA9A9B40010200000002000000ECD9CCFE550B91407DAE12E49F869B40B8A699CB220891407DAE12E49F869B40010200000002000000B8A699CB220891407DAE12E49F869B40B8A699CB22089140E314794A068D9B40010200000002000000B8A699CB22089140E314794A068D9B40ECD9CCFE550B9140E314794A068D9B40010200000002000000ECD9CCFE550B91408BADC26684949B40B8A699CB220891408BADC26684949B40010200000002000000B8A699CB220891408BADC26684949B40B8A699CB22089140F61329CDEA9A9B40010200000002000000B8A699CB22089140F61329CDEA9A9B40ECD9CCFE550B9140F61329CDEA9A9B40010200000002000000ECD9CCFE550B9140E314794A068D9B40ECD9CCFE550B91407DAE12E49F869B400102000000020000001F0D0032890B91404A7BDFB06C869B40ECD9CCFE550B91407DAE12E49F869B400102000000020000001F0D0032890B91401748AC7D398D9B40ECD9CCFE550B9140E314794A068D9B40010200000002000000ECD9CCFE550B9140F61329CDEA9A9B40ECD9CCFE550B91408BADC26684949B400102000000020000001F0D0032890B9140587A8F3351949B40ECD9CCFE550B91408BADC26684949B400102000000020000001F0D0032890B914029475C001E9B9B40ECD9CCFE550B9140F61329CDEA9A9B400102000000020000001F0D0032890B91401748AC7D398D9B401F0D0032890B91404A7BDFB06C869B400102000000020000001F0D0032890B914029475C001E9B9B401F0D0032890B9140587A8F3351949B4001020000000200000052C9BBF3140C9140BAB8E98790889B4014B40B01150C9140BAB8E98790889B4001020000000200000052C9BBF3140C91404CEEC38D168B9B4014B40B01150C91404CEEC38D168B9B4001020000000200000052C9BBF3140C9140C9B7990A75969B4014B40B01150C9140C9B7990A75969B4001020000000200000052C9BBF3140C91405BED7310FB989B4014B40B01150C91405BED7310FB989B4001020000000200000014B40B01150C9140BAB8E98790889B409329A1C4270C9140BAB8E98790889B4001020000002700000014B40B01150C9140BAB8E98790889B40F5DF1755130C91404D53520C91889B40240D162E110C9140CC373EE191889B40FDFBFD160F0C914006037BDB92889B40EEB955120D0C91406094DAF993889B40E3118D220B0C9140352A033B95889B401B9BFA49090C91404B03719D96889B4074E6D88A070C9140FC32781F98889B408ACD43E7050C9140DCA546BF99889B40EBE63561040C91407754E67A9B889B40742286FA020C91406EA13F509D889B40B990E5B4010C914028E01B3D9F889B402858DD91000C91400001283FA1889B405DDACC92FF0B9140B85FF753A3889B40E30BE8B8FE0B9140D3B00679A5889B4060003605FE0B9140410ABFABA7889B40FCAC8F78FD0B9140C30379E9A9889B4067E29E13FD0B914037EB7F2FAC889B40D57FDDD6FC0B9140E908157BAE889B40D9DF94C2FC0B914005F072C9B0889B40D57FDDD6FC0B914022D7D017B3889B4067E29E13FD0B9140D4F46563B5889B40FCAC8F78FD0B914047DC6CA9B7889B4060003605FE0B9140CAD526E7B9889B40E30BE8B8FE0B9140382FDF19BC889B405DDACC92FF0B91405280EE3EBE889B402858DD91000C91400BDFBD53C0889B40B990E5B4010C9140E3FFC955C2889B40742286FA020C91409D3EA642C4889B40EBE63561040C9140948BFF17C6889B408ACD43E7050C91402F3A9FD3C7889B4074E6D88A070C91400FAD6D73C9889B401B9BFA49090C9140BFDC74F5CA889B40E3118D220B0C9140D6B5E257CC889B40EEB955120D0C9140AB4B0B99CD889B40FDFBFD160F0C914005DD6AB7CE889B40240D162E110C91403FA8A7B1CF889B40F5DF1755130C9140BE8C9386D0889B4014B40B01150C91405127FC0AD1889B4001020000000A0000009329A1C4270C9140BAB8E98790889B4046AE3288250C9140142615F68F889B402B761B43230C9140647CE28B8F889B40921719F8200C9140D3F3D1498F889B40214EF0A91E0C9140F04F33308F889B4023A3695B1C0C9140637F253F8F889B4039114E0F1A0C9140947696768F889B408CA763C8170C9140754543D68F889B4080306A89150C91405368B85D90889B4014B40B01150C9140BAB8E98790889B4001020000000200000014B40B01150C91405127FC0AD1889B409329A1C4270C91405127FC0AD1889B4001020000000A00000014B40B01150C91405127FC0AD1889B4080306A89150C9140B8772D35D1889B408CA763C8170C9140969AA2BCD1889B4039114E0F1A0C914077694F1CD2889B4023A3695B1C0C9140A860C053D2889B40214EF0A91E0C91401B90B262D2889B40921719F8200C914038EC1349D2889B402B761B43230C9140A6630307D2889B4046AE3288250C9140F7B9D09CD1889B409329A1C4270C91405127FC0AD1889B400102000000320000008AF83C0E190C91400F9C8F23D58A9B40FCBA8E41E70B91400F9C8F23D58A9B40B77787DAE20B9140EA7E0FFDD48A9B40356AC178DE0B9140A71BBD89D48A9B4094827721DA0B9140E51722CAD38A9B40322DD8D9D50B9140762623BFD28A9B406D23FFA6D10B91405BF6FE69D18A9B40C952EF8DCD0B91406DB64CCCCF8A9B40A1E18C93C90B9140542FFAE7CD8A9B409B5897BCC50B91402A7649BFCB8A9B40CEF7A30DC20B91407C3ACE54C98A9B40603E188BBE0B9140E5B26AABC68A9B4027AB2439BB0B9140ED2B4CC6C38A9B4086BCBF1BB80B91404C3DE7A8C08A9B408E35A136B50B914013AAF356BD8A9B40F7AD3D8DB20B9140A5F067D4B98A9B404972C222B00B9140D88F7425B68A9B401FB911FAAD0B9140D2067F4EB28A9B400632BF15AC0B9140AA951C54AE8A9B4018F20C78AA0B914006C50C3BAA8A9B40FDC1E822A90B914041BB3308A68A9B408DD0E917A80B9140DE6594C0A18A9B40CCCC4E58A70B91403E7E4A699D8A9B408869FCE4A60B9140BC708407998A9B40644C7CBEA60B9140772D7DA0948A9B40644C7CBEA60B9140E9950E8E11899B408869FCE4A60B9140A45207270D899B40CCCC4E58A70B9140224541C508899B408DD0E917A80B9140825DF76D04899B40FDC1E822A90B91401F08582600899B4018F20C78AA0B91405AFE7EF3FB889B400632BF15AC0B9140B62D6FDAF7889B401FB911FAAD0B91408EBC0CE0F3889B404972C222B00B914088331709F0889B40F7AD3D8DB20B9140BBD2235AEC889B408E35A136B50B91404D1998D7E8889B4086BCBF1BB80B91401486A485E5889B4027AB2439BB0B914073973F68E2889B40603E188BBE0B91407B102183DF889B40CEF7A30DC20B9140E488BDD9DC889B409B5897BCC50B9140364D426FDA889B40A1E18C93C90B91400C949146D8889B40C952EF8DCD0B9140F30C3F62D6889B406D23FFA6D10B914005CD8CC4D4889B40322DD8D9D50B9140EA9C686FD3889B4094827721DA0B91407BAB6964D2889B40356AC178DE0B9140B9A7CEA4D1889B40B77787DAE20B914076447C31D1889B40FCBA8E41E70B91405127FC0AD1889B4014B40B01150C91405127FC0AD1889B4001020000000200000014B40B01150C91404CEEC38D168B9B409329A1C4270C91404CEEC38D168B9B4001020000000A00000014B40B01150C91404CEEC38D168B9B4080306A89150C9140B33EF5B7168B9B408CA763C8170C914091616A3F178B9B4039114E0F1A0C91407230179F178B9B4023A3695B1C0C9140A32788D6178B9B40214EF0A91E0C914016577AE5178B9B40921719F8200C914032B3DBCB178B9B402B761B43230C9140A12ACB89178B9B4046AE3288250C9140F280981F178B9B409329A1C4270C91404CEEC38D168B9B400102000000290000008AF83C0E190C91400F9C8F23D58A9B408CA763C8170C91406F0C0B59D58A9B4080306A89150C91404D2F80E0D58A9B40F5DF1755130C9140481A1A8FD68A9B40240D162E110C9140C7FE0564D78A9B40FDFBFD160F0C914001CA425ED88A9B40EEB955120D0C91405B5BA27CD98A9B40E3118D220B0C914030F1CABDDA8A9B401B9BFA49090C914046CA3820DC8A9B4074E6D88A070C9140F7F93FA2DD8A9B408ACD43E7050C9140D76C0E42DF8A9B40EBE63561040C9140721BAEFDE08A9B40742286FA020C9140696807D3E28A9B40B990E5B4010C914023A7E3BFE48A9B402858DD91000C9140FBC7EFC1E68A9B405DDACC92FF0B9140B326BFD6E88A9B40E30BE8B8FE0B9140CE77CEFBEA8A9B4060003605FE0B91403CD1862EED8A9B40FCAC8F78FD0B9140BECA406CEF8A9B4067E29E13FD0B914032B247B2F18A9B40D57FDDD6FC0B9140E4CFDCFDF38A9B40D9DF94C2FC0B914000B73A4CF68A9B40D57FDDD6FC0B91401D9E989AF88A9B4067E29E13FD0B9140CEBB2DE6FA8A9B40FCAC8F78FD0B914042A3342CFD8A9B4060003605FE0B9140C59CEE69FF8A9B40E30BE8B8FE0B914033F6A69C018B9B405DDACC92FF0B91404D47B6C1038B9B402858DD91000C914006A685D6058B9B40B990E5B4010C9140DEC691D8078B9B40742286FA020C914098056EC5098B9B40EBE63561040C91408F52C79A0B8B9B408ACD43E7050C9140290167560D8B9B4074E6D88A070C91400A7435F60E8B9B401B9BFA49090C9140BAA33C78108B9B40E3118D220B0C9140D07CAADA118B9B40EEB955120D0C9140A612D31B138B9B40FDFBFD160F0C9140FFA3323A148B9B40240D162E110C9140396F6F34158B9B40F5DF1755130C9140B9535B09168B9B4014B40B01150C91404CEEC38D168B9B4001020000000200000014B40B01150C9140C9B7990A75969B409329A1C4270C9140C9B7990A75969B4001020000002700000014B40B01150C9140C9B7990A75969B40F5DF1755130C91405C52028F75969B40240D162E110C9140DB36EE6376969B40FDFBFD160F0C914015022B5E77969B40EEB955120D0C91406F938A7C78969B40E3118D220B0C91404429B3BD79969B401B9BFA49090C91405A0221207B969B4074E6D88A070C91400B3228A27C969B408ACD43E7050C9140EBA4F6417E969B40EBE63561040C9140865396FD7F969B40742286FA020C91407DA0EFD281969B40B990E5B4010C914037DFCBBF83969B402858DD91000C91400F00D8C185969B405DDACC92FF0B9140C75EA7D687969B40E30BE8B8FE0B9140E2AFB6FB89969B4060003605FE0B914050096F2E8C969B40FCAC8F78FD0B9140D202296C8E969B4067E29E13FD0B914046EA2FB290969B40D57FDDD6FC0B9140F807C5FD92969B40D9DF94C2FC0B914014EF224C95969B40D57FDDD6FC0B914031D6809A97969B4067E29E13FD0B9140E3F315E699969B40FCAC8F78FD0B914056DB1C2C9C969B4060003605FE0B9140D9D4D6699E969B40E30BE8B8FE0B9140472E8F9CA0969B405DDACC92FF0B9140617F9EC1A2969B402858DD91000C91401ADE6DD6A4969B40B990E5B4010C9140F2FE79D8A6969B40742286FA020C9140AC3D56C5A8969B40EBE63561040C9140A38AAF9AAA969B408ACD43E7050C91403E394F56AC969B4074E6D88A070C91401EAC1DF6AD969B401B9BFA49090C9140CEDB2478AF969B40E3118D220B0C9140E5B492DAB0969B40EEB955120D0C9140BA4ABB1BB2969B40FDFBFD160F0C914014DC1A3AB3969B40240D162E110C91404EA75734B4969B40F5DF1755130C9140CD8B4309B5969B4014B40B01150C91406026AC8DB5969B4001020000000A0000009329A1C4270C9140C9B7990A75969B4046AE3288250C91402325C57874969B402B761B43230C9140737B920E74969B40921719F8200C9140E2F281CC73969B40214EF0A91E0C9140FF4EE3B273969B4023A3695B1C0C9140727ED5C173969B4039114E0F1A0C9140A37546F973969B408CA763C8170C91408444F35874969B4080306A89150C9140626768E074969B4014B40B01150C9140C9B7990A75969B4001020000000200000014B40B01150C91406026AC8DB5969B409329A1C4270C91406026AC8DB5969B4001020000000A00000014B40B01150C91406026AC8DB5969B4080306A89150C9140C776DDB7B5969B408CA763C8170C9140A599523FB6969B4039114E0F1A0C91408668FF9EB6969B4023A3695B1C0C9140B75F70D6B6969B40214EF0A91E0C91402A8F62E5B6969B40921719F8200C914047EBC3CBB6969B402B761B43230C9140B562B389B6969B4046AE3288250C914006B9801FB6969B409329A1C4270C91406026AC8DB5969B400102000000320000008AF83C0E190C91401E9B3FA6B9989B40FCBA8E41E70B91401E9B3FA6B9989B40B77787DAE20B9140F97DBF7FB9989B40356AC178DE0B9140B61A6D0CB9989B4094827721DA0B9140F416D24CB8989B40322DD8D9D50B91408525D341B7989B406D23FFA6D10B91406AF5AEECB5989B40C952EF8DCD0B91407CB5FC4EB4989B40A1E18C93C90B9140632EAA6AB2989B409B5897BCC50B91403975F941B0989B40CEF7A30DC20B91408B397ED7AD989B40603E188BBE0B9140F4B11A2EAB989B4027AB2439BB0B9140FC2AFC48A8989B4086BCBF1BB80B91405B3C972BA5989B408E35A136B50B914022A9A3D9A1989B40F7AD3D8DB20B9140B4EF17579E989B404972C222B00B9140E78E24A89A989B401FB911FAAD0B9140E1052FD196989B400632BF15AC0B9140B994CCD692989B4018F20C78AA0B914015C4BCBD8E989B40FDC1E822A90B914050BAE38A8A989B408DD0E917A80B9140ED64444386989B40CCCC4E58A70B91404D7DFAEB81989B408869FCE4A60B9140CB6F348A7D989B40644C7CBEA60B9140862C2D2379989B40644C7CBEA60B9140F894BE10F6969B408869FCE4A60B9140B351B7A9F1969B40CCCC4E58A70B91403144F147ED969B408DD0E917A80B9140915CA7F0E8969B40FDC1E822A90B91402E0708A9E4969B4018F20C78AA0B914069FD2E76E0969B400632BF15AC0B9140C52C1F5DDC969B401FB911FAAD0B91409DBBBC62D8969B404972C222B00B91409732C78BD4969B40F7AD3D8DB20B9140CAD1D3DCD0969B408E35A136B50B91405C18485ACD969B4086BCBF1BB80B914023855408CA969B4027AB2439BB0B91408296EFEAC6969B40603E188BBE0B91408A0FD105C4969B40CEF7A30DC20B9140F3876D5CC1969B409B5897BCC50B9140454CF2F1BE969B40A1E18C93C90B91401B9341C9BC969B40C952EF8DCD0B9140020CEFE4BA969B406D23FFA6D10B914014CC3C47B9969B40322DD8D9D50B9140F99B18F2B7969B4094827721DA0B91408AAA19E7B6969B40356AC178DE0B9140C8A67E27B6969B40B77787DAE20B914085432CB4B5969B40FCBA8E41E70B91406026AC8DB5969B4014B40B01150C91406026AC8DB5969B4001020000000200000014B40B01150C91405BED7310FB989B409329A1C4270C91405BED7310FB989B4001020000000A00000014B40B01150C91405BED7310FB989B4080306A89150C9140C23DA53AFB989B408CA763C8170C9140A0601AC2FB989B4039114E0F1A0C9140812FC721FC989B4023A3695B1C0C9140B2263859FC989B40214EF0A91E0C914025562A68FC989B40921719F8200C914041B28B4EFC989B402B761B43230C9140B0297B0CFC989B4046AE3288250C9140018048A2FB989B409329A1C4270C91405BED7310FB989B400102000000290000008AF83C0E190C91401E9B3FA6B9989B408CA763C8170C91407E0BBBDBB9989B4080306A89150C91405C2E3063BA989B40F5DF1755130C91405719CA11BB989B40240D162E110C9140D6FDB5E6BB989B40FDFBFD160F0C914010C9F2E0BC989B40EEB955120D0C91406A5A52FFBD989B40E3118D220B0C91403FF07A40BF989B401B9BFA49090C914055C9E8A2C0989B4074E6D88A070C914006F9EF24C2989B408ACD43E7050C9140E66BBEC4C3989B40EBE63561040C9140811A5E80C5989B40742286FA020C91407867B755C7989B40B990E5B4010C914032A69342C9989B402858DD91000C91400AC79F44CB989B405DDACC92FF0B9140C2256F59CD989B40E30BE8B8FE0B9140DD767E7ECF989B4060003605FE0B91404BD036B1D1989B40FCAC8F78FD0B9140CDC9F0EED3989B4067E29E13FD0B914041B1F734D6989B40D57FDDD6FC0B9140F3CE8C80D8989B40D9DF94C2FC0B91400FB6EACEDA989B40D57FDDD6FC0B91402C9D481DDD989B4067E29E13FD0B9140DDBADD68DF989B40FCAC8F78FD0B914051A2E4AEE1989B4060003605FE0B9140D49B9EECE3989B40E30BE8B8FE0B914042F5561FE6989B405DDACC92FF0B91405C466644E8989B402858DD91000C914015A53559EA989B40B990E5B4010C9140EDC5415BEC989B40742286FA020C9140A7041E48EE989B40EBE63561040C91409E51771DF0989B408ACD43E7050C9140380017D9F1989B4074E6D88A070C91401973E578F3989B401B9BFA49090C9140C9A2ECFAF4989B40E3118D220B0C9140DF7B5A5DF6989B40EEB955120D0C9140B511839EF7989B40FDFBFD160F0C91400EA3E2BCF8989B40240D162E110C9140486E1FB7F9989B40F5DF1755130C9140C8520B8CFA989B4014B40B01150C91405BED7310FB989B4001020000000200000089DD71B5230C91400F9C8F23D58A9B408AF83C0E190C91400F9C8F23D58A9B4001020000000700000089DD71B5230C91400F9C8F23D58A9B402B761B43230C91405F43AA0ED58A9B40921719F8200C9140CEBA99CCD48A9B40214EF0A91E0C9140EB16FBB2D48A9B4023A3695B1C0C91405E46EDC1D48A9B4039114E0F1A0C91408F3D5EF9D48A9B408AF83C0E190C91400F9C8F23D58A9B4001020000000200000089DD71B5230C91401E9B3FA6B9989B408AF83C0E190C91401E9B3FA6B9989B4001020000000700000089DD71B5230C91401E9B3FA6B9989B402B761B43230C91406E425A91B9989B40921719F8200C9140DDB9494FB9989B40214EF0A91E0C9140FA15AB35B9989B4023A3695B1C0C91406D459D44B9989B4039114E0F1A0C91409E3C0E7CB9989B408AF83C0E190C91401E9B3FA6B9989B40010200000002000000200B145F180D91400F9C8F23D58A9B4089DD71B5230C91400F9C8F23D58A9B400102000000030000009329A1C4270C9140B47FB10AD68A9B4046AE3288250C91400FEDDC78D58A9B4089DD71B5230C91400F9C8F23D58A9B40010200000002000000200B145F180D91401E9B3FA6B9989B4089DD71B5230C91401E9B3FA6B9989B400102000000030000009329A1C4270C9140C37E618DBA989B4046AE3288250C91401EEC8CFBB9989B4089DD71B5230C91401E9B3FA6B9989B400102000000020000009329A1C4270C9140BAB8E98790889B4015BFE44F140D9140BAB8E98790889B400102000000020000009329A1C4270C91405127FC0AD1889B4015BFE44F140D91405127FC0AD1889B400102000000020000009329A1C4270C91404CEEC38D168B9B4015BFE44F140D91404CEEC38D168B9B400102000000020000009329A1C4270C9140C9B7990A75969B4015BFE44F140D9140C9B7990A75969B400102000000020000009329A1C4270C91406026AC8DB5969B4015BFE44F140D91406026AC8DB5969B400102000000020000009329A1C4270C91405BED7310FB989B4015BFE44F140D91405BED7310FB989B4001020000000200000015BFE44F140D9140BAB8E98790889B4094347A13270D9140BAB8E98790889B4001020000000A00000094347A13270D9140BAB8E98790889B4028B81B8B260D91405368B85D90889B401C41224C240D9140754543D68F889B406FD73705220D9140947696768F889B4085451CB91F0D9140637F253F8F889B40879A956A1D0D9140F04F33308F889B4016D16C1C1B0D9140D3F3D1498F889B407E726AD1180D9140647CE28B8F889B40623A538C160D9140142615F68F889B4015BFE44F140D9140BAB8E98790889B4001020000000200000015BFE44F140D91405127FC0AD1889B4094347A13270D91405127FC0AD1889B4001020000000A00000015BFE44F140D91405127FC0AD1889B40623A538C160D9140F7B9D09CD1889B407E726AD1180D9140A6630307D2889B4016D16C1C1B0D914038EC1349D2889B40879A956A1D0D91401B90B262D2889B4085451CB91F0D9140A860C053D2889B406FD73705220D914077694F1CD2889B401C41224C240D9140969AA2BCD1889B4028B81B8B260D9140B8772D35D1889B4094347A13270D91405127FC0AD1889B40010200000003000000200B145F180D91400F9C8F23D58A9B40623A538C160D91400FEDDC78D58A9B4015BFE44F140D9140B47FB10AD68A9B4001020000000200000015BFE44F140D91404CEEC38D168B9B4094347A13270D91404CEEC38D168B9B4001020000000A00000015BFE44F140D91404CEEC38D168B9B40623A538C160D9140F280981F178B9B407E726AD1180D9140A12ACB89178B9B4016D16C1C1B0D914032B3DBCB178B9B40879A956A1D0D914016577AE5178B9B4085451CB91F0D9140A32788D6178B9B406FD73705220D91407230179F178B9B401C41224C240D914091616A3F178B9B4028B81B8B260D9140B33EF5B7168B9B4094347A13270D91404CEEC38D168B9B4001020000000200000015BFE44F140D9140C9B7990A75969B4094347A13270D9140C9B7990A75969B4001020000000A00000094347A13270D9140C9B7990A75969B4028B81B8B260D9140626768E074969B401C41224C240D91408444F35874969B406FD73705220D9140A37546F973969B4085451CB91F0D9140727ED5C173969B40879A956A1D0D9140FF4EE3B273969B4016D16C1C1B0D9140E2F281CC73969B407E726AD1180D9140737B920E74969B40623A538C160D91402325C57874969B4015BFE44F140D9140C9B7990A75969B4001020000000200000015BFE44F140D91406026AC8DB5969B4094347A13270D91406026AC8DB5969B4001020000000A00000015BFE44F140D91406026AC8DB5969B40623A538C160D914006B9801FB6969B407E726AD1180D9140B562B389B6969B4016D16C1C1B0D914047EBC3CBB6969B40879A956A1D0D91402A8F62E5B6969B4085451CB91F0D9140B75F70D6B6969B406FD73705220D91408668FF9EB6969B401C41224C240D9140A599523FB6969B4028B81B8B260D9140C776DDB7B5969B4094347A13270D91406026AC8DB5969B40010200000003000000200B145F180D91401E9B3FA6B9989B40623A538C160D91401EEC8CFBB9989B4015BFE44F140D9140C37E618DBA989B4001020000000200000015BFE44F140D91405BED7310FB989B4094347A13270D91405BED7310FB989B4001020000000A00000015BFE44F140D91405BED7310FB989B40623A538C160D9140018048A2FB989B407E726AD1180D9140B0297B0CFC989B4016D16C1C1B0D914041B28B4EFC989B40879A956A1D0D914025562A68FC989B4085451CB91F0D9140B2263859FC989B406FD73705220D9140812FC721FC989B401C41224C240D9140A0601AC2FB989B4028B81B8B260D9140C23DA53AFB989B4094347A13270D91405BED7310FB989B400102000000020000001EF04806230D91400F9C8F23D58A9B40200B145F180D91400F9C8F23D58A9B400102000000070000001EF04806230D91400F9C8F23D58A9B406FD73705220D91408F3D5EF9D48A9B4085451CB91F0D91405E46EDC1D48A9B40879A956A1D0D9140EB16FBB2D48A9B4016D16C1C1B0D9140CEBA99CCD48A9B407E726AD1180D91405F43AA0ED58A9B40200B145F180D91400F9C8F23D58A9B400102000000020000001EF04806230D91401E9B3FA6B9989B40200B145F180D91401E9B3FA6B9989B400102000000070000001EF04806230D91401E9B3FA6B9989B406FD73705220D91409E3C0E7CB9989B4085451CB91F0D91406D459D44B9989B40879A956A1D0D9140FA15AB35B9989B4016D16C1C1B0D9140DDB9494FB9989B407E726AD1180D91406E425A91B9989B40200B145F180D91401E9B3FA6B9989B400102000000090000001EF04806230D91400F9C8F23D58A9B40AD2DF7D2540D91400F9C8F23D58A9B40E898ED41590D9140CD1184FCD48A9B40262C86AB5D0D914060B69087D48A9B406B8E690A620D9140A11A43C5D38A9B40DE5C4D59660D9140867186B6D28A9B404092FA926A0D91407573A25CD18A9B40EAD653B26E0D91408DD139B9CF8A9B40C0B15BB2720D9140D73A48CECD8A9B4001020000002900000094347A13270D91404CEEC38D168B9B40B3086EBF280D9140B9535B09168B9B4084DB6FE62A0D9140396F6F34158B9B40ABEC87FD2C0D9140FFA3323A148B9B40BA2E30022F0D9140A612D31B138B9B40C5D6F8F1300D9140D07CAADA118B9B408E4D8BCA320D9140BAA33C78108B9B403502AD89340D91400A7435F60E8B9B401E1B422D360D9140290167560D8B9B40BD0150B3370D91408F52C79A0B8B9B4034C6FF19390D914098056EC5098B9B40EF57A05F3A0D9140DEC691D8078B9B408090A8823B0D914006A685D6058B9B404B0EB9813C0D91404D47B6C1038B9B40C6DC9D5B3D0D914033F6A69C018B9B4048E84F0F3E0D9140C59CEE69FF8A9B40AC3BF69B3E0D914042A3342CFD8A9B404106E7003F0D9140CEBB2DE6FA8A9B40D368A83D3F0D91401D9E989AF88A9B40CF08F1513F0D914000B73A4CF68A9B40D368A83D3F0D9140E4CFDCFDF38A9B404106E7003F0D914032B247B2F18A9B40AC3BF69B3E0D9140BECA406CEF8A9B4048E84F0F3E0D91403CD1862EED8A9B40C6DC9D5B3D0D9140CE77CEFBEA8A9B404B0EB9813C0D9140B326BFD6E88A9B408090A8823B0D9140FBC7EFC1E68A9B40EF57A05F3A0D914023A7E3BFE48A9B4034C6FF19390D9140696807D3E28A9B40BD0150B3370D9140721BAEFDE08A9B401E1B422D360D9140D76C0E42DF8A9B403502AD89340D9140F7F93FA2DD8A9B408E4D8BCA320D914046CA3820DC8A9B40C5D6F8F1300D914030F1CABDDA8A9B40BA2E30022F0D91405B5BA27CD98A9B40ABEC87FD2C0D914001CA425ED88A9B4084DB6FE62A0D9140C7FE0564D78A9B40B3086EBF280D9140481A1A8FD68A9B4028B81B8B260D91404D2F80E0D58A9B401C41224C240D91406F0C0B59D58A9B401EF04806230D91400F9C8F23D58A9B400102000000090000001EF04806230D91401E9B3FA6B9989B40AD2DF7D2540D91401E9B3FA6B9989B40E898ED41590D9140DC10347FB9989B40262C86AB5D0D91406FB5400AB9989B406B8E690A620D9140B019F347B8989B40DE5C4D59660D914095703639B7989B404092FA926A0D9140847252DFB5989B40EAD653B26E0D91409CD0E93BB4989B40C0B15BB2720D9140E639F850B2989B4001020000002900000094347A13270D91405BED7310FB989B40B3086EBF280D9140C8520B8CFA989B4084DB6FE62A0D9140486E1FB7F9989B40ABEC87FD2C0D91400EA3E2BCF8989B40BA2E30022F0D9140B511839EF7989B40C5D6F8F1300D9140DF7B5A5DF6989B408E4D8BCA320D9140C9A2ECFAF4989B403502AD89340D91401973E578F3989B401E1B422D360D9140380017D9F1989B40BD0150B3370D91409E51771DF0989B4034C6FF19390D9140A7041E48EE989B40EF57A05F3A0D9140EDC5415BEC989B408090A8823B0D914015A53559EA989B404B0EB9813C0D91405C466644E8989B40C6DC9D5B3D0D914042F5561FE6989B4048E84F0F3E0D9140D49B9EECE3989B40AC3BF69B3E0D914051A2E4AEE1989B404106E7003F0D9140DDBADD68DF989B40D368A83D3F0D91402C9D481DDD989B40CF08F1513F0D91400FB6EACEDA989B40D368A83D3F0D9140F3CE8C80D8989B404106E7003F0D914041B1F734D6989B40AC3BF69B3E0D9140CDC9F0EED3989B4048E84F0F3E0D91404BD036B1D1989B40C6DC9D5B3D0D9140DD767E7ECF989B404B0EB9813C0D9140C2256F59CD989B408090A8823B0D91400AC79F44CB989B40EF57A05F3A0D914032A69342C9989B4034C6FF19390D91407867B755C7989B40BD0150B3370D9140811A5E80C5989B401E1B422D360D9140E66BBEC4C3989B403502AD89340D914006F9EF24C2989B408E4D8BCA320D914055C9E8A2C0989B40C5D6F8F1300D91403FF07A40BF989B40BA2E30022F0D91406A5A52FFBD989B40ABEC87FD2C0D914010C9F2E0BC989B4084DB6FE62A0D9140D6FDB5E6BB989B40B3086EBF280D91405719CA11BB989B4028B81B8B260D91405C2E3063BA989B401C41224C240D91407E0BBBDBB9989B401EF04806230D91401E9B3FA6B9989B4001020000000200000094347A13270D9140BAB8E98790889B40561FCA20270D9140BAB8E98790889B4001020000002700000094347A13270D91405127FC0AD1889B40B3086EBF280D9140BE8C9386D0889B4084DB6FE62A0D91403FA8A7B1CF889B40ABEC87FD2C0D914005DD6AB7CE889B40BA2E30022F0D9140AB4B0B99CD889B40C5D6F8F1300D9140D6B5E257CC889B408E4D8BCA320D9140BFDC74F5CA889B403502AD89340D91400FAD6D73C9889B401E1B422D360D91402F3A9FD3C7889B40BD0150B3370D9140948BFF17C6889B4034C6FF19390D91409D3EA642C4889B40EF57A05F3A0D9140E3FFC955C2889B408090A8823B0D91400BDFBD53C0889B404B0EB9813C0D91405280EE3EBE889B40C6DC9D5B3D0D9140382FDF19BC889B4048E84F0F3E0D9140CAD526E7B9889B40AC3BF69B3E0D914047DC6CA9B7889B404106E7003F0D9140D4F46563B5889B40D368A83D3F0D914022D7D017B3889B40CF08F1513F0D914005F072C9B0889B40D368A83D3F0D9140E908157BAE889B404106E7003F0D914037EB7F2FAC889B40AC3BF69B3E0D9140C30379E9A9889B4048E84F0F3E0D9140410ABFABA7889B40C6DC9D5B3D0D9140D3B00679A5889B404B0EB9813C0D9140B85FF753A3889B408090A8823B0D91400001283FA1889B40EF57A05F3A0D914028E01B3D9F889B4034C6FF19390D91406EA13F509D889B40BD0150B3370D91407754E67A9B889B401E1B422D360D9140DCA546BF99889B403502AD89340D9140FC32781F98889B408E4D8BCA320D91404B03719D96889B40C5D6F8F1300D9140352A033B95889B40BA2E30022F0D91406094DAF993889B40ABEC87FD2C0D914006037BDB92889B4084DB6FE62A0D9140CC373EE191889B40B3086EBF280D91404D53520C91889B4094347A13270D9140BAB8E98790889B4001020000000900000094347A13270D91405127FC0AD1889B40AD2DF7D2540D91405127FC0AD1889B40E898ED41590D914093B10732D1889B40262C86AB5D0D9140000DFBA6D1889B406B8E690A620D9140BFA84869D2889B40DE5C4D59660D9140DA510578D3889B404092FA926A0D9140EB4FE9D1D4889B40EAD653B26E0D9140D3F15175D6889B40C0B15BB2720D914089884360D8889B4001020000000200000094347A13270D91404CEEC38D168B9B40561FCA20270D91404CEEC38D168B9B4001020000000200000094347A13270D9140C9B7990A75969B40561FCA20270D9140C9B7990A75969B4001020000002700000094347A13270D91406026AC8DB5969B40B3086EBF280D9140CD8B4309B5969B4084DB6FE62A0D91404EA75734B4969B40ABEC87FD2C0D914014DC1A3AB3969B40BA2E30022F0D9140BA4ABB1BB2969B40C5D6F8F1300D9140E5B492DAB0969B408E4D8BCA320D9140CEDB2478AF969B403502AD89340D91401EAC1DF6AD969B401E1B422D360D91403E394F56AC969B40BD0150B3370D9140A38AAF9AAA969B4034C6FF19390D9140AC3D56C5A8969B40EF57A05F3A0D9140F2FE79D8A6969B408090A8823B0D91401ADE6DD6A4969B404B0EB9813C0D9140617F9EC1A2969B40C6DC9D5B3D0D9140472E8F9CA0969B4048E84F0F3E0D9140D9D4D6699E969B40AC3BF69B3E0D914056DB1C2C9C969B404106E7003F0D9140E3F315E699969B40D368A83D3F0D914031D6809A97969B40CF08F1513F0D914014EF224C95969B40D368A83D3F0D9140F807C5FD92969B404106E7003F0D914046EA2FB290969B40AC3BF69B3E0D9140D202296C8E969B4048E84F0F3E0D914050096F2E8C969B40C6DC9D5B3D0D9140E2AFB6FB89969B404B0EB9813C0D9140C75EA7D687969B408090A8823B0D91400F00D8C185969B40EF57A05F3A0D914037DFCBBF83969B4034C6FF19390D91407DA0EFD281969B40BD0150B3370D9140865396FD7F969B401E1B422D360D9140EBA4F6417E969B403502AD89340D91400B3228A27C969B408E4D8BCA320D91405A0221207B969B40C5D6F8F1300D91404429B3BD79969B40BA2E30022F0D91406F938A7C78969B40ABEC87FD2C0D914015022B5E77969B4084DB6FE62A0D9140DB36EE6376969B40B3086EBF280D91405C52028F75969B4094347A13270D9140C9B7990A75969B4001020000000900000094347A13270D91406026AC8DB5969B40AD2DF7D2540D91406026AC8DB5969B40E898ED41590D9140A2B0B7B4B5969B40262C86AB5D0D91400F0CAB29B6969B406B8E690A620D9140CEA7F8EBB6969B40DE5C4D59660D9140E950B5FAB7969B404092FA926A0D9140FA4E9954B9969B40EAD653B26E0D9140E2F001F8BA969B40C0B15BB2720D91409887F3E2BC969B4001020000000200000094347A13270D91405BED7310FB989B40561FCA20270D91405BED7310FB989B40010200000004000000449C0956950D9140E278A1A233899B4040B812E18D0D9140A3A8C5F821899B40E7560D3F810D9140A63949DB08899B40F1C173F8720D914008E132A3F0889B40010200000004000000F1C173F8720D914058E2588BB58A9B40E7560D3F810D9140BA8942539D8A9B4040B812E18D0D9140BD1AC635848A9B40449C0956950D91407E4AEA8B728A9B40010200000004000000449C0956950D9140F177512518979B4040B812E18D0D9140B2A7757B06979B40E7560D3F810D9140B538F95DED969B40F1C173F8720D914017E0E225D5969B40010200000004000000F1C173F8720D914067E1080E9A989B40E7560D3F810D9140C988F2D581989B4040B812E18D0D9140CC1976B868989B40449C0956950D91408D499A0E57989B40010200000064000000D27E8E3F730D91408454D3B7B58A9B40C618406E720D91406A77B821B78A9B4074047DB6710D914021553B99B88A9B40D3C92619710D914045108F1CBA8A9B405882FE96700D9140094BD8A9BB8A9B40FBEBA330700D9140A06E2F3FBD8A9B402AA594E66F0D9140A901A3DABE8A9B409C922BB96F0D9140BA0A3A7AC08A9B40C46FA0A86F0D9140237CF61BC28A9B40698A07B56F0D9140E8A5D7BDC38A9B40BEA951DE6F0D914000ABDC5DC58A9B400E214C24700D9140BEF606FAC68A9B40ED0DA186700D914078AF5C90C88A9B40A2C1D704710D91405723EB1ECA8A9B404155559E710D91406B2CC9A3CB8A9B40CD675D52720D9140F888191DCD8A9B4065051320730D914036250D89CE8A9B4071B67906740D9140A853E5E5CF8A9B4082B57604750D91404DF1F531D18A9B40564AD218760D91401973A76BD28A9B4071483942770D91401FDA7891D38A9B405EAF3E7F780D9140118C01A2D48A9B40A96A5DCE790D9140D80DF39BD58A9B405F2FFA2D7B0D91400C9E1A7ED68A9B40DC74659C7C0D91407AAD6247D78A9B406586DD177E0D9140C033D4F6D78A9B4016AB909E7F0D914083DE978BD88A9B4077619F2E810D9140B119F704D98A9B40FCAB1EC6820D914093EF5C62D98A9B409B6B1A63840D9140A0BF56A3D98A9B409AC59703860D91402CCB94C7D98A9B409E9197A5870D91404497EACED98A9B4002CD1847890D91404C234FB9D98A9B4079101BE68A0D914001F4DC86D98A9B40E804A1808C0D9140F9F2D137D98A9B4086D4B2148E0D91409E228FCCD88A9B40399560A08F0D914020279845D88A9B4036A9C421910D9140EAA492A3D78A9B40FE120697920D9140517545E7D68A9B40E5B95AFE930D91408CB29711D68A9B40449C0956950D91400F9C8F23D58A9B40F1E65803A60D914032BB5442BD8A9B40CB5F1709B50D9140DABC264EA48A9B404D87A155C20D9140F65652648A8A9B40BDE859D9CD0D9140D0AD44A36F8A9B40CA6FBB86D70D9140699A672A548A9B406A486952DF0D914015C8FC19388A9B403C363C33E50D9140B7D4F7921B8A9B40E3534D22E90D914006A0D7B6FE899B40992DFE1AEB0D914057F77EA7E1899B40992DFE1AEB0D914009CC0C87C4899B40E3534D22E90D91405A23B477A7899B403C363C33E50D9140A9EE939B8A899B406A486952DF0D91404BFB8E146E899B40CA6FBB86D70D9140F728240452899B40BDE859D9CD0D91409015478B36899B404D87A155C20D91406A6C39CA1B899B40CB5F1709B50D9140860665E001899B40F1E65803A60D91402E0837ECE8889B40449C0956950D91405127FC0AD1889B40E5B95AFE930D9140D410F41CD0889B40FE120697920D91400F4E4647CF889B4036A9C421910D9140761EF98ACE889B40399560A08F0D9140409CF3E8CD889B4086D4B2148E0D9140C2A0FC61CD889B40E804A1808C0D914067D0B9F6CC889B4079101BE68A0D91405FCFAEA7CC889B4002CD1847890D914014A03C75CC889B409E9197A5870D91401C2CA15FCC889B409AC59703860D914034F8F666CC889B409B6B1A63840D9140C003358BCC889B40FCAB1EC6820D9140CDD32ECCCC889B4077619F2E810D9140AFA99429CD889B4016AB909E7F0D9140DDE4F3A2CD889B406586DD177E0D9140A08FB737CE889B40DC74659C7C0D9140E61529E7CE889B405F2FFA2D7B0D9140542571B0CF889B40A96A5DCE790D914088B59892D0889B405EAF3E7F780D91404F378A8CD1889B4071483942770D914041E9129DD2889B40564AD218760D91404750E4C2D3889B4082B57604750D914013D295FCD4889B4071B67906740D9140B86FA648D6889B4065051320730D91402A9E7EA5D7889B40CD675D52720D9140683A7211D9889B404155559E710D9140F596C28ADA889B40A2C1D704710D914009A0A00FDC889B40ED0DA186700D9140E8132F9EDD889B400E214C24700D9140A2CC8434DF889B40BEA951DE6F0D91406018AFD0E0889B40698A07B56F0D9140781DB470E2889B40C46FA0A86F0D91403D479512E4889B409C922BB96F0D9140A6B851B4E5889B402AA594E66F0D9140B7C1E853E7889B40FBEBA330700D9140C0545CEFE8889B405882FE96700D91405778B384EA889B40D3C92619710D91401BB3FC11EC889B4074047DB6710D91403F6E5095ED889B40C618406E720D9140F64BD30CEF889B40D27E8E3F730D9140DC6EB876F0889B40010200000064000000D27E8E3F730D91409353833A9A989B40C618406E720D9140797668A49B989B4074047DB6710D91403054EB1B9D989B40D3C92619710D9140540F3F9F9E989B405882FE96700D9140184A882CA0989B40FBEBA330700D9140AF6DDFC1A1989B402AA594E66F0D9140B800535DA3989B409C922BB96F0D9140C909EAFCA4989B40C46FA0A86F0D9140327BA69EA6989B40698A07B56F0D9140F7A48740A8989B40BEA951DE6F0D91400FAA8CE0A9989B400E214C24700D9140CDF5B67CAB989B40ED0DA186700D914087AE0C13AD989B40A2C1D704710D914066229BA1AE989B404155559E710D91407A2B7926B0989B40CD675D52720D91400788C99FB1989B4065051320730D91404524BD0BB3989B4071B67906740D9140B7529568B4989B4082B57604750D91405CF0A5B4B5989B40564AD218760D9140287257EEB6989B4071483942770D91402ED92814B8989B405EAF3E7F780D9140208BB124B9989B40A96A5DCE790D9140E70CA31EBA989B405F2FFA2D7B0D91401B9DCA00BB989B40DC74659C7C0D914089AC12CABB989B406586DD177E0D9140CF328479BC989B4016AB909E7F0D914092DD470EBD989B4077619F2E810D9140C018A787BD989B40FCAB1EC6820D9140A2EE0CE5BD989B409B6B1A63840D9140AFBE0626BE989B409AC59703860D91403BCA444ABE989B409E9197A5870D914053969A51BE989B4002CD1847890D91405B22FF3BBE989B4079101BE68A0D914010F38C09BE989B40E804A1808C0D914008F281BABD989B4086D4B2148E0D9140AD213F4FBD989B40399560A08F0D91402F2648C8BC989B4036A9C421910D9140F9A34226BC989B40FE120697920D91406074F569BB989B40E5B95AFE930D91409BB14794BA989B40449C0956950D91401E9B3FA6B9989B40F1E65803A60D914041BA04C5A1989B40CB5F1709B50D9140E9BBD6D088989B404D87A155C20D9140055602E76E989B40BDE859D9CD0D9140DFACF42554989B40CA6FBB86D70D9140789917AD38989B406A486952DF0D914024C7AC9C1C989B403C363C33E50D9140C6D3A71500989B40E3534D22E90D9140159F8739E3979B40992DFE1AEB0D914066F62E2AC6979B40992DFE1AEB0D914018CBBC09A9979B40E3534D22E90D9140692264FA8B979B403C363C33E50D9140B8ED431E6F979B406A486952DF0D91405AFA3E9752979B40CA6FBB86D70D91400628D48636979B40BDE859D9CD0D91409F14F70D1B979B404D87A155C20D9140796BE94C00979B40CB5F1709B50D914095051563E6969B40F1E65803A60D91403D07E76ECD969B40449C0956950D91406026AC8DB5969B40E5B95AFE930D9140E30FA49FB4969B40FE120697920D91401E4DF6C9B3969B4036A9C421910D9140851DA90DB3969B40399560A08F0D91404F9BA36BB2969B4086D4B2148E0D9140D19FACE4B1969B40E804A1808C0D914076CF6979B1969B4079101BE68A0D91406ECE5E2AB1969B4002CD1847890D9140239FECF7B0969B409E9197A5870D91402B2B51E2B0969B409AC59703860D914043F7A6E9B0969B409B6B1A63840D9140CF02E50DB1969B40FCAB1EC6820D9140DCD2DE4EB1969B4077619F2E810D9140BEA844ACB1969B4016AB909E7F0D9140ECE3A325B2969B406586DD177E0D9140AF8E67BAB2969B40DC74659C7C0D9140F514D969B3969B405F2FFA2D7B0D914063242133B4969B40A96A5DCE790D914097B44815B5969B405EAF3E7F780D91405E363A0FB6969B4071483942770D914050E8C21FB7969B40564AD218760D9140564F9445B8969B4082B57604750D914022D1457FB9969B4071B67906740D9140C76E56CBBA969B4065051320730D9140399D2E28BC969B40CD675D52720D914077392294BD969B404155559E710D91400496720DBF969B40A2C1D704710D9140189F5092C0969B40ED0DA186700D9140F712DF20C2969B400E214C24700D9140B1CB34B7C3969B40BEA951DE6F0D91406F175F53C5969B40698A07B56F0D9140871C64F3C6969B40C46FA0A86F0D91404C464595C8969B409C922BB96F0D9140B5B70137CA969B402AA594E66F0D9140C6C098D6CB969B40FBEBA330700D9140CF530C72CD969B405882FE96700D914066776307CF969B40D3C92619710D91402AB2AC94D0969B4074047DB6710D91404E6D0018D2969B40C618406E720D9140054B838FD3969B40D27E8E3F730D9140EB6D68F9D4969B40010200000002000000449C0956950D91402A44431933899B40449C0956950D9140E278A1A233899B4001020000000E000000449C0956950D91407E4AEA8B728A9B406E7A2FD0980D91405FB0604F6A8A9B406B85FCFFA10D91402E4B73BD4F8A9B4051260E66A90D9140037E219E348A9B4062E1FFF9AE0D9140183E2F10198A9B4019F77DB5B20D914027FDDD32FD899B4078914C94B40D91403235C925E1899B4078914C94B40D91402E8EC208C5899B4019F77DB5B20D914039C6ADFBA8899B4062E1FFF9AE0D914048855C1E8D899B4051260E66A90D91405D456A9071899B406B85FCFFA10D91403278187156899B406E7A2FD0980D914001132BDF3B899B40449C0956950D9140E278A1A233899B40010200000002000000449C0956950D9140E278A1A233899B40449C0956950D91407E4AEA8B728A9B40010200000002000000449C0956950D91407E4AEA8B728A9B40449C0956950D9140367F4815738A9B40010200000002000000449C0956950D91403943F39B17979B40449C0956950D9140F177512518979B4001020000000E000000449C0956950D91408D499A0E57989B406E7A2FD0980D91406EAF10D24E989B406B85FCFFA10D91403D4A234034989B4051260E66A90D9140127DD12019989B4062E1FFF9AE0D9140273DDF92FD979B4019F77DB5B20D914036FC8DB5E1979B4078914C94B40D9140413479A8C5979B4078914C94B40D91403D8D728BA9979B4019F77DB5B20D914048C55D7E8D979B4062E1FFF9AE0D914057840CA171979B4051260E66A90D91406C441A1356979B406B85FCFFA10D91404177C8F33A979B406E7A2FD0980D91401012DB6120979B40449C0956950D9140F177512518979B40010200000002000000449C0956950D9140F177512518979B40449C0956950D91408D499A0E57989B40010200000002000000449C0956950D91408D499A0E57989B40449C0956950D9140457EF89757989B400102000000070000007B3032923EC0904004F53C9F07A99B407BFB26F8A4C29040E0529C2906A99B407B661552A1C290400456B82A06A39B407BA95D1E6EC590408843D27604A39B407BA95D1E6EC59040A4F24C7804AB9B407B3032923EC09040DA75F7FA06AB9B407B3032923EC0904004F53C9F07A99B400102000000050000007BF721C9A8C190406C3931EEDBA69B407BDB9854BFC09040388C7D5368A69B407B2D0C89D3C09040ECF011863FA69B407B4A95FDBCC190401C9EC520B3A69B407BF721C9A8C190406C3931EEDBA69B400102000000050000007B9D67FBB6C190408865BCBDFCA99B407B2DFD0DB7C19040801D234D1BAA9B407BE9F80DB9C19040ACC4EB4B1BAA9B407B5963FBB8C19040B40C85BCFCA99B407B9D67FBB6C190408865BCBDFCA99B400102000000050000007B9B7925E2C19040C06A054EC9A99B407BA4F22FE2C19040C0C3C186DAA99B407B42DB3F1DC29040400ED762DAA99B407B3862351DC2904040B51A2AC9A99B407B9B7925E2C19040C06A054EC9A99B400102000000050000004943B990CAC39040E03C79B6E9A79B40515A6A2E93C49040E03C79B6E9A79B40515A6A2E93C49040A8E8F9BDE3A59B404943B990CAC39040A8E8F9BDE3A59B404943B990CAC39040E03C79B6E9A79B40010200000005000000379011E473D89040CC6A0133BCA29B40379011E473D8904037FD47A2BBAA9B4023C0D79464DC904037FD47A2BBAA9B4023C0D79464DC9040CC6A0133BCA29B40379011E473D89040CC6A0133BCA29B40010200000007000000A58A73F873DA9040DD15E235F2889B40A23465CBC1DA9040DD15E235F2889B40A23465CBC1DA9040A23B348103899B40A45FECE19ADA9040A23B348103899B40A45FECE19ADA9040884EDD260C899B40A58A73F873DA9040884EDD260C899B40A58A73F873DA9040DD15E235F2889B40010200000005000000E79B1870E7DB90402F84B9B4D5869B40E5FC3A0FEEDB90402DE5DB53DC869B40DF1FA2EC01DC904034C27476C8869B40E1BE7F4DFBDB9040366152D7C1869B40E79B1870E7DB90402F84B9B4D5869B40010200000005000000DA4209CA15DC90403DDDC85AA7869B40D8A32B691CDC90403B3EEBF9AD869B40D2C6924630DC9040411B841C9A869B40D46570A729DC904043BA617D93869B40DA4209CA15DC90403DDDC85AA7869B40010200000005000000A33194E629E790407FCB862F85A09B403915F87E41E79040E3643DB3D5A09B402CA0D10BEBE690400D11E908EFA09B4096BC6D73D3E69040A97732859EA09B40A33194E629E790407FCB862F85A09B40010200000005000000E5CF714748E7904057C877487CA09B407CB3D5DF5FE79040BB612ECCCCA09B407154D3BE4BE79040336D4DB2D2A09B40DA706F2634E79040D0D3962E82A09B40E5CF714748E7904057C877487CA09B400102000000050000000FE2ED3449E790406B6F0303F0A09B401ED731FE8FE79040601E7A8EE1A19B4011620B8B39E790408ACA25E4FAA19B40026DC7C1F2E69040961BAF5809A19B400FE2ED3449E790406B6F0303F0A09B40010200000005000000780CC94E52E79040A3905A9761A09B403366C59CC4E790409A7F76A2E7A19B404100A4D42CE79040D6137E1D14A29B4087A6A786BAE69040DE2462128EA09B40780CC94E52E79040A3905A9761A09B400102000000050000005280CB9567E79040436CF41BE7A09B4061750F5FAEE79040381B6BA7D8A19B4056160D3E9AE79040B0268A8DDEA19B404721C97453E79040BC771302EDA09B405280CB9567E79040436CF41BE7A09B4001020000005B000000110056B130E99040F98F5A9C3A8A9B40F45AD0AB30E99040CB0E7C3A3B8A9B40B94E469B30E99040D754D8D73B8A9B401C7CCC7F30E99040501FAB733C8A9B40BC27855930E990402B16320D3D8A9B40620FA02830E9904081BEADA33D8A9B40762E5AED2FE990405F6962363E8A9B40EC71FDA72FE99040DC1D99C43E8A9B40145CE0582FE990404C7DA04D3F8A9B40B49865002FE9904078A0CDD03F8A9B40F981FB9E2EE99040C6EC7C4D408A9B40D4961B352EE9904043E012C3408A9B4072E349C32DE9904098D3FC30418A9B408C5C144A2DE99040EFB0B196418A9B405A2E12CA2CE99040F39EB2F3418A9B400A00E3432CE99040FD9E8B47428A9B409D2C2EB82BE99040C51DD491428A9B4031F2A1272BE99040CE752FD2428A9B40AD98F2922AE99040EF624D08438A9B40EB90D9FA29E990407666EA33438A9B406C8D146029E990404F1BD054438A9B40C59564C328E99040DE79D56A438A9B40DB158D2528E990402F0BDF75438A9B402BEA528727E990402F0BDF75438A9B40416A7BE926E99040DE79D56A438A9B409A72CB4C26E990404F1BD054438A9B401B6F06B225E990407666EA33438A9B405967ED1925E99040EF624D08438A9B40D50D3E8524E99040CE752FD2428A9B4069D3B1F423E99040C51DD491428A9B40FCFFFC6823E99040FD9E8B47428A9B40ACD1CDE222E99040F39EB2F3418A9B407AA3CB6222E99040EFB0B196418A9B40941C96E921E9904098D3FC30418A9B403269C47721E9904043E012C3408A9B400D7EE40D21E99040C6EC7C4D408A9B4052677AAC20E9904078A0CDD03F8A9B40F2A3FF5320E990404C7DA04D3F8A9B401A8EE20420E99040DC1D99C43E8A9B4090D185BF1FE990405F6962363E8A9B40A4F03F841FE9904081BEADA33D8A9B404AD85A531FE990402B16320D3D8A9B40EA83132D1FE99040501FAB733C8A9B404DB199111FE99040D754D8D73B8A9B4012A50F011FE99040CB0E7C3A3B8A9B40F5FF89FB1EE99040F98F5A9C3A8A9B4012A50F011FE99040261139FE398A9B404DB199111FE990401ACBDC60398A9B40EA83132D1FE99040A1000AC5388A9B404AD85A531FE99040C609832B388A9B40A4F03F841FE9904070610795378A9B4090D185BF1FE9904092B65202378A9B401A8EE20420E9904016021C74368A9B40F2A3FF5320E99040A5A214EB358A9B4052677AAC20E99040797FE767358A9B400D7EE40D21E990402B3338EB348A9B403269C47721E99040AE3FA275348A9B40941C96E921E99040594CB807348A9B407AA3CB6222E99040026F03A2338A9B40ACD1CDE222E99040FE800245338A9B40FCFFFC6823E99040F48029F1328A9B4069D3B1F423E990402C02E1A6328A9B40D50D3E8524E9904023AA8566328A9B405967ED1925E9904002BD6730328A9B401B6F06B225E990407BB9CA04328A9B409A72CB4C26E99040A204E5E3318A9B40416A7BE926E9904013A6DFCD318A9B402BEA528727E99040C314D6C2318A9B40DB158D2528E99040C314D6C2318A9B40C59564C328E9904013A6DFCD318A9B406C8D146029E99040A204E5E3318A9B40EB90D9FA29E990407BB9CA04328A9B40AD98F2922AE9904002BD6730328A9B4031F2A1272BE9904023AA8566328A9B409D2C2EB82BE990402C02E1A6328A9B400A00E3432CE99040F48029F1328A9B405A2E12CA2CE99040FE800245338A9B408C5C144A2DE99040026F03A2338A9B4072E349C32DE99040594CB807348A9B40D4961B352EE99040AE3FA275348A9B40F981FB9E2EE990402B3338EB348A9B40B49865002FE99040797FE767358A9B40145CE0582FE99040A5A214EB358A9B40EC71FDA72FE9904016021C74368A9B40762E5AED2FE9904092B65202378A9B40620FA02830E9904070610795378A9B40BC27855930E99040C609832B388A9B401C7CCC7F30E99040A1000AC5388A9B40B94E469B30E990401ACBDC60398A9B40F45AD0AB30E99040261139FE398A9B40110056B130E99040F98F5A9C3A8A9B4001020000005B000000B7A6440E40E99040F98F5A9C3A8A9B40DA6A2AFF3FE990407F03D54C3C8A9B40438DEED13FE99040431334FB3D8A9B406B78C9863FE990403EFC5EA53F8A9B40F0E4181E3FE9904099394249418A9B40A8645F983EE99040921BD2E4428A9B40D2BF43F63DE99040AA540D76448A9B400B2590383DE99040CE79FFFA458A9B40272D31603CE990407C72C371478A9B401EB4346E3BE99040C4D585D8488A9B407588C8633AE990404131872D4A8A9B40D8F2384239E9904022371E6F4B8A9B40AA17EF0A38E99040A0D0B99B4C8A9B409B346FBF36E990403912E3B14D8A9B4070BC566135E990404C0F3FB04E8A9B405D535AF233E99040C78A90954F8A9B406DAE437432E99040D282B960508A9B40AB58EFE830E990408395BC10518A9B40C4604A522FE99040E53CBEA4518A9B401AF24FB22DE99040C2E0051C528A9B4036DC060B2CE99040DBBCFE75528A9B40B70B7F5E2AE99040769A38B2528A9B40E6F7CEAE28E99040525C68D0528A9B401F0811FE26E99040525C68D0528A9B404FF4604E25E99040769A38B2528A9B40D023D9A123E99040DBBCFE75528A9B40EC0D90FA21E99040C2E0051C528A9B40429F955A20E99040E53CBEA4518A9B405BA7F0C31EE990408395BC10518A9B4098519C381DE99040D282B960508A9B40A9AC85BA1BE99040C78A90954F8A9B409643894B1AE990404C0F3FB04E8A9B406BCB70ED18E990403912E3B14D8A9B405CE8F0A117E99040A0D0B99B4C8A9B402E0DA76A16E9904022371E6F4B8A9B409077174915E990404131872D4A8A9B40E84BAB3E14E99040C4D585D8488A9B40DED2AE4C13E990407C72C371478A9B40FBDA4F7412E99040CE79FFFA458A9B4034409CB611E99040AA540D76448A9B405E9B801411E99040921BD2E4428A9B40161BC78E10E9904099394249418A9B409B87162610E990403EFC5EA53F8A9B40C372F1DA0FE99040431334FB3D8A9B402B95B5AD0FE990407F03D54C3C8A9B404F599B9E0FE99040F98F5A9C3A8A9B402B95B5AD0FE99040721CE0EB388A9B40C372F1DA0FE99040AE0C813D378A9B409B87162610E99040B3235693358A9B40161BC78E10E9904058E672EF338A9B405E9B801411E990405F04E353328A9B4034409CB611E9904047CBA7C2308A9B40FBDA4F7412E9904023A6B53D2F8A9B40DED2AE4C13E9904075ADF1C62D8A9B40E84BAB3E14E990402D4A2F602C8A9B409077174915E99040B0EE2D0B2B8A9B402E0DA76A16E99040CFE896C9298A9B405CE8F0A117E99040514FFB9C288A9B406BCB70ED18E99040B80DD286278A9B409643894B1AE99040A5107688268A9B40A9AC85BA1BE990402A9524A3258A9B4098519C381DE990401F9DFBD7248A9B405BA7F0C31EE990406E8AF827248A9B40429F955A20E990400CE3F693238A9B40EC0D90FA21E990402F3FAF1C238A9B40D023D9A123E990401663B6C2228A9B404FF4604E25E990407B857C86228A9B401F0811FE26E990409FC34C68228A9B40E6F7CEAE28E990409FC34C68228A9B40B70B7F5E2AE990407B857C86228A9B4036DC060B2CE990401663B6C2228A9B401AF24FB22DE990402F3FAF1C238A9B40C4604A522FE990400CE3F693238A9B40AB58EFE830E990406E8AF827248A9B406DAE437432E990401F9DFBD7248A9B405D535AF233E990402A9524A3258A9B4070BC566135E99040A5107688268A9B409B346FBF36E99040B80DD286278A9B40AA17EF0A38E99040514FFB9C288A9B40D8F2384239E99040CFE896C9298A9B407588C8633AE99040B0EE2D0B2B8A9B401EB4346E3BE990402D4A2F602C8A9B40272D31603CE9904075ADF1C62D8A9B400B2590383DE9904023A6B53D2F8A9B40D2BF43F63DE9904047CBA7C2308A9B40A8645F983EE990405F04E353328A9B40F0E4181E3FE9904058E672EF338A9B406B78C9863FE99040B3235693358A9B40438DEED13FE99040AE0C813D378A9B40DA6A2AFF3FE99040721CE0EB388A9B40B7A6440E40E99040F98F5A9C3A8A9B40010200000005000000C99141CCF6E990402F84B9B4D5869B40C7F2636BFDE990402DE5DB53DC869B40C115CB4811EA904034C27476C8869B40C3B4A8A90AEA9040366152D7C1869B40C99141CCF6E990402F84B9B4D5869B40010200000005000000BC38322625EA90403DDDC85AA7869B40BA9954C52BEA90403B3EEBF9AD869B40B4BCBBA23FEA9040411B841C9A869B40B65B990339EA904043BA617D93869B40BC38322625EA90403DDDC85AA7869B400102000000070000000EBC7BA410F0904080CE00BBDD8F9B400EBC7BA410F0904006BA5273FC8F9B409E7E71CD6CF0904006BA5273FC8F9B409E7E71CD6CF09040587271F8E78F9B40569DF6B83EF09040587271F8E78F9B40569DF6B83EF0904080CE00BBDD8F9B400EBC7BA410F0904080CE00BBDD8F9B40010200000005000000068D6518DAF090406D1C7ED299889B40068D6518DAF0904087EFEA3484899B402851A19B12F290400B685245AB899B402851A19B12F29040E9A316C272889B40068D6518DAF090406D1C7ED299889B400102000000050000005FD121F51EF29040960545F8C2879B4027D2000CB7F49040960545F8C2879B4027D2000CB7F490405E06240F5B8A9B405FD121F51EF290405E06240F5B8A9B405FD121F51EF29040960545F8C2879B40010200000005000000B26FF3BECEF29040F09063BBBA879B40D4332F4207F49040F09063BBBA879B404FBBC731E0F39040CECC273882869B4036E85ACFF5F29040CECC273882869B40B26FF3BECEF29040F09063BBBA879B40010200000005000000B26FF3BECEF29040047B054C638A9B40D4332F4207F49040047B054C638A9B404FBBC731E0F39040263F41CF9B8B9B4036E85ACFF5F29040263F41CF9B8B9B40B26FF3BECEF29040047B054C638A9B400102000000050000005D528165C3F49040E9A316C272889B407F16BDE8FBF590406D1C7ED299889B407F16BDE8FBF5904087EFEA3484899B405D528165C3F490400B685245AB899B405D528165C3F49040E9A316C272889B40010200000005000000B8E2D0FBD5F79040FAF7FD4F5C8A9B40B8E2D0FBD5F79040B2C564C9318A9B402E7B827900F89040B2C564C9318A9B402E7B827900F89040FAF7FD4F5C8A9B40B8E2D0FBD5F79040FAF7FD4F5C8A9B40010200000005000000B19D9C4FF2F79040599AEB38E98B9B40B19D9C4FF2F79040BA507458A28B9B40AE2A80C871F89040BA507458A28B9B40AE2A80C871F89040599AEB38E98B9B40B19D9C4FF2F79040599AEB38E98B9B400102000000050000008205094FFDFA90407C13B2AE87899B408205094FFDFA904057AE866F158A9B409C2DFBE829F9904057AE866F158A9B409C2DFBE829F990407C13B2AE87899B408205094FFDFA90407C13B2AE87899B40010200000005000000AB343FAE8F089140815AFFF841879B404A7EB68ED6089140815AFFF841879B404A7EB68ED60891407EE7E271C1879B40AB343FAE8F0891407EE7E271C1879B40AB343FAE8F089140815AFFF841879B40010200000005000000AB343FAE8F0891409059AF7B26959B404A7EB68ED60891409059AF7B26959B404A7EB68ED60891408CE692F4A5959B40AB343FAE8F0891408CE692F4A5959B40AB343FAE8F0891409059AF7B26959B4001020000000500000009D72C971C0A9140849F33A525879B405109C61D470A9140849F33A525879B405109C61D470A9140FD37E52250879B4009D72C971C0A9140FD37E52250879B4009D72C971C0A9140849F33A525879B4001020000000500000009D72C971C0A9140979EE3270A959B405109C61D470A9140979EE3270A959B405109C61D470A91400C3795A534959B4009D72C971C0A91400C3795A534959B4009D72C971C0A9140979EE3270A959B4001020000000500000084BB7838F10A914052C26BF84C8A9B40A820A477630A914052C26BF84C8A9B40A820A477630A91406CEA5D9279889B4084BB7838F10A91406CEA5D9279889B4084BB7838F10A914052C26BF84C8A9B4001020000000500000084BB7838F10A914060C11B7B31989B40A820A477630A914060C11B7B31989B40A820A477630A91407FE90D155E969B4084BB7838F10A91407FE90D155E969B4084BB7838F10A914060C11B7B31989B40
\.


--
-- TOC entry 4546 (class 0 OID 1475571)
-- Dependencies: 259
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
-- TOC entry 4548 (class 0 OID 1475577)
-- Dependencies: 261
-- Data for Name: solicitudes_permiso; Type: TABLE DATA; Schema: recursos_humanos; Owner: postgres
--

COPY recursos_humanos.solicitudes_permiso (permiso_id, empleado_id, tipo_permiso, fecha_inicio, fecha_fin, estado, aprobado_por, comentarios) FROM stdin;
\.


--
-- TOC entry 4550 (class 0 OID 1475583)
-- Dependencies: 263
-- Data for Name: asistencias; Type: TABLE DATA; Schema: sistemas; Owner: postgres
--

COPY sistemas.asistencias (asistencia_id, empleado_id, fecha, hora_entrada, hora_salida, estado, comentarios) FROM stdin;
\.


--
-- TOC entry 4552 (class 0 OID 1475589)
-- Dependencies: 265
-- Data for Name: asignaciones_tareas; Type: TABLE DATA; Schema: tareas; Owner: postgres
--

COPY tareas.asignaciones_tareas (asignacion_id, tarea_id, empleado_id, asignador_id) FROM stdin;
77	121	\N	\N
82	123	31	15
83	124	31	21
84	125	31	21
85	126	31	21
86	127	24	21
87	128	16	21
88	129	19	21
89	130	17	21
\.


--
-- TOC entry 4554 (class 0 OID 1475593)
-- Dependencies: 267
-- Data for Name: tareas; Type: TABLE DATA; Schema: tareas; Owner: postgres
--

COPY tareas.tareas (tarea_id, titulo, descripcion, fecha_inicio, fecha_estimada_fin, fecha_real_fin, prioridad, estado, tiempo_restante_paralizado, tiempo_pasado_paralizado, tarea_padre, complejidad, puntos) FROM stdin;
121	Desarrollar Aplicativo de Mesa de Partes	Desarrollar Aplicativo de Mesa de Partes	2024-12-03 17:08:25-05	2024-12-04 19:00:00-05	2024-12-03 17:49:24.786-05	Alta	Completada	\N	\N	\N	1	1
123	Tarea	Tarea	2024-12-12 16:06:33-05	2024-12-20 16:06:00-05	\N	Media	Pendiente	\N	\N	\N	1	1
125	Tarea para Carlos 2.0	Tarea para Carlos 2.0	2024-12-16 10:14:44-05	2024-12-20 10:18:00-05	\N	Media	En Progreso	\N	\N	124	1	1
126	Tarea prueba	Tarea prueba	2024-12-16 10:26:18-05	2024-12-19 10:40:00-05	\N	Media	En Progreso	\N	\N	\N	1	1
127	Tarea Prueba	12345679	2024-12-16 12:00:26-05	2024-12-17 12:00:00-05	\N	Alta	En Progreso	\N	\N	\N	1	1
128	Tarea Pruebaaaaa	Tarea Pruebaaaaa	2024-12-16 14:16:20-05	2024-12-17 14:16:00-05	\N	Alta	Pendiente	\N	\N	\N	1	1
129	fadsfd	affdaf	2024-12-16 14:47:33-05	2024-12-17 14:47:00-05	\N	Media	Pendiente	\N	\N	\N	1	1
124	Tarea para Carlos	Tarea para Carlos	2024-12-16 10:14:18-05	2024-12-17 10:14:00-05	2024-12-16 14:52:33.856281-05	Alta	Completada	{"dias": 0, "horas": 19, "minutos": 21}	{"dias": 0, "horas": 0, "minutos": 0}	\N	1	1
130	423	FDSA	2024-12-16 14:54:32-05	2024-12-17 14:54:00-05	\N	Alta	Pendiente	\N	\N	\N	1	1
\.


--
-- TOC entry 4637 (class 0 OID 0)
-- Dependencies: 222
-- Name: evaluaciones_desempeño_evaluacion_id_seq; Type: SEQUENCE SET; Schema: evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('evaluaciones."evaluaciones_desempeño_evaluacion_id_seq"', 1, false);


--
-- TOC entry 4638 (class 0 OID 0)
-- Dependencies: 224
-- Name: solicitudes_permiso_permiso_id_seq; Type: SEQUENCE SET; Schema: permisos; Owner: postgres
--

SELECT pg_catalog.setval('permisos.solicitudes_permiso_permiso_id_seq', 1, false);


--
-- TOC entry 4639 (class 0 OID 0)
-- Dependencies: 226
-- Name: costos_costo_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.costos_costo_id_seq', 10, true);


--
-- TOC entry 4640 (class 0 OID 0)
-- Dependencies: 228
-- Name: facturas_id_factura_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.facturas_id_factura_seq', 28, true);


--
-- TOC entry 4641 (class 0 OID 0)
-- Dependencies: 230
-- Name: ordenescompra_id_orden_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.ordenescompra_id_orden_seq', 12, true);


--
-- TOC entry 4642 (class 0 OID 0)
-- Dependencies: 232
-- Name: pagos_id_pago_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.pagos_id_pago_seq', 48, true);


--
-- TOC entry 4643 (class 0 OID 0)
-- Dependencies: 234
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.proveedores_id_proveedor_seq', 20, true);


--
-- TOC entry 4644 (class 0 OID 0)
-- Dependencies: 236
-- Name: proyectos_proyecto_id_seq; Type: SEQUENCE SET; Schema: proyectos; Owner: postgres
--

SELECT pg_catalog.setval('proyectos.proyectos_proyecto_id_seq', 10, true);


--
-- TOC entry 4645 (class 0 OID 0)
-- Dependencies: 238
-- Name: areas_area_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.areas_area_id_seq', 40, true);


--
-- TOC entry 4646 (class 0 OID 0)
-- Dependencies: 240
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_group_id_seq', 1, false);


--
-- TOC entry 4647 (class 0 OID 0)
-- Dependencies: 242
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 4648 (class 0 OID 0)
-- Dependencies: 244
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_permission_id_seq', 1, false);


--
-- TOC entry 4649 (class 0 OID 0)
-- Dependencies: 247
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_user_groups_id_seq', 1, false);


--
-- TOC entry 4650 (class 0 OID 0)
-- Dependencies: 248
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_user_id_seq', 1, false);


--
-- TOC entry 4651 (class 0 OID 0)
-- Dependencies: 250
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 4652 (class 0 OID 0)
-- Dependencies: 252
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.django_admin_log_id_seq', 1, false);


--
-- TOC entry 4653 (class 0 OID 0)
-- Dependencies: 254
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.django_content_type_id_seq', 1, false);


--
-- TOC entry 4654 (class 0 OID 0)
-- Dependencies: 256
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.django_migrations_id_seq', 1, false);


--
-- TOC entry 4655 (class 0 OID 0)
-- Dependencies: 258
-- Name: empleados_id_empleado_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.empleados_id_empleado_seq', 49, true);


--
-- TOC entry 4656 (class 0 OID 0)
-- Dependencies: 269
-- Name: oficina_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.oficina_id_seq', 2, true);


--
-- TOC entry 4657 (class 0 OID 0)
-- Dependencies: 260
-- Name: roles_id_rol_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.roles_id_rol_seq', 10, true);


--
-- TOC entry 4658 (class 0 OID 0)
-- Dependencies: 262
-- Name: solicitudes_permiso_permiso_id_seq; Type: SEQUENCE SET; Schema: recursos_humanos; Owner: postgres
--

SELECT pg_catalog.setval('recursos_humanos.solicitudes_permiso_permiso_id_seq', 1, false);


--
-- TOC entry 4659 (class 0 OID 0)
-- Dependencies: 264
-- Name: asistencias_asistencia_id_seq; Type: SEQUENCE SET; Schema: sistemas; Owner: postgres
--

SELECT pg_catalog.setval('sistemas.asistencias_asistencia_id_seq', 1, false);


--
-- TOC entry 4660 (class 0 OID 0)
-- Dependencies: 266
-- Name: asignaciones_tareas_asignacion_id_seq; Type: SEQUENCE SET; Schema: tareas; Owner: postgres
--

SELECT pg_catalog.setval('tareas.asignaciones_tareas_asignacion_id_seq', 89, true);


--
-- TOC entry 4661 (class 0 OID 0)
-- Dependencies: 268
-- Name: tareas_tarea_id_seq; Type: SEQUENCE SET; Schema: tareas; Owner: postgres
--

SELECT pg_catalog.setval('tareas.tareas_tarea_id_seq', 130, true);


--
-- TOC entry 4246 (class 2606 OID 1475614)
-- Name: evaluaciones_desempeño evaluaciones_desempeño_pkey; Type: CONSTRAINT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño"
    ADD CONSTRAINT "evaluaciones_desempeño_pkey" PRIMARY KEY (evaluacion_id);


--
-- TOC entry 4248 (class 2606 OID 1475616)
-- Name: solicitudes_permiso solicitudes_permiso_pkey; Type: CONSTRAINT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_pkey PRIMARY KEY (permiso_id);


--
-- TOC entry 4250 (class 2606 OID 1475618)
-- Name: costos costos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos
    ADD CONSTRAINT costos_pkey PRIMARY KEY (costo_id);


--
-- TOC entry 4252 (class 2606 OID 1475620)
-- Name: facturas facturas_numero_factura_key; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas
    ADD CONSTRAINT facturas_numero_factura_key UNIQUE (numero_factura);


--
-- TOC entry 4254 (class 2606 OID 1475622)
-- Name: facturas facturas_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas
    ADD CONSTRAINT facturas_pkey PRIMARY KEY (id_factura);


--
-- TOC entry 4256 (class 2606 OID 1475624)
-- Name: ordenescompra ordenescompra_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra
    ADD CONSTRAINT ordenescompra_pkey PRIMARY KEY (id_orden);


--
-- TOC entry 4258 (class 2606 OID 1475626)
-- Name: pagos pagos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 4260 (class 2606 OID 1475628)
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);


--
-- TOC entry 4262 (class 2606 OID 1475630)
-- Name: proyectos proyectos_pkey; Type: CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos
    ADD CONSTRAINT proyectos_pkey PRIMARY KEY (proyecto_id);


--
-- TOC entry 4264 (class 2606 OID 1475632)
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (area_id);


--
-- TOC entry 4267 (class 2606 OID 1475634)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 4272 (class 2606 OID 1475636)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 4275 (class 2606 OID 1475638)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4269 (class 2606 OID 1475640)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 4278 (class 2606 OID 1475642)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 4280 (class 2606 OID 1475644)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 4288 (class 2606 OID 1475646)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4291 (class 2606 OID 1475648)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 4282 (class 2606 OID 1475650)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 4294 (class 2606 OID 1475652)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4297 (class 2606 OID 1475654)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 4285 (class 2606 OID 1475656)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 4300 (class 2606 OID 1475658)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4303 (class 2606 OID 1475660)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 4305 (class 2606 OID 1475662)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4307 (class 2606 OID 1475664)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4309 (class 2606 OID 1475666)
-- Name: empleados empleados_correo_key; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT empleados_correo_key UNIQUE (correo);


--
-- TOC entry 4311 (class 2606 OID 1475668)
-- Name: empleados empleados_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (id_empleado);


--
-- TOC entry 4334 (class 2606 OID 1476663)
-- Name: oficina oficina_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.oficina
    ADD CONSTRAINT oficina_pkey PRIMARY KEY (id);


--
-- TOC entry 4317 (class 2606 OID 1475670)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 4319 (class 2606 OID 1475672)
-- Name: solicitudes_permiso solicitudes_permiso_pkey; Type: CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_pkey PRIMARY KEY (permiso_id);


--
-- TOC entry 4321 (class 2606 OID 1475674)
-- Name: asistencias asistencias_pkey; Type: CONSTRAINT; Schema: sistemas; Owner: postgres
--

ALTER TABLE ONLY sistemas.asistencias
    ADD CONSTRAINT asistencias_pkey PRIMARY KEY (asistencia_id);


--
-- TOC entry 4323 (class 2606 OID 1475676)
-- Name: asignaciones_tareas asignaciones_tareas_pkey; Type: CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_pkey PRIMARY KEY (asignacion_id);


--
-- TOC entry 4332 (class 2606 OID 1475678)
-- Name: tareas tareas_pkey; Type: CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.tareas
    ADD CONSTRAINT tareas_pkey PRIMARY KEY (tarea_id);


--
-- TOC entry 4265 (class 1259 OID 1475679)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON recursos_humanos.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 4270 (class 1259 OID 1475680)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON recursos_humanos.auth_group_permissions USING btree (group_id);


--
-- TOC entry 4273 (class 1259 OID 1475681)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON recursos_humanos.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 4276 (class 1259 OID 1475682)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON recursos_humanos.auth_permission USING btree (content_type_id);


--
-- TOC entry 4286 (class 1259 OID 1475683)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON recursos_humanos.auth_user_groups USING btree (group_id);


--
-- TOC entry 4289 (class 1259 OID 1475684)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON recursos_humanos.auth_user_groups USING btree (user_id);


--
-- TOC entry 4292 (class 1259 OID 1475685)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON recursos_humanos.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 4295 (class 1259 OID 1475686)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON recursos_humanos.auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 4283 (class 1259 OID 1475687)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON recursos_humanos.auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 4298 (class 1259 OID 1475688)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON recursos_humanos.django_admin_log USING btree (content_type_id);


--
-- TOC entry 4301 (class 1259 OID 1475689)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON recursos_humanos.django_admin_log USING btree (user_id);


--
-- TOC entry 4312 (class 1259 OID 1476792)
-- Name: idx_empleados_activo; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX idx_empleados_activo ON recursos_humanos.empleados USING btree (activo);


--
-- TOC entry 4313 (class 1259 OID 1476790)
-- Name: idx_empleados_area_id; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX idx_empleados_area_id ON recursos_humanos.empleados USING btree (area_id);


--
-- TOC entry 4314 (class 1259 OID 1476793)
-- Name: idx_empleados_geom; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX idx_empleados_geom ON recursos_humanos.empleados USING gist (geom);


--
-- TOC entry 4315 (class 1259 OID 1476791)
-- Name: idx_empleados_rol_id; Type: INDEX; Schema: recursos_humanos; Owner: postgres
--

CREATE INDEX idx_empleados_rol_id ON recursos_humanos.empleados USING btree (rol_id);


--
-- TOC entry 4324 (class 1259 OID 1476800)
-- Name: idx_asignaciones_tareas_asignador_id; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_asignaciones_tareas_asignador_id ON tareas.asignaciones_tareas USING btree (asignador_id);


--
-- TOC entry 4325 (class 1259 OID 1476799)
-- Name: idx_asignaciones_tareas_empleado_id; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_asignaciones_tareas_empleado_id ON tareas.asignaciones_tareas USING btree (empleado_id);


--
-- TOC entry 4326 (class 1259 OID 1476798)
-- Name: idx_asignaciones_tareas_tarea_id; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_asignaciones_tareas_tarea_id ON tareas.asignaciones_tareas USING btree (tarea_id);


--
-- TOC entry 4327 (class 1259 OID 1476794)
-- Name: idx_tareas_estado; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_tareas_estado ON tareas.tareas USING btree (estado);


--
-- TOC entry 4328 (class 1259 OID 1476796)
-- Name: idx_tareas_fecha_estimada_fin; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_tareas_fecha_estimada_fin ON tareas.tareas USING btree (fecha_estimada_fin);


--
-- TOC entry 4329 (class 1259 OID 1476795)
-- Name: idx_tareas_fecha_inicio; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_tareas_fecha_inicio ON tareas.tareas USING btree (fecha_inicio);


--
-- TOC entry 4330 (class 1259 OID 1476797)
-- Name: idx_tareas_tarea_padre; Type: INDEX; Schema: tareas; Owner: postgres
--

CREATE INDEX idx_tareas_tarea_padre ON tareas.tareas USING btree (tarea_padre);


--
-- TOC entry 4335 (class 2606 OID 1475690)
-- Name: evaluaciones_desempeño evaluaciones_desempeño_empleado_id_fkey; Type: FK CONSTRAINT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño"
    ADD CONSTRAINT "evaluaciones_desempeño_empleado_id_fkey" FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- TOC entry 4336 (class 2606 OID 1475695)
-- Name: evaluaciones_desempeño evaluaciones_desempeño_evaluador_id_fkey; Type: FK CONSTRAINT; Schema: evaluaciones; Owner: postgres
--

ALTER TABLE ONLY evaluaciones."evaluaciones_desempeño"
    ADD CONSTRAINT "evaluaciones_desempeño_evaluador_id_fkey" FOREIGN KEY (evaluador_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- TOC entry 4337 (class 2606 OID 1475700)
-- Name: solicitudes_permiso solicitudes_permiso_aprobado_por_fkey; Type: FK CONSTRAINT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_aprobado_por_fkey FOREIGN KEY (aprobado_por) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- TOC entry 4338 (class 2606 OID 1475705)
-- Name: solicitudes_permiso solicitudes_permiso_empleado_id_fkey; Type: FK CONSTRAINT; Schema: permisos; Owner: postgres
--

ALTER TABLE ONLY permisos.solicitudes_permiso
    ADD CONSTRAINT solicitudes_permiso_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- TOC entry 4339 (class 2606 OID 1475710)
-- Name: costos costos_proveedor_id_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos
    ADD CONSTRAINT costos_proveedor_id_fkey FOREIGN KEY (proveedor_id) REFERENCES proyectos.proveedores(id_proveedor);


--
-- TOC entry 4341 (class 2606 OID 1475715)
-- Name: facturas facturas_id_orden_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.facturas
    ADD CONSTRAINT facturas_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES proyectos.ordenescompra(id_orden) ON DELETE CASCADE;


--
-- TOC entry 4340 (class 2606 OID 1475720)
-- Name: costos fk_proyecto; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.costos
    ADD CONSTRAINT fk_proyecto FOREIGN KEY (proyecto_id) REFERENCES proyectos.proyectos(proyecto_id) ON DELETE SET NULL;


--
-- TOC entry 4345 (class 2606 OID 1475725)
-- Name: proyectos fk_responsable; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.proyectos
    ADD CONSTRAINT fk_responsable FOREIGN KEY (responsable_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- TOC entry 4342 (class 2606 OID 1475730)
-- Name: ordenescompra ordenescompra_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra
    ADD CONSTRAINT ordenescompra_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES proyectos.proveedores(id_proveedor) ON DELETE CASCADE;


--
-- TOC entry 4343 (class 2606 OID 1475735)
-- Name: ordenescompra ordenescompra_id_proyecto_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.ordenescompra
    ADD CONSTRAINT ordenescompra_id_proyecto_fkey FOREIGN KEY (id_proyecto) REFERENCES proyectos.proyectos(proyecto_id) ON DELETE CASCADE;


--
-- TOC entry 4344 (class 2606 OID 1475740)
-- Name: pagos pagos_id_factura_fkey; Type: FK CONSTRAINT; Schema: proyectos; Owner: postgres
--

ALTER TABLE ONLY proyectos.pagos
    ADD CONSTRAINT pagos_id_factura_fkey FOREIGN KEY (id_factura) REFERENCES proyectos.facturas(id_factura) ON DELETE CASCADE;


--
-- TOC entry 4346 (class 2606 OID 1475745)
-- Name: areas areas_supervisor_id_fkey; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.areas
    ADD CONSTRAINT areas_supervisor_id_fkey FOREIGN KEY (supervisor_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- TOC entry 4347 (class 2606 OID 1475750)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES recursos_humanos.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4348 (class 2606 OID 1475755)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES recursos_humanos.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4349 (class 2606 OID 1475760)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES recursos_humanos.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4350 (class 2606 OID 1475765)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES recursos_humanos.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4351 (class 2606 OID 1475770)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES recursos_humanos.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4352 (class 2606 OID 1475775)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES recursos_humanos.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4353 (class 2606 OID 1475780)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES recursos_humanos.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4354 (class 2606 OID 1475785)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES recursos_humanos.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4355 (class 2606 OID 1475790)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES recursos_humanos.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4356 (class 2606 OID 1475795)
-- Name: empleados fk_area_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT fk_area_id FOREIGN KEY (area_id) REFERENCES recursos_humanos.areas(area_id) NOT VALID;


--
-- TOC entry 4357 (class 2606 OID 1475800)
-- Name: empleados fk_rol_id; Type: FK CONSTRAINT; Schema: recursos_humanos; Owner: postgres
--

ALTER TABLE ONLY recursos_humanos.empleados
    ADD CONSTRAINT fk_rol_id FOREIGN KEY (rol_id) REFERENCES recursos_humanos.roles(id_rol) NOT VALID;


--
-- TOC entry 4358 (class 2606 OID 1475805)
-- Name: asistencias asistencias_empleado_id_fkey; Type: FK CONSTRAINT; Schema: sistemas; Owner: postgres
--

ALTER TABLE ONLY sistemas.asistencias
    ADD CONSTRAINT asistencias_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- TOC entry 4359 (class 2606 OID 1475810)
-- Name: asignaciones_tareas asignaciones_tareas_asignador_id_fkey; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_asignador_id_fkey FOREIGN KEY (asignador_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE SET NULL;


--
-- TOC entry 4360 (class 2606 OID 1475815)
-- Name: asignaciones_tareas asignaciones_tareas_empleado_id_fkey; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES recursos_humanos.empleados(id_empleado) ON DELETE CASCADE;


--
-- TOC entry 4361 (class 2606 OID 1475820)
-- Name: asignaciones_tareas asignaciones_tareas_tarea_id_fkey; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.asignaciones_tareas
    ADD CONSTRAINT asignaciones_tareas_tarea_id_fkey FOREIGN KEY (tarea_id) REFERENCES tareas.tareas(tarea_id) ON DELETE CASCADE;


--
-- TOC entry 4362 (class 2606 OID 1475825)
-- Name: tareas fk_tarea_padre; Type: FK CONSTRAINT; Schema: tareas; Owner: postgres
--

ALTER TABLE ONLY tareas.tareas
    ADD CONSTRAINT fk_tarea_padre FOREIGN KEY (tarea_padre) REFERENCES tareas.tareas(tarea_id) ON DELETE CASCADE;


--
-- TOC entry 4563 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA evaluaciones; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA evaluaciones TO adminconsulta;
GRANT USAGE ON SCHEMA evaluaciones TO adminedita;


--
-- TOC entry 4564 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA permisos; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA permisos TO adminconsulta;
GRANT USAGE ON SCHEMA permisos TO adminedita;


--
-- TOC entry 4565 (class 0 OID 0)
-- Dependencies: 9
-- Name: SCHEMA proyectos; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA proyectos TO adminconsulta;
GRANT USAGE ON SCHEMA proyectos TO adminedita;


--
-- TOC entry 4566 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 4567 (class 0 OID 0)
-- Dependencies: 10
-- Name: SCHEMA recursos_humanos; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA recursos_humanos TO adminconsulta;
GRANT USAGE ON SCHEMA recursos_humanos TO adminedita;


--
-- TOC entry 4568 (class 0 OID 0)
-- Dependencies: 11
-- Name: SCHEMA sistemas; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA sistemas TO adminconsulta;
GRANT USAGE ON SCHEMA sistemas TO adminedita;


--
-- TOC entry 4569 (class 0 OID 0)
-- Dependencies: 12
-- Name: SCHEMA tareas; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA tareas TO adminconsulta;
GRANT USAGE ON SCHEMA tareas TO adminedita;


--
-- TOC entry 4571 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE "evaluaciones_desempeño"; Type: ACL; Schema: evaluaciones; Owner: postgres
--

GRANT SELECT ON TABLE evaluaciones."evaluaciones_desempeño" TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE evaluaciones."evaluaciones_desempeño" TO adminedita;


--
-- TOC entry 4573 (class 0 OID 0)
-- Dependencies: 222
-- Name: SEQUENCE "evaluaciones_desempeño_evaluacion_id_seq"; Type: ACL; Schema: evaluaciones; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE evaluaciones."evaluaciones_desempeño_evaluacion_id_seq" TO adminconsulta;
GRANT ALL ON SEQUENCE evaluaciones."evaluaciones_desempeño_evaluacion_id_seq" TO adminedita;


--
-- TOC entry 4574 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE solicitudes_permiso; Type: ACL; Schema: permisos; Owner: postgres
--

GRANT SELECT ON TABLE permisos.solicitudes_permiso TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE permisos.solicitudes_permiso TO adminedita;


--
-- TOC entry 4576 (class 0 OID 0)
-- Dependencies: 224
-- Name: SEQUENCE solicitudes_permiso_permiso_id_seq; Type: ACL; Schema: permisos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE permisos.solicitudes_permiso_permiso_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE permisos.solicitudes_permiso_permiso_id_seq TO adminedita;


--
-- TOC entry 4577 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE costos; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT ON TABLE proyectos.costos TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE proyectos.costos TO adminedita;


--
-- TOC entry 4579 (class 0 OID 0)
-- Dependencies: 226
-- Name: SEQUENCE costos_costo_id_seq; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE proyectos.costos_costo_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE proyectos.costos_costo_id_seq TO adminedita;


--
-- TOC entry 4580 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE facturas; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT ON TABLE proyectos.facturas TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE proyectos.facturas TO adminedita;


--
-- TOC entry 4582 (class 0 OID 0)
-- Dependencies: 228
-- Name: SEQUENCE facturas_id_factura_seq; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE proyectos.facturas_id_factura_seq TO adminconsulta;
GRANT ALL ON SEQUENCE proyectos.facturas_id_factura_seq TO adminedita;


--
-- TOC entry 4583 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE ordenescompra; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT ON TABLE proyectos.ordenescompra TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE proyectos.ordenescompra TO adminedita;


--
-- TOC entry 4585 (class 0 OID 0)
-- Dependencies: 230
-- Name: SEQUENCE ordenescompra_id_orden_seq; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE proyectos.ordenescompra_id_orden_seq TO adminconsulta;
GRANT ALL ON SEQUENCE proyectos.ordenescompra_id_orden_seq TO adminedita;


--
-- TOC entry 4586 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE pagos; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT ON TABLE proyectos.pagos TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE proyectos.pagos TO adminedita;


--
-- TOC entry 4588 (class 0 OID 0)
-- Dependencies: 232
-- Name: SEQUENCE pagos_id_pago_seq; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE proyectos.pagos_id_pago_seq TO adminconsulta;
GRANT ALL ON SEQUENCE proyectos.pagos_id_pago_seq TO adminedita;


--
-- TOC entry 4589 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE proveedores; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT ON TABLE proyectos.proveedores TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE proyectos.proveedores TO adminedita;


--
-- TOC entry 4591 (class 0 OID 0)
-- Dependencies: 234
-- Name: SEQUENCE proveedores_id_proveedor_seq; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE proyectos.proveedores_id_proveedor_seq TO adminconsulta;
GRANT ALL ON SEQUENCE proyectos.proveedores_id_proveedor_seq TO adminedita;


--
-- TOC entry 4592 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE proyectos; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT ON TABLE proyectos.proyectos TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE proyectos.proyectos TO adminedita;


--
-- TOC entry 4594 (class 0 OID 0)
-- Dependencies: 236
-- Name: SEQUENCE proyectos_proyecto_id_seq; Type: ACL; Schema: proyectos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE proyectos.proyectos_proyecto_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE proyectos.proyectos_proyecto_id_seq TO adminedita;


--
-- TOC entry 4595 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE areas; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.areas TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.areas TO adminedita;


--
-- TOC entry 4597 (class 0 OID 0)
-- Dependencies: 238
-- Name: SEQUENCE areas_area_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.areas_area_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.areas_area_id_seq TO adminedita;


--
-- TOC entry 4598 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE auth_group; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.auth_group TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.auth_group TO adminedita;


--
-- TOC entry 4599 (class 0 OID 0)
-- Dependencies: 240
-- Name: SEQUENCE auth_group_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.auth_group_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.auth_group_id_seq TO adminedita;


--
-- TOC entry 4600 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE auth_group_permissions; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.auth_group_permissions TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.auth_group_permissions TO adminedita;


--
-- TOC entry 4601 (class 0 OID 0)
-- Dependencies: 242
-- Name: SEQUENCE auth_group_permissions_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.auth_group_permissions_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.auth_group_permissions_id_seq TO adminedita;


--
-- TOC entry 4602 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE auth_permission; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.auth_permission TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.auth_permission TO adminedita;


--
-- TOC entry 4603 (class 0 OID 0)
-- Dependencies: 244
-- Name: SEQUENCE auth_permission_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.auth_permission_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.auth_permission_id_seq TO adminedita;


--
-- TOC entry 4604 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE auth_user; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.auth_user TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.auth_user TO adminedita;


--
-- TOC entry 4605 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE auth_user_groups; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.auth_user_groups TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.auth_user_groups TO adminedita;


--
-- TOC entry 4606 (class 0 OID 0)
-- Dependencies: 247
-- Name: SEQUENCE auth_user_groups_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.auth_user_groups_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.auth_user_groups_id_seq TO adminedita;


--
-- TOC entry 4607 (class 0 OID 0)
-- Dependencies: 248
-- Name: SEQUENCE auth_user_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.auth_user_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.auth_user_id_seq TO adminedita;


--
-- TOC entry 4608 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE auth_user_user_permissions; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.auth_user_user_permissions TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.auth_user_user_permissions TO adminedita;


--
-- TOC entry 4609 (class 0 OID 0)
-- Dependencies: 250
-- Name: SEQUENCE auth_user_user_permissions_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.auth_user_user_permissions_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.auth_user_user_permissions_id_seq TO adminedita;


--
-- TOC entry 4610 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE django_admin_log; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.django_admin_log TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.django_admin_log TO adminedita;


--
-- TOC entry 4611 (class 0 OID 0)
-- Dependencies: 252
-- Name: SEQUENCE django_admin_log_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.django_admin_log_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.django_admin_log_id_seq TO adminedita;


--
-- TOC entry 4612 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE django_content_type; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.django_content_type TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.django_content_type TO adminedita;


--
-- TOC entry 4613 (class 0 OID 0)
-- Dependencies: 254
-- Name: SEQUENCE django_content_type_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.django_content_type_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.django_content_type_id_seq TO adminedita;


--
-- TOC entry 4614 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE django_migrations; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.django_migrations TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.django_migrations TO adminedita;


--
-- TOC entry 4615 (class 0 OID 0)
-- Dependencies: 256
-- Name: SEQUENCE django_migrations_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.django_migrations_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.django_migrations_id_seq TO adminedita;


--
-- TOC entry 4616 (class 0 OID 0)
-- Dependencies: 257
-- Name: TABLE empleados; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.empleados TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.empleados TO adminedita;


--
-- TOC entry 4618 (class 0 OID 0)
-- Dependencies: 258
-- Name: SEQUENCE empleados_id_empleado_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.empleados_id_empleado_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.empleados_id_empleado_seq TO adminedita;


--
-- TOC entry 4619 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE oficina; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.oficina TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.oficina TO adminedita;


--
-- TOC entry 4621 (class 0 OID 0)
-- Dependencies: 269
-- Name: SEQUENCE oficina_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.oficina_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.oficina_id_seq TO adminedita;


--
-- TOC entry 4622 (class 0 OID 0)
-- Dependencies: 259
-- Name: TABLE roles; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.roles TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.roles TO adminedita;


--
-- TOC entry 4624 (class 0 OID 0)
-- Dependencies: 260
-- Name: SEQUENCE roles_id_rol_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.roles_id_rol_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.roles_id_rol_seq TO adminedita;


--
-- TOC entry 4625 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE solicitudes_permiso; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.solicitudes_permiso TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.solicitudes_permiso TO adminedita;


--
-- TOC entry 4626 (class 0 OID 0)
-- Dependencies: 262
-- Name: SEQUENCE solicitudes_permiso_permiso_id_seq; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE recursos_humanos.solicitudes_permiso_permiso_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE recursos_humanos.solicitudes_permiso_permiso_id_seq TO adminedita;


--
-- TOC entry 4627 (class 0 OID 0)
-- Dependencies: 265
-- Name: TABLE asignaciones_tareas; Type: ACL; Schema: tareas; Owner: postgres
--

GRANT SELECT ON TABLE tareas.asignaciones_tareas TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tareas.asignaciones_tareas TO adminedita;


--
-- TOC entry 4628 (class 0 OID 0)
-- Dependencies: 267
-- Name: TABLE tareas; Type: ACL; Schema: tareas; Owner: postgres
--

GRANT SELECT ON TABLE tareas.tareas TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tareas.tareas TO adminedita;


--
-- TOC entry 4629 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE vista_empleados_tareas; Type: ACL; Schema: recursos_humanos; Owner: postgres
--

GRANT SELECT ON TABLE recursos_humanos.vista_empleados_tareas TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE recursos_humanos.vista_empleados_tareas TO adminedita;


--
-- TOC entry 4630 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE asistencias; Type: ACL; Schema: sistemas; Owner: postgres
--

GRANT SELECT ON TABLE sistemas.asistencias TO adminconsulta;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE sistemas.asistencias TO adminedita;


--
-- TOC entry 4632 (class 0 OID 0)
-- Dependencies: 264
-- Name: SEQUENCE asistencias_asistencia_id_seq; Type: ACL; Schema: sistemas; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE sistemas.asistencias_asistencia_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE sistemas.asistencias_asistencia_id_seq TO adminedita;


--
-- TOC entry 4634 (class 0 OID 0)
-- Dependencies: 266
-- Name: SEQUENCE asignaciones_tareas_asignacion_id_seq; Type: ACL; Schema: tareas; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tareas.asignaciones_tareas_asignacion_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE tareas.asignaciones_tareas_asignacion_id_seq TO adminedita;


--
-- TOC entry 4636 (class 0 OID 0)
-- Dependencies: 268
-- Name: SEQUENCE tareas_tarea_id_seq; Type: ACL; Schema: tareas; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE tareas.tareas_tarea_id_seq TO adminconsulta;
GRANT ALL ON SEQUENCE tareas.tareas_tarea_id_seq TO adminedita;


-- Completed on 2024-12-17 22:47:44 -05

--
-- PostgreSQL database dump complete
--

