//
//  ContentView.swift
//  alcalc
//
//  Created by Mikhail Bulukhto on 19.04.2022.
//

import SwiftUI

var weightGlobal: String = ""
var koeff: Float = 0

struct ContentView: View {
    
    @State var birthday = Date()
    @State var weight: String=""
    var gender = ["Male" , "Female"]
    @State var selectedGender: Int = 0
    var toDate = Date()
    var age: Int = 0
    @State var good = false
    @State var alertCont = false
    @State var checkButton = false
    
    var body: some View {
        
        
        NavigationView{
            ZStack{
                darkGray.ignoresSafeArea()
                VStack{
                    VStack(spacing: 40){
                        VStack{
                            Picker(
                                selection: $selectedGender,
                                label: Text("Select Gender"))
                            {
                                ForEach(0 ..< 2) {
                                    Text(self.gender[$0])
                                }
                            }.pickerStyle(SegmentedPickerStyle()).colorMultiply(gray)
                        }.frame(width: 300, height: 25, alignment: .center).padding(20).background(.white).cornerRadius(10).opacity(0.8)
                        
                        VStack{
                            TextField("Weight",text: $weight)
                                .keyboardType(.numberPad)
                                .padding(.leading)
                                .colorMultiply(.black)
                        }.frame(width: 340, height: 60, alignment: .center).background(.white).cornerRadius(10).opacity(0.8)
                        
                        VStack{
                            DatePicker(selection: $birthday, in: ...Date(), displayedComponents: .date){
                                Text("Birthdate")
                                    .padding(.leading)
                            }.padding()
                        }.frame(width: 340, height: 60, alignment: .center).background(.white).cornerRadius(10).opacity(0.8)
                        
                        let timeRange = Calendar.current.dateComponents([.year, .month, .day], from: birthday, to: Date())
                        let age = Int(timeRange.year ?? 0)
                        
                        VStack{
                            Button(action: {
                                weightGlobal = weight
                                if selectedGender == 0{
                                    koeff = 0.7
                                }
                                else{
                                    koeff = 0.6
                                }
                                if age < 18{
                                    self.alertCont = true
                                }
                                else{
                                    self.checkButton = true
                                }
                                self.good = true
                            })
                            {
                                ZStack{
                                Text("Confirm")
                                    .fontWeight(.bold)
                                    .frame(width: 232, height: 69, alignment: .center)
                                    .opacity((weight.isEmpty) ? 0.5 : 1)
                                    .foregroundColor((weight.isEmpty) ? Color.black : Color.white)
                                    .background(yellow)
                                    .cornerRadius(10)
                                Image("check")
                                        .opacity((self.checkButton == false || self.good == false) ? 0 : 1)
                                        .frame(width: 215, height: 0, alignment: .trailing)
                                }}.opacity((weight.isEmpty) ? 0.3 : 1)
                                .disabled(weight.isEmpty)
                                .alert(isPresented: $alertCont) {
                                    Alert(title: Text("Message"), message: Text("You're too young"), dismissButton: .destructive(Text("OK"), action: {
                                        self.good = false
                                    }))
                                }
                        }
                    }
                    .frame(width: 376, height: 419, alignment: .center)
                    .background(gray)
                    .cornerRadius(10)
                    VStack(spacing: 20){
                        VStack {
                            NavigationLink(destination: theMainScreen()){
                                Text("Start Party")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .frame(width: 376, height: 82, alignment: .center)
                                    .background(yellow)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }.disabled(good == false)
                                .opacity((good == false) ? 0.5 : 1)
                        }
                        VStack{
                            NavigationLink(destination: settingsScreen()){
                                Text("Settings")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .frame(width: 376, height: 82, alignment: .center)
                                    .background(orange)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }
                        }.foregroundColor(.purple).frame(width: 350, alignment: .top)
                    }.frame(height: 250, alignment: .bottom)
                    
                    VStack{
                        Text("Version 1.0\n Popov edition").fontWeight(.ultraLight).multilineTextAlignment(.center)
                    }.padding(.top).frame(width: 300 ,height: 75, alignment: .bottom)
                }
                .frame(width: 350, height: 800, alignment: .top)
                
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
