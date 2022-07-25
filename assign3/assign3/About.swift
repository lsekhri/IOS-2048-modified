//
//  About.swift
//  assign3
//
//  Created by Laksh Sekhri on 10/18/21.
//

import Foundation
import SwiftUI


struct About: View
{
    
    @State var increase:CGFloat = 1.0
    @State var inc:CGFloat = 0.5
    
    var body: some View{
        VStack{
            Text("Press the circle love button to help the circle escape the rectangles and meet each other").font(Font.system(size:18, design: .monospaced))
                .foregroundColor(.black).background(Color.yellow)
        HStack{
        VStack{
            ZStack{
                Rectangle().frame(width:200,height:200,alignment:.center).background(Color.green)
                        Button("Love") {
                            increase += 1
                            
                            if (self.increase > 2) {
                                self.increase = 1
                            }
                        }
                        .padding(80)
                        .multilineTextAlignment(.center)
                        .background(Color.pink)
                        .clipShape(Circle())
                        .scaleEffect(increase)
                        .animation(
                            Animation.easeInOut(duration: 1)
                                .repeatForever(autoreverses: true)
                        )
                
                
                }
            ZStack{
            Rectangle().frame(width:200,height:200,alignment:.center).background(Color.green)
                Button("Love" ) {
                    increase += 1
                    
                    if (self.increase > 2) {
                        self.increase = 1
                    }
                }
                .padding(80)
                .multilineTextAlignment(.center)
                .background(Color.pink)
                .clipShape(Circle())
                .scaleEffect(increase)
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true)
                )
        
        
        }
            }
            VStack{
                ZStack{
                    Rectangle().frame(width:200,height:200,alignment:.center).background(Color.green)
                            Button("Love") {
                                increase += 1
                                
                                if (self.increase > 2) {
                                    self.increase = 1
                                }
                            }
                            .padding(80)
                            .multilineTextAlignment(.center)
                            .background(Color.pink)
                            .clipShape(Circle())
                            .scaleEffect(increase)
                            .animation(
                                Animation.easeInOut(duration: 1)
                                    .repeatForever(autoreverses: true)
                            )
                    
                    
                    }
                ZStack{
                Rectangle().frame(width:200,height:200,alignment:.center).background(Color.green)
                    Button("Love") {
                        increase += 1
                        
                        if (self.increase > 2) {
                            self.increase = 1
                        }
                    }
                    .padding(80)
                    .multilineTextAlignment(.center)
                    .background(Color.pink)
                    .clipShape(Circle())
                    .scaleEffect(increase)
                    .animation(
                        Animation.easeInOut(duration: 1)
                            .repeatForever(autoreverses: true)
                    )
            
            
            }
                }
        }
        }

      
            }
        }
        
          
    

