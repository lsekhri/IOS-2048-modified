//
//  Scores.swift
//  assign3
//
//  Created by Laksh Sekhri on 10/18/21.
//

import Foundation
import SwiftUI

struct Scores: View
{
    @EnvironmentObject var high_score: Highscores
    let dateFormatter = DateFormatter()
    
    init(){
    Formatter()
        
    }
    var body: some View {
        NavigationView{
            List(0..<high_score.high_score.count, id: \.self) { score in
                Text("\(score + 1) )" as String)
                Spacer()
                Text("\(high_score.high_score[score].score)" as String)
                Spacer()
                Text("\(dateFormatter.string(from: high_score.high_score[score].time))" as String)
            }.navigationTitle("Highest Scores")
        }
    }
    
    func Formatter (){
        dateFormatter.dateFormat = "HH: mm: ss, d MMM y"
    }
}



struct Score: Hashable {
    var score: Int
    var time: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
    }
    
    init(score: Int, time: Date) {
        self.score = score
        self.time = time
    }
}

class Highscores:ObservableObject{
    @Published var high_score:[Score]=[]
    init()
    {
        totalscore(sc:Score(score:400,time:Date()))
        totalscore(sc:Score(score:300,time:Date()))
    }
    func totalscore(sc:Score)
    {
    high_score.append(sc)
        high_score.sort{$0.score>$1.score}
    }
}
