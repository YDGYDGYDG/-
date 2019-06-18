
import UIKit
import MapKit

class BookMarkTableViewController: UITableViewController {
    
    var rests = [Restorant]()
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rests.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarkCell", for: indexPath)
        cell.textLabel?.text = rests[indexPath.row].title
        cell.detailTextLabel?.text = rests[indexPath.row].locationName
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
