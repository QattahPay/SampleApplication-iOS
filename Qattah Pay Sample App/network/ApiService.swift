//
// Created by khlafawi on 13/01/2023.
//

import Combine
import Foundation

final class ApiService: ObservableObject {

    func createNewQattahOrder(reference: String, callback_url: String, amount: String, onComplete: @escaping (_: ApiResponse) -> Void, onError: @escaping (_: String) -> Void) {

        let parameters = "{\n    \"amount\": " + amount + ",\n    \"reference\": \"" + reference + "\",\n    \"callback_url\": \"" + callback_url + "\"\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://staging-api.qattahpay.sa/api/v1/merchant-integration/orders")!, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer 1|PpurpKJBbPZfHnQ4nMLMbr6GSs0ce9rSlcLdZ9Wy", forHTTPHeaderField: "Authorization")

        request.httpMethod = "POST"
        request.httpBody = postData


        URLSession.shared.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                            onError("Error occured")
                        } else if let data = data {
                            do {
                                let newOrderResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                                print(newOrderResponse)
                                onComplete(newOrderResponse)
                            } catch {
                                print("Unable to Decode Response \(error)")
                                onError("Error occured")
                            }
                        }
                    }
                }
                .resume()
    }

    func getOrderPaymentStatus(orderId: String, onComplete: @escaping (_: ApiResponse) -> Void, onError: @escaping (_: String) -> Void) {

        var request = URLRequest(url: URL(string: "https://staging-api.qattahpay.sa/api/v1/merchant-integration/orders/" + orderId)!, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer 1|PpurpKJBbPZfHnQ4nMLMbr6GSs0ce9rSlcLdZ9Wy", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                            onError("Error occured")
                        } else if let data = data {
                            do {
                                let newOrderResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                                print(newOrderResponse)
                                onComplete(newOrderResponse)
                            } catch {
                                print("Unable to Decode Response \(error)")
                                onError("Error occured")
                            }
                        }
                    }
                }
                .resume()
    }
}
