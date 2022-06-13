open Js
open ServiceWorker

let register = path => {
  Js.log("I am running")
  let opts: ServiceWorker.Registration.registerOptions = {
    \"type": "module"
  } 
  ServiceWorker.Global.self->navigator->Navigator.serviceWorker->Container.registerWithOptions(path, opts)
}

let fromCache = (req: Fetch.Request.t, cacheName: string): Promise.t<Fetch.Response.t> =>
  Cache.caches(ServiceWorker.Global.self)->Cache.Storage.open_(cacheName)
  |> Promise.then_(cache => cache->Cache.matchWithoutOptions(req))
  |> Promise.then_(matching =>
    switch Js.Nullable.toOption(matching) {
    | Some(m) => Promise.resolve(m)
    | None => {Js.log2("Failure", req);Promise.reject(JsGen.makeExn("no-match"))}
    }
  )

let fromNetwork = (req: Fetch.Request.t): Promise.t<Fetch.Response.t> => Fetch.fetchWithRequest(req)

let assetStrategy = (req: Fetch.Request.t, cacheName: string): Promise.t<Fetch.Response.t> => {
  let result = req->Fetch.Request.makeWithRequest->fromCache(cacheName)

  /* update cache iff. item already exists in cache */
  let _ = result |> Promise.then_(_ => CacheExecutor.addToCache(req, cacheName))

  /* don't wait on the update to return */
  result
}

let runtimeStrategy = (req: Fetch.Request.t, cacheName: string): Promise.t<Fetch.Response.t> => {
  let result =
    req->Fetch.Request.makeWithRequest->fromNetwork
      |> Promise.catch(_ => req->Fetch.Request.makeWithRequest->fromCache(cacheName))

  let _ = CacheExecutor.addToCache(req, cacheName)

  result
}