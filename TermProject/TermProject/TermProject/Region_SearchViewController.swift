

import UIKit

class Region_SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
    }
    
    var SIGUN_NMList : [String]
    = [ "가평군",
        "과천시",
        "광명시",
        "광주시",
        "고양시",
        "구리시",
        "군포시",
        "김포시",
        "남양주시",
        "동두천시",
        "부천시",
        "성남시",
        "수원시",
        "시흥시",
        "안산시",
        "안성시",
        "안양시",
        "양주시",
        "양평군",
        "여주시",
        "연천군",
        "오산시",
        "용인시",
        "의왕시",
        "의정부시",
        "이천시",
        "파주시",
        "평택시",
        "포천시",
        "하남시",
        "화성시"]
    var SIGUN_NM : String = ""
    var url : String = "https://openapi.gg.go.kr/Genrestrtcate?KEY=aade671fa9c8412ba273f83db26a49e6&pIndex=1&pSize=100&SIGUN_NM="
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SIGUN_NMList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SIGUN_NMList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 1:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 2:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 3:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 4:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 5:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 6:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 7:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 8:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 9:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 10:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 11:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 12:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 13:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 14:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 15:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 16:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 17:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 18:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 19:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 20:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 21:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 22:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 23:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 24:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 25:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 26:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 27:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 28:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 29:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        case 30:
            SIGUN_NM = "\(SIGUN_NMList[row])"
            break;
        default:
            break;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRestorantList"{
            if let navController = segue.destination as? UINavigationController{
                if let listTableViewController = navController.topViewController as? R_ListTableViewController{
                    listTableViewController.url = url + SIGUN_NM
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
