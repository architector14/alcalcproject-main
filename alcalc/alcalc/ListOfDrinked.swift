//
//  ListOfDrinked.swift
//  alcalc
//
//  Created by Boss on 09.05.2022.
//

import SwiftUI

struct ListOfDrinked: View {
    @State var actDelete = true
    var body: some View {
        ZStack{
            darkGray.ignoresSafeArea()
            if(DrinkedList.isEmpty){
                VStack{
                    Text("DRINK SOMETHING!")
                        .fontWeight(.bold).font(.largeTitle).foregroundColor(.white).frame(alignment: .center)
                }
            }
            ScrollView{
                Spacer()
            VStack(alignment: .center, spacing: 0){
                ForEach(DrinkedList, id: \.id) { index in
                    ZStack{
                        HStack(alignment: .center){
                            HStack{
                                Circle()
                                    .frame(width: 20, height: 20, alignment: .center).foregroundColor(index.color).padding(.leading,35)
                                Text(index.name).font(.title3).fontWeight(.bold)
                                Text(index.alcohol + " %").padding().frame(alignment: .leading)
                            }.frame(width: 280, alignment: .leading)
                            HStack{
                                Text(index.volume + " ml")
                                    .fontWeight(.thin)
                            }.frame(width: 100, alignment: .trailing).padding(.trailing, 40.0)
                            Spacer()
                        }.frame(width: 388, height: 88).background(gray).cornerRadius(10).padding(.horizontal).padding(.vertical, 10.0)
                    }
                }
            }
        }
    }
}

struct ListOfDrinked_Previews: PreviewProvider {
    static var previews: some View {
        ListOfDrinked()
    }
}
}
