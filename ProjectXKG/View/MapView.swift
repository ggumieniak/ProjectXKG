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
//    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
     // code
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapView
        
        init(_ control: MapView) {
            self.control = control
        }
        
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
//        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate))
        MapView()
    }
}
