(self.webpackChunk_N_E=self.webpackChunk_N_E||[]).push([[773],{58951:(e,t,r)=>{Promise.resolve().then(r.bind(r,19809))},19809:(e,t,r)=>{"use strict";r.d(t,{default:()=>l});var a=r(95155),o=r(57798),s=r(12115),n=r(11536);let l=()=>{let[e,t]=(0,s.useState)([]),[r,l]=(0,s.useState)(!1),[i,c]=(0,s.useState)({monto:"",fecha_pago:"",metodo_pago:"Transferencia",id_factura:""}),[d,u]=(0,s.useState)(null),[m,g]=(0,s.useState)(!1),[x,b]=(0,s.useState)("");(0,s.useEffect)(()=>{(async()=>{try{let e=await (0,o.h3)();Array.isArray(e)&&t(e)}catch(e){console.error("Error fetching data:",e)}})()},[]);let p=async e=>{if(confirm("\xbfEst\xe1s seguro de que deseas eliminar este pago?"))try{await (0,o.Dk)(e);let r=await (0,o.h3)();Array.isArray(r)&&t(r),b("Pago eliminado exitosamente")}catch(e){console.error("Error al eliminar el pago:",e),b("Error al eliminar el pago")}},h=async()=>{try{await (0,o.HP)(i);let e=await (0,o.h3)();Array.isArray(e)&&t(e),l(!1),c({monto:"",fecha_pago:"",metodo_pago:"Transferencia",id_factura:""}),b("Pago agregado exitosamente")}catch(e){console.error("Error al agregar el pago:",e),b("Error al agregar el pago")}},f=async()=>{try{await (0,o.Xr)(d.id_pago,d);let e=await (0,o.h3)();Array.isArray(e)&&t(e),l(!1),u(null),g(!1),b("Pago actualizado exitosamente")}catch(e){console.error("Error al actualizar el pago:",e),b("Error al actualizar el pago")}},y=e=>{u(e),g(!0),l(!0)};return(0,a.jsxs)("div",{className:"p-6 bg-white shadow-lg rounded-lg",children:[(0,a.jsx)("h2",{className:"text-2xl font-semibold mb-4 text-gray-800",children:"Gesti\xf3n de Pagos"}),(0,a.jsxs)("button",{className:"bg-green-600 text-white px-6 py-3 rounded-lg mb-6 flex items-center hover:bg-green-700 transition",onClick:()=>{c({monto:"",fecha_pago:"",metodo_pago:"Transferencia",id_factura:""}),g(!1),l(!0)},children:[(0,a.jsx)(n.OiG,{className:"mr-3"}),"Agregar Pago"]}),x&&(0,a.jsx)("div",{className:"mb-6 p-4 bg-green-100 text-green-700 rounded-lg shadow-sm",children:x}),(0,a.jsxs)("table",{className:"table-auto w-full border border-gray-300 rounded-lg",children:[(0,a.jsx)("thead",{className:"bg-gray-100",children:(0,a.jsxs)("tr",{children:[(0,a.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"Monto"}),(0,a.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"Fecha de Pago"}),(0,a.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"M\xe9todo de Pago"}),(0,a.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"ID de Factura"}),(0,a.jsx)("th",{className:"px-6 py-3 border-b text-left text-sm font-medium text-gray-600",children:"Acciones"})]})}),(0,a.jsx)("tbody",{children:Array.isArray(e)&&e.map(e=>(0,a.jsxs)("tr",{className:"hover:bg-gray-50 transition duration-200",children:[(0,a.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.monto}),(0,a.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.fecha_pago}),(0,a.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.metodo_pago}),(0,a.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:e.id_factura}),(0,a.jsx)("td",{className:"px-6 py-4 border-b text-sm text-gray-700",children:(0,a.jsxs)("div",{className:"flex gap-3",children:[(0,a.jsx)("button",{className:"text-blue-600 hover:text-blue-800 transition",onClick:()=>y(e),children:(0,a.jsx)(n.uO9,{})}),(0,a.jsx)("button",{className:"text-red-600 hover:text-red-800 transition",onClick:()=>p(e.id_pago),children:(0,a.jsx)(n.qbC,{})})]})})]},e.id_pago))})]}),r&&(0,a.jsx)("div",{className:"fixed inset-0 bg-gray-600 bg-opacity-50 flex justify-center items-center",children:(0,a.jsxs)("div",{className:"bg-white p-8 rounded-lg shadow-xl w-3/4 md:w-1/3",children:[(0,a.jsxs)("div",{className:"flex justify-between items-center mb-6",children:[(0,a.jsx)("h2",{className:"text-2xl font-semibold text-gray-800",children:m?"Editar Pago":"Agregar Nuevo Pago"}),(0,a.jsx)("button",{onClick:()=>l(!1),children:(0,a.jsx)(n.QCr,{className:"text-gray-600 hover:text-gray-800"})})]}),[{label:"Monto",value:m?d.monto:i.monto,key:"monto",type:"number"},{label:"Fecha de Pago",value:m?d.fecha_pago:i.fecha_pago,key:"fecha_pago",type:"date"},{label:"ID de Factura",value:m?d.id_factura:i.id_factura,key:"id_factura",type:"number"}].map(e=>{let{label:t,value:r,key:o,type:s="text"}=e;return(0,a.jsxs)("div",{className:"mb-6",children:[(0,a.jsx)("label",{className:"block text-gray-700 text-sm font-medium mb-2",children:t}),(0,a.jsx)("input",{type:s,className:"shadow-sm border rounded w-full py-3 px-4 text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500",value:r,onChange:e=>{let t=m?{...d,[o]:e.target.value}:{...i,[o]:e.target.value};m?u(t):c(t)}})]},o)}),(0,a.jsxs)("div",{className:"mb-6",children:[(0,a.jsx)("label",{className:"block text-gray-700 text-sm font-medium mb-2",children:"M\xe9todo de Pago"}),(0,a.jsxs)("select",{className:"shadow-sm border rounded w-full py-3 px-4 text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500",value:m?d.metodo_pago:i.metodo_pago,onChange:e=>{let t=m?{...d,metodo_pago:e.target.value}:{...i,metodo_pago:e.target.value};m?u(t):c(t)},children:[(0,a.jsx)("option",{value:"Transferencia",children:"Transferencia"}),(0,a.jsx)("option",{value:"Efectivo",children:"Efectivo"}),(0,a.jsx)("option",{value:"Cheque",children:"Cheque"})]})]}),(0,a.jsxs)("div",{className:"flex justify-end",children:[(0,a.jsx)("button",{className:"bg-blue-600 text-white px-6 py-3 rounded-lg mr-3 hover:bg-blue-700 transition",onClick:m?f:h,children:m?"Actualizar":"Agregar"}),(0,a.jsx)("button",{className:"bg-gray-500 text-white px-6 py-3 rounded-lg hover:bg-gray-600 transition",onClick:()=>l(!1),children:"Cancelar"})]})]})})]})}},93435:(e,t,r)=>{"use strict";r.d(t,{k5:()=>d});var a=r(12115),o={color:void 0,size:void 0,className:void 0,style:void 0,attr:void 0},s=a.createContext&&a.createContext(o),n=["attr","size","title"];function l(){return(l=Object.assign?Object.assign.bind():function(e){for(var t=1;t<arguments.length;t++){var r=arguments[t];for(var a in r)Object.prototype.hasOwnProperty.call(r,a)&&(e[a]=r[a])}return e}).apply(this,arguments)}function i(e,t){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter(function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable})),r.push.apply(r,a)}return r}function c(e){for(var t=1;t<arguments.length;t++){var r=null!=arguments[t]?arguments[t]:{};t%2?i(Object(r),!0).forEach(function(t){var a,o;a=t,o=r[t],(a=function(e){var t=function(e,t){if("object"!=typeof e||!e)return e;var r=e[Symbol.toPrimitive];if(void 0!==r){var a=r.call(e,t||"default");if("object"!=typeof a)return a;throw TypeError("@@toPrimitive must return a primitive value.")}return("string"===t?String:Number)(e)}(e,"string");return"symbol"==typeof t?t:t+""}(a))in e?Object.defineProperty(e,a,{value:o,enumerable:!0,configurable:!0,writable:!0}):e[a]=o}):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):i(Object(r)).forEach(function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(r,t))})}return e}function d(e){return t=>a.createElement(u,l({attr:c({},e.attr)},t),function e(t){return t&&t.map((t,r)=>a.createElement(t.tag,c({key:r},t.attr),e(t.child)))}(e.child))}function u(e){var t=t=>{var r,{attr:o,size:s,title:i}=e,d=function(e,t){if(null==e)return{};var r,a,o=function(e,t){if(null==e)return{};var r={};for(var a in e)if(Object.prototype.hasOwnProperty.call(e,a)){if(t.indexOf(a)>=0)continue;r[a]=e[a]}return r}(e,t);if(Object.getOwnPropertySymbols){var s=Object.getOwnPropertySymbols(e);for(a=0;a<s.length;a++)r=s[a],!(t.indexOf(r)>=0)&&Object.prototype.propertyIsEnumerable.call(e,r)&&(o[r]=e[r])}return o}(e,n),u=s||t.size||"1em";return t.className&&(r=t.className),e.className&&(r=(r?r+" ":"")+e.className),a.createElement("svg",l({stroke:"currentColor",fill:"currentColor",strokeWidth:"0"},t.attr,o,d,{className:r,style:c(c({color:e.color||t.color},t.style),e.style),height:u,width:u,xmlns:"http://www.w3.org/2000/svg"}),i&&a.createElement("title",null,i),e.children)};return void 0!==s?a.createElement(s.Consumer,null,e=>t(e)):t(o)}}},e=>{var t=t=>e(e.s=t);e.O(0,[711,798,441,517,358],()=>t(58951)),_N_E=e.O()}]);