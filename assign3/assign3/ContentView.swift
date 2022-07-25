//
//  ContentView.swift
//  assign3
//
//  Created by Laksh Sekhri on 10/17/21.
//
import SwiftUI





    struct ContentView: View{
        var highScores:Highscores = Highscores()
        var body: some View{
            TabView{
                BoardView().tabItem{
                    Label("Board",systemImage:"gamecontroller")
                }
              Scores().tabItem {
                    Label("HighScores",systemImage:"list.dash")
                }
                About().tabItem
                {
                    Label("About",systemImage:"info.circle")
                }
                
            }.environmentObject(highScores)
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


