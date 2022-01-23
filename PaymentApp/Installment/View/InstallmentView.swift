import UIKit

class InstallmentView: UIViewController {
    @IBOutlet weak var collectionInstallments: UICollectionView!
    @IBOutlet weak var btnPay: UIButton?
    @IBOutlet weak var lblRecommendedMessage: UILabel?
    let cellIdentifier = "InstallmentViewCell"
    var installments: [PayerCosts]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionInstallments.dataSource = self
        collectionInstallments.delegate = self
        
        collectionInstallments.register(UINib(nibName: cellIdentifier, bundle: .main), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        InstallmentService.getInstallments { [weak self] installment in
            guard let self = self else { return }
            self.installments = installment
            self.lblRecommendedMessage?.text = self.installments?[0].recommended_message
            self.installments?[0].selected = true
            self.collectionInstallments.reloadData()
        }
    }
    
    func setup() {
        title = "Cuotas"
        
        btnPay?.layer.cornerRadius = 16.0
    }
    
    @IBAction func handlePay(_ sender: UIButton) {
        let installmentSelected = installments?.filter({ installment -> Bool in
            installment.selected == true
        }).first
        
        PaymentModel.shared.installments = String((installmentSelected?.installments)!)
        PaymentModel.shared.installmentAmount = String((installmentSelected?.installment_amount)!)
        PaymentModel.shared.totalAmount = String((installmentSelected?.total_amount)!)
        PaymentModel.shared.paymentCompleted = true
        
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension InstallmentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return installments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? InstallmentViewCell else { return UICollectionViewCell() }
        cell.setup(selected: self.installments?[indexPath.item].selected ?? false)
        cell.lblInstallment?.text = String(self.installments?[indexPath.item].installments ?? 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var newInstallments: [PayerCosts]? = self.installments?.map({ installment -> PayerCosts in
            var _installment = installment
            _installment.selected = false
            return _installment
        })
        newInstallments?[indexPath.item].selected = true
        lblRecommendedMessage?.text = newInstallments?[indexPath.item].recommended_message
        installments = newInstallments
        collectionView.reloadData()
    }
}
