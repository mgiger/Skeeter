print("Hello, world!")

if let v = "hello".data(using: .utf8) {
	print("\(hexStr(v))")
}