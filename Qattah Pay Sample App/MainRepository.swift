//
// Created by khlafawi on 10/01/2023.
//

import Combine
import Foundation
import SocketIO

final class MainRepository: ObservableObject {

    // MARK: - Properties
    private var service: ApiService
    private var socket: SocketIOClient?

    // MARK: - Initializers
    init() {
        service = ApiService()
    }

    // MARK: - Public methods
    func createNewQattah(reference: String, callback_url: String, amount: String, onComplete: @escaping (_ response: ApiResponse) -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        service.createNewQattahOrder(reference: reference, callback_url: callback_url, amount: amount, onComplete: onComplete, onError: onError)
    }

    func orderPaymentStatus(orderId: String, onComplete: @escaping (_ response: ApiResponse) -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        service.getOrderPaymentStatus(orderId: orderId, onComplete: onComplete, onError: onError)
    }

    func startSocketListener(onNewPaymentEvent: @escaping (_ orderId: String) -> Void) {
        
        let manager = SocketManager(socketURL: URL(string: "http://161.35.70.189:3000/")!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        handleSocketEvents(onNewPaymentEvent: onNewPaymentEvent)
        socket?.connect()
    }

    func stopSocketListener() {
        socket?.disconnect()
    }

    // MARK: - Private methods
    private func handleSocketEvents(onNewPaymentEvent: @escaping (_ orderId: String) -> Void) {
        socket?.on(clientEvent: .connect) { data, ack in
            print("CONNECTED" + ((data[0] as AnyObject) as! String))
        }
        socket?.on(Constants.ORDER_PAYMENT_STATUS) { data, ack in
            print(Constants.ORDER_PAYMENT_STATUS + ((data[0] as AnyObject) as! String))
            var orderId = (data[0] as AnyObject) as! String
            onNewPaymentEvent(orderId)
        }
        socket?.on(clientEvent: .disconnect) { data, ack in
            print("DISCONNECTED" + ((data[0] as AnyObject) as! String))
        }
        socket?.on(clientEvent: .error) { data, ack in
            print("CONECTION_ERROR" + ((data[0] as AnyObject) as! String))
        }
    }
}
