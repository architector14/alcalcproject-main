//
//  theMainScreenFemale.swift
//  alcalc
//
//  Created by Boss on 22.04.2022.
//

import SwiftUI

struct theMainScreenFemale: View {
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

struct theMainScreenFemale_Previews: PreviewProvider {
    static var previews: some View {
        theMainScreenFemale()
    }
}
