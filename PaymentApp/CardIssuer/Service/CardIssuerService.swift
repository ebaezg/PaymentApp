import UIKit
import Alamofire

class CardIssuerService {
    static var cardIssuers: [CardIssuerModel]?
    static let URL = Paths.basePath+Paths.cardIssuers
    
    static func parameters() -> [String: String] {
        return ["public_key": Paths.PUBLIC_KEY, "payment_method_id": PaymentModel.shared.paymentMethodId!]
    }
    
    static func getJson(data: Data) -> [CardIssuerModel]? {
        do { cardIssuers = try JSONDecoder().decode([CardIssuerModel].self, from: data) }
        catch let error { print("CardIssuerService error: \(error.localizedDescription)") }
        return cardIssuers?.filter({ cardIssuer -> Bool in
            cardIssuer.status == "active"
        }).sorted(by: { (lhs, rhs) -> Bool in lhs.name ?? "" < rhs.name ?? "" })
    }
    
    static func getCardIssuers(completion: @escaping ([CardIssuerModel]?) -> Void) {
        AF.request(URL, method: .get, parameters: parameters(), encoding: URLEncoding.default).response {
            response in
            if let data = response.data {
                completion(getJson(data: data))
            }
        }
    }
    
}
