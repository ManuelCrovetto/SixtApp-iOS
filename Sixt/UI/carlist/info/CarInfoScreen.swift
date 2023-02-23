//
//  CarInfoScreen.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 23/02/2023.
//

import SwiftUI

struct CarInfoScreen: View {
    
    @EnvironmentObject var viewModel: CarListViewModel
    let car: Car
    let onClose: () -> Void
   
    
    
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
            
            .padding(24)
                
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
            }
            .cornerRadius(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            
        
            Spacer()
                
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
