//
//  TileView.swift
//  assign3
//
//  Created by Laksh Sekhri on 10/17/21.
//

import Foundation
import SwiftUI


struct TileView: View {
    var tile = Twos.Tile(val: 0, id: 0, lastRow: 0, lastCol: 0)
    
    
    init(tile: Twos.Tile) {
            self.tile = tile
        }
    
    func colorselect() -> Color
    {
        switch(tile.val) {
                           case 0:
                            return Color.white;

                        case 2:
                            return Color.green
                        case 4:
                            return Color.blue

                        case 8:
                            return Color.yellow
                            
                        case 16:
                            return Color.pink
                        case 32:
                            return Color.purple

                        case 64:
                          return  Color.red
                            
                        case 128:
                           return Color.blue

                        case 256:
                           return Color.orange

                        default:
                            return Color.red

                }
    }
    
        

    var body: some View {
        if(tile.val==0)
        {
            Text("").font(.system(size: 20))
                .frame(width: 30, height: 30)
                .padding()
                .background(colorselect())
                .overlay(Rectangle().stroke(Color.black, lineWidth: 3))
                .animation(.easeIn(duration:1.0))
        }
        else
        {
        Text("\(tile.val)").font(.system(size: 20))
            .frame(width: 30, height: 30)
            .padding()
            .background(colorselect())
            .overlay(Rectangle().stroke(Color.black, lineWidth: 3))
            .animation(.easeIn(duration:1.0))
        }
        
    }
}



