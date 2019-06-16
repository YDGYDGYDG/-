
import UIKit
import MapKit

class R_MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var lon : Double = 0
    var lat : Double = 0
    
    let regionRadius: CLLocationDistance = 5000
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    var restorants: [Restorant] = []
    
    func initializeLInformToMap(post : Restorant!)
    {
        lat = post.coordinate.latitude
        lon = post.coordinate.longitude
     let newRes = Restorant(title: post.title!, locationName: post.locationName, coordinate: post.coordinate, resFd: post.resFd, resOpDt: post.resOpDt)
        restorants.append(newRes)
    }
    
    func initializeListToMap(post : [Restorant]!)
    {
        lat = (post.last?.coordinate.latitude)!
        lon = (post.last?.coordinate.longitude)!
        let newRes : [Restorant] = post
        restorants = newRes
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
        
        let initialLocation = CLLocation(latitude: lat, longitude: lon)
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        mapView.addAnnotations(restorants)
    }
    
}
