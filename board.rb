require_relative 'piece'
require_relative 'empty_square'


class Board
  attr_reader :grid, :size, :cursor_pos, :selected_pos, :move_seq
  attr_accessor :current_player_color

  def initialize(size = 8, grid = nil)
    @size = size
    @cursor_pos = [0, 0]
    @selected_pos = nil
    @move_seq = []
    @grid = grid || populate_grid(size)
    @current_player_color = :white
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  def move(start_pos, end_pos)
    piece = selected_piece
    self[*start_pos] = cursor_piece
    self[*end_pos] = piece
  end

  def selected_piece
    if selected_pos
      self[*selected_pos]
    else
      raise "Trying to select a piece that doesn't exist"
    end
  end

  def cursor_piece
    self[*cursor_pos]
  end

  def remove_piece(pos)
    self[*pos] = EmptySquare.new
  end

  def all_pieces
    grid.flatten
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
    add_to_move_seq(cursor_pos)
  end

  def reset_selected_pos
    self.selected_pos = nil
    reset_move_seq
  end

  def add_to_move_seq(pos)
    begin
      raise MoveError.new("Invalid move.") unless selected_piece.valid_move?(pos)
      self.move_seq << pos
    rescue => e
      puts e.message
    end
  end

  def reset_move_seq
    self.move_seq = []
  end

  def

  def deep_dup
    p "DUPING THE BOARD"
    new_grid = dup_grid
    # new_grid = grid.map { |row| row.map { |piece| piece.dup } }
    new_board = self.class.new(size, new_grid)
    new_board.grid.map! { |row| row.map! { |piece| piece.board = self } }
    new_board
  end

  def dup_grid
    new_grid = Array.new(8) { [] }
    grid.each_with_index do |row, row_i|
      row.each do |cell|
        p "duping #{cell}"
        new_grid[row_i] << cell.dup
      end
    end

    p "TESTING DUP_GRID METHOD: #{new_grid == grid}"

    new_grid
  end

  protected

  attr_writer :grid

  private

  attr_writer :cursor_pos, :selected_pos, :move_seq

  def render
    grid.map.with_index do |row, row_i|
      render_row(row, row_i)
    end.join("\n")
  end

  def render_row(row, row_i)
    row.map.with_index do |cell, col_i|
      pos = row_i, col_i

      if !selected_pos.nil? && selected_piece.valid_move?(pos) &&
         current_player_color == selected_piece.color
        cell.to_s.colorize(:background => :light_red)
      elsif selected_pos.nil? && cursor_piece.valid_move?(pos) &&
            current_player_color == cursor_piece.color
        cell.to_s.colorize(:background => :light_red)
      elsif pos == selected_pos
        cell.to_s.colorize(:background => :light_magenta)
      elsif pos == cursor_pos
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
        row[col_i] = Piece.new(color, [row_i, col_i], self) unless col_i % 2 == 0
      end
    else
      row.map.with_index do |cell, col_i|
        row[col_i] = Piece.new(color, [row_i, col_i], self) if col_i % 2 == 0
      end
    end
  end
end
