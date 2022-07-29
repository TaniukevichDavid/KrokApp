import UIKit
import GoogleMaps
import CoreLocation
import Alamofire

class GoogleMapController: UIViewController {
    
    private var places: [Places] = []
    let manager = CLLocationManager()
    let mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGMSMapView()
        getData(url: "http://krokapp.by/api/get_points/11/")
        createPoints(markers: places)
        configureLocationManager()
    }
    
    private func setUpGMSMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func getData(url: String) {
        AF.request(url).responseJSON { responce in
            guard let result = responce.data else { return }
            do {
                self.places = try JSONDecoder().decode([Places].self, from: result).filter({$0.visible == true && $0.lang == 1})
                DispatchQueue.main.async {
                    self.createPoints(markers: self.places)
                }
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
    
    private func createPoints(markers: [Places]) {
        for marker in markers {
            let position = CLLocationCoordinate2D(latitude: marker.lat, longitude: marker.lng)
            let textPlace = marker.text.trimHTMLTags() ?? "<p>"
            let namePlace = marker.name.trimHTMLTags() ?? "<p>"
            let marker = GMSMarker(position: position)
            marker.title = "\(textPlace)"
            marker.snippet = namePlace
            marker.icon = GMSMarker.markerImage(with: UIColor.lightGray)
            marker.map = self.mapView
            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: 53.893009, longitude: 27.567444))
            mapView.animate(toZoom: 11)
        }
    }
    
    private func configureLocationManager() {
        manager.startUpdatingLocation()
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
    }
}

extension GoogleMapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("clicked on the marker!")
        var itemPhoto = ""
        var itemDataCreation = ""
        var itemInfo = ""
        var itemName = ""
        var itemSound = ""
        for item in places.filter({$0.lng == marker.position.longitude}) {
            itemPhoto = item.photo
            itemDataCreation = item.creation_date
            itemInfo = item.text.trimHTMLTags() ?? "<p>"
            itemName = item.name
            itemSound = item.sound
        }
        
        let detailsVC = DetailsViewController(placesPhoto: itemPhoto, dataCreation: itemDataCreation, infoPlaces: itemInfo, namePlaces: itemName, soundOfPlace: itemSound)
        self.navigationController?.pushViewController(detailsVC, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        navigationController?.modalPresentationStyle = .pageSheet
        return false
    }
    
}



