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
    color == :white ? "\u26AA" : "\u26AB"
  end


end
