//
//  CarMapViewComponent.swift
//  Sixt
//
//  Created by Manuel Crovetto on 24/02/2023.
//

import SwiftUI
import CoreLocation
import _MapKit_SwiftUI

struct CarMapViewComponent: View {
    
    var isLoading: Bool = false
    var carLocations: [CarLocation] = []
    let onPressed: (CarLocation) -> Void
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.1351, longitude: 11.5820), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(.circular)
        } else {
            Map(coordinateRegion: $region, annotationItems: carLocations, annotationContent: { carLocation in
                
                MapAnnotation(coordinate: carLocation.coordinate) {
                    Button {
                        onPressed(carLocation)
                    } label: {
                        Image(systemName: "mappin").resizable().scaledToFit().frame(width: 35, height: 35).foregroundColor(.sixtColor).contentShape(Circle())
                    }
                }
                
            })
        }
    }
}

struct CarMapViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        CarMapViewComponent() { car in
            
        }
    }
}
