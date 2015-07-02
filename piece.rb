require 'colorize'

class Piece
  attr_reader :color

  def initialize(color, pos)
    @color = color
    @kinged = false
    @pos = pos
  end

  def to_s
    " #{symbol}  "
  end

  def symbol
    color == :white ? "\u26AA" : "\u26AB"
  end

  def perform_slide()

  end
end
