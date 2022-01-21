import UIKit

class PaymentMethodViewCell: UITableViewCell {
    
    @IBOutlet weak var bgCell: UIView!
    @IBOutlet weak var imgLogo: UIImageView?
    @IBOutlet weak var lblName: UILabel?
    
    
    func setup(model: PaymentMethodViewCellModel) {
        imgLogo?.image = model.image
        lblName?.text = model.text
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: bgCell.frame.height - 1, width: bgCell.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(named: "LightGray")?.cgColor
        bgCell.layer.addSublayer(bottomLine)
    }
}

struct PaymentMethodViewCellModel {
    let image: UIImage
    let text: String
}
