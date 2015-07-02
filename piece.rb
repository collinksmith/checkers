require 'colorize'

class Piece
  attr_reader :color, :pos, :kinged, :board

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @kinged = false
  end

  def to_s
    " #{symbol}  "
  end

  def symbol
    color == :white ? "\u26AA" : "\u26AB"
  end

  def empty?
    false
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

  def valid_move?(end_pos)
    valid_slide?(end_pos) || valid_jump?(end_pos)
  end

  def king?
    kinged
  end

  private

  def valid_slide?(end_pos)
    end_row, end_col = end_pos[0], end_pos[1]
    start_row, start_col = pos[0], pos[1]
    row_change = end_row - start_row
    col_change = end_col - start_col

    return false unless on_board?(end_pos) && board[*end_pos].empty?

    allowed_direction = color == :white ? -1 : 1

    if king?
      row_change.abs == 1 && col_change.abs == 1
    else
      row_change == allowed_direction && col_change.abs == 1
    end
  end

  def valid_jump?(end_pos)

  end

  def on_board?(pos)
    pos
  end
end
