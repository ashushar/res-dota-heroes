@new external makeExn: string => exn = "Error"
@get external request: _ => Fetch.Request.t = "request"

module Event = {
  type t

  @send external addEventListener: (ServiceWorker.Global.t, string, t => unit) => unit = "addEventListener"

  @send external onInstall: (ServiceWorker.Global.t, t => unit) => unit = "oninstall"

  @send external onFetch: (ServiceWorker.Global.t, t => unit) => unit = "onfetch"

  
@send external respondWith: (
  _,
  @unwrap
  [
    | #Resp(Fetch.Response.t)
    | #Promise(Js.Promise.t<Fetch.Response.t>)
  ],
) => unit = "respondWith"

@send external waitUntil: (t, Js.Promise.t<unit>) => unit = "waitUntil";
}
