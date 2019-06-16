
import UIKit
import MapKit

class R_InformationTableViewController: UITableViewController {
    
    @IBOutlet var detailTableView: UITableView!
    
    let postsname : [String] = ["업소명", "주소(지번)", "업종", "개업일"]
    var posts : [String] = ["","","",""]
    
    var mapPosts = NSMutableArray()
    var mapElements : [String] = ["","","",""]
    
    var restName = NSString()
    var rests = Restorant(resNm: "default", locationName: "default", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), resFd: "default", resOpDt: "default")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
    }
    
    
    func loadInitialData(){
        posts[0] = rests.resNm
        posts[1] = rests.locationName
        posts[2] = rests.resFd
        posts[3] = rests.resOpDt
        
        detailTableView.reloadData()
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
