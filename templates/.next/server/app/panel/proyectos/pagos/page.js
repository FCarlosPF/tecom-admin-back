(()=>{var e={};e.id=773,e.ids=[773],e.modules={10846:e=>{"use strict";e.exports=require("next/dist/compiled/next-server/app-page.runtime.prod.js")},19121:e=>{"use strict";e.exports=require("next/dist/server/app-render/action-async-storage.external.js")},29294:e=>{"use strict";e.exports=require("next/dist/server/app-render/work-async-storage.external.js")},63033:e=>{"use strict";e.exports=require("next/dist/server/app-render/work-unit-async-storage.external.js")},33873:e=>{"use strict";e.exports=require("path")},37403:(e,t,a)=>{"use strict";a.r(t),a.d(t,{GlobalError:()=>n.a,__next_app__:()=>p,pages:()=>c,routeModule:()=>x,tree:()=>d});var r=a(70260),s=a(28203),o=a(25155),n=a.n(o),l=a(67292),i={};for(let e in l)0>["default","tree","pages","GlobalError","__next_app__","routeModule"].indexOf(e)&&(i[e]=()=>l[e]);a.d(t,i);let d=["",{children:["panel",{children:["proyectos",{children:["pagos",{children:["__PAGE__",{},{page:[()=>Promise.resolve().then(a.bind(a,3099)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\proyectos\\pagos\\page.jsx"]}]},{}]},{}]},{layout:[()=>Promise.resolve().then(a.bind(a,54045)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\layout.jsx"]}]},{layout:[()=>Promise.resolve().then(a.bind(a,98180)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\layout.jsx"],"not-found":[()=>Promise.resolve().then(a.t.bind(a,19937,23)),"next/dist/client/components/not-found-error"]}],c=["C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\proyectos\\pagos\\page.jsx"],p={require:a,loadChunk:()=>Promise.resolve()},x=new r.AppPageRouteModule({definition:{kind:s.RouteKind.APP_PAGE,page:"/panel/proyectos/pagos/page",pathname:"/panel/proyectos/pagos",bundlePath:"",filename:"",appPaths:[]},userland:{loaderTree:d}})},42521:(e,t,a)=>{Promise.resolve().then(a.bind(a,64627))},55673:(e,t,a)=>{Promise.resolve().then(a.bind(a,23767))},23767:(e,t,a)=>{"use strict";a.d(t,{default:()=>l});var r=a(45512),s=a(27582),o=a(58009),n=a(44098);let l=()=>{let[e,t]=(0,o.useState)([]),[a,l]=(0,o.useState)(!1),[i,d]=(0,o.useState)({monto:"",fecha_pago:"",metodo_pago:"Transferencia",id_factura:""}),[c,p]=(0,o.useState)(null),[x,m]=(0,o.useState)(!1),[u,g]=(0,o.useState)("");(0,o.useEffect)(()=>{(async()=>{try{let e=await (0,s.h3)();Array.isArray(e)&&t(e)}catch(e){console.error("Error fetching data:",e)}})()},[]);let h=async e=>{if(confirm("\xbfEst\xe1s seguro de que deseas eliminar este pago?"))try{await (0,s.Dk)(e);let a=await (0,s.h3)();Array.isArray(a)&&t(a),g("Pago eliminado exitosamente")}catch(e){console.error("Error al eliminar el pago:",e),g("Error al eliminar el pago")}},b=async()=>{try{await (0,s.HP)(i);let e=await (0,s.h3)();Array.isArray(e)&&t(e),l(!1),d({monto:"",fecha_pago:"",metodo_pago:"Transferencia",id_factura:""}),g("Pago agregado exitosamente")}catch(e){console.error("Error al agregar el pago:",e),g("Error al agregar el pago")}},f=async()=>{try{await (0,s.Xr)(c.id_pago,c);let e=await (0,s.h3)();Array.isArray(e)&&t(e),l(!1),p(null),m(!1),g("Pago actualizado exitosamente")}catch(e){console.error("Error al actualizar el pago:",e),g("Error al actualizar el pago")}},y=e=>{p(e),m(!0),l(!0)};return(0,r.jsxs)("div",{className:"p-6 bg-white shadow-lg rounded-lg",children:[(0,r.jsx)("h2",{className:"text-2xl font-semibold mb-4 text-gray-800",children:"Gesti\xf3n de Pagos"}),(0,r.jsxs)("button",{className:"bg-green-600 text-white px-6 py-3 rounded-lg mb-6 flex items-center hover:bg-green-700 transition",onClick:()=>{d({monto:"",fecha_pago:"",metodo_pago:"Transferencia",id_factura:""}),m(!1),l(!0)},children:[(0,r.jsx)(n.OiG,{className:"mr-3"}),"Agregar Pago"]}),u&&(0,r.jsx)("div",{className:"mb-6 p-4 bg-green-100 text-green-700 rounded-lg shadow-sm",children:u}),(0,r.jsxs)("table",{className:"table-auto w-full border border-gray-300 rounded-lg",children:[(0,r.jsx)("thead",{className:"bg-gray-100",children:(0,r.jsxs)("tr",{children:[(0,r.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"Monto"}),(0,r.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"Fecha de Pago"}),(0,r.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"M\xe9todo de Pago"}),(0,r.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"ID de Factura"}),(0,r.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"Acciones"})]})}),(0,r.jsx)("tbody",{children:Array.isArray(e)&&e.map(e=>(0,r.jsxs)("tr",{className:"hover:bg-gray-50 transition duration-200",children:[(0,r.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.monto}),(0,r.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.fecha_pago}),(0,r.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.metodo_pago}),(0,r.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.id_factura}),(0,r.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:(0,r.jsxs)("div",{className:"flex gap-3",children:[(0,r.jsx)("button",{className:"text-blue-600 hover:text-blue-800 transition",onClick:()=>y(e),children:(0,r.jsx)(n.uO9,{})}),(0,r.jsx)("button",{className:"text-red-600 hover:text-red-800 transition",onClick:()=>h(e.id_pago),children:(0,r.jsx)(n.qbC,{})})]})})]},e.id_pago))})]}),a&&(0,r.jsx)("div",{className:"fixed inset-0 bg-gray-600 bg-opacity-50 flex justify-center items-center",children:(0,r.jsxs)("div",{className:"bg-white p-8 rounded-lg shadow-xl w-3/4 md:w-1/3",children:[(0,r.jsxs)("div",{className:"flex justify-between items-center mb-6",children:[(0,r.jsx)("h2",{className:"text-2xl font-semibold text-gray-800",children:x?"Editar Pago":"Agregar Nuevo Pago"}),(0,r.jsx)("button",{onClick:()=>l(!1),children:(0,r.jsx)(n.QCr,{className:"text-gray-600 hover:text-gray-800"})})]}),[{label:"Monto",value:x?c.monto:i.monto,key:"monto",type:"number"},{label:"Fecha de Pago",value:x?c.fecha_pago:i.fecha_pago,key:"fecha_pago",type:"date"},{label:"ID de Factura",value:x?c.id_factura:i.id_factura,key:"id_factura",type:"number"}].map(({label:e,value:t,key:a,type:s="text"})=>(0,r.jsxs)("div",{className:"mb-6",children:[(0,r.jsx)("label",{className:"block text-gray-700 text-sm font-medium mb-2",children:e}),(0,r.jsx)("input",{type:s,className:"shadow-sm border rounded w-full py-3 px-4 text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500",value:t,onChange:e=>{let t=x?{...c,[a]:e.target.value}:{...i,[a]:e.target.value};x?p(t):d(t)}})]},a)),(0,r.jsxs)("div",{className:"mb-6",children:[(0,r.jsx)("label",{className:"block text-gray-700 text-sm font-medium mb-2",children:"M\xe9todo de Pago"}),(0,r.jsxs)("select",{className:"shadow-sm border rounded w-full py-3 px-4 text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500",value:x?c.metodo_pago:i.metodo_pago,onChange:e=>{let t=x?{...c,metodo_pago:e.target.value}:{...i,metodo_pago:e.target.value};x?p(t):d(t)},children:[(0,r.jsx)("option",{value:"Transferencia",children:"Transferencia"}),(0,r.jsx)("option",{value:"Efectivo",children:"Efectivo"}),(0,r.jsx)("option",{value:"Cheque",children:"Cheque"})]})]}),(0,r.jsxs)("div",{className:"flex justify-end",children:[(0,r.jsx)("button",{className:"bg-blue-600 text-white px-6 py-3 rounded-lg mr-3 hover:bg-blue-700 transition",onClick:x?f:b,children:x?"Actualizar":"Agregar"}),(0,r.jsx)("button",{className:"bg-gray-500 text-white px-6 py-3 rounded-lg hover:bg-gray-600 transition",onClick:()=>l(!1),children:"Cancelar"})]})]})})]})}},3099:(e,t,a)=>{"use strict";a.r(t),a.d(t,{default:()=>o});var r=a(62740),s=a(64627);a(76301);let o=()=>(0,r.jsx)(s.default,{})},64627:(e,t,a)=>{"use strict";a.d(t,{default:()=>r});let r=(0,a(46760).registerClientReference)(function(){throw Error("Attempted to call the default export of \"C:\\\\Users\\\\Usuario\\\\Desktop\\\\dev\\\\tecom_admin_front\\\\src\\\\components\\\\proyectos\\\\pagos\\\\pagosTable.jsx\" from the server, but it's on the client. It's not possible to invoke a client function from the server, it can only be rendered as a Component or passed to props of a Client Component.")},"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\components\\proyectos\\pagos\\pagosTable.jsx","default")}};var t=require("../../../../webpack-runtime.js");t.C(e);var a=e=>t(t.s=e),r=t.X(0,[112,175,900,264,473],()=>a(37403));module.exports=r})();