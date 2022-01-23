import UIKit
import Alamofire

class InstallmentService {
    static var installments: [InstallmentModel]?
    static let URL = Paths.basePath+Paths.installments
    
    static func parameters() -> [String: String] {
        return ["public_key": Paths.PUBLIC_KEY, "amount": PaymentModel.shared.amount!, "payment_method_id": PaymentModel.shared.paymentMethodId!, "issuer.id": PaymentModel.shared.cardIssuerId!]
    }
    
    static func getJson(data: Data) -> [PayerCosts]? {
        do { installments = try JSONDecoder().decode([InstallmentModel].self, from: data) }
        catch let error { print("InstallmentService error: \(error.localizedDescription)") }
        return installments?[0].payer_costs
        
    }
    
    static func getInstallments(completion: @escaping ([PayerCosts]?) -> Void) {
        AF.request(URL, method: .get, parameters: parameters(), encoding: URLEncoding.default).response {
            response in
            if let data = response.data {
                completion(getJson(data: data))
            }
        }
    }
}
