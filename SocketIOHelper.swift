//
//  SocketIOHelper.swift
//  Zaynax Health
//
//  Created by Rz Rasel on 2/9/21.
//

import Foundation
import SocketIO

class SocketIOHelper {
    private var socketIO: SocketIOManager!
    private var isLog = false
    //
    
    public init(isLog argIsLog: Bool) {
        isLog = argIsLog
        socketIO = SocketIOManager(isLog: isLog)
    }
	
    public func params(key argKey: String, value argValue: Any) -> SocketIOHelper {
        socketIO = socketIO.params(key: argKey, value: argValue)
        return self
    }

    public func with(url argURL: String) -> SocketIOHelper {
        socketIO = socketIO.with(url: argURL)
        return self
    }

    public func connect(messageHandler, callHandler ) {
        socketIO.prepareConnection()
        socketIO.socket.on(clientEvent: SocketClientEvent.connect) {data, ack in
            print("DEBUG_SOCKET_IO_MANAGER: SocketIO connected File: \(#file) Line: \(#line)")
            socketIO.socket.on("message", messageHandler);
			socketIO.socket.on("INCOMING_CALL", callHandler);
			
        }
    }

    public func message() {
        socketIO.socket.on("message") {data, ack in
            print("DEBUG_SOCKET_IO_MANAGER: SocketIO message \(data) \(ack) File: \(#file) Line: \(#line)")
        }
    }

	public func acceptCall(doctorID, roomID) {
		socketIO.socket.emit("CALL_ACCEPTED", "{\"doctorID\": \(doctorID), \"roomID\": \(roomID)}")
	}

	public func rejectCall(doctorID, roomID) {
		socketIO.socket.emit("CALL_REJECTED", "{\"doctorID\": \(doctorID), \"roomID\": \(roomID)}")
	}
}
