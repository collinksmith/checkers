require 'io/console'

class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_input
    $stdin.getch
  end

  def to_s
    color.to_s
  end
end
