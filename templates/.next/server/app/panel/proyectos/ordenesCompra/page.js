(()=>{var e={};e.id=137,e.ids=[137],e.modules={10846:e=>{"use strict";e.exports=require("next/dist/compiled/next-server/app-page.runtime.prod.js")},19121:e=>{"use strict";e.exports=require("next/dist/server/app-render/action-async-storage.external.js")},29294:e=>{"use strict";e.exports=require("next/dist/server/app-render/work-async-storage.external.js")},63033:e=>{"use strict";e.exports=require("next/dist/server/app-render/work-unit-async-storage.external.js")},33873:e=>{"use strict";e.exports=require("path")},48611:(e,r,t)=>{"use strict";t.r(r),t.d(r,{GlobalError:()=>n.a,__next_app__:()=>x,pages:()=>c,routeModule:()=>m,tree:()=>i});var s=t(70260),a=t(28203),o=t(25155),n=t.n(o),d=t(67292),l={};for(let e in d)0>["default","tree","pages","GlobalError","__next_app__","routeModule"].indexOf(e)&&(l[e]=()=>d[e]);t.d(r,l);let i=["",{children:["panel",{children:["proyectos",{children:["ordenesCompra",{children:["__PAGE__",{},{page:[()=>Promise.resolve().then(t.bind(t,42044)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\proyectos\\ordenesCompra\\page.jsx"]}]},{}]},{}]},{layout:[()=>Promise.resolve().then(t.bind(t,54045)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\layout.jsx"]}]},{layout:[()=>Promise.resolve().then(t.bind(t,98180)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\layout.jsx"],"not-found":[()=>Promise.resolve().then(t.t.bind(t,19937,23)),"next/dist/client/components/not-found-error"]}],c=["C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\proyectos\\ordenesCompra\\page.jsx"],x={require:t,loadChunk:()=>Promise.resolve()},m=new s.AppPageRouteModule({definition:{kind:a.RouteKind.APP_PAGE,page:"/panel/proyectos/ordenesCompra/page",pathname:"/panel/proyectos/ordenesCompra",bundlePath:"",filename:"",appPaths:[]},userland:{loaderTree:i}})},6953:(e,r,t)=>{Promise.resolve().then(t.bind(t,60847))},72105:(e,r,t)=>{Promise.resolve().then(t.bind(t,83059))},83059:(e,r,t)=>{"use strict";t.d(r,{default:()=>d});var s=t(45512),a=t(27582),o=t(58009),n=t(44098);let d=()=>{let[e,r]=(0,o.useState)([]),[t,d]=(0,o.useState)(!1),[l,i]=(0,o.useState)({monto:"",fecha:"",estado:"Pendiente",id_proyecto:"",id_proveedor:""}),[c,x]=(0,o.useState)(null),[m,p]=(0,o.useState)(!1),[u,h]=(0,o.useState)("");(0,o.useEffect)(()=>{(async()=>{try{let e=await (0,a.$G)();Array.isArray(e)&&r(e)}catch(e){console.error("Error fetching data:",e)}})()},[]);let y=async e=>{if(confirm("\xbfEst\xe1s seguro de que deseas eliminar esta orden?"))try{await (0,a.Ad)(e);let t=await (0,a.$G)();Array.isArray(t)&&r(t),h("Orden eliminada exitosamente")}catch(e){console.error("Error al eliminar la orden:",e),h("Error al eliminar la orden")}},b=async()=>{try{await (0,a.i1)(l);let e=await (0,a.$G)();Array.isArray(e)&&r(e),d(!1),i({monto:"",fecha:"",estado:"Pendiente",id_proyecto:"",id_proveedor:""}),h("Orden agregada exitosamente")}catch(e){console.error("Error al agregar la orden:",e),h("Error al agregar la orden")}},g=async()=>{try{await (0,a.kI)(c.id_orden,c);let e=await (0,a.$G)();Array.isArray(e)&&r(e),d(!1),x(null),p(!1),h("Orden actualizada exitosamente")}catch(e){console.error("Error al actualizar la orden:",e),h("Error al actualizar la orden")}},f=e=>{x(e),p(!0),d(!0)};return(0,s.jsxs)("div",{className:"p-6 bg-white shadow-lg rounded-lg",children:[(0,s.jsx)("h2",{className:"text-2xl font-semibold mb-4 text-gray-800",children:"Gesti\xf3n de \xd3rdenes de Compra"}),(0,s.jsxs)("button",{className:"bg-green-600 text-white px-6 py-3 rounded-lg mb-6 flex items-center hover:bg-green-700 transition",onClick:()=>{i({monto:"",fecha:"",estado:"Pendiente",id_proyecto:"",id_proveedor:""}),p(!1),d(!0)},children:[(0,s.jsx)(n.OiG,{className:"mr-3"}),"Agregar Orden"]}),u&&(0,s.jsx)("div",{className:"mb-6 p-4 bg-green-100 text-green-700 rounded-lg shadow-sm",children:u}),(0,s.jsxs)("table",{className:"table-auto w-full border border-gray-300 rounded-lg",children:[(0,s.jsx)("thead",{className:"bg-gray-100",children:(0,s.jsxs)("tr",{children:[(0,s.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"Monto"}),(0,s.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"Fecha"}),(0,s.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"Estado"}),(0,s.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"ID de Proyecto"}),(0,s.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"ID de Proveedor"}),(0,s.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"Acciones"})]})}),(0,s.jsx)("tbody",{children:Array.isArray(e)&&e.map(e=>(0,s.jsxs)("tr",{className:"hover:bg-gray-50 transition duration-200",children:[(0,s.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.monto}),(0,s.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.fecha}),(0,s.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.estado}),(0,s.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.id_proyecto}),(0,s.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.id_proveedor}),(0,s.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:(0,s.jsxs)("div",{className:"flex gap-3",children:[(0,s.jsx)("button",{className:"text-blue-600 hover:text-blue-800 transition",onClick:()=>f(e),children:(0,s.jsx)(n.uO9,{})}),(0,s.jsx)("button",{className:"text-red-600 hover:text-red-800 transition",onClick:()=>y(e.id_orden),children:(0,s.jsx)(n.qbC,{})})]})})]},e.id_orden))})]}),t&&(0,s.jsx)("div",{className:"fixed inset-0 bg-gray-600 bg-opacity-50 flex justify-center items-center",children:(0,s.jsxs)("div",{className:"bg-white p-8 rounded-lg shadow-xl w-3/4 md:w-1/3",children:[(0,s.jsxs)("div",{className:"flex justify-between items-center mb-6",children:[(0,s.jsx)("h2",{className:"text-2xl font-semibold text-gray-800",children:m?"Editar Orden":"Agregar Nueva Orden"}),(0,s.jsx)("button",{onClick:()=>d(!1),children:(0,s.jsx)(n.QCr,{className:"text-gray-600 hover:text-gray-800"})})]}),[{label:"Monto",value:m?c.monto:l.monto,key:"monto",type:"number"},{label:"Fecha",value:m?c.fecha:l.fecha,key:"fecha",type:"date"},{label:"ID de Proyecto",value:m?c.id_proyecto:l.id_proyecto,key:"id_proyecto",type:"number"},{label:"ID de Proveedor",value:m?c.id_proveedor:l.id_proveedor,key:"id_proveedor",type:"number"}].map(({label:e,value:r,key:t,type:a="text"})=>(0,s.jsxs)("div",{className:"mb-6",children:[(0,s.jsx)("label",{className:"block text-gray-700 text-sm font-medium mb-2",children:e}),(0,s.jsx)("input",{type:a,className:"shadow-sm border rounded w-full py-3 px-4 text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500",value:r,onChange:e=>{let r=m?{...c,[t]:e.target.value}:{...l,[t]:e.target.value};m?x(r):i(r)}})]},t)),(0,s.jsxs)("div",{className:"mb-6",children:[(0,s.jsx)("label",{className:"block text-gray-700 text-sm font-medium mb-2",children:"Estado"}),(0,s.jsxs)("select",{className:"shadow-sm border rounded w-full py-3 px-4 text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500",value:m?c.estado:l.estado,onChange:e=>{let r=m?{...c,estado:e.target.value}:{...l,estado:e.target.value};m?x(r):i(r)},children:[(0,s.jsx)("option",{value:"Pendiente",children:"Pendiente"}),(0,s.jsx)("option",{value:"Completado",children:"Completado"})]})]}),(0,s.jsxs)("div",{className:"flex justify-end",children:[(0,s.jsx)("button",{className:"bg-blue-600 text-white px-6 py-3 rounded-lg mr-3 hover:bg-blue-700 transition",onClick:m?g:b,children:m?"Actualizar":"Agregar"}),(0,s.jsx)("button",{className:"bg-gray-500 text-white px-6 py-3 rounded-lg hover:bg-gray-600 transition",onClick:()=>d(!1),children:"Cancelar"})]})]})})]})}},42044:(e,r,t)=>{"use strict";t.r(r),t.d(r,{default:()=>o});var s=t(62740),a=t(60847);t(76301);let o=()=>(0,s.jsx)(a.default,{})},60847:(e,r,t)=>{"use strict";t.d(r,{default:()=>s});let s=(0,t(46760).registerClientReference)(function(){throw Error("Attempted to call the default export of \"C:\\\\Users\\\\Usuario\\\\Desktop\\\\dev\\\\tecom_admin_front\\\\src\\\\components\\\\proyectos\\\\ordenes\\\\ordenesTable.jsx\" from the server, but it's on the client. It's not possible to invoke a client function from the server, it can only be rendered as a Component or passed to props of a Client Component.")},"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\components\\proyectos\\ordenes\\ordenesTable.jsx","default")}};var r=require("../../../../webpack-runtime.js");r.C(e);var t=e=>r(r.s=e),s=r.X(0,[112,175,900,264,473],()=>t(48611));module.exports=s})();