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
    
    var body: some View {
        NavigationView {
            if (isLoading == true) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Car list")
                    .toolbarBackground(Color.sixtColor, for: .navigationBar)
                    .toolbarBackground(Color.sixtColor, for: .tabBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    
                    
            } else {
                List {
                    ForEach(viewModel.carList, id: \.id) { car in
                        VStack {
                            CarItem(car: car)
                                .swipeActions {
                                    Button {
                                        viewModel.car = car
                                        showCarInfoSheet = true
                                    } label: {
                                        Label("", systemImage: "info.circle")
                                            
                                    }
                                    .tint(.sixtColor)
                                }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Car list")
                .toolbarBackground(Color.sixtColor, for: .navigationBar)
                .toolbarBackground(Color.sixtColor, for: .tabBar)
                .toolbarBackground(.visible, for: .navigationBar)
                
            }
        }
        .sheet(isPresented: $showCarInfoSheet, content: {
            CarInfoScreen(car: viewModel.car) {
                showCarInfoSheet = false
            }
                
        })
        .onAppear {
            Task {
                isLoading = true
                await viewModel.getList()
                isLoading = false
            }
        }
        .environmentObject(viewModel)
    }
}

struct CarListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CarListScreen().environmentObject(CarListViewModel())
    }
}
