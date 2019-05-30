
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "mblogthumb1.phinf.naver.net.jpeg")!
        TileImage.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
        TileImage.image = image
        
    }


}

