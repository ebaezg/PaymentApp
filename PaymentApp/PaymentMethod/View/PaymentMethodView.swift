import UIKit

class PaymentMethodView: UIViewController {
    @IBOutlet weak var tablePaymentMethods: UITableView?
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let cellIdentifier = "PaymentMethodViewCell"
    var paymentMethods: [PaymentMethodModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tablePaymentMethods?.delegate = self
        tablePaymentMethods?.dataSource = self
        tablePaymentMethods?.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        PaymentMethodService.getPaymentMethods { [weak self] completion in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.tablePaymentMethods?.isHidden = false
            self.paymentMethods = completion
            self.tablePaymentMethods?.reloadData()
        }
    }
    
    func setup() {
        title = "Medio de Pago"
        self.tablePaymentMethods?.isHidden = true
    }
}

extension PaymentMethodView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PaymentMethodViewCell else {
            return UITableViewCell()
        }
        cell.setup()
        cell.imgLogo?.load(urlString: self.paymentMethods?[indexPath.item].thumbnail ?? "")
        cell.lblName?.text = self.paymentMethods?[indexPath.item].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "CardIssuerView", bundle: .main)
        let vc = sb.instantiateViewController(identifier: "CardIssuerView")
        
        PaymentModel.shared.paymentMethodId = self.paymentMethods?[indexPath.item].id
        PaymentModel.shared.paymentMethodName = self.paymentMethods?[indexPath.item].name
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { self?.image = image }
                }
            }
        }
    }
}
