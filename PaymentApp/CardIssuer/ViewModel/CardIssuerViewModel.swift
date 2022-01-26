import UIKit

class CardIssuerViewModel {
    func getCardIssuers(completion: @escaping ([CardIssuerModel]?) -> Void) {
        CardIssuerService.getCardIssuers { cardIssuers in
            completion(cardIssuers)
        }
    }
}
