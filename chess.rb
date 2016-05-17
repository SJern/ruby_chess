require_relative 'board.rb'
require_relative 'player.rb'

class Game
  attr_reader :current_player, :board

  def initialize(player1, player2, board)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @previous_player = player2
  end

  def play
    board.populate
    begin
      until board.checkmate?(@current_player.color) #board.checkmate?(:black) || board.checkmate?(:white)
        current_player.play_turn
        @current_player, @previous_player = @previous_player, @current_player
      end
      print "\n\nin checkmate!\n#{@previous_player.color} you won\n\n"
    rescue
      puts "Pick a new piece"
      sleep(1)
      retry
    end
  end
end


if $PROGRAM_NAME == __FILE__
  board = Board.new
  player1 = HumanPlayer.new(:black, board)
  player2 = HumanPlayer.new(:white, board)
  g = Game.new(player1, player2, board)
  g.play

end
