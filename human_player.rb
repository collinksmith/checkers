require 'io/console'

class HumanPlayer
  def initialize(color)
    @color = color
  end

  def get_input
    $stdin.getch
  end
end
