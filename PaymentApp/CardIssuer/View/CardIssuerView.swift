import UIKit

class CardIssuerView: UIViewController {
    @IBOutlet weak var tableCardIssuer: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let cardIssuerViewModel = CardIssuerViewModel()
    var cardIssuers: [CardIssuerModel]?
    let cellIdentifier = "CardIssuerViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCardIssuers()
    }
    
    func setup() {
        tableCardIssuer?.delegate = self
        tableCardIssuer?.dataSource = self
        tableCardIssuer?.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        
        title = "Banco"
        tableCardIssuer.isHidden = true
    }
    
    func getCardIssuers() {
        cardIssuerViewModel.getCardIssuers { [weak self] cardIssuers in
            guard let self = self else { return }
            self.cardIssuers = cardIssuers
            self.indicator.stopAnimating()
            self.tableCardIssuer.isHidden = false
            self.tableCardIssuer?.reloadData()
        }
    }
}

extension CardIssuerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardIssuers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CardIssuerViewCell else {
            return UITableViewCell()
        }
        cell.setup()
        cell.imgLogo?.image = UIImage(named: "logoMastercard")
        cell.lblName?.text = self.cardIssuers?[indexPath.item].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "InstallmentView", bundle: .main)
        let vc = sb.instantiateViewController(identifier: "InstallmentView")
        
        PaymentModel.shared.cardIssuerId = self.cardIssuers?[indexPath.item].id
        PaymentModel.shared.cardIssuerName = self.cardIssuers?[indexPath.item].name
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
