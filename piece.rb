require_relative 'errors'
require 'colorize'
require 'byebug'

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
    if valid_slide?(end_pos)
      perform_slide(end_pos)
    elsif valid_jump?(end_pos)
      perform_jump(end_pos)
    else
      raise MoveError.new("Invalid move")
    end
  end

  def perform_slide(end_pos)
    if valid_slide?(end_pos)
      board.move(pos, end_pos)
      self.pos = end_pos
    end
  end

  def perform_jump(end_pos)
    if valid_jump?(end_pos)
      board.move(pos, end_pos)
      remove_jumped_piece(pos, end_pos)
      self.pos = end_pos
    end
  end

  def valid_move?(end_pos)
    valid_slide?(end_pos) || valid_jump?(end_pos)
  end

  def king?
    kinged
  end

  private

  attr_writer :pos

  def valid_slide?(end_pos)
    row_change = end_pos[0] - pos[0]
    col_change = end_pos[1] - pos[1]

    return false unless valid_end_pos?(end_pos) && col_change.abs == 1

    if king?
      row_change.abs == 1
    else
      row_change == allowed_direction
    end
  end

  def valid_jump?(end_pos)
    row_change = end_pos[0] - pos[0]
    col_change = end_pos[1] - pos[1]

    return false unless valid_end_pos?(end_pos) && col_change.abs == 2 &&
    jumped_piece?(pos, end_pos)

    if king?
      row_change.abs == 2
    else
      row_change == allowed_direction * 2
    end
  end

  def jumped_piece?(start_pos, end_pos)
    mid_pos = mid_pos(start_pos, end_pos)

    board[*mid_pos].color == opponent_color ? true : false
  end

  def remove_jumped_piece(start_pos, end_pos)
    board.remove_piece(mid_pos(start_pos, end_pos))
  end

  def mid_pos(start_pos, end_pos)
    row_change = end_pos[0] - pos[0]
    col_change = end_pos[1] - pos[1]

    mid_row = pos[0] + (row_change / 2)
    mid_col = pos[1] + (col_change / 2)
    [mid_row, mid_col]
  end

  def allowed_direction
    color == :white ? -1 : 1
  end

  def valid_end_pos?(end_pos)
    on_board?(end_pos) && board[*end_pos].empty? ? true : false
  end

  def opponent_color
    color == :white ? :black : :white
  end

  def on_board?(pos)
    pos
  end
end
