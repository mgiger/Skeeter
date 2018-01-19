//
//  UDPSocket.swift
//  SkeeterEater
//
//  Created by Matthew Giger on 1/15/18.
//  Copyright © 2018 Matthew Giger. All rights reserved.
//

import Foundation
import Glibc

enum SocketError: Error {
	case allocateError
	case badHost
	case sendError
	case receiveError
}

public protocol UDPRequest {
	var packet: Data { get }
}


class UDPSocket {
	
	private var socket: Int32
	
	init(timeout: Int = 10) throws {
		
		socket = Darwin.socket(AF_INET, SOCK_DGRAM, 0)
		if socket < 0 {
			throw SocketError.allocateError
		}
		
//		var socktimeout = Darwin.timeval()
//		socktimeout.tv_sec = timeout
//		socktimeout.tv_usec = 0
//		
//		let timesize = socklen_t(MemoryLayout<Darwin.timeval>.size)
//		if Darwin.setsockopt(socket, SOL_SOCKET, SO_RCVTIMEO, &socktimeout, timesize) < 0 {
//			throw SocketError.allocateError
//		}
//		if Darwin.setsockopt(socket, SOL_SOCKET, SO_SNDTIMEO, &socktimeout, timesize) < 0 {
//			throw SocketError.allocateError
//		}
	}
}
