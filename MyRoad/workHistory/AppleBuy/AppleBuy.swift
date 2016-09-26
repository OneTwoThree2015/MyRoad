//
//  AppleBuy.swift
//  workHistory
//
//  Created by Elley on 16/9/13.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class AppleBuy: NSObject,SKPaymentTransactionObserver,SKProductsRequestDelegate {
    private let VERIFY_RECEIPT_URL = "https://buy.itunes.apple.com/verifyReceipt"
    private let ITMS_SANDBOX_VERIFY_RECEIPT_URL = "https://sandbox.itunes.apple.com/verifyReceipt"
    private var productDict:NSMutableDictionary!
    var Id = ""
    var num = 0
    var payment = SKPayment()
    var g_payment = SKMutablePayment()
    
    init(productId:String,buyNum:Int) {
        super.init()
        //添加一个交易队列观察者
        Id = productId
        num = buyNum
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
    }
    
    func buyProduct(){
        
        if SKPaymentQueue.canMakePayments(){
            buyThroughProductId(Id)
        }else{
            print("不允许内付款")
        }
    
    }
    
    func buyThroughProductId(productId:String){
        let arry = [productId]
        let set = NSSet(array: arry)
        
        let request = SKProductsRequest(productIdentifiers: set as! Set<String>)
        request.delegate = self
        request.start()
    }
    
    
    // SKProductsRequestDelegate
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        //接收商品信息
        let product = response.products
        if product.isEmpty{
            return
        }
        // SKProduct对象包含了在App Store上注册的商品的本地化信息。
        var storeProduct = SKProduct()
        for pro in product{
            if pro.productIdentifier == Id{
                storeProduct = pro
            }
        }
        self.g_payment = SKMutablePayment(product: storeProduct)
        self.g_payment.quantity = num
        SKPaymentQueue.defaultQueue().addPayment(g_payment)
    }
    
    func request(request: SKRequest, didFailWithError error: NSError) {
        print("请求商品信息失败")
    }
    func requestDidFinish(request: SKRequest) {
        
    }
    
    //SKPaymentTransactionObserver
    //监听购买结果
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if (SKPaymentTransactionState.Purchased == transaction.transactionState) {
                // 更新界面或者数据，把用户购买得商品交给用户
                print("支付成了")
                // 验证购买凭据
                self.verifyPruchase()
                // 将交易从交易队列中删除
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
            }
            else if(SKPaymentTransactionState.Failed == transaction.transactionState){
                print("支付失败")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
            }
            else if (SKPaymentTransactionState.Restored == transaction.transactionState) {
                // 恢复购买
                // 更新界面或者数据
                // 将交易从交易队列中删除
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
            }else if(SKPaymentTransactionState.Purchasing == transaction.transactionState){
                // 交易正在进行
                print("purchasing")
            }else if(SKPaymentTransactionState.Deferred == transaction.transactionState){
                // 内购延迟
                print("Deferred")
            }
        }
    }
    
    func verifyPruchase(){
        // 验证凭据，获取到苹果返回的交易凭据
        // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
        let receiptURL = NSBundle.mainBundle().appStoreReceiptURL
        // 从沙盒中获取到购买凭据
        let receiptData = NSData(contentsOfURL: receiptURL!)
        // 发送网络POST请求，对购买凭据进行验证
        let url = NSURL(string: ITMS_SANDBOX_VERIFY_RECEIPT_URL)
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        let encodeStr = receiptData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)
        
        let payload = NSString(string: "{\"receipt-data\" : \"" + encodeStr! + "\"}")
        //        print(payload)
        let payloadData = payload.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = payloadData;
        
        let session = NSURLSession.sharedSession()
        let semaphore = dispatch_semaphore_create(0)
        
        let dataTask = session.dataTaskWithRequest(request,
                                                   completionHandler: {(data, response, error) -> Void in
                                                    if error != nil{
                                                        print(error?.code)
                                                        print(error?.description)
                                                    }else{
                                                        
                                                        //                    let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
                                                        //                    print(str)
                                                        // 官方验证结果为空
                                                        if (data==nil) {
                                                            //验证失败
                                                            return
                                                        }
                                                        do{
                                                            let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                                                            if (jsonResult.count != 0) {
                                                                // 比对字典中以下信息基本上可以保证数据安全
                                                                // bundle_id&application_version&product_id&transaction_id
                                                                // 凭证验证成功
                                                                let receipt = jsonResult["receipt"] as! NSDictionary
                                                                print(receipt["bundle_id"])
                                                            }
                                                        }catch{
                                                            print("验证凭证出错")
                                                        }
                                                    }
                                                    
                                                    dispatch_semaphore_signal(semaphore)
        }) as NSURLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }

}
