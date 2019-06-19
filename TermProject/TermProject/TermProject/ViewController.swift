
import UIKit

class ViewController: UIViewController {
    //========================================================================
    // 오디오
    var audioController: AudioController
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEffect(audioFileNames: AudioEffectFiles)
        
        super.init(coder: aDecoder)
    }
    
    //========================================================================
    @IBOutlet weak var TileImage: UIImageView!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func ActionStart(_ sender: Any) {
            let explore = ExplodeView(frame: CGRect(x: (startButton.imageView?.center.x)!, y: (startButton.imageView?.center.y)!, width: 1, height: 1))
            startButton.imageView?.superview?.addSubview(explore)
            startButton.imageView?.superview?.sendSubviewToBack(explore)
            audioController.playerEffect(name: soundDing)
    }
    
    func dustCircle() {
        let startX: CGFloat = ScreenWidth/2
        let startY: CGFloat = 0
        let endY: CGFloat = ScreenHeight
        
        let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 1, height: 1))
        self.view.addSubview(stars)
        self.view.sendSubviewToBack(stars)
        
        UIView.animate(withDuration: 5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            stars.center = CGPoint(x: startX, y: endY)
        })
        { (value:Bool) in
            stars.removeFromSuperview()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "mblogthumb1.phinf.naver.net.jpeg")!
        TileImage.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
        TileImage.image = image
        
        //dustCircle()
        let startX: CGFloat = ScreenWidth/2
        let startY: CGFloat = 0
        let endY: CGFloat = ScreenHeight
        
        let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 1, height: 1))
        self.view.addSubview(stars)
        self.view.sendSubviewToBack(stars)
        
    }


}

