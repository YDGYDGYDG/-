
import UIKit
import MapKit

class R_InformationTableViewController: UITableViewController {
    
    @IBOutlet var detailTableView: UITableView!
    
    let postsname : [String] = ["업소명", "주소(지번)", "업종", "개업일"]
    var posts : [String] = ["","","",""]
    var parameters : [String] =
        ["restNm", "locationName", "resFd", "resOpDt"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var resToMap : Restorant = Restorant(title: "", locationName: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), resFd: "", resOpDt: "")
    
    func initialize(post : Restorant!)
    {
        resToMap = post
        
        var str = post.title as! NSString as String
        posts[0] = str
        str = post.locationName as NSString as String
        posts[1] = str
        str = post.resFd as NSString as String
        posts[2] = str
        str = post.resOpDt as NSString as String
        posts[3] = str
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
                mapViewController.initializeLInformToMap(post: resToMap)
            }
        }
    }
}
