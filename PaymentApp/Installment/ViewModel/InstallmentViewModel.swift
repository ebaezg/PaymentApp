import UIKit

class InstallmentViewModel {
    func getInstallments(completion: @escaping ([PayerCosts]?) -> Void) {
        InstallmentService.getInstallments { installments in
            completion(installments)
        }
    }
}
