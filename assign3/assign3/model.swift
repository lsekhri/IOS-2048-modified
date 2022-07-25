//
//  model.swift
//  assign3
//
//  Created by Laksh Sekhri on 10/17/21.
//

import Foundation
 //the given structure is equatable



 
enum Direction {
    case left
    case right
    case up
    case down
}
 
 
//we use the generic function here too but send an integer value instead
public func rotate2DInts(input: [[Int]]) ->[[Int]]
{
    return rotate2D(input:input);
}




// we define a generic rotate function instead her
public func rotate2D<T>(input: [[T]]) ->[[T]]
{
    //we have a game double dimensional array
    var game:[[T]]=[];
    //then we declare a temporary array
    var new:[T]=[];
    //we start by going column by column
    for c in 0..<input.count
    {
        //remove the elements from temporary array as soon as the first column becomes the first row
        new.removeAll()
    for r in 0..<input.count{
        // we keep adding to the front of the array
                new.insert(input[r][c], at: 0)
            }
        //the first columns becomes the first row in reverse order as it is rotated
            game.append(new)
        }
    return game;
}

class Twos: ObservableObject {
    struct Tile: Hashable {
        var val : Int = 0
        var id : Int
        var lastRow: Int
        var lastCol: Int
    }
    @Published var isDone:Bool=false
    @Published var board: [[Tile]]
    @Published var rand:Bool=true
    private var determ :SeededGenerator
    private var rando :SystemRandomNumberGenerator
    private var space: Bool = false
    private var join : Bool = false
    @Published var score:Int
    @Published var over:Bool=true;
  
    let length = 4
 //initializes the whole table with 0 elements and other
    init() {
        
        rando=SystemRandomNumberGenerator()
        board = Array(repeating:Array(repeating:Tile(val: 0, id: 0, lastRow: 0, lastCol: 0), count: length), count: length)
        score=0;
        determ=SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
    }
    

    
    
    func newgame(_ dec: Bool) {
      
        
        
        board = Array(repeating:Array(repeating:Tile(val: 0, id: 0, lastRow: 0, lastCol: 0), count: length), count: length)
        
        
        //decide which generator to user
        if(dec) {
            rando = SystemRandomNumberGenerator()
        } else {
            determ = SeededGenerator(seed: 14)
        }
        score = 0
        isDone=false
        spawn()
        spawn()
        
        
    }
    
    
    func spawn()
    {
        var open = Array(repeating:Array(repeating:0, count: 4), count: 4)
               var val:Int
               var c:Int=0
               for i in 0..<4{
                for j in 0...3{
                       if(board[i][j].val==0)
                       {
                           open[i][j]=c
                           c+=1;
                       }
                   }
               }
               if (c==0)
               {
                   print("Game Over,go home");
                   return
               }
               var spot:Int
               if(over)
               {
                   val=[2,4].randomElement(using: &rando) as! Int
                   spot=Int.random(in: 0..<c, using: &rando)
               }
               else
               {
                   val=[2,4].randomElement(using: &determ) as! Int
                   spot=Int.random(in: 0..<c, using: &determ)
               }
               for r in 0..<4
               {
                for co in 0...3{
                       if (open[r][co]==spot)
                       {
                           board[r][co].val=val
                           return
                       }
                   }
               }
           }
    func isGameDone()->Bool{
        let tscore=score
        let tboard=board
        if(isDone)
        {
            return true;
        }
        if(collapse(dir:Direction.up))
        {
            score = tscore
            board = tboard
            return isDone;
        }
        if(collapse(dir:Direction.down))
        {
            score = tscore
            board = tboard
            return isDone;
        }

        if(collapse(dir:Direction.left))
        {
            score = tscore
            board = tboard
            return isDone;
        }
        if(collapse(dir:Direction.right))
        {
            score = tscore
            board = tboard
            return isDone;
        }
        else{
            score=tscore
            board=tboard
            isDone=true;
            return isDone;
        }
        
        
        
    }
    
 // we will make a helper function and call it in shiftLeft we will got throught the elements in board
    func shiftLeft() -> Bool{
        var changed:Bool=false;
        var last_row:[Int] = Array(repeating:0,count:4)
        for i in 0...board.count-1{
            for j in 0...board[i].count-1{
                last_row[j]=board[i][j].val
            }
            board[i]=shift(row:board[i])
            for l in 0...last_row.count-1{
                if last_row[l] != board[i][l].val
            {
                changed=true;
            }
                
            }
            
        }
        return changed;
    }
    
    func shift(row: [Tile]) -> [Tile]{
        var temp:[Tile]=Array(repeating: Tile(val: 0, id: 0, lastRow: 0, lastCol: 0), count:row.count)
        for j in 0...row.count-1{
            temp[j].val = row[j].val
        }
        var i=0;
        var c=0;
        var ind=0
        while i<row.count{
            if c==0 && temp[i].val>0
            {
                c=temp[i].val
                ind=i;
            }
            else if c>0 && temp[i].val==c
            {
                temp[i].val=0
                temp[ind].val += c
                score+=temp[ind].val
                c=0;
                ind=0;
            }
            else if (c>0 && temp[i].val>0) && (c != temp[i].val)
            {
                c=temp[i].val
                ind=i;
            }
            i=i+1;
        }
        //we make new values and assign it with 0
        var newt:[Tile]=[Tile(val: 0, id: 0, lastRow: 0, lastCol: 0),Tile(val: 0, id: 0, lastRow: 0, lastCol: 0),Tile(val: 0, id: 0, lastRow: 0, lastCol: 0),Tile(val: 0, id: 0, lastRow: 0, lastCol: 0)]
        let m = 0;
        var n = 0
        // we shift values to the left and 0 to the right
        for m in m...row.count-1{
            if temp[m].val > 0{
                newt[n].val = temp[m].val
                n += 1
            }
        }
        return newt
    }
    // we use the rotate2D function here also.
    func rightRotate() {
        board=rotate2D(input: board)
    }
 
    
    func collapse(dir: Direction)-> Bool {
        if(isDone)
        {
            return false;
        }
        var modified:Bool=false;
        switch dir {
        
        case .left: modified=shiftLeft()
            
        case .right: rightRotate()
                    rightRotate()
                     modified=shiftLeft()
                     rightRotate()
                     rightRotate()
            
        case .up: rightRotate()
                  rightRotate()
                  rightRotate()
                  modified=shiftLeft()
                  rightRotate()
                 
            
        case .down: rightRotate()
                    modified=shiftLeft()
                    rightRotate()
                    rightRotate()
                    rightRotate()
           
        }
        if(modified)
        {
            spawn()
        }
        return modified;
      
    }
 
}



