# require_relative 'board.rb'

class HumanPlayer
  attr_reader :color, :board

  def initialize(color, board)
    @color = color
    @board = board
  end

  def play_turn
    board.display.msg = "#{color} player, pick up a piece"
    start = check_piece(board.display.move)
    board.display.msg = "you picked#{start}, choose where to move it: " +
      "valid moves: #{board[start].valid_moves}"

    end_pos =  board.display.move
    board.display.msg = ""
    board.move(start, end_pos)
  end

  def check_piece(pos)
    raise "ERRORR: No piece here!" if board[pos].is_a?(NullPiece) || board[pos].color != color
    pos
  end
end
