(self.webpackChunk_N_E=self.webpackChunk_N_E||[]).push([[974],{6224:(e,a,t)=>{Promise.resolve().then(t.bind(t,19248))},19248:(e,a,t)=>{"use strict";t.d(a,{default:()=>p});var s=t(95155),o=t(12115),l=t(76046),r=t(57798),i=t(41938),n=t(98975),c=t(26737),d=t(22665),u=t(11536),m=t(5565);let h=o.memo(e=>{let{options:a,particlesLoaded:t}=e;return(0,s.jsx)(n.Ay,{id:"tsparticles",particlesLoaded:t,options:a})});h.displayName="ParticlesMemo";let p=()=>{let[e,a]=(0,o.useState)(""),[t,p]=(0,o.useState)(""),[b,f]=(0,o.useState)(!1),[x,g]=(0,o.useState)(""),v=(0,l.useRouter)(),{setUsuarioLogeado:w,usuarioLogeado:y}=(0,i.A)(),j=(0,o.useRef)(!1);(0,o.useEffect)(()=>{let e=localStorage.getItem("usuarioLogeado");e&&(w(JSON.parse(e)),v.push("/panel"))},[w,v]),(0,o.useEffect)(()=>{j.current||(0,n.iC)(async e=>{await (0,c.m)(e)}).then(()=>{j.current=!0})},[]);let N=async a=>{a.preventDefault(),g("");try{let a=await (0,r.Bi)(e,t);if(a){let e={id_empleado:a.id_empleado,nombre:a.nombre,apellidos:a.apellidos,correo:a.correo,especialidad:a.especialidad,sueldo:a.sueldo,activo:a.activo,foto:a.foto,nombre_usuario:a.nombre_usuario,fecha_contratacion:a.fecha_contratacion,area:a.area,rol:a.rol};w(e),localStorage.setItem("usuarioLogeado",JSON.stringify(e)),v.push("/panel")}else g("Credenciales incorrectas")}catch(e){g("Credenciales incorrectas")}},_=(0,o.useCallback)(async e=>{console.log(e)},[]),k=(0,o.useMemo)(()=>({background:{color:{value:"white-blue"}},fpsLimit:120,interactivity:{events:{onClick:{enable:!0,mode:"push"},onHover:{enable:!0,mode:"repulse"}},modes:{push:{quantity:4},repulse:{distance:100,duration:.4}}},particles:{color:{value:"#ffffff"},links:{enable:!1},move:{direction:d.FWc.bottom,enable:!0,outModes:{default:d.Yzx.out},random:!1,speed:1,straight:!1},number:{density:{enable:!0},value:1600},opacity:{value:.8},shape:{type:"circle"},size:{value:{min:1,max:5}}},detectRetina:!0}),[]),C=(0,o.useCallback)(e=>{a(e.target.value)},[]),L=(0,o.useCallback)(e=>{p(e.target.value)},[]);return(0,s.jsxs)("div",{className:"relative flex items-center justify-center min-h-screen bg-black",children:[(0,s.jsx)(h,{particlesLoaded:_,options:k}),(0,s.jsxs)("div",{className:"flex items-center justify-center rounded-lg shadow-lg bg-blue-800 bg-opacity-90 max-w-4xl w-full z-10",children:[(0,s.jsx)("div",{className:"w-1/2 hidden md:block",children:(0,s.jsx)(m.default,{src:"https://media.licdn.com/dms/image/v2/D4E0BAQGgGk-XuOr2cA/company-logo_200_200/company-logo_200_200/0/1666116188527?e=1741824000&v=beta&t=Yx0Q88ghBsl--XUhVQuOak_VdJeLx-l0HoT1mjmovAo",alt:"Login Image",width:200,height:200,className:"w-full h-auto object-cover rounded-lg shadow-lg"})}),(0,s.jsxs)("div",{className:"w-full md:w-1/2 p-6",children:[(0,s.jsx)("h2",{className:"text-center text-3xl font-bold text-white mb-6",children:"Iniciar Sesi\xf3n"}),x&&(0,s.jsx)("p",{className:"text-red-500 mb-4",children:x}),(0,s.jsxs)("form",{onSubmit:N,children:[(0,s.jsxs)("div",{className:"mb-4",children:[(0,s.jsx)("label",{htmlFor:"username",className:"block text-sm font-bold text-white mb-2",children:"Nombre de Usuario"}),(0,s.jsx)("input",{type:"text",id:"username",value:e,onChange:C,className:"w-full p-3 rounded-lg bg-gray-800 shadow-inner focus:outline-none text-white font-bold",placeholder:"nombre de usuario",required:!0,autoComplete:"username"})]}),(0,s.jsxs)("div",{className:"mb-4",children:[(0,s.jsx)("label",{htmlFor:"password",className:"block text-sm font-bold text-white mb-2",children:"Contrase\xf1a"}),(0,s.jsxs)("div",{className:"relative",children:[(0,s.jsx)("input",{type:b?"text":"password",id:"password",value:t,onChange:L,className:"w-full p-3 rounded-lg bg-gray-800 shadow-inner focus:outline-none text-white font-bold pr-10",placeholder:"********",required:!0,autoComplete:"current-password"}),(0,s.jsx)("button",{type:"button",onClick:()=>{f(!b)},className:"absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-gray-200",children:b?(0,s.jsx)(u.mx3,{}):(0,s.jsx)(u.Ny1,{})})]})]}),(0,s.jsx)("button",{type:"submit",className:"w-full py-3 rounded-lg bg-gradient-to-r from-blue-500 to-blue-700 hover:from-blue-600 hover:to-blue-800 shadow-lg active:shadow-inner transition-all font-medium text-white",children:"Entrar"})]})]})]})]})}},41938:(e,a,t)=>{"use strict";t.d(a,{A:()=>s});let s=(0,t(99827).v)(e=>({usuarioLogeado:{id_empleado:null,nombre:"",apellidos:"",correo:"",especialidad:"",sueldo:"",activo:!1,foto:"",nombre_usuario:"",fecha_contratacion:"",area:null,rol:null},empleados:[],tareas:[],asignacionesTareas:[],proyectos:[],notificaciones:[],setUsuarioLogeado:a=>e({usuarioLogeado:a}),setEmpleados:a=>e({empleados:a}),setTareas:a=>e({tareas:a}),setAsignacionesTareas:a=>e({asignacionesTareas:a}),setProyectos:a=>e({proyectos:a}),setNotificaciones:a=>e({notificaciones:a})}))}},e=>{var a=a=>e(e.s=a);e.O(0,[711,4,798,441,517,358],()=>a(6224)),_N_E=e.O()}]);