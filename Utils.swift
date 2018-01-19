//
//  Utils.swift
//  SkeeterEater
//
//  Created by Matthew Giger on 1/15/18.
//  Copyright © 2018 Matthew Giger. All rights reserved.
//

import Foundation

func encode<T>(_ value: T) -> Data {
	var val = value
	return withUnsafePointer(to: &val) { p in
		Data(bytes: p, count: MemoryLayout.size(ofValue: val))
	}
}

func decode<T>(_ data: Data) -> T {
	let size = MemoryLayout<T.Type>.size
	let pointer = UnsafeMutablePointer<T>.allocate(capacity: size)
	data.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> Void in
		memcpy(pointer, bytes, size)
	}
	return pointer.move()
}

func hexStr(_ data: Data) -> String {
	return [UInt8](data).flatMap { String(format:"0x%02x ", $0) }.joined(separator: "")
}


extension Data {
	
	mutating func add<T>(_ value: T) {
		var val = value
		self.append(UnsafeBufferPointer(start: &val, count: 1))
	}
	
	func extract<T>(_ index: Int) -> T
	{
		let slice = self[startIndex.advanced(by: index)...]
		return slice.withUnsafeBytes { (pointer: UnsafePointer<T>) -> T in
			return pointer.pointee
		}
	}
}

public protocol DataConvertible {
	static func + (lhs: Data, rhs: Self) -> Data
	static func += (lhs: inout Data, rhs: Self)
}

extension DataConvertible {
	public static func + (lhs: Data, rhs: Self) -> Data {
		var value = rhs
		let data = Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
		return lhs + data
	}
	
	public static func += (lhs: inout Data, rhs: Self) {
		lhs = lhs + rhs
	}
}

extension UInt8 : DataConvertible { }
extension UInt16 : DataConvertible { }
extension UInt32 : DataConvertible { }
extension Int8 : DataConvertible { }
extension Int16 : DataConvertible { }
extension Int32 : DataConvertible { }
extension Float : DataConvertible { }
extension Double : DataConvertible { }
extension String : DataConvertible {
	public static func + (lhs: Data, rhs: String) -> Data {
		guard let data = rhs.data(using: .utf8) else { return lhs}
		return lhs + data
	}
}
extension Data : DataConvertible {
	public static func + (lhs: Data, rhs: Data) -> Data {
		var data = Data()
		data.append(lhs)
		data.append(rhs)
		return data
	}
}
