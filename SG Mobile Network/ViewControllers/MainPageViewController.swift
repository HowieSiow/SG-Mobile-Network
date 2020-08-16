//
//  MainPageViewController.swift
//  SG Mobile Network
//
//  Created by Howie Siow on 13/8/20.
//  Copyright © 2020 Chang. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {
    @IBOutlet var YearDataTableView: UITableView!
    var dataRecordItemArray = [DataRecordItem] ()
    var refinedDataRecordItemArray = [DataRecordItem] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()
        initialise();
        // Do any additional setup after loading the view.
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //getData()
    }
    
    func initialise() {
        getReferences()
        getData()
    }
    
    func getReferences() {
        YearDataTableView.delegate = self
        YearDataTableView.dataSource = self
    }
    
    func getData(){
        let connectionHelper = ConnectionHelper()
        let privateResources = PriviteResources()

        _ = connectionHelper.completeLoadAction(urlString: privateResources.getUrl()){
            result,isSuccess  in
            if isSuccess{
                //self.showMessage(message: result)
                self.convertToRecordObject(jsonStrong: result)
            }
            else{
                self.showMessage(message: result)
                //self.convertToRecordObject(jsonStrong: result)
            }
        }
    }
    
    func convertToRecordObject(jsonStrong:String){
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        
        do{
            let jsonData = try JSONSerialization.jsonObject(with: jsonStrong.data(using: .utf8)!, options: []) as? [String:Any]
            
            let records = (jsonData!["result"] as? [String:Any])!["records"]
            
            self.dataRecordItemArray = try decoder.decode([DataRecordItem].self, from: JSONSerialization.data(withJSONObject: records as Any, options: []))
            
            populateTableData(dataRecordItems: self.dataRecordItemArray)
        }
        catch let error{
            showMessage(message: error.localizedDescription)
        }
    }
    
    func populateTableData(dataRecordItems:[DataRecordItem]) {
        //to set the data at 2008 - 2018
        var yearlyDataRecordItemArray = [DataRecordItem]()
        var numberDeleted = 0
        var previousRecordYear = 0
        var currentRecordYear = 0
        var totalUsage = Double(0.0)
        var previousUsage = Double(0.0)
        var isDecrease = false
        for dataRecordItem in dataRecordItems.enumerated(){
            //to remove non 2008 - 2018 data
            var year = Int((dataRecordItem.element.quarter?.prefix(4))!)
            if(year! < 2008 || year! > 2019){
                dataRecordItemArray.remove(at: dataRecordItem.offset - numberDeleted)
                numberDeleted = numberDeleted + 1
            }
            else{
                if(previousRecordYear == 0){
                    previousRecordYear = year!
                    currentRecordYear = year!
                    totalUsage = Double(dataRecordItem.element.volume_of_mobile_data!)!
                    previousUsage = Double(dataRecordItem.element.volume_of_mobile_data!)!
                }
                else{
                    currentRecordYear = Int(year!)

                    if(currentRecordYear == previousRecordYear){
                        totalUsage = totalUsage + Double(dataRecordItem.element.volume_of_mobile_data!)!
                        previousRecordYear = year!
                        if(previousUsage > Double(dataRecordItem.element.volume_of_mobile_data!)!)
                        {
                            isDecrease = true
                        }
                        previousUsage = Double(dataRecordItem.element.volume_of_mobile_data!)!
                    }
                    else{
                        let temp = DataRecordItem()
                        temp.quarter = String(previousRecordYear)
                        temp.volume_of_mobile_data = String(totalUsage)
                        temp.hasDecrease = isDecrease
                        yearlyDataRecordItemArray.append(temp)
                        previousRecordYear = year!
                        previousUsage = Double(dataRecordItem.element.volume_of_mobile_data!)!
                        isDecrease = false
                        totalUsage = Double(dataRecordItem.element.volume_of_mobile_data!)!
                    }
                }
            }
        }
        dataRecordItemArray = yearlyDataRecordItemArray

        YearDataTableView.reloadData()
    }
    
    func showMessage(message:String){
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
                self.present(alert, animated: true)
    }
    
    func showMessageAtImageClick(message:String){
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
                self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataRecordItemArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YearDataTableViewCell", for: indexPath) as! YearDataTableViewCell
        
        cell.setCellContent(dataRecordItems: dataRecordItemArray, atIndex: indexPath.row)
        cell.delegate = self
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
