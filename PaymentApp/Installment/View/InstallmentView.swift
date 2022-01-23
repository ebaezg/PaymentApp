import UIKit

class InstallmentView: UIViewController {
    @IBOutlet weak var collectionInstallments: UICollectionView!
    @IBOutlet weak var btnPay: UIButton?
    let cellIdentifier = "InstallmentViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionInstallments.dataSource = self
        collectionInstallments.delegate = self
        
        //collectionInstallments.register(InstallmentViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionInstallments.register(UINib(nibName: cellIdentifier, bundle: .main), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func setup() {
        title = "Cuotas"
        
        btnPay?.layer.cornerRadius = 16.0
    }
}

extension InstallmentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? InstallmentViewCell else { return UICollectionViewCell() }
        cell.setup()
        //cell.btnInstallment?.setTitle(String(indexPath.row + 1), for: .normal)
        cell.lblInstallment?.text = String(indexPath.row + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("SELECTED INSTALLMENT: \(indexPath.row)")
    }
}
