
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
    var BIZPLC_NM = NSMutableString()
    // 주소
    var REFINE_LOTNO_ADDR = NSMutableString()
    // 지도상 위치
    var REFINE_WGS84_LOGT = NSMutableString()
    var REFINE_WGS84_LAT = NSMutableString()
    // 업종
    var SANITTN_BIZCOND_NM = NSMutableString()
    // 오픈일
    var LICENSG_DE = NSMutableString()

    
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
            BIZPLC_NM           = NSMutableString()
            BIZPLC_NM           = ""
            REFINE_LOTNO_ADDR   = NSMutableString()
            REFINE_LOTNO_ADDR   = ""
            REFINE_WGS84_LOGT   = NSMutableString()
            REFINE_WGS84_LOGT   = ""
            REFINE_WGS84_LAT    = NSMutableString()
            REFINE_WGS84_LAT    = ""
            SANITTN_BIZCOND_NM = NSMutableString()
            SANITTN_BIZCOND_NM = ""
            LICENSG_DE          = NSMutableString()
            LICENSG_DE          = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "BIZPLC_NM"){
            BIZPLC_NM.append(string)
        }
        else if element.isEqual(to: "REFINE_LOTNO_ADDR"){
            REFINE_LOTNO_ADDR.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LOGT"){
            REFINE_WGS84_LOGT.append(string)
        }
        else if element.isEqual(to: "REFINE_WGS84_LAT"){
            REFINE_WGS84_LAT.append(string)
        }
        else if element.isEqual(to: "SANITTN_BIZCOND_NM"){
            SANITTN_BIZCOND_NM.append(string)
        }
        else if element.isEqual(to: "LICENSG_DE"){
            LICENSG_DE.append(string)
        }
    }
    
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "row"){
            if !BIZPLC_NM.isEqual(nil){
                elements.setObject(BIZPLC_NM, forKey: "BIZPLC_NM" as NSCopying)
            }
            if !REFINE_LOTNO_ADDR.isEqual(nil){
                elements.setObject(REFINE_LOTNO_ADDR, forKey: "REFINE_LOTNO_ADDR" as NSCopying)
            }
            if !REFINE_WGS84_LOGT.isEqual(nil){
                elements.setObject(REFINE_WGS84_LOGT, forKey: "REFINE_WGS84_LOGT" as NSCopying)
            }
            if !REFINE_WGS84_LAT.isEqual(nil){
                elements.setObject(REFINE_WGS84_LAT, forKey: "REFINE_WGS84_LAT" as NSCopying)
            }
            if !SANITTN_BIZCOND_NM.isEqual(nil){
                elements.setObject(SANITTN_BIZCOND_NM, forKey: "SANITTN_BIZCOND_NM" as NSCopying)
            }
            if !LICENSG_DE.isEqual(nil){
                elements.setObject(LICENSG_DE, forKey: "LICENSG_DE" as NSCopying)
            }
            posts.add(elements)
        }
    }
    
    
    func loadInitialData(){
        for post in self.posts{
            let BIZPLC_NM = (post as AnyObject).value(forKey: "BIZPLC_NM") as! NSString as String
            let REFINE_LOTNO_ADDR = (post as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSString as String
            let REFINE_WGS84_LOGT = (post as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSString as String
            let REFINE_WGS84_LAT = (post as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSString as String
            lon = (REFINE_WGS84_LOGT as NSString).doubleValue
            lat = (REFINE_WGS84_LAT as NSString).doubleValue
            let SANITTN_BIZCOND_NM = (post as AnyObject).value(forKey: "SANITTN_BIZCOND_NM") as! NSString as String
            let LICENSG_DE = (post as AnyObject).value(forKey: "LICENSG_DE") as! NSString as String
            let restorant = Restorant(title: BIZPLC_NM, locationName: REFINE_LOTNO_ADDR, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), resFd: SANITTN_BIZCOND_NM, resOpDt: LICENSG_DE)
            rests.append(restorant)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredRests.count, of: rests.count)
            return filteredRests.count
        }
            
        searchFooter.setNotFiltering()
        
        return rests.count
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let resList : Restorant
        if isFiltering(){
            resList = filteredRests[indexPath.row]
        }
        else{
            resList = rests[indexPath.row]
        }
        cell.textLabel?.text = resList.title
        cell.detailTextLabel?.text = resList.locationName

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRestorantInformation"{
            if let cell = sender as? UITableViewCell{
                let indexPath = tbData.indexPath(for: cell)
                
                if let informationTableViewController = segue.destination as? R_InformationTableViewController {
                    if isFiltering(){
                        informationTableViewController.initialize(post: filteredRests[(indexPath?.row)!])
                    }
                    else {
                        //informationTableViewController.initialize(post: posts.object(at: (indexPath?.row)!)as AnyObject)
                        informationTableViewController.initialize(post: rests[(indexPath?.row)!])
                    }
                }
 
            }
        }
        
        if segue.identifier == "segueToMapView"{
            if let mapViewController = segue.destination as? R_MapViewController{
                if isFiltering(){
                    mapViewController.initializeListToMap(post: filteredRests.self)
                }
                else {
                    mapViewController.initializeListToMap(post: rests.self)
                }
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
                return doesCategoryMatch && restorant.title!.lowercased().contains(searchText.lowercased())
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
        
        searchController.searchBar.scopeButtonTitles = ["All", "까페", "일식", "중식", "패스트푸드"]
        searchController.searchBar.delegate = self as UISearchBarDelegate
        
        tbData.tableFooterView = searchFooter
        
        loadInitialData()

    }
}


extension R_ListTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension R_ListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
