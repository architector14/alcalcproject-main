//
//  Menu.swift
//  alcalc
//
//  Created by Artur on 23.04.2022.
//

import SwiftUI


struct Drink: Hashable{
    var id = UUID()
    let name: String
    let alcohol: String
    let volume: String
    let target: Double
    var progress: Double
    let taskName: String
    let task: String
    let color: Color
}

var maxAlc: Int = 0

var drinksArray = [
    Drink(name:"Vodka", alcohol: "\(40)", volume:"",
          target: 0, progress: 0,taskName: "", task: "",
          color: Color.yellow),
    Drink(name:"Wine", alcohol:"\(8)", volume:"",
          target: 2250, progress: 0,taskName: "Mother Tereza", task: "Drink 3 bottles of wine",
          color: Color.yellow),
    Drink(name:"Bear", alcohol:"\(4)", volume:"",
          target: 0, progress: 0,taskName: "", task: "",
          color: Color.yellow),
    Drink(name:"Jagermeister", alcohol:"\(35)", volume:"",
          target: 700, progress: 0,taskName: "Naked warden", task: "Drink 0,7 of Jagermeister",
          color: Color.yellow),
    Drink(name:"Moonshine", alcohol:"\(45)", volume:"",
          target: 1000, progress: 0,taskName: "Last way", task: "Drink liter of Moonshine",
          color: Color.yellow),
    Drink(name:"Rom", alcohol:"\(40)", volume:"",
          target: 1000, progress: 0,taskName: "Pirates King", task: "Drink liter of Rom",
          color: Color.yellow)
    
]

let orange = Color(red: 207 / 255, green: 119 / 255, blue: 37 / 255)
let darkGray = Color(red: 102 / 255, green: 104 / 255, blue: 91 / 255)
let gray = Color(red: 171 / 255, green: 172 / 255, blue: 167 / 255)
let yellow = Color(red: 240 / 255, green: 186 / 255, blue: 52 / 255)



