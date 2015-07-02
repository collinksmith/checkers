class Game
  def initialize(player1, player2)
    @players = [player1, player2]
  end

  def play
    loop do
      input = layer.get_input
      process_input(input)
    end
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
