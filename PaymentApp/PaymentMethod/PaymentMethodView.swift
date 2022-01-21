import UIKit

class PaymentMethodView: UIViewController {
    @IBOutlet weak var tablePaymentMethods: UITableView?
    
    let cellIdentifier = "PaymentMethodViewCell"
    
    let paymentMethods: [PaymentMethodViewCellModel] = [
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "Mastercard"),
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "Cordobesa"),
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "CMR"),
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "Visa"),
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "Naranja"),
        PaymentMethodViewCellModel(image: UIImage(named: "logoMastercard") ?? UIImage(), text: "Tarjeta Shopping")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tablePaymentMethods?.delegate = self
        tablePaymentMethods?.dataSource = self
        tablePaymentMethods?.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
    }
    
    func setup() {
        title = "Medio de Pago"
    }
}

extension PaymentMethodView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PaymentMethodViewCell else {
            return UITableViewCell()
        }
        cell.setup(model: paymentMethods[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED IS: \(paymentMethods[indexPath.item])")
    }
    
}
