load 'board.rb'
b = Board.new
q
b[[1,1]] = Bishop.new(b, [1,1], "steven", "bis")
q
b[[2,2]] = Bishop.new(b, [2,2], "steven", "bis")
q
b[[3,3]] = Bishop.new(b, [3,3], "hellboy", "bis")
q
b[[2,3]] = Rook.new(b, [2,3], "steven", "roo")
q
b[[3,2]] = Queen.new(b, [3,2], "hellboy", "que")
q
b.display.render
b[[2,2]].moves
b[[2,3]].moves
b[[3,2]].moves
