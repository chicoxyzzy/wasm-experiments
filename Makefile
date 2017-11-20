WAT_ARGS ?= --fold-exprs --inline-exports --generate-names

example/hello.rs:
	cargo +wasm32 build --target=wasm32-unknown-unknown --release --example hello
	cp target/wasm32-unknown-unknown/release/examples/hello.wasm hello-wasm.wasm
	wasm2wat $(WAT_ARGS) hello-wasm.wasm > hello-wasm.wat
	wasm-gc hello-wasm.wasm hello-wasm.gc.wasm
	wasm2wat $(WAT_ARGS) hello-wasm.gc.wasm > hello-wasm.gc.wat

test: example/hello.rs
	npm test
