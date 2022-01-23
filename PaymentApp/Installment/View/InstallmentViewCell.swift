import UIKit

class InstallmentViewCell: UICollectionViewCell {
    //@IBOutlet weak var btnInstallment: UIButton?
    @IBOutlet weak var bgCell: UIView!
    @IBOutlet weak var lblInstallment: UILabel?
    
    func setup() {
        /*btnInstallment?.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        btnInstallment?.layer.borderWidth = 1
        btnInstallment?.layer.cornerRadius = 12*/
        bgCell?.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        bgCell?.layer.borderWidth = 1
        bgCell?.layer.cornerRadius = 12
    }
}
