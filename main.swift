
import Foundation

print("hello")
if let v = "hello".data(using: .utf8) {
	print("\(hexStr(v))")
}