//
//  settingsScreen.swift
//  alcalc
//
//  Created by Mikhail Bulukhto on 29.04.2022.
//

import SwiftUI

struct settingsScreen: View {
    var body: some View {
        ZStack{
            darkGray.ignoresSafeArea()
            Text("Comming Soon").fontWeight(.bold).font(.largeTitle).foregroundColor(.white).frame(alignment: .center)
        }
    }
}

struct settingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        settingsScreen()
    }
}
