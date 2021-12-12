//
//  MyMapViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/12/12.
//

import UIKit
import MapKit

class MyMapViewController: BaseViewController {

    let mapView = MKMapView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        initV()
        bindConstraints()
        // apple mapkit
        let locationManager = CLLocationManager()
        
        // 정확도를 최고로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        addCustomAnnotation(lat: 37.55050341198298, long: 127.07328961168999)
    }
}

extension MyMapViewController {
    private func initV() {
        self.view.addSubview(mapView)
    }
    private func bindConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}



// MARK: - map kit 활용 부분
extension MyMapViewController {
    
    // 2
    class CustomAnnotation: NSObject, MKAnnotation
    {
        // 3
        var coordinate: CLLocationCoordinate2D
        var title: String?
        
        // 4
        init(coor: CLLocationCoordinate2D)
        {
            coordinate = coor
        }
    }
    
    // 4
    func addCustomAnnotation(lat: CLLocationDegrees, long : CLLocationDegrees) {
        let missionDoloresCoor = CLLocationCoordinate2DMake(lat, long)
        let pin = CustomAnnotation(coor: missionDoloresCoor)
        let spanValue = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
        let pRegion = MKCoordinateRegion(center: missionDoloresCoor, span: spanValue)
        mapView.setRegion(pRegion, animated: true)
        
        pin.title = "카페 딕셔너리 (광개토관 b1)"
       
        self.mapView.addAnnotation(pin)
    }
}

extension MyMapViewController : MKMapViewDelegate {
    
    // 3
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom pin")
        annotationView.image =  UIImage(named: "zesteMini")
        annotationView.canShowCallout = true
        return annotationView
    }
}


