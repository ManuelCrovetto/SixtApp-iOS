//
//  CarItem.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 22/02/2023.
//

import SwiftUI

struct CarItem: View {
    @EnvironmentObject var viewModel: CarListViewModel
    var car: Car
    
    var body: some View {
        HStack {
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
            .frame(maxWidth: 80, maxHeight: 80)
            
            
            VStack(alignment: .leading, content: {
                HStack {
                    Image(systemName: "car")
                        .foregroundColor(.gray)
                    Text(car.modelName)
                        .bold()
                        .font(.headline)
                        .padding(.leading, 2)
                }
                HStack {
                    Image(systemName: "paintpalette")
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(viewModel.provideColor(color: car.color))
                        .cornerRadius(8)
                        .padding(.leading, 2)
                    Text(viewModel.provideColorText(color: car.color))
                        .font(.subheadline)
                }
                HStack(alignment: .center, content: {
                    Image(systemName: "gauge.medium")
                        .foregroundColor(.gray)
                    ProgressView(value: car.fuelLevel)
                        .progressViewStyle(LinearProgressViewStyle(tint: .sixtColor))
                        .padding(.leading, 4)
                })
            })
        }
    
    }
}

struct CarList_Previews: PreviewProvider {
    static var previews: some View {
        CarListScreen()
    }
}


