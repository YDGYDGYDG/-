

import Foundation

import MapKit

import Contacts


class Restorant: NSObject, MKAnnotation{
    
    // 상호
    let resNm: String
    // 주소
    let locationName: String
    // 지도상위치
    let coordinate: CLLocationCoordinate2D
    // 업종명 (카페, 일식 등)
    let resFd: String
    // 개점 일자
    let resOpDt: String
    
    init(resNm: String,
         locationName:String,
         coordinate:CLLocationCoordinate2D,
         resFd: String,
         resOpDt: String) {
        self.resNm = resNm
        self.locationName = locationName
        self.coordinate = coordinate
        self.resFd = resFd
        self.resOpDt = resOpDt

        super.init()
    }
    
    
    var subtitle:String?{
        return locationName
    }
    
    func mapItem() -> MKMapItem{
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = resNm
        
        return mapItem
        
    }
    
}
