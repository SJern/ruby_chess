require_relative 'piece.rb'
require 'colorize'
require_relative 'display.rb'

class Board
  attr_reader :grid, :display

  def initialize

    @grid = Array.new(8) { Array.new(8, NullPiece.instance)  }
    @display = Display.new(self)
    # @grid[1][1] = NullPiece.new
  end

  def [](pos)
    x, y = pos
    grid[x][y]

  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def move(start, end_pos)
    piece = take_piece(start)
    raise "invalid move" unless piece.moves(pos).include?(end_pos)
    self[end_pos] = piece
    self[start] = nil
  end

  def take_piece(pos)
    raise "ERRORRR: No piece here!" if self[pos].nil? # || it's opponent's piece
    # return piece
  end

  def in_bounds?(new_pos)
    new_pos.all? { |x| x.between?(0, 7) }
  end

  # def move
  #   until true
  #     pos = display.move
  #     @grid.mark(pos)
  #   end
  # end


end
# 
# b = Board.new
# b.display.move
