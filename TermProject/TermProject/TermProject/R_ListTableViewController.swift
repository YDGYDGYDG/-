
import UIKit
import MapKit

class R_ListTableViewController: UIViewController, XMLParserDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tbData: UITableView!
    @IBOutlet weak var searchFooter: SearchFooter!
    
    var url: String?
    
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    var filteredPosts = NSMutableArray()
    var rests : [Restorant] = []
    var restName = NSString()
    var filteredRests : [Restorant] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    var lon : Double = 0
    var lat : Double = 0
    
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
    // 업종
    var resFd = NSMutableString()
    // 오픈일
    var resOpDt = NSMutableString()

    
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
            resFd = NSMutableString()
            resFd = ""
            resOpDt = NSMutableString()
            resOpDt = ""
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
        else if element.isEqual(to: "SANITTN_BIZCOND_NM"){
            resFd.append(string)
        }
        else if element.isEqual(to: "LICENSG_DE"){
            resOpDt.append(string)
        }
    }
    
    func loadInitialData(){
        for post in posts{
            let resNm = (post as AnyObject).value(forKey: "BIZPLC_NM") as! NSString as String
            let addr = (post as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSString as String
            let XPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSString as String
            lon = (XPos as NSString).doubleValue
            lat = (YPos as NSString).doubleValue
            let resFd = (post as AnyObject).value(forKey: "SANITTN_BIZCOND_NM") as! NSString as String
            let resOpDt = (post as AnyObject).value(forKey: "LICENSG_DE") as! NSString as String
            let restorant = Restorant(resNm: resNm, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), resFd: resFd, resOpDt: resOpDt)
            rests.append(restorant)
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
            if !resFd.isEqual(nil){
                elements.setObject(resFd, forKey: "SANITTN_BIZCOND_NM" as NSCopying)
            }
            if !resOpDt.isEqual(nil){
                elements.setObject(resOpDt, forKey: "LICENSG_DE" as NSCopying)
            }
            posts.add(elements)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredPosts.count, of: posts.count)
            return filteredPosts.count
        }
            
        searchFooter.setNotFiltering()
        
        return posts.count
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let resList : Restorant
        if isFiltering(){
            resList = filteredRests[indexPath.row]
            cell.textLabel!.text = resList.resNm
            cell.detailTextLabel!.text = resList.locationName
        }
        else{
            resList = rests[indexPath.row]
            cell.textLabel?.text = resList.resNm
            cell.detailTextLabel?.text = resList.locationName
            /*
             cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "BIZPLC_NM")
             as! NSString as String
             cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "REFINE_LOTNO_ADDR")
             as! NSString as String
            */
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRestorantInformation"{
            if let cell = sender as? UITableViewCell{
                let indexPath = tbData.indexPath(for: cell)
                restName = (posts.object(at: (indexPath?.row)!)as   AnyObject).value(forKey: "BIZPLC_NM") as! NSString
                
                if let informationTableViewController = segue.destination as?   R_InformationTableViewController{
                    if isFiltering(){
                        informationTableViewController.rests =  filteredRests[(indexPath?.row)!]
                    }
                    else {
                        informationTableViewController.rests =  rests[(indexPath?.row)!]
                    }
                    informationTableViewController.restName = restName
                }
            }
        }
        
        if segue.identifier == "segueToMapView"{
            if let mapViewController = segue.destination as? R_MapViewController{
                mapViewController.posts = posts
            }
        }
    }
    
    func searchBarIsEmpty () -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredRests = rests.filter({( restorant : Restorant) -> Bool in
            let doesCategoryMatch = (scope == "All") || (restorant.resFd == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            }
            else {
                return doesCategoryMatch && restorant.resNm.lowercased().contains(searchText.lowercased())
            }
        })
        tbData.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginParsing()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Restorants"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        tbData.tableFooterView = searchFooter
        
        loadInitialData()

    }
}


extension R_ListTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
