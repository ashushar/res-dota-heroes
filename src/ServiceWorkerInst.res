let getVersion = () => "0.0.11"

let assetCacheName = Js.String.concat(getVersion(), "dota-asset-")

let runtimeCacheName = Js.String.concat(getVersion(), "dota-runtime-")

let assets = ["/assets/android-icon-144x144.png", "/assets/android-icon-192x192.png", "assets/favicon-32x32.png", "./manifest.json"]

ServiceWorker.Global.self->JsGen.Event.addEventListener("install", (event: JsGen.Event.t): unit =>{
  Js.log2("The service worker is being installed.", event)
  event -> JsGen.Event.waitUntil(CacheExecutor.precache(assets, assetCacheName))
}
)

ServiceWorker.Global.self->JsGen.Event.addEventListener("fetch", event => {
  let req = event->JsGen.request
  let resp: Js.Promise.t<Fetch.Response.t> =
    req->Fetch.Request.makeWithRequest->ServiceWorkerExecutor.assetStrategy(assetCacheName)
      |> Js.Promise.catch(_ => req->Fetch.Request.makeWithRequest->ServiceWorkerExecutor.runtimeStrategy(runtimeCacheName))
  event->JsGen.Event.respondWith(#Promise(resp))
})
