require 'singleton'
require 'byebug'


class Piece
  attr_reader :type, :current_pos, :owner, :board
  def initialize(board, starting_pos, player, type = "squ")
    @board = board
    @type = type
    @current_pos = starting_pos
    @owner = player
  end

  def to_s
    type
  end

  def moves

  end

end


class SlidingPiece < Piece


  def moves
    moves_arr = []

    move_dirs.each do |dir|
      i = 1
      while true
        pos = dir.map.with_index { |e, idx| e * i + current_pos[idx] }

        break if pos.any? { |idx| !idx.between?(0, 7) } || board[pos].owner == owner
        moves_arr << pos
        break unless board[pos].is_a?(NullPiece)
        i += 1
      end

    end

    moves_arr
  end
end

class Bishop < SlidingPiece
  # def initialize
  #   super
  #   @type='bis'
  # end

  def move_dirs
    [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end
end

class Rook < SlidingPiece
  def move_dirs
    [[0, -1], [-1, 0], [1, 0], [0, 1]]
  end
end

class Queen < SlidingPiece
  def move_dirs
    [[0, -1], [-1, 0], [1, 0], [0, 1], [-1, -1], [-1, 1], [1, -1], [1, 1]]
  end
end

class NullPiece < Piece
  include Singleton

  def initialize

    super(nil, nil, "hi", "   ")
  end
end
