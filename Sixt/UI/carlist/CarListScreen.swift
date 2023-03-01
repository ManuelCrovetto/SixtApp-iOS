//
//  CarListScreen.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 22/02/2023.
//

import SwiftUI

struct CarListScreen: View {
    
    @StateObject var viewModel = CarListViewModel()
    @State var isLoading = false
    @State var showCarInfoSheet = false
    @State var carList: [Car] = []
    
    
    var body: some View {
        NavigationStack {
            CarListViewComponent(isLoading: isLoading, carList: carList) { car in
                viewModel.carSelected = car
                showCarInfoSheet = true
            }
            .onReceive(viewModel.$carList, perform: { carList in
                self.carList = carList
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Car list")
            .toolbarBackground(Color.sixtColor, for: .navigationBar)
            .toolbarBackground(Color.sixtColor, for: .tabBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        
        .sheet(isPresented: $showCarInfoSheet, content: {
            CarInfoScreen(car: viewModel.carSelected) {
                showCarInfoSheet = false
            }
                
        })
        .onAppear {
            Task {
                isLoading = true
                try await viewModel.getList()
                isLoading = false
            }
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
    }
}


struct CarListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CarListScreen().environmentObject(CarListViewModel())
    }
}
