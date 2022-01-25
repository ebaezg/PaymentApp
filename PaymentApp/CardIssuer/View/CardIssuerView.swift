import UIKit

class CardIssuerView: UIViewController {
    @IBOutlet weak var tableCardIssuer: UITableView!
    let cellIdentifier = "CardIssuerViewCell"
    var cardIssuers: [CardIssuerModel]?
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tableCardIssuer?.delegate = self
        tableCardIssuer?.dataSource = self
        tableCardIssuer?.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CardIssuerService.getCardIssuers { [weak self] completion in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.tableCardIssuer.isHidden = false
            self.cardIssuers = completion
            self.tableCardIssuer?.reloadData()
        }
    }
    
    func setup() {
        title = "Banco"
        tableCardIssuer.isHidden = true
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
