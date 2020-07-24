//
//  MapView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 19/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    var coordinate: CLLocationCoordinate2D?
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        map.setUserTrackingMode(.follow, animated: true)
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        if let aktualizacja = coordinate  {
            print("aktualizacja \(aktualizacja)")
            let latitude:CLLocationDegrees = coordinate!.latitude
            let longitude:CLLocationDegrees = coordinate!.longitude
            let latDelta:CLLocationDegrees = 0.05
            let lonDelta:CLLocationDegrees = 0.05
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let location = CLLocationCoordinate2DMake(latitude, longitude)
            let region = MKCoordinateRegion(center: coordinate!, span: span)
            uiView.setRegion(region, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
