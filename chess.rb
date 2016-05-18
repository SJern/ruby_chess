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
      until board.checkmate?(@current_player.color)
        current_player.play_turn
        @current_player, @previous_player = @previous_player, @current_player
      end
      print "\n\nCheckmate!\n#{@previous_player.color.upcase}, you won!!!\n\n"
    rescue BadMoveError => e
      board.display.msg = e.message
      retry
    end
  end
end

class BadMoveError < ArgumentError
  attr_reader :message
  def initialize(msg="Bad move!")
    @message = msg
  end
end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  player1 = HumanPlayer.new(:black, board)
  player2 = HumanPlayer.new(:white, board)
  g = Game.new(player1, player2, board)
  g.play
end
