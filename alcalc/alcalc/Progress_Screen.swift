//
//  Progress_Screen.swift
//  alcalc
//
//  Created by Komarzz on 07.05.2022.
//

import SwiftUI

struct Progress_Screen: View {
    var body: some View {
        
            
            ZStack{
                darkGray.ignoresSafeArea()
                ScrollView{
                
                VStack(alignment: .center, spacing: 1){
                    ForEach(drinksArray, id: \.id) { index in
                        
                        if (index.target != 0){
                            
                            HStack(alignment: .center){
                                
                                VStack(alignment: .leading, spacing: 15){
                                    Text(index.taskName).font(.title3).fontWeight(.bold)
                                    Text(index.task)
                                }.padding().frame(width: 288, height: 88, alignment: .leading)
                                
                                Spacer()
                                
                                HStack{
                                    
                                    ZStack{
                                        Circle()
                                            .stroke(darkGray, lineWidth: 8)
                                            .frame(width: 55, height: 55)
                        
                                        Circle().trim(from: 0.0, to: index.progress)
                                            .stroke(((index.progress < 1) ? orange : yellow), lineWidth: 8)
                                            .frame(width: 55, height: 55)
                                            .rotationEffect(Angle(degrees: -90))
                                        if(index.progress < 1){
                                            Text("\(Int(index.progress * 100))").font(.title2).fontWeight(.ultraLight)
                                        }else{
                                            Text("100").font(.title2).fontWeight(.ultraLight)
                                        }
                                    }
                                }.padding().frame(width: 100, height: 88, alignment: .center)
                            }.frame(width: 388, height: 88).background(gray).cornerRadius(10).padding()
                        }
                    }
                }
                
            }.padding()
            }
    }
    
}

struct Progress_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Progress_Screen()
    }
}

