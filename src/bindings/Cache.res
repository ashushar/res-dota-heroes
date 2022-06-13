open Fetch
type cache

module Storage = {
  type cacheStorage
  @send
  external has: (cacheStorage, string) => Js.Promise.t<bool> = "has"

  @send
  external open_: (cacheStorage, string) => Js.Promise.t<cache> = "open"

  @send
  external delete: (cacheStorage, string) => Js.Promise.t<bool> = "delete"

  @send
  external keys: cacheStorage => Js.Promise.t<array<string>> = "keys"
  type t = cacheStorage
}

@get external caches: _ => Storage.t = "caches"

@send
external addAll: (cache, array<string>) => Js.Promise.t<unit> = "addAll"

@send
external add: (cache, @unwrap [#Request(Request.t) | #String(string)]) => Js.Promise.t<unit> = "add"

@send
external matchWithoutOptions: (
  cache,
  Fetch.Request.t,
) => Js.Promise.t<Js.Nullable.t<Fetch.Response.t>> = "match"

type t = cache

