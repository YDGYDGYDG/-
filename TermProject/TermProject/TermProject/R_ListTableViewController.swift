
import UIKit

class R_ListTableViewController: UIViewController, XMLParserDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tbData: UITableView!
    @IBOutlet weak var searchFooter: SearchFooter!
    
    var url: String?
    
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    
    //
    var elements = NSMutableDictionary()
    var element = NSString()
    
    // 업소명
    var restNm = NSMutableString()
    // 주소
    var addr = NSMutableString()
    // 지도상 위치
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    // 업소명을 주소로 주기 위한 저장
    var restorantname = ""
    var restorantname_utf8 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        tbData.tableFooterView = searchFooter
    }
    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf: (URL(string: url!))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "row"){
            elements = NSMutableDictionary()
            elements = [:]
            restNm = NSMutableString()
            restNm = ""
            addr = NSMutableString()
            addr = ""
            XPos = NSMutableString()
            XPos = ""
            YPos = NSMutableString()
            YPos = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "BIZPLC_NM"){
            restNm.append(string)
        }
        else if element.isEqual(to: "REFINE_LOTNO_ADDR"){
            addr.append(string)
        }
            
        else if element.isEqual(to: "REFINE_WGS84_LOGT"){
            XPos.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LAT"){
            YPos.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "row"){
            if !restNm.isEqual(nil){
                elements.setObject(restNm, forKey: "BIZPLC_NM" as NSCopying)
            }
            
            if !addr.isEqual(nil){
                elements.setObject(addr, forKey: "REFINE_LOTNO_ADDR" as NSCopying)
            }
            
            if !XPos.isEqual(nil){
                elements.setObject(XPos, forKey: "REFINE_WGS84_LOGT" as NSCopying)
            }
            if !YPos.isEqual(nil){
                elements.setObject(YPos, forKey: "REFINE_WGS84_LAT" as NSCopying)
            }
            posts.add(elements)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "BIZPLC_NM")
            as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR")
            as! NSString as String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRestorantInformation"{
            //if let cell = sender as? UITableViewCell{
                //let indexPath = tableView.indexPath(for: cell)
                
                //restorantname = (posts.object(at: (indexPath?.row)!)as AnyObject).value(forKey: "BIZPLC_NM") as! NSString as String
                //restorantname_utf8 = restorantname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                
                if let informationTableViewController = segue.destination as? R_InformationTableViewController{
                    informationTableViewController.url = url
                }
            //}
        }
        
        if segue.identifier == "segueToMapView"{
            if let mapViewController = segue.destination as? R_MapViewController{
                mapViewController.posts = posts
            }
        }
    }
    
}
