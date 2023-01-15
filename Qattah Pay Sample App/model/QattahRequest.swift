//
// Created by khlafawi on 02/01/2023.
//

import Foundation

struct QattahRequest: Decodable, Hashable {
    var ref_id: String
    var amount: Float
    var callback_url: Float
}