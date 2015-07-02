require_relative 'piece'
require_relative 'empty_square'


class Board
  attr_reader :grid, :size, :cursor_pos, :selected_pos

  def initialize(size, grid = nil)
    @size = size
    @cursor_pos = [0, 0]
    @selected_pos = nil
    @grid = grid || populate_grid(size)
  end

  def move

  end

  def display
    puts render
  end

  def move_cursor(direction)
    pos_row = cursor_pos.first
    pos_col = cursor_pos.last
    case direction
    when :up
      self.cursor_pos = [pos_row - 1, pos_col] unless pos_row < 1
    when :left
      self.cursor_pos = [pos_row, pos_col - 1] unless pos_col < 1
    when :down
      self.cursor_pos = [pos_row + 1, pos_col] unless pos_row > (size - 1)
    when :right
      self.cursor_pos = [pos_row, pos_col + 1] unless pos_col > (size - 1)
    end
  end

  def set_selected_pos
    self.selected_pos = cursor_pos
  end

  def reset_selected_pos
    self.selected_pos = nil
  end

  private

  attr_writer :cursor_pos, :selected_pos

  def render
    grid.map.with_index do |row, row_i|
      render_row(row, row_i)
    end.join("\n")
  end

  def render_row(row, row_i)
    row.map.with_index do |cell, col_i|
      if [row_i, col_i] == selected_pos
        cell.to_s.colorize(:background => :light_magenta)
      elsif [row_i, col_i] == cursor_pos
        cell.to_s.colorize(:background => :light_cyan)
      elsif (row_i + col_i) % 2 == 0
        cell.to_s.colorize(:background => :yellow)
      else
        cell.to_s.colorize(:background => :green)
      end
    end.join("")
  end

  def populate_grid(size)
    grid = Array.new(size) { Array.new(size) { EmptySquare.new } }

    grid.map.with_index do |row, row_i|
      if row_i <= 2
        if row_i % 2 == 0
          fill_row(row, row_i, true, :black)
        else
          fill_row(row, row_i, false, :black)
        end
      elsif row_i >= 5
        if row_i % 2 == 0
          fill_row(row, row_i, true, :white)
        else
          fill_row(row, row_i, false, :white)
        end
      end
    end

    grid
  end

  def fill_row(row, row_i, odd, color)
    if odd
      row.map.with_index do |cell, col_i|
        row[col_i] = Piece.new(color, [row_i, col_i]) unless col_i % 2 == 0
      end
    else
      row.map.with_index do |cell, col_i|
        row[col_i] = Piece.new(color, [row_i, col_i]) if col_i % 2 == 0
      end
    end
  end
end
