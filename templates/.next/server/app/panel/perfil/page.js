(()=>{var e={};e.id=402,e.ids=[402],e.modules={10846:e=>{"use strict";e.exports=require("next/dist/compiled/next-server/app-page.runtime.prod.js")},19121:e=>{"use strict";e.exports=require("next/dist/server/app-render/action-async-storage.external.js")},29294:e=>{"use strict";e.exports=require("next/dist/server/app-render/work-async-storage.external.js")},63033:e=>{"use strict";e.exports=require("next/dist/server/app-render/work-unit-async-storage.external.js")},33873:e=>{"use strict";e.exports=require("path")},77497:(e,t,r)=>{"use strict";r.r(t),r.d(t,{GlobalError:()=>n.a,__next_app__:()=>p,pages:()=>c,routeModule:()=>u,tree:()=>d});var s=r(70260),a=r(28203),l=r(25155),n=r.n(l),o=r(67292),i={};for(let e in o)0>["default","tree","pages","GlobalError","__next_app__","routeModule"].indexOf(e)&&(i[e]=()=>o[e]);r.d(t,i);let d=["",{children:["panel",{children:["perfil",{children:["__PAGE__",{},{page:[()=>Promise.resolve().then(r.bind(r,67995)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\perfil\\page.jsx"]}]},{}]},{layout:[()=>Promise.resolve().then(r.bind(r,54045)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\layout.jsx"]}]},{layout:[()=>Promise.resolve().then(r.bind(r,98180)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\layout.jsx"],"not-found":[()=>Promise.resolve().then(r.t.bind(r,19937,23)),"next/dist/client/components/not-found-error"]}],c=["C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\perfil\\page.jsx"],p={require:r,loadChunk:()=>Promise.resolve()},u=new s.AppPageRouteModule({definition:{kind:a.RouteKind.APP_PAGE,page:"/panel/perfil/page",pathname:"/panel/perfil",bundlePath:"",filename:"",appPaths:[]},userland:{loaderTree:d}})},48663:(e,t,r)=>{Promise.resolve().then(r.bind(r,83841))},85455:(e,t,r)=>{Promise.resolve().then(r.bind(r,25261))},25261:(e,t,r)=>{"use strict";r.d(t,{default:()=>i});var s=r(45512),a=r(58009),l=r(64014),n=r(27582);let o=({label:e,value:t})=>(0,s.jsxs)("div",{className:"flex justify-between items-center",children:[(0,s.jsxs)("span",{className:"text-gray-400 font-medium",children:[e,":"]}),(0,s.jsx)("span",{className:"text-gray-100 font-semibold",children:t||"No disponible"})]}),i=()=>{let{usuarioLogeado:e}=(0,l.A)(),[t,r]=(0,a.useState)(!1),[i,d]=(0,a.useState)(""),[c,p]=(0,a.useState)(""),[u,m]=(0,a.useState)(""),[x,h]=(0,a.useState)(""),b=async()=>{try{await (0,n.Vp)(i,c),h("Contrase\xf1a cambiada exitosamente"),m(""),r(!1)}catch(e){m("Error al cambiar la contrase\xf1a"),h("")}};return e?(0,s.jsx)("div",{className:"p-6 bg-gray-100 h-[100%]",children:(0,s.jsxs)("div",{className:"bg-gray-900 p-6 rounded-lg max-w-lg mx-auto h-[100%]",children:[(0,s.jsx)("h2",{className:"text-3xl font-semibold text-gray-100 mb-6 text-center",children:"Perfil del Usuario"}),(0,s.jsxs)("div",{className:"flex flex-col items-center space-y-6 mb-8",children:[(0,s.jsx)("div",{className:"w-28 h-28 rounded-full bg-gradient-to-br from-blue-400 to-purple-500 shadow-lg flex items-center justify-center text-white text-3xl font-bold",children:((e,t)=>{let r=e?e.charAt(0).toUpperCase():"",s=t?t.charAt(0).toUpperCase():"";return`${r}${s}`})(e.nombre,e.apellidos)}),(0,s.jsx)("div",{className:"text-center",children:(0,s.jsxs)("h3",{className:"text-2xl font-bold text-gray-100",children:[e.nombre," ",e.apellidos]})})]}),(0,s.jsxs)("div",{className:"space-y-5",children:[(0,s.jsx)(o,{label:"Correo",value:e.correo}),(0,s.jsx)(o,{label:"Especialidad",value:e.especialidad}),(0,s.jsx)(o,{label:"Sueldo",value:e.sueldo}),(0,s.jsx)(o,{label:"Fecha de Contrataci\xf3n",value:e.fecha_contratacion}),(0,s.jsx)(o,{label:"\xc1rea",value:e.area?.nombre})]}),(0,s.jsx)("button",{onClick:()=>r(!0),className:"mt-6 w-full bg-blue-600 text-white p-3 rounded-lg shadow-md hover:bg-blue-700 transition",children:"Cambiar Contrase\xf1a"}),t&&(0,s.jsx)("div",{className:"fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center",children:(0,s.jsxs)("div",{className:"bg-white p-6 rounded-lg shadow-lg max-w-md w-full",children:[(0,s.jsx)("h3",{className:"text-xl font-semibold mb-4",children:"Cambiar Contrase\xf1a"}),u&&(0,s.jsx)("p",{className:"text-red-500 mb-4",children:u}),x&&(0,s.jsx)("p",{className:"text-green-500 mb-4",children:x}),(0,s.jsx)("input",{type:"password",placeholder:"Contrase\xf1a Antigua",value:i,onChange:e=>d(e.target.value),className:"w-full p-2 mb-4 border rounded"}),(0,s.jsx)("input",{type:"password",placeholder:"Contrase\xf1a Nueva",value:c,onChange:e=>p(e.target.value),className:"w-full p-2 mb-4 border rounded"}),(0,s.jsxs)("div",{className:"flex justify-end space-x-4",children:[(0,s.jsx)("button",{onClick:()=>r(!1),className:"bg-gray-500 text-white p-2 rounded hover:bg-gray-600 transition",children:"Cancelar"}),(0,s.jsx)("button",{onClick:b,className:"bg-blue-600 text-white p-2 rounded hover:bg-blue-700 transition",children:"Cambiar"})]})]})})]})}):(0,s.jsx)("div",{className:"flex justify-center items-center h-64",children:(0,s.jsx)("p",{className:"text-center text-gray-600",children:"No hay usuario logeado."})})}},67995:(e,t,r)=>{"use strict";r.r(t),r.d(t,{default:()=>l});var s=r(62740),a=r(83841);r(76301);let l=()=>(0,s.jsx)(a.default,{})},83841:(e,t,r)=>{"use strict";r.d(t,{default:()=>s});let s=(0,r(46760).registerClientReference)(function(){throw Error("Attempted to call the default export of \"C:\\\\Users\\\\Usuario\\\\Desktop\\\\dev\\\\tecom_admin_front\\\\src\\\\components\\\\perfil.jsx\" from the server, but it's on the client. It's not possible to invoke a client function from the server, it can only be rendered as a Component or passed to props of a Client Component.")},"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\components\\perfil.jsx","default")}};var t=require("../../../webpack-runtime.js");t.C(e);var r=e=>t(t.s=e),s=t.X(0,[112,175,900,264,473],()=>r(77497));module.exports=s})();