import UIKit

class InstallmentViewCell: UICollectionViewCell {
    //@IBOutlet weak var btnInstallment: UIButton?
    @IBOutlet weak var bgCell: UIView?
    @IBOutlet weak var lblInstallment: UILabel?
    
    func setup(selected: Bool) {
        bgCell?.layer.backgroundColor = UIColor(named: selected ? "Purple" : "White")?.cgColor
        bgCell?.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        bgCell?.layer.borderWidth = selected ? 0 : 1
        bgCell?.layer.cornerRadius = 12
        
        lblInstallment?.textColor = UIColor(named: selected ? "White" : "Gray")
        lblInstallment?.font = UIFont(name: "Helvetica Neue\(selected ? " Bold" : "")", size: 14)
    }
}
