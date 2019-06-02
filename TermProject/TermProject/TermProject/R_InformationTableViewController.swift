
import UIKit

class R_InformationTableViewController: UITableViewController, XMLParserDelegate {
    
    @IBOutlet var detailTableView: UITableView!
    
    var url: String?
    var parser = XMLParser()
    
    let postsname : [String] = ["업소명", "업종", "주소(지번)", "주소(도로명)", "개업일", "운영 여부"]
    var posts : [String] = ["","","","","",""]
    
    var mapPosts = NSMutableArray()
    var mapElements : [String] = ["","","",""]
    
    var element = NSString()
    
    var restNm = NSMutableString()
    var restFd = NSMutableString()
    var addr = NSMutableString()
    var addrRM = NSMutableString()
    var openDate = NSMutableString()
    var nowOn = NSMutableString()
    
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf: (URL(string: url!))!)!
        parser.delegate = self
        parser.parse()
        detailTableView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginParsing()
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "row"){
            posts = ["","","","","",""]
            
            restNm = NSMutableString()
            restNm = ""
            restFd = NSMutableString()
            restFd = ""
            addr = NSMutableString()
            addr = ""
            addrRM = NSMutableString()
            addrRM = ""
            openDate = NSMutableString()
            openDate = ""
            nowOn = NSMutableString()
            nowOn = ""
            
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
        else if element.isEqual(to: "SANITTN_BIZCOND_NM"){
            restFd.append(string)
            
        }
        else if element.isEqual(to: "REFINE_LOTNO_ADDR"){
            addr.append(string)
            
        }
        else if element.isEqual(to: "REFINE_ROADNM_ADDR"){
            addrRM.append(string)
            
        }
        else if element.isEqual(to: "LICENSG_DE"){
            openDate.append(string)
            
        }
        else if element.isEqual(to: "BSN_STATE_NM"){
            nowOn.append(string)
            
        }
            
        else if element.isEqual(to: "REFINE_WGS84_LAT"){
            XPos.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LOGT"){
            YPos.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "row"){
            if !restNm.isEqual(nil){
                posts[0] = restNm as String
                mapElements[0] = restNm as String
            }
            if !restFd.isEqual(nil){
                posts[1] = restFd as String
            }
            if !addr.isEqual(nil){
                posts[2] = addr as String
                mapElements[1] = addr as String
            }
            if !addrRM.isEqual(nil){
                posts[3] = addrRM as String
            }
            if !openDate.isEqual(nil){
                posts[4] = openDate as String
            }
            if !nowOn.isEqual(nil){
                posts[5] = nowOn as String
            }
            if !XPos.isEqual(nil){
                mapElements[2] = XPos as String
            }
            if !YPos.isEqual(nil){
                mapElements[3] = YPos as String
            }
            mapPosts.add(mapElements)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestorantCell", for: indexPath)
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMapView"{
            if let mapViewController = segue.destination as? R_MapViewController{
                mapViewController.posts = mapPosts
            }
        }
    }
}
