//
//  theMainScreen.swift
//  alcalc
//
//  Created by Boss on 24.04.2022.
//

import SwiftUI
import AVKit
import AVFoundation

struct Drinked: Hashable{
    var id = UUID()
    let name: String
    let alcohol: String
    let volume: String
    let color: Color
}
var DrinkedList: [Drinked] = []

struct theMainScreen: View {
    
    @State private var pressM = false
    @State private var pressP = false
    @State private var pressS = false
    @State private var allVol: Int = 0
    @State private var allAlc: Float = 0
    @State private var promille: Float = 0
    @State var timeRemaining = 84600
    @State var alcAlert = false
    @State var shown = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var videoURL1: URL?
    private var videoURL2: URL?
    private var videoURL3: URL?
            init() {
                videoURL1 = Bundle.main.url(forResource: "chel1", withExtension: "mov")
                videoURL2 = Bundle.main.url(forResource: "chel2", withExtension: "mov")
                videoURL3 = Bundle.main.url(forResource: "chel3", withExtension: "mov")
            }
    
    var body: some View {
        
            ZStack{
                darkGray.ignoresSafeArea()
            VStack{
            HStack{
                Text("\(String(format: "%.2f",promille))"+"‰")
                    .font(.title)
                    .fontWeight(.bold).foregroundColor(.white)
                    
                    .padding(.trailing, 107.0)
                    .onReceive(timer) { _ in
                    if timeRemaining > 0 && promille > 0{
                                timeRemaining -= 1
                                promille -= 1/84600
                        
                    }
                        if promille >= 1.5 && shown == false {
                            self.alcAlert = true
                        }
            }

                Button (action:
                        {
                            self.pressP.toggle()
                            
                        })
                        {
                            Image("crown").padding().frame(width:65, height:65, alignment: .center).opacity(1).background(Color.yellow).cornerRadius(10)
                        }
                        .padding(.vertical).frame(width: 115, alignment: .trailing)
                        .sheet(isPresented: $pressP)
                            {
                                Progress_Screen()
                                
                            }
            
            }.frame(width: 500, height: 150, alignment: .bottom).background(gray).edgesIgnoringSafeArea([.top, .bottom])
                
            VStack{
                if promille <= 1{
                    Looper1().frame(width:300, height: 500)
                }
                if promille > 1 && promille <= 2 {
                    Looper2().frame(width:300, height: 500)
                }
                if promille > 2 {
                    Looper3().frame(width:300, height: 500)
                }
                
            }.frame(maxHeight: .greatestFiniteMagnitude, alignment: .center)
            HStack{
                NavigationLink(destination: Menu(name: "", alcohol: "", volume: "", selColor: Color.white, color: .white, allVol: $allVol, allAlc: $allAlc, promille: $promille)){
                        Text("Menu").fontWeight(.bold)
                                    .frame( alignment: .leading).foregroundColor(.white)
                                    .frame(width: 162, height: 122)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                                    
                }
                    .alert(isPresented: $alcAlert) {
                        Alert(title: Text("Attention!").fontWeight(.bold), message: Text("Halfway to alcohol intoxication!"), dismissButton: .destructive(Text("OK"), action: {
                        self.shown = true
                        }))
                    }
                .padding(.trailing, 7.0)
                Button (action:
                        {
                            self.pressS.toggle()
                        })
                        {
                            Text("Drunk List").fontWeight(.bold).foregroundColor(.white)
                                .frame(width: 162, height: 122)
                                .background(Color.orange)
                                .cornerRadius(10)
                        }
                        .padding(.leading, 7.0)
                        .sheet(isPresented: $pressS)
                            {
                                ListOfDrinked()
                                
                            }.frame(alignment: .trailing)
            }.padding(.bottom, 15.0).frame(width:500, height: 150, alignment: .bottom)
        }
            }.navigationBarHidden(true)
        }
}

struct theMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        theMainScreen()
    }
}


struct Looper1: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Looper1>) {
    }

    func makeUIView(context: Context) -> UIView {
        return thePlayerForChel1(frame: .zero)
    }
}

class thePlayerForChel1: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    @State private var promille: Float = 0
    required init?(coder: NSCoder) {
        fatalError("stop")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let fileUrl = Bundle.main.url(forResource: "chel1", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)

        playerLooper = AVPlayerLooper(player: player, templateItem: item)

        player.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct Looper2: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Looper2>) {
    }

    func makeUIView(context: Context) -> UIView {
        return thePlayerForChel2(frame: .zero)
    }
}
class thePlayerForChel2: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    @State private var promille: Float = 0
    required init?(coder: NSCoder) {
        fatalError("stop")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let fileUrl = Bundle.main.url(forResource: "chel2", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)

        playerLooper = AVPlayerLooper(player: player, templateItem: item)

        player.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct Looper3: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Looper3>) {
    }

    func makeUIView(context: Context) -> UIView {
        return thePlayerForChel3(frame: .zero)
    }
}
class thePlayerForChel3: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    required init?(coder: NSCoder) {
        fatalError("stop")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let fileUrl = Bundle.main.url(forResource: "chel3", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)

        playerLooper = AVPlayerLooper(player: player, templateItem: item)

        player.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}


