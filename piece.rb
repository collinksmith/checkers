require 'colorize'

class Piece
  attr_reader :color

  def initialize(color)
    @color = color
    @kinged = false
  end

  def to_s
    " #{symbol} "
  end

  def symbol
    if color == :red
      "\u25CF".colorize(:color => :red)
    else
      "\u25CF".colorize(:color => :white)
    end
  end
end
