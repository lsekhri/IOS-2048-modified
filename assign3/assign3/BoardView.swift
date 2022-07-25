import Foundation

import SwiftUI

struct scorev:View{
    private var score=0;
    init(_ inp: Int)
    {
        score=inp;
    }
    var body:some View{
        HStack(alignment: .center){
        Text("Score:")
        Text("\(score)")
    }
}
}




struct BoardView: View
{
   
    @Environment(\.verticalSizeClass) var verticalSizeClass:UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass:UserInterfaceSizeClass?
    @StateObject var box: Twos=Twos()
    @EnvironmentObject var list: Highscores
    @State var isDone=false
    var body:some View{
        if (verticalSizeClass == .regular) {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.vertical)
                .overlay(
        VStack{
            scorev(box.score)
            ForEach(0..<4,id:\.self){
                i in
                HStack{
                    ForEach(0..<4,id:\.self){
                        j in
                        TileView(tile:box.board[i][j])
                    }
                }
            }
            .gesture(DragGesture(minimumDistance:20.0,coordinateSpace: .local).onEnded{
            value in
            if value.translation.height<0{
                box.collapse(dir:.up)
            }
            else if value.translation.height>0{
                box.collapse(dir:.down)
            }
            else if value.translation.width > 0 && abs(value.translation.width) > abs(value.translation.height)
            {
                box.collapse(dir:.right)
                
            }
            else if value.translation.width < 0 && abs(value.translation.width) > abs(value.translation.height)
            {
                box.collapse(dir:.left)
            }
        })
        Button("UP"){
                    box.collapse(dir:.up)
                    isDone=box.isGameDone()
                   }.frame(width:100,height:40).background(Color.green).cornerRadius(25)
                   
                   HStack{
                       Button("LEFT"){
                        box.collapse(dir:.left)
                        isDone=box.isGameDone()
                       }.frame(width:100,height:40).background(Color.black).cornerRadius(25).padding()
                       
                       Button("RIGHT"){
                           box.collapse(dir:.right)
                        isDone=box.isGameDone()
                       }.frame(width:100,height:40).background(Color.red).cornerRadius(25).padding()
                       
                   }
                   Button("DOWN"){
                    box.collapse(dir:.down)
                    isDone=box.isGameDone()
                   }.frame(width:100,height:40).background(Color.yellow).cornerRadius(25)
                   
                   Button("NEW GAME"){
                    let newElement = Score(score: box.score, time: Date())
                    list.totalscore(sc: newElement)
                    isDone=true;
                    box.newgame(box.over)
    
                       
                   }.frame(width:200,height:40).background(Color.pink).cornerRadius(25).padding(.top)
                  
                   Picker("testing", selection: $box.over) {
                       Text("Determ").tag(false)
                       Text("Random").tag(true)
                   }
                   .pickerStyle(SegmentedPickerStyle())
                   .frame(width: 300, height: 100, alignment: .center)
        }.alert(isPresented: $isDone)
        {
          Alert(title:Text("Game Over"),
            message:Text("you can't make any more moves or you entered new game"),
            dismissButton: .default(Text("New Game"), action: {
                let newElement = Score(score: box.score, time: Date())
                list.totalscore(sc: newElement)
                box.newgame(box.over)
                isDone = false
                               }))
        }.environmentObject(box)
          
        )
        }
        else
            {
                LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.horizontal)
                    .overlay(
                        HStack
                        {
                        VStack{
                            scorev(box.score)
                            ForEach(0..<4,id:\.self){
                                i in
                                HStack{
                                    ForEach(0..<4,id:\.self){
                                        j in
                                        TileView(tile:box.board[i][j])
                                    }
                                }
                            }
                        }
                            .gesture(DragGesture(minimumDistance:20.0,coordinateSpace: .local).onEnded{
                            value in
                            if value.translation.height<0{
                                box.collapse(dir:.up)
                            }
                            else if value.translation.height>0{
                                box.collapse(dir:.down)
                            }
                            else if value.translation.width > 0 && abs(value.translation.width) > abs(value.translation.height)
                            {
                                box.collapse(dir:.right)
                                
                            }
                            else if value.translation.width < 0 && abs(value.translation.width) > abs(value.translation.height)
                            {
                                box.collapse(dir:.left)
                            }
                        })
                            VStack{
                        Button("UP"){
                                    box.collapse(dir:.up)
                                   }.frame(width:100,height:40).background(Color.green).cornerRadius(25)
                                   
                                   HStack{
                                       Button("LEFT"){
                                           box.collapse(dir:.left)
                                       }.frame(width:100,height:40).background(Color.black).cornerRadius(25).padding()
                                       
                                       Button("RIGHT"){
                                           box.collapse(dir:.right)
                                       }.frame(width:100,height:40).background(Color.red).cornerRadius(25).padding()
                                       
                                   }
                                   Button("DOWN"){
                                       box.collapse(dir:.down)
                                   }.frame(width:100,height:40).background(Color.yellow).cornerRadius(25)
                                   
                                   
                                   Button("NEW GAME"){
                                    let newElement = Score(score: box.score, time: Date())
                                    list.totalscore(sc: newElement)
                                    isDone=true;
                                    box.newgame(box.over)
                                       
                                   }.frame(width:200,height:40).background(Color.pink).cornerRadius(25).padding(.top)
                                  
                                   Picker("testing", selection: $box.over) {
                                       Text("Determ").tag(false)
                                       Text("Random").tag(true)
                                   }
                                   .pickerStyle(SegmentedPickerStyle())
                                   .frame(width: 300, height: 100, alignment: .center)
                            }.offset(y:27).alert(isPresented: $isDone)
                            {
                              Alert(title:Text("Game Over"),
                                message:Text("you can't make any more moves or you entered new game"),
                                dismissButton: .default(Text("New Game"), action: {
                                    let newElement = Score(score: box.score, time: Date())
                                    list.totalscore(sc: newElement)
                                    box.newgame(box.over)
                                    isDone = false
                                                   }))
                            }.environmentObject(box)
                        }
                        )
            }
    }
    }
    
    
    



