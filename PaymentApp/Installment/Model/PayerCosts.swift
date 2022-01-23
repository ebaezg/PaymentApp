import UIKit

struct PayerCosts: Codable {
    let installments: Int?
    let recommended_message: String?
    let installment_amount: Double?
    let total_amount: Double?
    var selected: Bool?
}
