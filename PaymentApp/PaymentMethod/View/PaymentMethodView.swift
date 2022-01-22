import UIKit

class PaymentMethodView: UIViewController {
    @IBOutlet weak var tablePaymentMethods: UITableView?
    
    let cellIdentifier = "PaymentMethodViewCell"
    var paymentMethods: [PaymentMethodModel]?
/*    let paymentMethods: [PaymentMethodViewCellModel] = [
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "Mastercard"),
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "Cordobesa"),
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "CMR"),
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "Visa"),
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "Naranja"),
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "Tarjeta Shopping")
    ]*/
    
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
            self.paymentMethods = completion
            self.tablePaymentMethods?.reloadData()
        }
    }
    
    func setup() {
        title = "Medio de Pago"
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
        print("SELECTED IS: \(paymentMethods?[indexPath.item])")
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
