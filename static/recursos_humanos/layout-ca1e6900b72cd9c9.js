(self.webpackChunk_N_E = self.webpackChunk_N_E || []).push([
  [60],
  {
    81279: (e, s, r) => {
      Promise.resolve().then(r.bind(r, 22459));
    },
    22459: (e, s, r) => {
      "use strict";
      r.r(s), r.d(s, { default: () => x });
      var a = r(95155),
        l = r(12115),
        d = r(67396),
        n = r(76046),
        o = r(11536),
        i = r(57798),
        t = r(41938);
      let c = (e) => {
          let { isMenuOpen: s, toggleMenu: r } = e,
            c = (0, n.useRouter)(),
            { usuarioLogeado: h, setUsuarioLogeado: m } = (0, t.A)(),
            [x, b] = (0, l.useState)(!1);
          (0, l.useEffect)(() => {
            let e = JSON.parse(localStorage.getItem("usuarioLogeado"));
            e && m(e);
          }, [m]);
          let u = async () => {
            try {
              await (0, i.KX)(),
                localStorage.removeItem("usuarioLogeado"),
                m(null),
                c.push("/");
            } catch (e) {
              console.error("Error al cerrar sesi\xf3n:", e);
            }
          };
          return (0, a.jsxs)("aside", {
            className:
              "bg-black shadow-lg fixed top-0 left-0 h-full flex flex-col justify-between transition-all duration-300 ".concat(
                s ? "w-72" : "w-0"
              ),
            children: [
              (0, a.jsxs)("div", {
                className: "flex justify-between items-center p-4 mr-9",
                children: [
                  s &&
                    (0, a.jsx)("div", {
                      className: "hidden md:block p-4",
                      children: (0, a.jsx)("h1", {
                        className: "text-2xl font-bold text-white",
                        children: "TECOM ADMINISTRADOR",
                      }),
                    }),
                  (0, a.jsx)("button", {
                    onClick: r,
                    className: "text-".concat(s ? "white" : "black"),
                    children: (0, a.jsx)(o.OXb, {}),
                  }),
                ],
              }),
              (0, a.jsx)("div", {
                className:
                  "overflow-y-auto scrollbar-thin scrollbar-thumb-blue-500 scrollbar-track-black h-full",
                children: (0, a.jsx)("nav", {
                  className: "p-4",
                  children: (0, a.jsxs)("ul", {
                    className: "space-y-4",
                    children: [
                      (0, a.jsx)("li", {
                        className: "border-b border-gray-700",
                        children: (0, a.jsxs)(d.default, {
                          href: "/panel",
                          className:
                            "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition",
                          children: [
                            (0, a.jsx)(o.rQ8, { className: "mr-2" }),
                            (0, a.jsx)("span", {
                              className: "hidden md:inline",
                              children: "Panel",
                            }),
                          ],
                        }),
                      }),
                      h &&
                        1 === h.rol &&
                        (0, a.jsx)("li", {
                          className: "border-b border-gray-700",
                          children: (0, a.jsxs)(d.default, {
                            href: "/panel/dashboard",
                            className:
                              "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition",
                            children: [
                              (0, a.jsx)(o.x7F, { className: "mr-2" }),
                              (0, a.jsx)("span", {
                                className: "hidden md:inline",
                                children: "Dashboard",
                              }),
                            ],
                          }),
                        }),
                      (0, a.jsx)("li", {
                        className: "border-b border-gray-700",
                        children: (0, a.jsxs)(d.default, {
                          href: "/panel/perfil",
                          className:
                            "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition",
                          children: [
                            (0, a.jsx)(o.NBi, { className: "mr-2" }),
                            (0, a.jsx)("span", {
                              className: "hidden md:inline",
                              children: "Perfil",
                            }),
                          ],
                        }),
                      }),
                      h &&
                        1 === h.rol &&
                        (0, a.jsx)("li", {
                          className: "border-b border-gray-700",
                          children: (0, a.jsxs)(d.default, {
                            href: "/panel/areas",
                            className:
                              "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition",
                            children: [
                              (0, a.jsx)(o.ZYm, { className: "mr-2" }),
                              (0, a.jsx)("span", {
                                className: "hidden md:inline",
                                children: "\xc1reas",
                              }),
                            ],
                          }),
                        }),
                      (0, a.jsx)("li", {
                        className: "border-b border-gray-700",
                        children: (0, a.jsxs)(d.default, {
                          href: "/panel/tareas",
                          className:
                            "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition",
                          children: [
                            (0, a.jsx)(o.kkc, { className: "mr-2" }),
                            (0, a.jsx)("span", {
                              className: "hidden md:inline",
                              children: "Tareas",
                            }),
                          ],
                        }),
                      }),
                      h &&
                        1 === h.rol &&
                        (0, a.jsx)("li", {
                          className: "border-b border-gray-700",
                          children: (0, a.jsxs)(d.default, {
                            href: "/panel/usuarios",
                            className:
                              "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition",
                            children: [
                              (0, a.jsx)(o.vWM, { className: "mr-2" }),
                              (0, a.jsx)("span", {
                                className: "hidden md:inline",
                                children: "Empleados",
                              }),
                            ],
                          }),
                        }),
                      (0, a.jsx)("li", {
                        className: "border-b border-gray-700",
                        children: (0, a.jsxs)(d.default, {
                          href: "/panel/desempenio",
                          className:
                            "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition",
                          children: [
                            (0, a.jsx)(o.v$b, { className: "mr-2" }),
                            (0, a.jsx)("span", {
                              className: "hidden md:inline",
                              children: "Desempe\xf1o",
                            }),
                          ],
                        }),
                      }),
                      (0, a.jsx)("li", {
                        className: "border-b border-gray-700",
                        children: (0, a.jsxs)(d.default, {
                          href: "/panel/asistencias",
                          className:
                            "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition",
                          children: [
                            (0, a.jsx)(o.gUT, { className: "mr-2" }),
                            (0, a.jsx)("span", {
                              className: "hidden md:inline",
                              children: "Calendario",
                            }),
                          ],
                        }),
                      }),
                      h &&
                        (1 === h.rol || 6 === h.rol) &&
                        (0, a.jsx)("li", {
                          className: "border-b border-gray-700",
                          children: (0, a.jsxs)(d.default, {
                            href: "/panel/notificaciones",
                            className:
                              "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition",
                            children: [
                              (0, a.jsx)(o.jNV, { className: "mr-2" }),
                              (0, a.jsx)("span", {
                                className: "hidden md:inline",
                                children: "Notificaciones",
                              }),
                            ],
                          }),
                        }),
                      h &&
                        1 === h.rol &&
                        (0, a.jsxs)("li", {
                          className: "border-b border-gray-700",
                          children: [
                            (0, a.jsxs)("div", {
                              onClick: () => {
                                b(!x);
                              },
                              className:
                                "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition cursor-pointer",
                              children: [
                                (0, a.jsx)(o.yd7, { className: "mr-2" }),
                                (0, a.jsx)("span", {
                                  className: "hidden md:inline",
                                  children: "Proyectos",
                                }),
                                (0, a.jsx)(o.Vr3, { className: "ml-2" }),
                              ],
                            }),
                            x &&
                              (0, a.jsxs)("ul", {
                                className: "ml-4 mt-2 space-y-2",
                                children: [
                                  (0, a.jsx)("li", {
                                    className: "border-b border-gray-700",
                                    children: (0, a.jsx)(d.default, {
                                      href: "/panel/proyectos",
                                      className:
                                        "flex items-center p-2 rounded-lg text-white hover:bg-blue-600 transition",
                                      children: "Dashboard",
                                    }),
                                  }),
                                  (0, a.jsx)("li", {
                                    className: "border-b border-gray-700",
                                    children: (0, a.jsx)(d.default, {
                                      href: "/panel/proyectos/proyecto",
                                      className:
                                        "flex items-center p-2 rounded-lg text-white hover:bg-blue-600 transition",
                                      children: "Proyecto",
                                    }),
                                  }),
                                  (0, a.jsx)("li", {
                                    className: "border-b border-gray-700",
                                    children: (0, a.jsx)(d.default, {
                                      href: "/panel/proyectos/facturas",
                                      className:
                                        "flex items-center p-2 rounded-lg text-white hover:bg-blue-600 transition",
                                      children: "Facturas",
                                    }),
                                  }),
                                  (0, a.jsx)("li", {
                                    className: "border-b border-gray-700",
                                    children: (0, a.jsx)(d.default, {
                                      href: "/panel/proyectos/ordenesCompra",
                                      className:
                                        "flex items-center p-2 rounded-lg text-white hover:bg-blue-600 transition",
                                      children: "\xd3rdenes de Compra",
                                    }),
                                  }),
                                  (0, a.jsx)("li", {
                                    className: "border-b border-gray-700",
                                    children: (0, a.jsx)(d.default, {
                                      href: "/panel/proyectos/costos",
                                      className:
                                        "flex items-center p-2 rounded-lg text-white hover:bg-blue-600 transition",
                                      children: "Costos",
                                    }),
                                  }),
                                  (0, a.jsx)("li", {
                                    className: "border-b border-gray-700",
                                    children: (0, a.jsx)(d.default, {
                                      href: "/panel/proyectos/pagos",
                                      className:
                                        "flex items-center p-2 rounded-lg text-white hover:bg-blue-600 transition",
                                      children: "Pagos",
                                    }),
                                  }),
                                ],
                              }),
                          ],
                        }),
                      h &&
                        1 === h.rol &&
                        (0, a.jsx)("li", {
                          className: "border-b border-gray-700",
                          children: (0, a.jsxs)(d.default, {
                            href: "/panel/roles",
                            className:
                              "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition",
                            children: [
                              (0, a.jsx)(o.e7y, { className: "mr-2" }),
                              (0, a.jsx)("span", {
                                className: "hidden md:inline",
                                children: "Roles",
                              }),
                            ],
                          }),
                        }),
                    ],
                  }),
                }),
              }),
              (0, a.jsx)("div", {
                className: "p-4",
                children: (0, a.jsxs)("button", {
                  onClick: u,
                  className:
                    "flex items-center p-3 rounded-lg shadow-md text-white hover:bg-blue-600 hover:shadow-lg transition w-full",
                  children: [
                    (0, a.jsx)(o.axc, { className: "mr-2" }),
                    (0, a.jsx)("span", {
                      className: "hidden md:inline",
                      children: "Cerrar Sesi\xf3n",
                    }),
                  ],
                }),
              }),
            ],
          });
        },
        h = (e) => {
          let { children: s } = e,
            r = (0, n.useRouter)(),
            a = localStorage.getItem("accessToken");
          return ((0, l.useEffect)(() => {
            a || r.push("/");
          }, [a, r]),
          a)
            ? s
            : null;
        };
      var m = r(91068);
      r(85716);
      let x = (e) => {
        let { children: s } = e,
          [r, d] = (0, l.useState)(!1),
          [n, i] = (0, l.useState)(!0);
        (0, l.useEffect)(() => {
          d(!0);
        }, []);
        let t = () => {
          i(!n);
        };
        return r
          ? (0, a.jsx)(h, {
              children: (0, a.jsxs)("div", {
                className: "flex bg-primary",
                children: [
                  (0, a.jsx)(c, { isMenuOpen: n, toggleMenu: t }),
                  (0, a.jsxs)("main", {
                    className: "flex-1 ".concat(
                      n ? "ml-72" : "ml-0",
                      " h-screen overflow-y-auto bg-gray-100 transition-all duration-300"
                    ),
                    children: [
                      (0, a.jsx)("button", {
                        onClick: t,
                        className:
                          "text-black p-4 md:hidden fixed top-0 left-0",
                        children: (0, a.jsx)(o.OXb, {}),
                      }),
                      s,
                      (0, a.jsx)(m.N9, {}),
                    ],
                  }),
                ],
              }),
            })
          : null;
      };
    },
    41938: (e, s, r) => {
      "use strict";
      r.d(s, { A: () => a });
      let a = (0, r(99827).v)((e) => ({
        usuarioLogeado: {
          id_empleado: null,
          nombre: "",
          apellidos: "",
          correo: "",
          especialidad: "",
          sueldo: "",
          activo: !1,
          foto: "",
          nombre_usuario: "",
          fecha_contratacion: "",
          area: null,
          rol: null,
        },
        empleados: [],
        tareas: [],
        asignacionesTareas: [],
        proyectos: [],
        notificaciones: [],
        setUsuarioLogeado: (s) => e({ usuarioLogeado: s }),
        setEmpleados: (s) => e({ empleados: s }),
        setTareas: (s) => e({ tareas: s }),
        setAsignacionesTareas: (s) => e({ asignacionesTareas: s }),
        setProyectos: (s) => e({ proyectos: s }),
        setNotificaciones: (s) => e({ notificaciones: s }),
      }));
    },
  },
  (e) => {
    var s = (s) => e((e.s = s));
    e.O(0, [797, 711, 466, 368, 798, 441, 517, 358], () => s(81279)),
      (_N_E = e.O());
  },
]);
