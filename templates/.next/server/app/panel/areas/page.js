(()=>{var e={};e.id=150,e.ids=[150],e.modules={10846:e=>{"use strict";e.exports=require("next/dist/compiled/next-server/app-page.runtime.prod.js")},19121:e=>{"use strict";e.exports=require("next/dist/server/app-render/action-async-storage.external.js")},29294:e=>{"use strict";e.exports=require("next/dist/server/app-render/work-async-storage.external.js")},63033:e=>{"use strict";e.exports=require("next/dist/server/app-render/work-unit-async-storage.external.js")},33873:e=>{"use strict";e.exports=require("path")},98405:(e,r,s)=>{"use strict";s.r(r),s.d(r,{GlobalError:()=>l.a,__next_app__:()=>u,pages:()=>c,routeModule:()=>p,tree:()=>d});var t=s(70260),a=s(28203),o=s(25155),l=s.n(o),n=s(67292),i={};for(let e in n)0>["default","tree","pages","GlobalError","__next_app__","routeModule"].indexOf(e)&&(i[e]=()=>n[e]);s.d(r,i);let d=["",{children:["panel",{children:["areas",{children:["__PAGE__",{},{page:[()=>Promise.resolve().then(s.bind(s,95047)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\areas\\page.jsx"]}]},{}]},{layout:[()=>Promise.resolve().then(s.bind(s,54045)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\layout.jsx"]}]},{layout:[()=>Promise.resolve().then(s.bind(s,98180)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\layout.jsx"],"not-found":[()=>Promise.resolve().then(s.t.bind(s,19937,23)),"next/dist/client/components/not-found-error"]}],c=["C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\areas\\page.jsx"],u={require:s,loadChunk:()=>Promise.resolve()},p=new t.AppPageRouteModule({definition:{kind:a.RouteKind.APP_PAGE,page:"/panel/areas/page",pathname:"/panel/areas",bundlePath:"",filename:"",appPaths:[]},userland:{loaderTree:d}})},93867:(e,r,s)=>{Promise.resolve().then(s.bind(s,47453))},69891:(e,r,s)=>{Promise.resolve().then(s.bind(s,19313))},19313:(e,r,s)=>{"use strict";s.d(r,{default:()=>d});var t=s(45512),a=s(58009),o=s(44098),l=s(64014),n=s(27582),i=s(44750);let d=()=>{let[e,r]=(0,a.useState)([]),[s,d]=(0,a.useState)(!0),[c,u]=(0,a.useState)(!1),[p,x]=(0,a.useState)({nombre:"",supervisor:""}),[m,h]=(0,a.useState)(null),[b,v]=(0,a.useState)(!1),{empleados:g}=(0,l.A)();(0,a.useEffect)(()=>{(async()=>{try{let e=await (0,n.j8)();r(e)}catch(e){console.error("Error al obtener las \xe1reas:",e)}finally{d(!1)}})()},[]);let f=async e=>{try{await (0,n.X6)(e),r(r=>r.filter(r=>r.area_id!==e)),i.oR.success("\xc1rea eliminada correctamente")}catch(e){console.error("Error al eliminar el \xe1rea:",e),i.oR.error("Error al eliminar el \xe1rea")}},j=async()=>{try{let e={...p,supervisor:p.supervisor||null};await (0,n.Xn)(e);let s=await (0,n.j8)();r(s),u(!1),x({nombre:"",supervisor:""}),i.oR.success("\xc1rea agregada exitosamente")}catch(e){console.error("Error al agregar el \xe1rea:",e),i.oR.error("Error al agregar el \xe1rea")}},y=async()=>{try{let e={...m,supervisor:m.supervisor?m.supervisor.id_empleado:null};await (0,n.BE)(e.area_id,e);let s=await (0,n.j8)();r(s),u(!1),h(null),v(!1),i.oR.success("\xc1rea actualizada exitosamente")}catch(e){console.error("Error al actualizar el \xe1rea:",e),i.oR.error("Error al actualizar el \xe1rea")}},_=e=>{h(e),v(!0),u(!0)};return s?(0,t.jsx)("div",{className:"flex justify-center items-center h-64",children:"Cargando..."}):(0,t.jsxs)("div",{className:"p-6 bg-gray-100 min-h-screen",children:[(0,t.jsxs)("div",{children:[(0,t.jsxs)("div",{className:"flex justify-between items-center mb-6",children:[(0,t.jsx)("h2",{className:"text-2xl font-semibold text-gray-800",children:"Gesti\xf3n de \xc1reas"}),(0,t.jsx)("button",{className:"p-2 bg-gray-800 text-white rounded-full shadow-lg flex items-center hover:shadow-xl transition",onClick:()=>{x({nombre:"",supervisor:""}),v(!1),u(!0)},children:(0,t.jsx)(o.OiG,{})})]}),(0,t.jsx)("div",{className:"bg-gray-900 p-6 rounded-lg",children:(0,t.jsxs)("table",{className:"w-full rounded-lg",children:[(0,t.jsx)("thead",{className:"bg-gray-800",children:(0,t.jsxs)("tr",{children:[(0,t.jsx)("th",{className:"px-4 py-3 text-left text-sm text-white font-bold",children:"Nombre"}),(0,t.jsx)("th",{className:"px-4 py-3 text-left text-sm text-white font-bold",children:"Supervisor"}),(0,t.jsx)("th",{className:"px-4 py-3 text-center text-sm text-white font-bold",children:"Acciones"})]})}),(0,t.jsx)("tbody",{children:e.map(e=>(0,t.jsxs)("tr",{className:"hover:bg-gray-700 transition",children:[(0,t.jsx)("td",{className:"px-4 py-3 text-sm text-gray-100",children:e.nombre}),(0,t.jsx)("td",{className:"px-4 py-3 text-sm text-gray-100",children:e.supervisor?`${e.supervisor.nombre} ${e.supervisor.apellidos}`:"Sin supervisor"}),(0,t.jsx)("td",{className:"px-4 py-3 text-sm text-gray-100 text-center",children:(0,t.jsxs)("div",{className:"flex justify-center gap-2",children:[(0,t.jsx)("button",{className:"text-blue-500 hover:text-blue-700 transition",onClick:()=>_(e),children:(0,t.jsx)(o.uO9,{})}),(0,t.jsx)("button",{className:"text-red-500 hover:text-red-700 transition",onClick:()=>f(e.area_id),children:(0,t.jsx)(o.qbC,{})})]})})]},e.area_id))})]})})]}),c&&(0,t.jsx)("div",{className:"fixed inset-0 bg-gray-700 bg-opacity-75 flex justify-center items-center z-50",children:(0,t.jsxs)("div",{className:"bg-white rounded-lg shadow-lg w-1/3 p-6 relative",children:[(0,t.jsx)("button",{className:"absolute top-4 right-4 text-gray-500 hover:text-gray-700",onClick:()=>u(!1),children:(0,t.jsx)(o.QCr,{})}),(0,t.jsx)("h2",{className:"text-xl font-bold mb-4",children:b?"Editar \xc1rea":"Agregar Nueva \xc1rea"}),(0,t.jsxs)("div",{className:"mb-4",children:[(0,t.jsx)("label",{className:"block text-gray-700 font-semibold mb-2",children:"Nombre"}),(0,t.jsx)("input",{type:"text",className:"w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:ring-blue-300",value:b?m.nombre:p.nombre,onChange:e=>b?h({...m,nombre:e.target.value}):x({...p,nombre:e.target.value})})]}),(0,t.jsxs)("div",{className:"mb-4",children:[(0,t.jsx)("label",{className:"block text-gray-700 font-semibold mb-2",children:"Supervisor"}),(0,t.jsxs)("select",{className:"w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:ring-blue-300",value:b?m.supervisor?.id_empleado||"":p.supervisor,onChange:e=>b?h({...m,supervisor:e.target.value?{id_empleado:e.target.value}:null}):x({...p,supervisor:e.target.value||null}),children:[(0,t.jsx)("option",{value:"",children:"Seleccione un supervisor"}),g.map(e=>(0,t.jsx)("option",{value:e.id_empleado,children:e.nombre},e.id_empleado))]})]}),(0,t.jsxs)("div",{className:"flex justify-end",children:[(0,t.jsx)("button",{className:"bg-blue-500 text-white px-4 py-2 rounded mr-2 hover:bg-blue-600 transition",onClick:b?y:j,children:b?"Actualizar":"Agregar"}),(0,t.jsx)("button",{className:"bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600 transition",onClick:()=>u(!1),children:"Cancelar"})]})]})})]})}},95047:(e,r,s)=>{"use strict";s.r(r),s.d(r,{default:()=>o});var t=s(62740),a=s(47453);s(76301);let o=()=>(0,t.jsx)(a.default,{})},47453:(e,r,s)=>{"use strict";s.d(r,{default:()=>t});let t=(0,s(46760).registerClientReference)(function(){throw Error("Attempted to call the default export of \"C:\\\\Users\\\\Usuario\\\\Desktop\\\\dev\\\\tecom_admin_front\\\\src\\\\components\\\\areas.jsx\" from the server, but it's on the client. It's not possible to invoke a client function from the server, it can only be rendered as a Component or passed to props of a Client Component.")},"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\components\\areas.jsx","default")}};var r=require("../../../webpack-runtime.js");r.C(e);var s=e=>r(r.s=e),t=r.X(0,[112,175,900,264,473],()=>s(98405));module.exports=t})();