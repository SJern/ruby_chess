require_relative 'piece.rb'
require 'colorize'
require_relative 'display.rb'

class Board
  attr_reader :grid, :display
  PIECE_ROW = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def initialize
    @grid = Array.new(8) { Array.new(8, NullPiece.instance)  }
    @display = Display.new(self)
    populate
  end
  def populate
    populate_black
    populate_white
  end
  def populate_black
    grid[1].each_index do |j|
      grid[1][j] = Pawn.new(self, [1, j], :black)
    end
    PIECE_ROW.each_with_index do |class_name, j|
      grid[0][j] = class_name.new(self, [0, j], :black)
    end
  end

  def populate_white
    grid[6].each_index do |j|
      grid[6][j] = Pawn.new(self, [6, j], :white)
    end
    PIECE_ROW.each_with_index do |class_name, j|
      grid[7][j] = class_name.new(self, [7, j], :white)
    end
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
    raise "ERRORRR: No piece here!" if self[pos]..is_a?(NullPiece) # || it's opponent's piece
    # return piece
  end

  def in_bounds?(new_pos)
    new_pos.all? { |x| x.between?(0, 7) }
  end


end
