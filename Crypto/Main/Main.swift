//
//  Main.swift
//  Crypto
//
//  Created by Sufyan Akhtar on 13/08/2024.
//

import UIKit

class Main: UIViewController {
    @IBOutlet var cryptoCollectionView: UICollectionView!
    @IBOutlet var backgroundImage: UIImageView!
    
    var isGreeBackground = false;
    
    private let selectionIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.630102396, green: 0.5963565707, blue: 0.834733367, alpha: 1)
        return view
    }()
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isGreeBackground {
            backgroundImage.image = UIImage(named: AccountDetail.account.backgroundGreen ?? "")
        } else {
            backgroundImage.image = UIImage(named: AccountDetail.account.backgroundRed ?? "")
        }
        
        updateCollectionViewContentInset()
        tabBarController?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if cryptoCollectionView.contentSize.height <= cryptoCollectionView.frame.size.height {
            cryptoCollectionView.alwaysBounceVertical = true
        } else {
            cryptoCollectionView.alwaysBounceVertical = false
        }
    }
    func updateCollectionViewContentInset() {
        let bottomInset = max(0, cryptoCollectionView.frame.size.height - cryptoCollectionView.contentSize.height)
        cryptoCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.addSubview(selectionIndicatorView)
        updateSelectionIndicator()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        selectionIndicatorView.backgroundColor = .clear
    }
    
}

extension Main: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return CryptoCoinModel.collection.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = CryptoCoinModel.collection[indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.type, for: indexPath) as! CollectionCell
        
        if model.type == "Balance"
        {
            // Formatter setup
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "en_US") // Change locale as needed
            
            // Formatting and assigning to the label
            if let formattedPrice = formatter.string(from: NSNumber(value: AccountDetail.account.totalAmount)) {
                cell.lblTotalAmount.text = formattedPrice
            }
            
            cell.lblTotalDeduction.text = "-$\(AccountDetail.account.totalDeduction)"
            cell.lblTotalDeduction.textColor = self.hexStringToUIColor(hex: ColorCode.Red)
            
            cell.totalPercentage.text = "-\(AccountDetail.account.totalPercentage)%"
            cell.totalPercentage.textColor = self.hexStringToUIColor(hex: ColorCode.Red)
            
            
            cell.viewHighligt.backgroundColor = self.hexStringToUIColor(hex: ColorCode.RedSolid)
            cell.viewHighligt.layer.cornerRadius = 6.0
            cell.viewHighligt.clipsToBounds = true
            cell.viewHighligt.alpha = 0.7
            
        } else if model.type == "BalanceDetails"
        {
            cell.coinImageView.image = UIImage(named: model.image)
            cell.lblCoinName.text = model.coinName
            
            cell.lblTotalCoins.text = "\(model.totalCoins) SOL"
            
            // Formatter setup
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "en_US") // Change locale as needed
            
            // Formatting and assigning to the label
            if let formattedPrice = formatter.string(from: NSNumber(value: model.totalMoney)) {
                cell.lblTotalMoney.text = formattedPrice
            }
            
            
            cell.lblDeductionMoney.text = "+$\(model.totalDeduction)"
            cell.lblDeductionMoney.textColor = self.hexStringToUIColor(hex: ColorCode.Red)
            
            cell.subCoinImage.isHidden = true
            
            refreshControl.addTarget(self, action: #selector(refreshCollection(_ :)), for: .valueChanged)
            refreshControl.tintColor = .white
            cryptoCollectionView.addSubview(refreshControl)
            
            if model.coinName == "Dogwifhat"
            {
                cell.lblTotalCoins.text = "\(model.totalCoins) $WIF"
                cell.subCoinImage.isHidden = false
                cell.subCoinImage.image = UIImage(named: model.subCoinImage ?? "")
            }
            
        } else if model.type == "TokenCell" {
            cell.coinImageView.image = UIImage(named: model.image)
            cell.lblCoinName.text = model.coinName
        }
        return cell
    }
    
    @objc func refreshCollection(_ sender: UIRefreshControl) {
        // Reload your data here
        cryptoCollectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
             sender.endRefreshing()
         }
    }
}

extension Main: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = CryptoCoinModel.collection[indexPath.row]
        
        let frame = collectionView.frame
        let width = frame.size.width
        
        if model.type == "Balance" {
            return CGSize(width: width, height: 125)
        } else if model.type == "AllButtons" {
            return CGSize(width: width, height: 103)
        } else if model.type == "TokenCell" {
            return CGSize(width: width, height: 87)
        }
        
        return CGSize(width: width, height: 77)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
    }
}

extension Main: UITabBarControllerDelegate {
    private func tabBarController(_ tabBarController: UITabBarController, didSelect item: UITabBarItem) {
        updateSelectionIndicator()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let viewControllers = tabBarController.viewControllers, let selectedIndex = viewControllers.firstIndex(of: viewController) {
            return selectedIndex == 0
        }
        return false
    }
    
    private func updateSelectionIndicator() {
        guard let tabBar = tabBarController?.tabBar else { return }
        guard let selectedItem = tabBar.selectedItem else { return }
        
        guard let items = tabBar.items, let index = items.firstIndex(of: selectedItem) else { return }
        let itemWidth = tabBar.frame.width / CGFloat(items.count)
        let lineWidth: CGFloat = 50
        let xPosition = CGFloat(index) * itemWidth + (itemWidth - lineWidth) / 2
        
        selectionIndicatorView.frame = CGRect(x: xPosition, y: 0, width: lineWidth, height: 2)
        selectionIndicatorView.backgroundColor = #colorLiteral(red: 0.630102396, green: 0.5963565707, blue: 0.834733367, alpha: 1)
    }
}


extension Main
{
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
