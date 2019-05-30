//
//  Region_SearchViewController.swift
//  TermProject
//
//  Created by kpugame on 2019. 5. 30..
//  Copyright © 2019년 YDK. All rights reserved.
//

import UIKit

class Region_SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
    }
    
    var pickerDataSource = ["광진구", "구로구", "동대문구", "종로구"]
    var url : String = "https://openapi.gg.go.kr/Genrestrtcate"
    var sgguCd: String = "110023"
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0{
            sgguCd = "110023"
        }
        else if row == 1{
            sgguCd = "110005"
        }
        else if row == 2{
            sgguCd = "110007"
        }
        else {
            sgguCd = "110016"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTableView"{
            if let navController = segue.destination as? UINavigationController{
                if let informationTableViewController = navController.topViewController as? R_InformationTableViewController{
                    informationTableViewController.url = url + sgguCd
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
    }
    
    

}