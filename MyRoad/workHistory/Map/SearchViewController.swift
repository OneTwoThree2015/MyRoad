//
//  SearchViewController.swift
//  workHistory
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var searchTxtField: UITextField!
    var search: AMapSearchAPI!
    var request : AMapPOIAroundSearchRequest!
    var addressArr = [AddressModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "地图搜索"
        addressTableView.delegate = self
        addressTableView.dataSource = self
        addressTableView.tableFooterView = UIView()
    }

    @IBAction func SearchBtn(sender: AnyObject) {
        addressArr.removeAll()
        addressTableView.reloadData()
        startSeacrh()
        searchTxtField.resignFirstResponder()
    }
    
    func startSeacrh(){
        
        if search == nil {
            search = AMapSearchAPI()
            search.delegate = self
        }
        if request == nil{
            request = AMapPOIAroundSearchRequest()
            request.types = "汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施"
            request.sortrule = 0
            request.requireExtension = true
        }
        
        request.location = AMapGeoPoint.locationWithLatitude(CGFloat(30.2721896988), longitude:CGFloat(120.1190488757))
        request.keywords = searchTxtField.text!
        search.AMapPOIAroundSearch(request)
        
    }
    
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0 {
            print("没结果")
            return
        }
        
        for poi in response.pois{
            let addressModel = AddressModel()
            let poi = (poi as! AMapPOI)
            addressModel.name = poi.name
            addressModel.address = poi.address
            addressModel.distance = poi.distance
            addressModel.location =  CLLocationCoordinate2D(latitude:Double(poi.location.latitude), longitude: Double(poi.location.longitude))
           addressArr.append(addressModel)
        }
        self.addressTableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("addressCell", forIndexPath: indexPath)

        cell.textLabel?.text = addressArr[indexPath.row].name
        cell.detailTextLabel?.text = addressArr[indexPath.row].address
        cell.selectionStyle = .None
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
