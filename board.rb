require_relative 'piece'
require_relative 'empty_square'


class Board
  attr_reader :grid

  def initialize(size, grid = nil)
    @grid = grid || populate_grid(size)
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

  def display
    system('clear')
    puts render
  end

  def render
    grid.map.with_index do |row, row_i|
      row.map.with_index do |cell, col_i|
        if (row_i + col_i) % 2 == 0
          cell.to_s.colorize(:background => :yellow)
        else
          cell.to_s.colorize(:background => :green)
        end
      end.join("")
    end.join("\n")
  end
end

board = Board.new(8)
board.display
