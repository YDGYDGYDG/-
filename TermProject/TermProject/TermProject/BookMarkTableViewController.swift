
import UIKit
import MapKit

class BookMarkTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fvo = Favorite()

    @IBOutlet weak var tbData: UITableView!
    var rests = [Restorant]()
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list : Array<Restorant> = self.fvo.config.object(forKey: "favoriteArray") as! Array<Restorant>
        
        return list.count
        
        /*
        if rests.count <= 0{
            return 0
        }
        else {
            return rests.count
        }*/
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarkCell", for: indexPath)
        /*
        if rests.count > 0{
            cell.textLabel?.text = rests[indexPath.row].title
            cell.detailTextLabel?.text = rests[indexPath.row].locationName
        }*/
        
        let list : Array<String> = self.fvo.config.object(forKey: "favoriteArray") as! Array<String>
        
        cell.textLabel?.text = list[indexPath.row]
        //cell.detailTextLabel?.text = list[indexPath.row].locationName

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToBookMarkedInform"{
            if let cell = sender as? UITableViewCell{
                let indexPath = tbData.indexPath(for: cell)
                if let informationTableViewController = segue.destination as? R_InformationTableViewController {
                    informationTableViewController.initialize(post: rests[(indexPath?.row)!])
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
