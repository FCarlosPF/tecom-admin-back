(()=>{var e={};e.id=307,e.ids=[307],e.modules={10846:e=>{"use strict";e.exports=require("next/dist/compiled/next-server/app-page.runtime.prod.js")},19121:e=>{"use strict";e.exports=require("next/dist/server/app-render/action-async-storage.external.js")},29294:e=>{"use strict";e.exports=require("next/dist/server/app-render/work-async-storage.external.js")},63033:e=>{"use strict";e.exports=require("next/dist/server/app-render/work-unit-async-storage.external.js")},33873:e=>{"use strict";e.exports=require("path")},10583:(e,a,s)=>{"use strict";s.r(a),s.d(a,{GlobalError:()=>i.a,__next_app__:()=>m,pages:()=>c,routeModule:()=>x,tree:()=>d});var t=s(70260),r=s(28203),l=s(25155),i=s.n(l),o=s(67292),n={};for(let e in o)0>["default","tree","pages","GlobalError","__next_app__","routeModule"].indexOf(e)&&(n[e]=()=>o[e]);s.d(a,n);let d=["",{children:["panel",{children:["__PAGE__",{},{page:[()=>Promise.resolve().then(s.bind(s,65374)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\page.jsx"]}]},{layout:[()=>Promise.resolve().then(s.bind(s,54045)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\layout.jsx"]}]},{layout:[()=>Promise.resolve().then(s.bind(s,98180)),"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\layout.jsx"],"not-found":[()=>Promise.resolve().then(s.t.bind(s,19937,23)),"next/dist/client/components/not-found-error"]}],c=["C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\app\\panel\\page.jsx"],m={require:s,loadChunk:()=>Promise.resolve()},x=new t.AppPageRouteModule({definition:{kind:r.RouteKind.APP_PAGE,page:"/panel/page",pathname:"/panel",bundlePath:"",filename:"",appPaths:[]},userland:{loaderTree:d}})},34408:(e,a,s)=>{Promise.resolve().then(s.bind(s,66797))},97960:(e,a,s)=>{Promise.resolve().then(s.bind(s,84571))},84571:(e,a,s)=>{"use strict";s.d(a,{default:()=>x});var t=s(45512),r=s(58009),l=s(44098),i=s(64014),o=s(27582),n=s(31879);let d=({isOpen:e,onClose:a})=>{let[s,l]=(0,r.useState)([]),{usuarioLogeado:n}=(0,i.A)();return((0,r.useEffect)(()=>{e&&(async()=>{try{let e=await (0,o.X9)(n.id_empleado);l(e)}catch(e){console.error("Error al obtener las notificaciones:",e)}})()},[e,n?.id_empleado]),e)?(0,t.jsx)("div",{className:"fixed inset-0 bg-gray-800 bg-opacity-75 flex justify-end",onClick:e=>{e.target===e.currentTarget&&a()},children:(0,t.jsxs)("div",{className:"bg-white p-6 rounded-lg shadow-lg w-1/4 h-full overflow-y-auto relative",children:[(0,t.jsx)("button",{className:"absolute top-0 right-0 m-4 text-3xl",onClick:a,children:"\xd7"}),(0,t.jsx)("h2",{className:"text-2xl font-bold mb-4",children:"Notificaciones"}),(0,t.jsx)("div",{className:"space-y-4",children:s.map(e=>(0,t.jsxs)("div",{className:"bg-gray-100 p-4 rounded-lg shadow-md",children:[(0,t.jsx)("h3",{className:"text-lg font-semibold",children:e.titulo_notificacion}),(0,t.jsx)("p",{children:e.descripcion_notificacion}),(0,t.jsx)("p",{className:"text-sm text-gray-500",children:new Date(e.fecha_evento).toLocaleString()})]},e.id_notificacion))})]})}):null},c=({selectedTarea:e,asignadorNombres:a,empleadoNombres:s,closeModal:r,handleOutsideClick:i})=>e&&(0,t.jsx)("div",{id:"modal-overlay",className:"fixed inset-0 bg-black bg-opacity-50 flex justify-end items-start",onClick:i,children:(0,t.jsxs)("div",{className:"w-[25%] md:w-[30%] lg:w-[25%] h-full bg-white shadow-2xl rounded-l-lg p-6 relative z-50 overflow-y-auto",onClick:e=>e.stopPropagation(),children:[(0,t.jsx)("button",{className:"absolute top-4 right-4 text-gray-600 hover:text-red-500 text-3xl",onClick:r,children:"\xd7"}),(0,t.jsx)("h2",{className:"text-3xl font-bold mb-6 text-gray-800",children:e.titulo}),(0,t.jsx)("p",{className:"text-gray-600 mb-6 text-base leading-relaxed",children:e.descripcion}),(0,t.jsxs)("div",{className:"space-y-4",children:[(0,t.jsxs)("div",{className:"flex items-center text-base text-gray-600",children:[(0,t.jsx)(l.w_X,{className:"mr-2 text-blue-500"}),(0,t.jsx)("span",{className:"font-medium",children:"Fecha de inicio:"})," ",(0,t.jsx)("span",{className:"ml-1",children:(0,n.GP)(new Date(e.fecha_inicio),"dd/MM/yyyy HH:mm")})]}),(0,t.jsxs)("div",{className:"flex items-center text-base text-gray-600",children:[(0,t.jsx)(l.w_X,{className:"mr-2 text-blue-500"}),(0,t.jsx)("span",{className:"font-medium",children:"Fecha estimada de fin:"})," ",(0,t.jsx)("span",{className:"ml-1",children:(0,n.GP)(new Date(e.fecha_estimada_fin),"dd/MM/yyyy HH:mm")})]}),e.fecha_real_fin&&(0,t.jsxs)("div",{className:"flex items-center text-base text-gray-600",children:[(0,t.jsx)(l.w_X,{className:"mr-2 text-green-500"}),(0,t.jsx)("span",{className:"font-medium",children:"Fecha real de fin:"})," ",(0,t.jsx)("span",{className:"ml-1",children:(0,n.GP)(new Date(e.fecha_real_fin),"dd/MM/yyyy HH:mm")})]}),(0,t.jsxs)("div",{className:"flex items-center text-base text-gray-600",children:[(0,t.jsx)(l.wJQ,{className:"mr-2 text-yellow-500"}),(0,t.jsx)("span",{className:"font-medium",children:"Prioridad:"})," ",(0,t.jsx)("span",{className:"ml-1",children:e.prioridad})]}),(0,t.jsxs)("div",{className:"flex items-center text-base text-gray-600",children:[(0,t.jsx)(l.x$1,{className:"mr-2 text-purple-500"}),(0,t.jsx)("span",{className:"font-medium",children:"Asignador:"})," ",(0,t.jsx)("span",{className:"ml-1",children:a})]}),(0,t.jsxs)("div",{className:"flex items-center text-base text-gray-600",children:[(0,t.jsx)(l.x$1,{className:"mr-2 text-purple-500"}),(0,t.jsx)("span",{className:"font-medium",children:"Empleado:"})," ",(0,t.jsx)("span",{className:"ml-1",children:s})]}),(0,t.jsxs)("div",{className:"flex items-center text-base text-gray-600",children:[(0,t.jsx)(l.w_X,{className:"mr-2 text-teal-500"}),(0,t.jsx)("span",{className:"font-medium",children:"Tiempo restante:"})," ",(0,t.jsxs)("span",{className:"ml-1",children:[e.tiempo_restante.dias," d\xedas,"," ",e.tiempo_restante.horas," horas,"," ",e.tiempo_restante.minutos," minutos"]})]}),(0,t.jsxs)("div",{className:"flex items-center text-base text-gray-600",children:[(0,t.jsx)(l.w_X,{className:"mr-2 text-red-500"}),(0,t.jsx)("span",{className:"font-medium",children:"Tiempo pasado:"})," ",(0,t.jsxs)("span",{className:"ml-1",children:[e.tiempo_pasado.dias," d\xedas,"," ",e.tiempo_pasado.horas," horas,"," ",e.tiempo_pasado.minutos," minutos"]})]})]})]})}),m=({estados:e,tareasPorEstado:a,usuarioLogeado:s,tareas:r,handleCardClick:i,completarTarea:o,toggleExpand:d,expandedTareas:c})=>(0,t.jsx)("div",{className:"grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 h-full flex-grow",children:e.map(e=>(0,t.jsxs)("div",{className:"bg-gray-900 p-2 rounded-lg shadow-md flex flex-col h-full overflow-y-auto",children:[(0,t.jsx)("h2",{className:"text-lg font-semibold text-white mb-2",children:e}),(0,t.jsx)("div",{className:"flex flex-col space-y-2",children:a[e]&&a[e].length>0?a[e].filter(e=>s&&1==s.rol?!e.tarea_padre:!e.tarea.tarea_padre).map(e=>{let a=r.filter(a=>s&&1===s.rol?a.tarea_padre===e.tarea_id:a.tarea.tarea_padre===e.tarea.tarea_id),m=s&&1===s.rol?e:e.tarea;return(0,t.jsxs)("div",{className:"bg-gray-800 shadow-md rounded-lg overflow-hidden p-2 border-l-4 border-blue-500 cursor-pointer",children:[(0,t.jsxs)("div",{className:"flex justify-between items-center",onClick:()=>1===s.rol?i(e):i(e.tarea),children:[(0,t.jsxs)("div",{className:"flex-grow",children:[(0,t.jsx)("div",{className:"flex justify-between items-center mb-1",children:(0,t.jsx)("h2",{className:"text-base font-semibold text-white",children:m.titulo})}),(0,t.jsx)("p",{className:"text-sm text-gray-400 mb-1",children:m.descripcion}),(0,t.jsxs)("div",{className:"flex items-center text-sm text-gray-400 mb-1",children:[(0,t.jsx)(l.w_X,{className:"mr-1 text-blue-500"}),(0,t.jsx)("span",{className:"Completada"!==m.estado&&0===m.tiempo_restante.dias&&0===m.tiempo_restante.horas||"Completada"===m.estado&&new Date(m.fecha_real_fin)>new Date(m.fecha_estimada_fin)?"text-red-500":"",children:"Completada"===m.estado?`Completada el: ${(0,n.GP)(new Date(m.fecha_real_fin),"dd/MM/yyyy HH:mm")}`:0===m.tiempo_restante.dias&&0===m.tiempo_restante.horas?`Vencido: ${m.tiempo_pasado.dias} d\xedas y ${m.tiempo_pasado.horas} horas pasados`:`Tiempo restante: ${m.tiempo_restante.dias} d\xedas y ${m.tiempo_restante.horas} horas`})]}),(0,t.jsxs)("div",{className:"flex items-center text-sm text-gray-400 mb-1",children:[(0,t.jsx)(l.wJQ,{className:"mr-1 text-yellow-500"}),(0,t.jsx)("span",{children:m.prioridad})]})]}),(0,t.jsxs)("div",{className:"flex items-center",children:["Completada"!==m.estado&&(0,t.jsx)("button",{className:`flex items-center justify-center w-6 h-6 text-white rounded-full shadow-md transition-colors duration-300 ${"Pendiente"===m.estado?"bg-blue-500 hover:bg-blue-600":"bg-green-500 hover:bg-green-600"}`,onClick:a=>{a.stopPropagation(),o(s&&1==s.rol?e.tarea_id:e.tarea.tarea_id)},children:"Pendiente"===m.estado?(0,t.jsx)(l.Z0P,{size:12}):(0,t.jsx)(l.CMH,{size:12})}),a.length>0&&(0,t.jsx)("button",{className:"ml-2 text-gray-400 hover:text-gray-200",onClick:a=>{a.stopPropagation(),d(1===s.rol?e.tarea_id:e.tarea.tarea_id)},children:c[1===s.rol?e.tarea_id:e.tarea.tarea_id]?(0,t.jsx)(l.Ucs,{}):(0,t.jsx)(l.Vr3,{})})]})]}),c[s&&1===s.rol?e.tarea_id:e.tarea.tarea_id]&&(0,t.jsx)("div",{className:"pl-4 mt-2",children:a.map(e=>{let a=1===s.rol?e:e.tarea;return(0,t.jsx)("div",{className:"bg-gray-700 shadow-md rounded-lg overflow-hidden p-2 border-l-4 border-indigo-500 cursor-pointer",children:(0,t.jsxs)("div",{className:"flex justify-between items-center",onClick:()=>i(a),children:[(0,t.jsxs)("div",{className:"flex-grow",children:[(0,t.jsx)("div",{className:"flex justify-between items-center mb-1",children:(0,t.jsx)("h2",{className:"text-base font-semibold text-white",children:a.titulo})}),(0,t.jsx)("p",{className:"text-sm text-gray-400 mb-1",children:a.descripcion}),(0,t.jsxs)("div",{className:"flex items-center text-sm text-gray-400 mb-1",children:[(0,t.jsx)(l.w_X,{className:"mr-1 text-blue-500"}),(0,t.jsx)("span",{children:"Completada"===a.estado?`Completada el: ${(0,n.GP)(new Date(a.fecha_real_fin),"dd/MM/yyyy HH:mm")}`:0===a.tiempo_restante.dias&&0===a.tiempo_restante.horas?`Vencido: ${a.tiempo_pasado.dias} d\xedas y ${a.tiempo_pasado.horas} horas pasados`:`Tiempo restante: ${a.tiempo_restante.dias} d\xedas y ${a.tiempo_restante.horas} horas`})]}),(0,t.jsxs)("div",{className:"flex items-center text-sm text-gray-400 mb-1",children:[(0,t.jsx)(l.wJQ,{className:"mr-1 text-yellow-500"}),(0,t.jsx)("span",{children:a.prioridad})]})]}),(0,t.jsx)("div",{className:"flex items-center",children:"Completada"!==a.estado&&(0,t.jsx)("button",{className:`flex items-center justify-center w-6 h-6 text-white rounded-full shadow-md transition-colors duration-300 ${"Pendiente"===a.estado?"bg-blue-500 hover:bg-blue-600":"bg-green-500 hover:bg-green-600"}`,onClick:a=>{a.stopPropagation(),o(e.tarea_id)},children:"Pendiente"===a.estado?(0,t.jsx)(l.Z0P,{size:12}):(0,t.jsx)(l.CMH,{size:12})})})]})},a.tarea_id)})})]},m.tarea_id)}):(0,t.jsx)("p",{className:"text-gray-500 text-sm",children:"No hay tareas en este estado."})})]},e))}),x=()=>{let{tareas:e,setTareas:a,usuarioLogeado:s,setEmpleados:x,setAsignacionesTareas:p,asignacionesTareas:h}=(0,i.A)(),[u,f]=(0,r.useState)(!0),[j,g]=(0,r.useState)(null),[y,_]=(0,r.useState)(""),[b,N]=(0,r.useState)(""),[v,w]=(0,r.useState)({}),[C,P]=(0,r.useState)(!1);(0,r.useEffect)(()=>{let e=async()=>{try{let e=await (0,o.Lr)();Array.isArray(e)?p(e):console.error("La respuesta de la API no es un array:",e)}catch(e){console.error("Error al obtener las asignaciones de tareas:",e)}};(async()=>{try{let e=await (0,o.T8)();Array.isArray(e)?x(e):console.error("La respuesta de la API no es un array:",e)}catch(e){console.error("Error al obtener los usuarios:",e)}})(),e()},[x,p]),(0,r.useEffect)(()=>{s&&k()},[s]),(0,r.useEffect)(()=>{console.log("Tareas:",e)},[e]);let k=async()=>{if(!s){console.error("usuarioLogeado no est\xe1 definido"),a([]),f(!1);return}if(null===s.id_empleado){console.log("id_empleado es null, no se ejecuta fetchTareas"),f(!1);return}try{let e;if(1===s.rol)e=await (0,o.C)();else{if(!s.id_empleado){console.error("id_empleado no est\xe1 definido en usuarioLogeado"),a([]),f(!1);return}e=await (0,o.bC)(s.id_empleado)}a(Array.isArray(e)?e:[])}catch(e){console.error("Error al obtener las tareas:",e.message,e.stack),a([])}finally{f(!1)}},E=async t=>{try{let r=e.find(e=>1===s.rol?e.tarea_id===t:e.asignacion_id===t);if(!r)throw Error("Tarea no encontrada");let l=1===s.rol?r.estado:r.tarea.estado,i="Pendiente"===l?"En Progreso":"Completada",d="Completada"===i?(0,n.GP)(new Date,"yyyy-MM-dd'T'HH:mm:ss.SSSxxx"):null;1===s.rol?await (0,o.QW)(t,{...r,estado:i,fecha_real_fin:d}):await (0,o.aJ)(t,{tarea:{...r.tarea,estado:i,fecha_real_fin:d}}),a(e=>e.map(e=>(1===s.rol?e.tarea_id:e.asignacion_id)===t?{...e,estado:i}:e)),k()}catch(e){console.error("Error al completar la tarea:",e)}},A=()=>{g(null),_(""),N("")};if(u)return(0,t.jsx)("div",{className:"flex justify-center items-center min-h-screen",children:(0,t.jsx)("p",{className:"text-lg text-gray-600 animate-pulse",children:"Cargando..."})});let M=(Array.isArray(e)?e:[]).reduce((e,a)=>{let t=s&&1===s.rol?a.estado:a.tarea?.estado;return e[t]||(e[t]=[]),e[t].push(a),e},{});return(0,t.jsxs)("div",{className:"container mx-auto p-6 h-screen flex flex-col",children:[(0,t.jsxs)("div",{className:"flex items-center justify-between mb-6",children:[(0,t.jsx)("div",{className:"flex-grow text-center",children:(0,t.jsx)("h1",{className:"text-4xl font-bold text-black",children:"Panel de Tareas"})}),(0,t.jsx)(l.jNV,{className:"text-4xl text-black cursor-pointer",onClick:()=>{P(!0)}})]}),(0,t.jsx)(m,{estados:["Pendiente","En Progreso","Completada"],tareasPorEstado:M,usuarioLogeado:s,tareas:e,handleCardClick:e=>{console.log("Tarea seleccionada:",e),g(e);let a=h.filter(a=>a.tarea.tarea_id===e.tarea_id);_([...new Set(a.map(e=>e.asignador.nombre))].join(", ")),N(a.map(e=>e.empleado?.nombre).join(", "))},completarTarea:E,toggleExpand:e=>{w(a=>({...a,[e]:!a[e]}))},expandedTareas:v}),(0,t.jsx)(c,{selectedTarea:j,asignadorNombres:y,empleadoNombres:b,closeModal:A,handleOutsideClick:e=>{"modal-overlay"===e.target.id&&A()}}),(0,t.jsx)(d,{isOpen:C,onClose:()=>{P(!1)}})]})}},65374:(e,a,s)=>{"use strict";s.r(a),s.d(a,{default:()=>l});var t=s(62740),r=s(66797);s(76301);let l=()=>(0,t.jsx)(r.default,{})},66797:(e,a,s)=>{"use strict";s.d(a,{default:()=>t});let t=(0,s(46760).registerClientReference)(function(){throw Error("Attempted to call the default export of \"C:\\\\Users\\\\Usuario\\\\Desktop\\\\dev\\\\tecom_admin_front\\\\src\\\\components\\\\inicio-tareas\\\\inicio.jsx\" from the server, but it's on the client. It's not possible to invoke a client function from the server, it can only be rendered as a Component or passed to props of a Client Component.")},"C:\\Users\\Usuario\\Desktop\\dev\\tecom_admin_front\\src\\components\\inicio-tareas\\inicio.jsx","default")}};var a=require("../../webpack-runtime.js");a.C(e);var s=e=>a(a.s=e),t=a.X(0,[112,175,900,879,264,473],()=>s(10583));module.exports=t})();