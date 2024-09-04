//
//  Model.swift
//  Crypto
//
//  Created by Sufyan Akhtar on 13/08/2024.
//

import Foundation
import UIKit

struct ColorCode {
    static var Green = "#2DDD78"
    static var GreenSolid = "#22392A"
    static var Red = "#E93842"
    static var RedSolid = "#3B2425"
}

struct CryptoCoinModel {
    
    var image: String
    var subCoinImage: String? = nil
    var coinName : String
    var totalMoney : Double
    var totalCoins: Double
    var totalDeduction : Double
    var type : String

    static let collection : [CryptoCoinModel] = [
        CryptoCoinModel(image: "", coinName: "", totalMoney: AccountDetail.account.totalAmount, totalCoins: 0, totalDeduction: AccountDetail.account.totalDeduction, type: "Balance"),
        CryptoCoinModel(image: "", coinName: "", totalMoney: 0, totalCoins: 0, totalDeduction: 0, type: "AllButtons"),
        
        CryptoCoinModel(image: "solana", coinName: "Solana", totalMoney: 8025.52, totalCoins: 56.6694, totalDeduction: 172.54, type: "BalanceDetails"),
        CryptoCoinModel(image: "dogwifhat",subCoinImage: "subCoinImage", coinName: "dogwifhat", totalMoney: 85.65, totalCoins: 57.25941, totalDeduction: 2.23, type: "BalanceDetails"),
        
        
        CryptoCoinModel(image: "tokenList", coinName: "Manage token list", totalMoney: 0, totalCoins: 0, totalDeduction: 0, type: "TokenCell")
   
    ]
}


struct AccountDetail {
    var totalAmount: Double
    var totalDeduction : Double
    var totalPercentage: Double
    var backgroundRed : String? = nil
    var backgroundGreen: String? = nil
    
    static let account : AccountDetail = AccountDetail(totalAmount: 8111.17, totalDeduction: 174.77, totalPercentage: 2.11, backgroundRed: "background", backgroundGreen: "backgroundGreen")
}
