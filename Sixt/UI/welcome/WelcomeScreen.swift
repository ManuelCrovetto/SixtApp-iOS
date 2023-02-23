//
//  WelcomeScreen.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 23/02/2023.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to")
                    .bold()
                    .font(.largeTitle)
                    .shadow(radius: 2)
                Image("Sixt-logo-transparent")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 24)
                    .shadow(radius: 8)
                Spacer().frame(height: 32)
                NavigationLink("Rent now", destination: TabNavigation().navigationBarBackButtonHidden())
                .padding()
                .foregroundColor(.white)
                .background(Color.sixtColor)
                .bold()
                .cornerRadius(8)
                .shadow(radius: 8)
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .center
                )
            .background {
                Image("sixt-background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: UIScreen.main.bounds.height)
                    .blur(radius: 8)
            }
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
