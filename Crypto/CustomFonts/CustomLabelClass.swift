//
//  CustomLabelClass.swift
//  LifeQuotes
//
//  Created by Sufyan Akhtar on 11/07/2024.
//

import Foundation
import UIKit

class CustomLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupFont()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupFont()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupFont()
    }

    private func setupFont() {
         let tag = self.tag 
        
        switch tag {
        case 1:
            self.font = UIFont(name: "Roboto-Regular", size: self.font.pointSize)
        case 2:
            self.font = UIFont(name: "Roboto-Medium", size: self.font.pointSize)
        case 3:
            self.font = UIFont(name: "Roboto-Bold", size: self.font.pointSize)
        case 4:
            self.font = UIFont(name: "Poppins-Regular", size: self.font.pointSize)
        case 5:
            self.font = UIFont(name: "Poppins-SemiBold", size: self.font.pointSize)
        case 6:
            self.font = UIFont(name: "Poppins-Bold", size: self.font.pointSize)
        case 7:
            self.font = UIFont(name: "Poppins-Light", size: self.font.pointSize)
        case 8:
            self.font = UIFont(name: "Poppins-Medium", size: self.font.pointSize)
        default:
            break
        }
    }
}
