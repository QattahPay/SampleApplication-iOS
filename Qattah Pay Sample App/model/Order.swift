//
// Created by khlafawi on 02/01/2023.
//

import Foundation
import SwiftUI

struct Order: Decodable, Hashable {
    let id: String
    let merchant_id: String
    let reference: String
    let amount: String
    let started_at: String?
    let is_expired: Bool
    let payment_status: String
    let invoices: [Invoice]
}

struct Data: Decodable, Hashable {
    let order: Order
}

struct Links: Decodable, Hashable {
    let redirect_to: String
}

struct ApiResponse: Decodable, Hashable {
    let successful: Bool?
    let data: Data?
    let links: Links?
} 