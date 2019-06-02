
import UIKit
import MapKit

class R_MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var posts = NSMutableArray()
    
    let regionRadius: CLLocationDistance = 5000
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    var restorants: [Restorant] = []
    
    func loadInitialData(){
        for post in posts{
            let sigunNm = (post as AnyObject).value(forKey: "SIGUN_NM") as! NSString as String
            let addr = (post as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSString as String
            let XPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSString as String
            let lon = (XPos as NSString).doubleValue
            let lat = (YPos as NSString).doubleValue
            let restorant = Restorant(title: sigunNm, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            restorants.append(restorant)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Restorant
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Restorant else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        }
        else{
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 37.5384514, longitude: 127.0709764)
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        
        loadInitialData()
        mapView.addAnnotations(restorants)
    }
    
    

}
