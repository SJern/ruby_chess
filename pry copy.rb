load 'board.rb'
b = Board.new
q
b[[1,1]] = Bishop.new(b, [1,1], :white)
q
b[[2,2]] = Bishop.new(b, [2,2], :white)
q
b[[3,3]] = Bishop.new(b, [3,3], :black)
q
b[[2,3]] = Rook.new(b, [2,3], :white)
q
b[[3,2]] = Queen.new(b, [3,2], :black)
q
b.display.render
b[[2,2]].moves
b[[2,3]].moves
b[[3,2]].moves

load 'board.rb'
b = Board.new
q
b[[1,1]] = Bishop.new(b, [1,1], :white)
q
b[[2,2]] = King.new(b, [2,2], :white)
q
b[[3,3]] = Bishop.new(b, [3,3], :black)
q
b[[2,3]] = Rook.new(b, [2,3], :white)
q
b[[3,2]] = Queen.new(b, [3,2], :black)
q
b[[4,4]] = Knight.new(b, [4,4], :white)
q
b[[4,1]] = Knight.new(b, [4,1], :black)
q
p = Pawn.new(b, [6,0], :white)
q
b[[6,0]] = p
q
b.display.render
b[[2,2]].moves
b[[2,3]].moves
b[[3,2]].moves

load 'board.rb'
b = Board.new
q
p = Pawn.new(b, [6,0], :white)
q
b[[6,0]] = p
q
p.move_dirs
