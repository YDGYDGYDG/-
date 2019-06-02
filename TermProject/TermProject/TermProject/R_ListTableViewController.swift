
import UIKit

class R_ListTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var tbData: UITableView!
    
    var url: String?
    
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var yadmNm = NSMutableString()
    var addr = NSMutableString()
    
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
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
            yadmNm = NSMutableString()
            yadmNm = ""
            addr = NSMutableString()
            addr = ""
            XPos = NSMutableString()
            XPos = ""
            YPos = NSMutableString()
            YPos = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "SIGUN_NM"){
            yadmNm.append(string)
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
            if !yadmNm.isEqual(nil){
                elements.setObject(yadmNm, forKey: "SIGUN_NM" as NSCopying)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "SIGUN_NM")
            as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR")
            as! NSString as String
        
        return cell
    }
    
    
    
    
}
