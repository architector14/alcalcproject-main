//
//  theMainScreenMale.swift
//  alcalc
//
//  Created by Boss on 22.04.2022.
//

import SwiftUI

struct theMainScreenMale: View {
    @State private var press = false
    var body: some View {
        Text("Hello, Woman!")
        Button (action:
                            {
                    self.press.toggle()
                })
                {
                    Text("choose a drink")
                }.sheet(isPresented: $press)
                {
                    Menu()
                }

    }
    
}

struct theMainScreenMale_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
