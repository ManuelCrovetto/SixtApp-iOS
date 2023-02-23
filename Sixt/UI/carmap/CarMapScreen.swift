//
//  CarMapScreen.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 23/02/2023.
//

import SwiftUI
import MapKit


struct CarMapScreen: View {
    @StateObject var viewModel = CarMapViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.1351, longitude: 11.5820), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var isLoading = false
    @State var isMapMarkerPresented = false

    var body: some View {
        NavigationStack {
            if (isLoading == true) {
                ProgressView()
                    .progressViewStyle(.circular)
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.sixtColor, for: .navigationBar)
                .toolbarBackground(Color.sixtColor, for: .tabBar)
                .toolbarBackground(.visible, for: .navigationBar)
            } else {
                Map(coordinateRegion: $region, annotationItems: viewModel.carLocations, annotationContent: { carLocation in
                    
                    MapAnnotation(coordinate: carLocation.coordinate) {
                        Button {
                            viewModel.carLocationSelected = carLocation
                            isMapMarkerPresented = true
                        } label: {
                            Image(systemName: "mappin").resizable().scaledToFit().frame(width: 35, height: 35).foregroundColor(.sixtColor).contentShape(Circle())
                        }
                    }
                        
                })
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.sixtColor, for: .navigationBar)
                .toolbarBackground(Color.sixtColor, for: .tabBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        
            
            
        }
        .sheet(isPresented: $isMapMarkerPresented, content: {
            Form {
                InfoRow(iconName: "car.fill", text: viewModel.carLocationSelected.modelName)
                InfoRow(iconName: "person.fill", text: viewModel.carLocationSelected.name)
                
            }
            
            .presentationDetents([.height(132), .medium])
            .presentationDragIndicator(.visible)
        })
        .onAppear {
            Task {
                isLoading = true
                await viewModel.getCarList()
                isLoading = false
            }
        }
    }
}

struct CarMapScreen_Previews: PreviewProvider {
    static var previews: some View {
        CarMapScreen()
    }
}
