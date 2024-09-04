//
//  CollectionCell.swift
//  Crypto
//
//  Created by Sufyan Akhtar on 13/08/2024.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet var coinImageView: UIImageView!
    @IBOutlet var lblCoinName: UILabel!
    @IBOutlet var lblTotalCoins: UILabel!
    @IBOutlet var lblTotalMoney: UILabel!
    @IBOutlet var lblDeductionMoney: UILabel!
    @IBOutlet var viewHighligt: UIView!
    @IBOutlet var subCoinImage: UIImageView!
    
    @IBOutlet var lblTotalAmount: UILabel!
    @IBOutlet var lblTotalDeduction: UILabel!
    @IBOutlet var totalPercentage: UILabel!
}
