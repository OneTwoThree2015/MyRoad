//
//  AppleBuyViewController.swift
//  workHistory
//
//  Created by Elley on 16/9/13.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class AppleBuyViewController: UIViewController,SKProductsRequestDelegate,SKPaymentTransactionObserver {
    private var productId = ""   //商品id
    private var productDict:NSMutableDictionary!
    let ITMS_SANDBOX_VERIFY_RECEIPT_URL = "https://sandbox.itunes.apple.com/verifyReceipt" //测试环境
    
    let ITMS_VERIFY_RECEIPT_URL = "https://buy.itunes.apple.com/verifyReceipt"//正式环境
    
    @IBOutlet weak var buy1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ApplePay"
        //SKPaymentQueue与服务器端交互付款队列
        //添加队列观察者
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        purchaseProduct()
    }
    
    
    
    
    @IBAction func buy1Action(sender: AnyObject) {
        bugProdcut(productDict.valueForKey("appleTest.00001") as! SKProduct )
    }
    
    
    deinit{
        //移除队列观察者
        SKPaymentQueue.defaultQueue().removeTransactionObserver(self)
    }
    
    
    //===========================商品购买前的验证=============================
    //MARK: - 验证是否能内购
    func purchaseProduct(){
        if SKPaymentQueue.canMakePayments(){
            buyThroughProductId()
        }else{
            print("不支持内购")
            SKPaymentQueue.defaultQueue().removeTransactionObserver(self)
        }
    }
    //MARK: - 询问苹果服务器能够销售那些商品
    func buyThroughProductId(){
        let arry = ["appleTest.00001"]  //商品id数组
        let set = NSSet(array: arry)
        let request = SKProductsRequest(productIdentifiers: set as! Set<String>)
        request.delegate = self
        request.start()
    }
    
    //MARK: - SKProductsRequestDelegate
    //MARK: - 验证查询的回调（返回查询商品信息）
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        if productDict == nil{
            productDict = NSMutableDictionary(capacity: response.products.count)
        }
        //返回的products 是可以销售的商品
        for  product in response.products{
            print("productId:\(product.productIdentifier)") //商品id
            print("productTitle:\(product.localizedTitle)")//商品标题
            print("productDescription:\(product.localizedDescription)")//商品描述
            print("productPrice:\(product.price)")//商品价格
            productDict.setObject(product, forKey: product.productIdentifier)
        }
    }
    
    
    func requestDidFinish(request: SKRequest) {
        
    }
    func request(request: SKRequest, didFailWithError error: NSError) {
        print(error)
    }
    
    //===========================商品购买=============================
    
    func bugProdcut(product:SKProduct){
        let payment = SKPayment(product: product)
        //向服务器添加一个付款队列
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
    //MARK: - SKPaymentTransactionObserver
    //发送事务回调
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions{
            switch transaction.transactionState {
            case .Purchased:
                verifyPruchase()
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
            case .Purchasing:
                print("商品添加进列表")
            case .Restored:
                print("已经购买过商品")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
            case .Failed:
                print("购买商品失败")
                SKPaymentQueue.defaultQueue().finishTransaction(transaction)
            default:
                break
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
        // 国内访问苹果服务器比较慢，timeoutInterval需要长一点
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        // 在网络中传输数据，大多情况下是传输的字符串而不是二进制数据
        // 传输的是BASE64编码的字符串
        /**
         BASE64 常用的编码方案，通常用于数据传输，以及加密算法的基础算法，传输过程中能够保证数据传输的稳定性
         BASE64是可以编码和解码的
         */
        let encodeStr = receiptData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)
        
        let payload = NSString(string: "{\"receipt-data\" : \"" + encodeStr! + "\"}")
        
        let payloadData = payload.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = payloadData
        
        do{
            let result = try NSURLConnection.sendSynchronousRequest(request, returningResponse:nil)
            // 官方验证结果为空
            do{
                let dic = try NSJSONSerialization.JSONObjectWithData(result, options: NSJSONReadingOptions.AllowFragments)
                print(dic)
                let status = dic.valueForKey("status") as! Int
                if status == 0 {
                    print("购买验证成功")
                }else{
                    print("购买验证失败")
                }
                
            }catch{
                print(error)
            }
            
            
        }catch {
            print(error)
        }
    }

}
