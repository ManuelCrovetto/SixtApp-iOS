//
//  CarInfoScreen.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 23/02/2023.
//

import SwiftUI
import MapKit

struct CarInfoScreen: View {
    
    @EnvironmentObject var viewModel: CarListViewModel
    let car: Car
    let onClose: () -> Void
    @State private var regionState = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var singleCarLocationList: [CarLocation] = []
    
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Spacer()
                Text("+ Info")
                    .bold()
                    .font(.largeTitle)
                    .padding(.leading, 24)
                Spacer()
                Button {
                    onClose()
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 24)
            AsyncImage(url: viewModel.getImageUrl(stringUrl: car.carImageUrl)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image(systemName: "photo")
                } else {
                    ProgressView()
                }
            }
            .shadow(radius: 8)
            .frame(maxWidth: 400, maxHeight: 250, alignment: .top)
            
            Form {
                InfoRow(iconName: "car.fill", text: car.modelName)
                InfoRow(iconName: "person.fill", text: car.name)
                InfoRow(iconName: "fuelpump.fill", text: viewModel.provideFuelTypeText(type: car.fuelType))
                InfoRow(iconName: "numbersign", text: car.licensePlate)
                InfoRow(iconName: "paintbrush.fill", text: car.innerCleanliness)
                Map(coordinateRegion: $regionState, annotationItems: singleCarLocationList, annotationContent: { coordinate in
                    MapMarker(coordinate: coordinate.coordinate)
                })
                    .cornerRadius(8)
                    .padding(.vertical, 8)
                    .frame(minWidth: 250, idealWidth: 250, maxWidth: .infinity, minHeight: 250, idealHeight: 250, maxHeight: 250)
            }
            .cornerRadius(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            Spacer()
        }
        .onReceive(viewModel.$coordinateRegion, perform: { newRegion in
            singleCarLocationList.removeAll()
            singleCarLocationList.append(CarLocation(coordinate: newRegion.center))
            self.regionState = newRegion
        })
        .onAppear {
            viewModel.setCoordinateRegion()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

struct CarInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        CarInfoScreen(car: Car()) {
            
        }.environmentObject(CarListViewModel())
    }
}
