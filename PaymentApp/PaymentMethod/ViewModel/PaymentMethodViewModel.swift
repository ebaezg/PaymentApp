import UIKit

class PaymentMethodViewModel {
    func getPaymentMethods(completion: @escaping ([PaymentMethodModel]?) -> Void) {
        PaymentMethodService.getPaymentMethods { paymentMethod in
            completion(paymentMethod)
        }
    }
}
