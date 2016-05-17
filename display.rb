require "colorize"
require_relative "cursorable"

class Display

  include Cursorable
  attr_accessor :msg

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :green
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    unless @board[[i,j]].is_a?(NullPiece)
      if @board[[i,j]].color == :black
        cl = :red
      else
        cl = :white
      end
    end

    { background: bg, color: cl }
  end

  def render
    system("clear")
    puts msg
    puts "select a spot"
    build_grid.each { |row| puts row.join }
  end

  def move
    result = nil
    until result
      self.render
      result = get_input
    end
    result
  end
end
