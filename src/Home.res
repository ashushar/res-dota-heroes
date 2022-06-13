switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<App />, root)
| None => () // do nothing
}
let path = "./ServiceWorkerInst.bs.js"
ServiceWorkerExecutor.register(path)->ignore
