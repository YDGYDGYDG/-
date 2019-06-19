
import UIKit
import MapKit

class R_InformationTableViewController: UITableViewController {
    
    var fvo = Favorite()
    
    @IBOutlet var detailTableView: UITableView!
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
    }
    
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
        
        var str = post.title! as NSString as String
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
        
        if segue.identifier == "segueToBookMark"{
            if let bookMarkViewController = segue.destination as? BookMarkTableViewController{
                bookMarkViewController.rests.append(resToMap)
                bookMarkViewController.fvo = fvo

            }
        }
    }
    
    
    // 즐겨찾기 추가 버튼(알림창을 통한 추가)
    @IBAction func addFavoriteBtn(sender: AnyObject) {
        
        let alert = UIAlertController(title: nil, message: "즐겨찾기 추가", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "추가", style: .default, handler: { (action) -> Void in
            
            var list : Array<Restorant> = self.fvo.config.object(forKey: "favoriteArray") as! Array<Restorant>
            list.append(self.resToMap.title!)
            
            self.fvo.config.set(list, forKey: "favoriteArray")
            
            self.tableView.reloadData()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
