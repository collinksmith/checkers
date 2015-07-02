require_relative 'piece'
require_relative 'empty_square'


class Board
  attr_accessor :cursor_pos
  attr_reader :grid, :size

  def initialize(size, grid = nil)
    @grid = grid || populate_grid(size)
    @cursor_pos = [0, 0]
    @selected_pos = nil
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
      self.cursor_pos = [pos_row, pos_col - 1] unless pow_col < 1
    when :down
      self.cursor_pos = [pos_row + 1, pos_col] unless pos_row > (size - 1)
    when :right
      self.cursor_pos = [pos_row, pos_col + 1] unless pos-col > (size - 1)
    end
  end

  private

  def render
    grid.map.with_index do |row, row_i|
      render_row(row, row_i)
    end.join("\n")
  end

  def render_row(row, row_i)
    row.map.with_index do |cell, col_i|
      if [row_i, col_i] == cursor_pos
        cell.to_s.colorize(:background => :cyan)
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
          fill_row(row, true, :red)
        else
          fill_row(row, false, :red)
        end
      elsif row_i >= 5
        if row_i % 2 == 0
          fill_row(row, true, :white)
        else
          fill_row(row, false, :white)
        end
      end
    end

    grid
  end

  def fill_row(row, odd, color)
    if odd
      row.map.with_index do |cell, col_i|
        row[col_i] = Piece.new(color) unless col_i % 2 == 0
      end
    else
      row.map.with_index do |cell, col_i|
        row[col_i] = Piece.new(color) if col_i % 2 == 0
      end
    end
  end
end
