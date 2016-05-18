require 'colorize'
require_relative 'piece.rb'
require_relative 'display.rb'

class Board
  attr_reader :grid, :display
  PIECE_ROW = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def initialize
    @grid = Array.new(8) { Array.new(8, NullPiece.instance)  }
    @display = Display.new(self)
  end

  def populate
    populate_(:black)
    populate_(:white)
  end

  def populate_(color)
    if color == :black
      pawn_row, back_row = 1, 0
    else
      pawn_row, back_row = 6, 7
    end
    grid[pawn_row].each_index do |j|
      grid[pawn_row][j] = Pawn.new(self, [pawn_row, j], color)
    end
    PIECE_ROW.each_with_index do |class_name, j|
      grid[back_row][j] = class_name.new(self, [back_row, j], color)
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
    piece = self[start]
    unless piece.valid_moves.include?(end_pos)
      raise BadMoveError.new("You cannot move your piece there.")
    end
    self[end_pos] = self[start]
    self[start] = NullPiece.instance
    self[end_pos].current_pos = end_pos
  end

  def move!(start, end_pos)
    piece = self[start]
    self[end_pos] = self[start]
    self[start] = NullPiece.instance
    self[end_pos].current_pos = end_pos
  end

  def in_bounds?(new_pos)
    new_pos.all? { |x| x.between?(0, 7) }
  end

  def in_check?(color)
    king_pos = grid.flatten.select { |piece|
      piece.is_a?(King) && piece.color == color
    }.first.current_pos

    grid.flatten.reject { |piece|
      piece.is_a?(NullPiece) || piece.color == color
    }.each { |piece| return true if piece.moves.include?(king_pos) }
    false
  end

  def checkmate?(color)
    my_color_pieces = grid.flatten.select do |piece|
      !piece.is_a?(NullPiece) && piece.color == color
    end

    in_check?(color) && my_color_pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def dup
    n_board = Board.new
    grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        unless piece.is_a?(NullPiece)
          n_board[[i,j]] = piece.dup
          n_board[[i,j]].current_pos = [piece.current_pos[0], piece.current_pos[1]]
          n_board[[i,j]].board = n_board
        end
      end
    end
    n_board
  end
end
