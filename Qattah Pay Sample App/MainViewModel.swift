//
// Created by khlafawi on 13/01/2023.
//

import Combine
import Foundation

final class MainViewModel: ObservableObject {

    // MARK: - Properties
    private var repo: MainRepository

    @Published var reference = ""
    @Published var callback_url = ""
    @Published var amount = ""

    @Published var hasError = false
    @Published var emptyBoxes = false
    @Published var isLoading = false
    @Published var apiResponse: ApiResponse? = nil
    @Published var navigate = false

    // MARK: -
    var canRequestNewOrder: Bool {
        !reference.isEmpty && !callback_url.isEmpty && !amount.isEmpty
    }

    init() {
        repo = MainRepository()
    }

    // MARK: - Public API
    func pay() {
        self.isLoading = true
        repo.createNewQattah(reference: reference, callback_url: callback_url, amount: amount) { response in
            self.apiResponse = response
            self.navigate = true
            self.isLoading = false
        } onError: { errorMessage in
            self.hasError = true
            print("Error: \(errorMessage)")
            self.isLoading = false
        }
    }

    func startListener(onPaidSuccessfully: @escaping () -> Void) {
        repo.startSocketListener { orderId in
            self.repo.orderPaymentStatus(orderId: orderId) { response in
                if response.data?.order.payment_status == "paid" {
                    onPaidSuccessfully()
                }
            } onError: { errorMessage in
                self.hasError = true
                print("Error: \(errorMessage)")
                self.isLoading = false
            }
        }
    }

    func stopListeningForPaymentStatus() {
        repo.stopSocketListener()
    }
}
