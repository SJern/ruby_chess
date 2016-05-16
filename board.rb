require_relative 'piece.rb'
require 'colorize'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }

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





end
