open Js
open ServiceWorker

let register: string => Js.Promise.t<Registration.t>

let fromCache: (Fetch.Request.t, string)=> Promise.t<Fetch.Response.t> 
let fromNetwork: (Fetch.Request.t)=> Promise.t<Fetch.Response.t> 

let assetStrategy : (Fetch.Request.t, string)=> Promise.t<Fetch.Response.t> 

let runtimeStrategy: (Fetch.Request.t, string) => Promise.t<Fetch.Response.t>