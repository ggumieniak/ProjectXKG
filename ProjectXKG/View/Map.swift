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
    
    @Binding var coordinate: CLLocation?
    
    func makeUIView(context: UIViewRepresentableContext<Map>) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        map.setUserTrackingMode(.follow, animated: true)
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<Map>) {
        // TODO: Do userdefaults value that saves that user pressed to lock map at center or not
        guard let point = coordinate else {
            return
        }
        if SharedReports.shared.summaryAccidentArray.count + 1 != uiView.annotations.count { // uiView.annotations always have 1 more object in array because there is nil object as additional
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(SharedReports.shared.summaryAccidentArray)
        }
        let latDelta:CLLocationDegrees = userDefaultsToSpan()
        let lonDelta:CLLocationDegrees = userDefaultsToSpan()
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: point.coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func userDefaultsToSpan() -> Double {
        if UserDefaults.standard.double(forKey: K.UserDefaultKeys.distance).isEqual(to: 0) {
            return 0.1
        } else {
            return UserDefaults.standard.double(forKey: K.UserDefaultKeys.distance)/100
        }
    }
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        
        var control: Map
        
        init(_ control: Map) {
            self.control = control
        }
        
    }
}
