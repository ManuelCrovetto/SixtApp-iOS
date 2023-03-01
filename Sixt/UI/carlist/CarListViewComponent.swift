//
//  CarListViewComponent.swift
//  Sixt
//
//  Created by Manuel Crovetto on 24/02/2023.
//

import SwiftUI

struct CarListViewComponent: View {
    
    var isLoading: Bool = false
    var carList: [Car] = []
    let onSwiped: (Car) -> Void
    
    var body: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(.circular)
        } else {
            List {
                ForEach(carList, id: \.id) { car in
                    VStack {
                        CarItem(car: car)
                            .swipeActions {
                                Button {
                                    onSwiped(car)
                                } label: {
                                    Label("", systemImage: "info.circle")
                                }
                                .tint(.sixtColor)
                            }
                    }
                }
            }
        }
    }
}

struct CarListViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        CarListViewComponent() { car in
            
        }
    }
}
