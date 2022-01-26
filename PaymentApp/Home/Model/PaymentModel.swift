import UIKit

class PaymentModel {
    static let shared = PaymentModel()
    
    var amount: String?
    var paymentMethodId: String?
    var paymentMethodName: String?
    var cardIssuerId: String?
    var cardIssuerName: String?
    var installments: String?
    var installmentAmount: String?
    var totalAmount: String?
    var paymentCompleted = false
    
    private init() {}
}
