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
    var annotations: [MKPointAnnotation]
    
    func makeUIView(context: UIViewRepresentableContext<Map>) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        map.setUserTrackingMode(.follow, animated: true)
//        map.isZoomEnabled = false
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<Map>) {
        guard let point = coordinate else {
            return
        }
        if annotations.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(self.annotations)
        }
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: point
            , span: span)
        uiView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
