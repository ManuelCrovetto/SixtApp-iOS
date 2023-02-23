//
//  CarListViewModel.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 22/02/2023.
//

import Foundation
import SwiftUI

class CarListViewModel: ObservableObject {
    
    private let getCarList = GetCarList()
    
    @Published var carList: [Car] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var car: Car = Car()
    
    
    func getList() async {
        let responseSource = await self.getCarList.getCarList()
        DispatchQueue.main.async {
            switch responseSource {
            case let .error(errorMessage):
                self.isError = true
                self.errorMessage = errorMessage
            case let .success(list):
                self.isError = false
                self.errorMessage = ""
                let carList = list as! [Car]
                self.carList = carList
            }
        }
    }
    
    func getImageUrl(stringUrl: String) -> URL {
        return URL(string: stringUrl) ?? URL(string: "https://cdn.sixt.io/codingtask/images/mini.png")!
    }
    
    func provideColor(color: String) -> Color {
        switch color {
        case "midnight_black": return Color.black
        case "hot_chocolate": return Color.brown
        case "light_white": return Color.cyan
        case "iced_chocolate": return Color.gray
        case "alpinweiss": return Color.cyan
        case "saphirschwarz": return Color.gray
        case "": return Color.black
        default: return Color.black
        }
    }
    
    func provideColorText(color: String) -> String {
        switch color {
        case "midnight_black": return "Black"
        case "hot_chocolate": return "Brown"
        case "light_white": return "Gray"
        case "iced_chocolate": return "Gray"
        case "alpinweiss": return "Cyan"
        case "saphirschwarz": return "Gray"
        case "": return "Black"
        default: return "Black"
        }
    }
    
    func provideFuelTypeText(type: String) -> String {
        switch type {
        case "P": return "Petrol"
        case "D": return "Diesel"
        default: return "Unknown"
        }
    }
    
}
