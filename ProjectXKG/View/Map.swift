//
//  MapView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 19/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI
import MapKit

struct Map: UIViewRepresentable {
    
    var coordinate: CLLocationCoordinate2D?
    var annotations = [MKAnnotation]()
    
    init(coordinate: CLLocationCoordinate2D?, annotations: [MKAnnotation]) {
        self.coordinate = coordinate
        self.annotations = annotations
    }
    
    func makeUIView(context: UIViewRepresentableContext<Map>) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        map.setUserTrackingMode(.follow, animated: true)
//        map.isZoomEnabled = false
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<Map>) {
//        annotationsToConsole(from: annotations)
        guard let point = coordinate else {
            return
        }
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(self.annotations)
        let latDelta:CLLocationDegrees = 0.005
        let lonDelta:CLLocationDegrees = 0.005
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: point, span: span)
        uiView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: DO USUNIECIA
    func annotationsToConsole(from annotations: [MKAnnotation]) {
        print("______________________________________________________________________________________________")
        print("Ilosc adnotacji \(annotations.count)")
        for annotation in annotations {
            print(annotation.subtitle ?? "Brak opisu" )
        }
        print("______________________________________________________________________________________________")
    }
    
}
