require 'colorize'

class Piece
  attr_reader :color

  def initialize(color)
    @color = color
    @kinged = false
  end

  def to_s
    " #{symbol}  "
  end

  def symbol
    if color == :red
      "\u26AA"
    else
      "\u26AB"
    end
  end
end
