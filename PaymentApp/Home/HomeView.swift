import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var maskAmount: UIView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func handleContinue(_ sender: UIButton) {
        let sb = UIStoryboard(name: "PaymentMethodView", bundle: .main)
        let vc = sb.instantiateViewController(identifier: "PaymentMethodView")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func amountChanged(_ sender: UITextField) {
        /*txtAmount.text!.remove(at: txtAmount.text!.startIndex)
        print("aaaaa: \(txtAmount.text!)")
        let amount = Decimal(string: txtAmount.text!)!
        print("amount: \(amount)")
        let amountLength: Int = txtAmount.text!.count
        
        if amountLength == 0 { txtAmount.text = "$" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        let doubleValue = amount.doubleValue
        if let result = formatter.string(from: doubleValue as NSNumber) {
            print("RESULT: \(result)")
            txtAmount.text = result
        }*/
        
        let amountLength: Int = txtAmount.text!.count
        if amountLength == 0 { txtAmount.text = "$" }
        enableButton(isEnabled: amountLength > 1)
    }

    func setup() {
        title = "Inicio"
        
        maskAmount.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        maskAmount.layer.borderWidth = 1.0
        maskAmount.layer.cornerRadius = 16.0
        
        txtAmount.text = "$"
        txtAmount.becomeFirstResponder()
        
        btnContinue.layer.cornerRadius = 16.0
        enableButton(isEnabled: false)
    }
    
    func enableButton(isEnabled: Bool) {
        if (isEnabled) {
            btnContinue.layer.backgroundColor = UIColor(named: "Purple")?.cgColor
            btnContinue.isEnabled = true
        } else {
            btnContinue.layer.backgroundColor = UIColor(named: "LightGray")?.cgColor
            btnContinue.isEnabled = false
        }
    }

}

/*extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
*/
