//
//  ContentView.swift
//  Memory
//
//  Created by Bennet Panzek on 4/11/2023.
//

import SwiftUI

let dimension = 4

struct ContentView: View {
    var pictureTable = ["hare",
                        "tortoise",
                        "lizard",
                        "bird",
                        "ant",
                        "fish",
                        "pawprint",
                        "leaf",
                        "hare",
                        "tortoise",
                        "lizard",
                        "bird",
                        "ant",
                        "fish",
                        "pawprint",
                        "leaf"].shuffled()
    
    @State var pictureTableStates = Array(repeating: false, count: dimension * dimension)
    @State var karteName: String = "zero"
    @State var karteID: Int = -1
    @State var gewinnerText: String = " "
    @State var zahlenumgedrehtCount: Int = 0
    
    func kartenauswerter(_ kartenInName: String, _ kartenInID: Int) -> Bool{
            if(karteName == "zero"){
                karteName = kartenInName
                karteID = kartenInID
                zahlenumgedrehtCount += 1
                return true
            } else if (kartenInName == karteName){
                karteID = -1
                karteName = "zero"
                zahlenumgedrehtCount += 1
                if(zahlenumgedrehtCount == pictureTable.count){
                    gewinnerText = "Du hast gewonnen!!!!"
                }
                return true
            } else {
                karteName = "zero"
                pictureTableStates[karteID] = false
                zahlenumgedrehtCount -= 1
              return false
            }
        }

    var body: some View {
        Text("Memory")
                .font(.headline)
                    .frame(width: 300)
                    .foregroundStyle(.blue)
            
            VStack {
                ForEach(0..<4) { row in
                    HStack {
                        ForEach(0..<dimension, id: \.self) { column in
                            Button(action: {
                                if(!pictureTableStates[row*dimension + column]){
                                    pictureTableStates[row*dimension + column] = kartenauswerter(pictureTable[row*dimension + column], row*dimension + column)
                                }
                                print("Aufruf der Karte: \(pictureTable[row*dimension + column])")}) {
                                    if pictureTableStates[row*dimension + column] {
                                        Image(systemName: pictureTable[row*dimension + column])
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                    } else {
                                        Image(systemName: "stop")
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                    }
                                }.frame(width: 80, height: 100)
                        }
                    }
                    
                    
                }
            }
            .frame(width: 360, height: 450)
            .background(Color(red:0.95, green: 0.95, blue: 0.95))
            .cornerRadius(13)
        
        Text(gewinnerText)
            .font(.headline)
                .frame(width: 300)
                .foregroundStyle(.blue)
        }
    }


#Preview {
    ContentView()
}
