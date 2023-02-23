//
//  InfoRow.swift
//  SixtApp
//
//  Created by Manuel Crovetto on 23/02/2023.
//

import SwiftUI

struct InfoRow: View {
    
    var iconName: String = "car.fill"
    var text: String = "Name"
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.gray)
                .padding(.leading, 24)
            Spacer()
            Text(text)
                .font(.headline)
            Spacer()
        }
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow()
    }
}
