open Cache

let precache = (assets: array<string>, cacheName: string): Js.Promise.t<unit> =>{
  Js.log("Preloaded")
  caches(ServiceWorker.Global.self)->Storage.open_(cacheName)
    |> Js.Promise.then_(cache => cache->addAll(assets))
}
let addToCache = (req: Fetch.Request.t, cacheName: string): Js.Promise.t<unit> => {
  caches(ServiceWorker.Global.self)->Storage.open_(cacheName)
    |> Js.Promise.then_(cache => cache->add(#Request(req)))
}

