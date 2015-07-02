require_relative 'board'
require_relative 'human_player'

class Game
  attr_reader :board, :players

  def initialize(player1, player2)
    @players = [player1, player2]
    @board = Board.new(8)
  end

  def play
    loop do
      display_board
      input = current_player.get_input
      process_input(input)
    end
  end

  def display_board
    system('clear')
    board.display
  end

  def current_player
    players.first
  end

  def process_input(input)
    case input
    when 'w'
      board.move_cursor(:up)
    when 'a'
      board.move_cursor(:left)
    when 's'
      board.move_cursor(:down)
    when 'd'
      board.move_cursor(:right)
    when "\r"
      if board.selected_pos
        # Move Piece
        board.reset_selected_pos
      else
        board.set_selected_pos
      end
    when 'q'
      exit
    end
  end
end

game = Game.new(HumanPlayer.new(:black), HumanPlayer.new(:white))
game.play
