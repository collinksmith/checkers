class Game
  def initialize(player1, player2)
    @players = [player1, player2]
  end

  def play
    loop do
      player.get_input
    end
  end
end
