module Global = {
  type t
  @val external self: t = "self"
}
module Registration = {
  type t
  type registerOptions = {\"type": string}
}
module Container = {
  type t
  @send
  external registerWithOptions: (
    t,
    string,
    Registration.registerOptions,
  ) => Js.Promise.t<Registration.t> = "register"

  @send
  external registerWithoutOptions: (t, string) => Js.Promise.t<Registration.t> = "register"
}
module Navigator = {
  type t

  @get
  external serviceWorker: t => Container.t = "serviceWorker"
}
type t
@get external navigator: Global.t => Navigator.t = "navigator"
