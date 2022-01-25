import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var maskAmount: UIView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnResume: UIButton!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var containerAmount: UIView!
    @IBOutlet weak var containerResume: UIView!
    @IBOutlet weak var bgResume: UIView!
    @IBOutlet weak var resumeAmount: UILabel!
    @IBOutlet weak var resumePaymentMethod: UILabel!
    @IBOutlet weak var resumeCardIssuer: UILabel!
    @IBOutlet weak var resumeInstallments: UILabel!
    @IBOutlet weak var resumeInstallmentAmount: UILabel!
    @IBOutlet weak var resumeTotalAmount: UILabel!
    @IBOutlet weak var lblMinimumAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        print("PaymentModel.shared.paymentCompleted: \(PaymentModel.shared.paymentCompleted)")
        showAmountView(show: !PaymentModel.shared.paymentCompleted)
    }
    
    @IBAction func handleContinue(_ sender: UIButton) {
        let sb = UIStoryboard(name: "PaymentMethodView", bundle: .main)
        let vc = sb.instantiateViewController(identifier: "PaymentMethodView")
        
        PaymentModel.shared.amount = String(txtAmount.text!.dropFirst())
        txtAmount.resignFirstResponder()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func handleResume(_ sender: UIButton) {
        PaymentModel.shared.amount = ""
        PaymentModel.shared.paymentMethodId = ""
        PaymentModel.shared.paymentMethodName = ""
        PaymentModel.shared.cardIssuerId = ""
        PaymentModel.shared.cardIssuerName = ""
        PaymentModel.shared.installments = ""
        PaymentModel.shared.installmentAmount = ""
        PaymentModel.shared.totalAmount = ""
        PaymentModel.shared.paymentCompleted = false
        
        showAmountView(show: true)
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
        if let count = txtAmount.text?.count {
            count < 15 ? enableButton(isEnabled: isValidAmount(amount: txtAmount.text!)) : nil
        }
    }

    func setup() {
        title = "Inicio"
        
        maskAmount.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        maskAmount.layer.borderWidth = 1
        maskAmount.layer.cornerRadius = 16
        
        txtAmount.text = "$"
        
        btnContinue.layer.cornerRadius = 16
        
        bgResume.layer.cornerRadius = 12
        btnResume.layer.cornerRadius = 16
        
        lblMinimumAmount.isHidden = true
        
        enableButton(isEnabled: false)
    }
    
    func showAmountView(show: Bool) {
        if (show == true) {
            containerAmount.isHidden = false
            containerResume.isHidden = true
            lblSubtitle.text = "Ingresar monto a pagar"
            txtAmount.becomeFirstResponder()
        } else {
            containerAmount.isHidden = true
            containerResume.isHidden = false
            
            lblSubtitle.text = "Resumen Pago"
            enableButton(isEnabled: false)
            
            txtAmount.text = "$"
            
            resumeAmount.text = "$\(PaymentModel.shared.amount ?? "Vacío")"
            resumePaymentMethod.text = PaymentModel.shared.paymentMethodName
            resumeCardIssuer.text = PaymentModel.shared.cardIssuerName
            resumeInstallments.text = "\(PaymentModel.shared.installments ?? "Vacío") cuotas de "
            resumeInstallmentAmount.text = "$\(PaymentModel.shared.installmentAmount ?? "Vacío")"
            resumeTotalAmount.text = "$\(PaymentModel.shared.totalAmount ?? "Vacío")"
        }
    }
    
    func isValidAmount(amount: String) -> Bool {
        if (amount.count <= 1) {
            lblMinimumAmount.isHidden = true
            txtAmount.text = "$"
            return false
        } else if (Int(amount.dropFirst())! < 2000) {
            lblMinimumAmount.isHidden = false
            lblMinimumAmount.text = "Monto mínimo $2.000"
            return false
        } else if (Int(amount.dropFirst())! > 500000) {
            lblMinimumAmount.isHidden = false
            lblMinimumAmount.text = "Monto máximo $500.000"
            return false
        } else {
            lblMinimumAmount.isHidden = true
            return true
        }
    }
    
    func enableButton(isEnabled: Bool) {
        btnContinue.layer.backgroundColor = UIColor(named: isEnabled ? "Purple" : "LightGray")?.cgColor
        btnContinue.isEnabled = isEnabled
    }

}


/*extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
*/
