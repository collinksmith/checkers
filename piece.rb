require 'colorize'

class Piece
  attr_reader :color, :pos, :kinged

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

  def perform_move(end_pos)

  end

  def perform_slide(end_pos)
    if valid_slide?(end_pos)
      board.move(pos, end_pos)
    end
  end

  def perform_jump(end_pos)
    if valid_jump?(end_pos)
      board.move(pos, end_pos)
    end
  end

  def king?
    kinged
  end

  private

  def valid_slide?(end_pos)


  end

  def on_board?(pos)
    pos
  end
end
