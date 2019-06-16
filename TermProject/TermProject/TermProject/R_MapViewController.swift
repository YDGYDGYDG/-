
import UIKit
import MapKit

class R_MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var posts = NSMutableArray()
    
    var lon : Double = 0
    var lat : Double = 0
    
    let regionRadius: CLLocationDistance = 5000
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    var restorants: [Restorant] = []
    
    func loadInitialData(){
        for post in posts{
            let resNm = (post as AnyObject).value(forKey: "BIZPLC_NM") as! NSString as String
            let addr = (post as AnyObject).value(forKey: "REFINE_LOTNO_ADDR") as! NSString as String
            let XPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSString as String
            lon = (XPos as NSString).doubleValue
            lat = (YPos as NSString).doubleValue
            let resFd = (post as AnyObject).value(forKey: "SANITTN_BIZCOND_NM") as! NSString as String
            let resOpDt = (post as AnyObject).value(forKey: "LICENSG_DE") as! NSString as String
            let restorant = Restorant(resNm: resNm, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), resFd: resFd, resOpDt: resOpDt)
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
        
        mapView.delegate = self
        
        loadInitialData()
        
        let initialLocation = CLLocation(latitude: lat, longitude: lon)
        centerMapOnLocation(location: initialLocation)
        
        mapView.addAnnotations(restorants)
    }
    
}
