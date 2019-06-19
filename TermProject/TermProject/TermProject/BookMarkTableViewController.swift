
import UIKit
import MapKit

class BookMarkTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var rests = [Restorant]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rests.count <= 0{
            return 0
        }
        else {
            return rests.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarkCell", for: indexPath)
        if rests.count > 0{
            cell.textLabel?.text = rests[indexPath.row].title
            cell.detailTextLabel?.text = rests[indexPath.row].locationName
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
