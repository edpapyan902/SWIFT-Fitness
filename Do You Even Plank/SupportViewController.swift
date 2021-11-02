//
//  SupportViewController.swift
//  Do You Even Plank
//
//  Created by iDeveloper on 8/11/16.
//  Copyright © 2016 iDeveloper. All rights reserved.
//

import UIKit
//import StoreKit



class SupportViewController: UIViewController {

    
 //   var productIDs: Array<String!> = []
    
//    var productsArray: Array<SKProduct!> = []
    
 //   var selectedProductIndex: Int! = 0

 //   var transactionInProgress = false
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
 //       productIDs.append("DoYouEvenPlankGold")
        
  //      requestProductInfo()
        
 //       SKPaymentQueue.defaultQueue().addTransactionObserver(self)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func requestProductInfo() {
//        if SKPaymentQueue.canMakePayments() {
//            let productIdentifiers = NSSet(array: productIDs)
//            let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
//            
//            productRequest.delegate = self
//            productRequest.start()
//        }
//        else {
//            print("Cannot perform In App Purchases.")
//        }
//    }
//
//    
//
//    @IBAction func buyBtn(sender: UIButton) {
//        showActions()
//    }
//    func showActions() {
//        if transactionInProgress {
//            return
//        }
//        
//        let actionSheetController = UIAlertController(title: "Do You Even Plank", message: "What do you want to do?", preferredStyle: UIAlertControllerStyle.ActionSheet)
//        
//        let buyAction = UIAlertAction(title: "Buy", style: UIAlertActionStyle.Default) { (action) -> Void in
//            let payment = SKPayment(product: self.productsArray[self.selectedProductIndex] as SKProduct)
//            SKPaymentQueue.defaultQueue().addPayment(payment)
//            self.transactionInProgress = true
//        }
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
//            
//        }
//        
//        actionSheetController.addAction(buyAction)
//        actionSheetController.addAction(cancelAction)
//        
//        presentViewController(actionSheetController, animated: true, completion: nil)
//    }
//
//    
//    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
//        if response.products.count != 0 {
//            for product in response.products {
//                productsArray.append(product )
//            }
//            
//        }
//        else {
//            print("There are no products.")
//        }
//        
//        if response.invalidProductIdentifiers.count != 0 {
//            print(response.invalidProductIdentifiers.description)
//        }
//    }
//
//    
//    
//    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        for transaction in transactions {
//            switch transaction.transactionState {
//            case SKPaymentTransactionState.Purchased:
//                print("Transaction completed successfully.")
//                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
//                transactionInProgress = false
//                
//                
//            case SKPaymentTransactionState.Failed:
//                print("Transaction Failed");
//                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
//                transactionInProgress = false
//                
//            default:
//                print(transaction.transactionState.rawValue)
//            }
//        }
//    }




    @IBAction func onBtnBack(){
        self.dismissViewControllerAnimated(true) { 
            
        }
    }

}
