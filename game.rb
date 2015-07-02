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
      board.cursor_up
    when 'a'
      board.cursor_left
    when 's'
      board.cursor_down
    when 'd'
      board.cursor_right
    when 'q'
      exit
    end
  end
end
