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

