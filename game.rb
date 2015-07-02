require_relative 'board'

class Game
  attr_reader :board, :players

  def initialize(player1, player2)
    @players = [player1, player2]
    @board = Board.new(8)
  end

  def play
    loop do
      input = current_player.get_input
      process_input(input)
    end
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
    when 'q'
      exit
    end
  end
end
