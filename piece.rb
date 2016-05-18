require 'singleton'
require 'byebug'

class Piece
  attr_reader  :color
  attr_accessor :current_pos, :board
  def initialize(board, starting_pos, color)
    @board = board
    @current_pos = starting_pos
    @color = color
  end

  def valid_moves
    moves.reject { |pos| move_into_check?(pos) }
  end

  def move_into_check?(pos)
    fake_board = board.dup
    fake_board.move!(current_pos, pos)
    fake_board.in_check?(color)
  end

  def to_s
    "   "
  end

  def moves
  end
end

class Pawn < Piece

  def to_s
    " ♟ "
  end

  def move_dirs
    dir = color == :white ? -1 : 1
    [[dir, 0], [dir, -1], [dir, 1]]
  end

  def front_squares
    cur_x, cur_y = current_pos
    front_steps = [move_dirs.first, move_dirs.first.map { |dx| dx * 2 }]
    front_steps.map { |(dx, dy)| [cur_x + dx, cur_y + dy] }
  end

  def front_3
    cur_x, cur_y = current_pos
    move_dirs.map { |(dx, dy)| [cur_x + dx, cur_y + dy] }
  end

  def starting_no_blocking
    current_pos[0] == (color == :white ? 6 : 1 ) && front_squares.all? { |pos| board[pos].is_a?(NullPiece) }
  end

  def moves
    moves_arr = []
    moves_arr << front_squares[-1] if starting_no_blocking
    front_3.each_with_index do |pos, idx|
      if pos.all? { |coord| coord.between?(0, 7) }
        if idx.zero?
          moves_arr << pos if board[pos].is_a?(NullPiece)
        else
          moves_arr << pos unless board[pos].is_a?(NullPiece) || board[pos].color == color
        end
      end
    end
    moves_arr
  end
end

class SlidingPiece < Piece
  def moves
    moves_arr = []
    move_dirs.each do |dir|
      i = 1
      while true
        pos = dir.map.with_index { |e, idx| e * i + current_pos[idx] }
        break if pos.any? { |idx| !idx.between?(0, 7) } || (!board[pos].is_a?(NullPiece) && board[pos].color == color)
        moves_arr << pos
        break unless board[pos].is_a?(NullPiece)
        i += 1
      end
    end
    moves_arr
  end
end

class Bishop < SlidingPiece
  def to_s
    " ♝ "
  end

  def move_dirs
    [[-1, 1], [1, 1], [1, -1], [-1, -1]]
  end
end

class Rook < SlidingPiece
  def to_s
    " ♜ "
  end

  def move_dirs
    [[-1, 0], [0, 1], [1, 0], [0, -1]]
  end
end

class Queen < SlidingPiece
  def to_s
    " ♛ "
  end

  def move_dirs
    [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1]]
  end
end

class SteppingPiece < Piece
  def moves
    cur_x, cur_y = current_pos
    steps.map { |(dx, dy)| [cur_x + dx, cur_y + dy] }
    .select { |pos| pos.all? { |i| i.between?(0, 7) } }
    .reject { |pos| !board[pos].is_a?(NullPiece) && board[pos].color == color }
  end
end

class King < SteppingPiece
  def to_s
    " ♚ "
  end

  def steps
    [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1]]
  end
end

class Knight < SteppingPiece
  def to_s
    " ♞ "
  end

  def steps
    [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]]
  end
end

class NullPiece

  include Singleton

  def to_s
    "   "
  end

end