struct Menu: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var showAdd = false
    @State var showDrink = false
    @State var showDelete = false
    @State var name: String
    @State var alcohol: String
    @State var volume: String
    @State var selColor: Color
    @State var color: Color
    @Binding var allVol: Int
    @State var ind: Int = 0
    @Binding var allAlc: Float
    @Binding var promille: Float
    @State var showLower = false
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    let colors: [Color] = [Color.red, Color.green, Color.blue, Color.yellow, Color.black, Color.pink, Color.mint]
    
    var body: some View {
        
        
        ZStack{
            
            darkGray.ignoresSafeArea()
            
            VStack{
                
                ScrollView{
                    LazyVGrid(columns: columns, spacing: UIScreen.main.bounds.height * 0.0215){
                        ForEach(drinksArray.indices, id: \.self){ item in
                            
                            Button(action:{}){
                                VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.0107){
                                    Text(drinksArray[item].name).bold()
                                    Text("Alcohol: " + drinksArray[item].alcohol + "%")
                                }.frame(width: UIScreen.main.bounds.width * 0.408, height: UIScreen.main.bounds.width * 0.408, alignment: .center)
                                    .background(drinksArray[item].color)
                                    .cornerRadius(10)
                                    .foregroundColor(Color.white)
                                
                            }.simultaneousGesture(LongPressGesture().onEnded { _ in
                                if(item > 5){
                                    ind = item
                                    showDelete = true}
                            })
                            .highPriorityGesture(TapGesture()
                                .onEnded { _ in
                                    name = "\(drinksArray[item].name)"
                                    alcohol = "\(drinksArray[item].alcohol)"
                                    color = drinksArray[item].color
                                    ind = item
                                    
                                    if(Int(alcohol) ?? 0 < maxAlc){
                                        showLower = true
                                    }else{
                                        showDrink = true
                                    }
                                })
                            
                        }.disabled(showAdd || showDrink)
                    }
                }.padding(.horizontal)
                
                Button(action:{
                    self.showAdd = true
                }){
                    Text("Add Drink")
                        .frame(width: UIScreen.main.bounds.width * 0.8785, height: UIScreen.main.bounds.height * 0.08855, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(orange)
                        .cornerRadius(10)
                        .disabled(showDrink || showLower || showDelete)
                }.padding(.bottom)
                
                
            }.frame(alignment: .top)
            
            if(showAdd){
                ZStack {
                    
                    
                    VStack(spacing: UIScreen.main.bounds.height * 0.0107){
                        VStack{
                            
                            
                            
                            Button(action:{
                                name = ""
                                alcohol = ""
                                volume = ""
                                self.showAdd = false
                            }){
                                Text("X").frame(width: UIScreen.main.bounds.width * 0.095, height: UIScreen.main.bounds.width * 0.095, alignment: .center).background(darkGray).cornerRadius(10).foregroundColor(Color.white)
                            }
                        }.frame(width: UIScreen.main.bounds.width * 0.7 ,height: UIScreen.main.bounds.height * 0.0442, alignment: .topTrailing).padding()
                        
                        
                        VStack(alignment: .center, spacing: UIScreen.main.bounds.height * 0.0107){
                            TextField("Name", text: $name).keyboardType(.alphabet).padding().frame(width: UIScreen.main.bounds.width * 0.6191, height: UIScreen.main.bounds.height * 0.0626).overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(Color.gray, lineWidth: 1.0)).background(Color.white).cornerRadius(10)
                            TextField("%", text: $alcohol).keyboardType(.numberPad).padding().frame(width: UIScreen.main.bounds.width * 0.6191, height: UIScreen.main.bounds.height * 0.0626).overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(Color.gray, lineWidth: 1.0)).background(Color.white).cornerRadius(10)
                            TextField("ml", text: $volume).keyboardType(.numberPad).padding().frame(width: UIScreen.main.bounds.width * 0.6191, height: UIScreen.main.bounds.height * 0.0626).overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(Color.gray, lineWidth: 1.0)).background(Color.white).cornerRadius(10)
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(colors, id: \.self){ color in
                                        Circle().foregroundColor(color)
                                            .frame(width: 58, height: 58)
                                            .opacity(color == selColor ? 0.5 : 1.0)
                                            .scaleEffect(color == selColor ? 1.1 : 1.0)
                                            .onTapGesture{
                                                selColor = color
                                            }
                                    }
                                }.padding()
                            }.frame(width: UIScreen.main.bounds.width * 0.6191, height: UIScreen.main.bounds.height * 0.0971).overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1.0)
                            ).background(Color.white).cornerRadius(10)
                        }.frame(height: UIScreen.main.bounds.height * 0.3282 ,alignment: .center)
                        
                        
                        VStack{
                            Button(
                                action: {
                                    drinksArray.append(Drink(name: name, alcohol: alcohol, volume: volume,target: 0, progress: 0, taskName:"", task: "", color: selColor))
                                    name = ""
                                    alcohol = ""
                                    volume = ""
                                    selColor = Color.white
                                    self.showAdd = false
                                }){
                                    
                                    Text("Add").foregroundColor(Color.white)
                                        .frame(width: UIScreen.main.bounds.width * 0.542, height: UIScreen.main.bounds.height * 0.0745, alignment: .center)
                                        .background(yellow)
                                        .opacity((name.isEmpty || alcohol.isEmpty || volume.isEmpty) || (selColor == Color.white) ? 0.5 : 1.0)
                                        .cornerRadius(20)
                                }.disabled((name.isEmpty || alcohol.isEmpty || volume.isEmpty) || (selColor == Color.white))
                            
                            
                        }.padding().frame(height: UIScreen.main.bounds.height * 0.0971, alignment: .bottom)
                    }.frame(width: UIScreen.main.bounds.width * 0.7476, height: UIScreen.main.bounds.height * 0.5323, alignment: .top)
                    
                    
                }.frame(width: UIScreen.main.bounds.width * 0.7476, height: UIScreen.main.bounds.height * 0.5323).background(gray)
                    .cornerRadius(20).shadow(radius: 20).padding()
            }
            
            
            if(showDrink){
                ZStack{
                    gray
                    VStack(spacing: 0){
                        VStack(spacing: 0){
                                
                                Button(action:{
                                    self.showDrink = false
                                }){
                                    Text("X").frame(width: 30, height: 30, alignment: .center).background(darkGray).cornerRadius(10).foregroundColor(Color.white)
                                }
                        }.frame(width: 280 ,height: 30, alignment: .topTrailing).padding(.top)
                                                        
                            VStack(alignment: .leading, spacing: 7){
                                Text("\(name)").fontWeight(.bold).padding().frame(width: 250, height: 40, alignment: .leading).background(.white).cornerRadius(10)
                                Text(alcohol + "%").padding().frame(width: 250, height: 40, alignment: .leading).background(.white).cornerRadius(10)
                                TextField("ml", text: $volume).padding().keyboardType(.numberPad).frame(width: 250, height: 40, alignment: .center).background(.white).cornerRadius(10)
                            }.frame(width: 300, height: 160, alignment: .center)
                            
                        VStack(spacing: 0){
                            Button(action: {
                                drinksArray[ind].progress += (Double(volume) ?? 0)/drinksArray[ind].target
                                DrinkedList.append(Drinked(name: name, alcohol: alcohol, volume: volume, color: color))
                                allVol = Int(volume) ?? 0
                                allAlc = (Float(alcohol) ?? 0)*0.01
                                promille += Float(allVol)*allAlc*0.8/(koeff*(Float(weightGlobal) ?? 0))
                                if (Int(alcohol) ?? 0 > maxAlc){
                                    maxAlc = Int(alcohol) ?? 0
                                }
                                name = ""
                                alcohol = ""
                                volume = ""
                                self.showDrink = false
                            }){
                                Text("Drink").frame(width: 250, height: 50, alignment: .center).background(yellow).opacity((name.isEmpty || alcohol.isEmpty || volume.isEmpty) ? 0.5 : 1.0).cornerRadius(10).disabled(name.isEmpty || alcohol.isEmpty || volume.isEmpty).foregroundColor(.white)
                            }.disabled(name.isEmpty || alcohol.isEmpty || volume.isEmpty)
                        }.frame(alignment: .center)
                            
                    }.frame(width: 300, height: 280, alignment: .top)
                }.padding().frame(width: 300, height: 280)
                    .cornerRadius(20).shadow(radius: 20)
            }
            
            if(showDelete){
                ZStack{
                    darkGray
                    VStack{
                        
                        Spacer()
                        
                        Text("Want to delete?").fontWeight(.bold).font(.title).frame(alignment: .top).foregroundColor(.white)
                        
                        Spacer()
                        VStack(alignment: .center, spacing: 0){
                            Button(action: {
                                drinksArray.remove(at: ind)
                                self.showDelete = false
                            }){
                                Text("Delete").fontWeight(.bold).frame(width: 400, height: 50).border(gray).foregroundColor(orange)
                            }
                            
                            Button(action: {
                                self.showDelete = false
                            }){
                                Text("Cancel").frame(width: 400, height: 50).foregroundColor(.white)
                            }
                        }.frame(alignment: .bottom)
                        
                        
                    }.padding(0).frame(width: 300, height: 200, alignment: .center)
                    
                }.frame(width: 300, height: 200)
                    .cornerRadius(20).shadow(radius: 20).padding(0)
            }
            
            if(showLower){
                ZStack{
                    darkGray
                    VStack{
                        
                        Spacer()
                        VStack(alignment: .center, spacing: 5){
                            Text("Lower Alcohol").fontWeight(.bold).font(.title).frame(alignment: .top).foregroundColor(.white)
                            Text("You might feel worse if you drink it").foregroundColor(.white).frame(alignment: .top)
                        }.frame(alignment: .top)
                        
                        Spacer()
                        VStack(alignment: .center, spacing: 0){
                            Button(action: {
                                self.showLower = false
                                self.showDrink = true
                            }){
                                Text("I dont care").fontWeight(.bold).frame(width: 400, height: 50).border(gray).foregroundColor(orange)
                            }
                            
                            Button(action: {
                                self.showLower = false
                                self.showDrink = false
                                
                            }){
                                Text("Ok, I won't").frame(width: 400, height: 50).foregroundColor(.white)
                            }
                        }.frame(alignment: .bottom)
                        
                        
                    }.padding(0).frame(width: 300, height: 200, alignment: .center)
                    
                }.frame(width: 300, height: 200)
                    .cornerRadius(20).shadow(radius: 20).padding(0)
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                ZStack{
                    Circle()
                        .stroke(orange, lineWidth: 3)
                        .frame(width: 35, height: 35)
                    Image(systemName: "arrow.left").foregroundColor(orange)
                }
            })
        
        
        
    }
}

