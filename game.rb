require_relative 'board'
require_relative 'human_player'

class Game
  attr_reader :board, :players

  def initialize(player1, player2)
    @players = [player1, player2]
    @board = Board.new(8)
  end

  def play
    until game_over?
      display_board

      moved = false
      until moved
        begin
          input = current_player.get_input
          moved = process_input(input)
          display_board
        rescue MoveError => e
          board.reset_selected_pos
          display_board
          puts e.message
          retry
        end
      end

      switch_players!
    end

    puts "Game over. #{players.last.to_s.capitalize} wins!"
  end

  def game_over?
    no_pieces?(:black) || no_pieces?(:white)
  end

  def no_pieces?(color)
    board.all_pieces.none? { |piece| piece.color == color }
  end

  def display_board
    system('clear')
    board.display
    puts "#{current_player.to_s.capitalize}'s turn"
  end

  def current_player
    players.first
  end

  def switch_players!
    players.rotate!
    board.current_player_color = current_player.color
  end

  def process_input(input)
    case input
    when 'w'
      board.move_cursor(:up)
    when 'a'
      board.move_cursor(:left)
    when 's'
      board.move_cursor(:down)
    when 'd'
      board.move_cursor(:right)
    when "\r"
      if board.selected_pos
        board.add_to_move_seq(board.cursor_pos)
        board.selected_piece.perform_moves(board.move_seq)
        board.reset_selected_pos
        return true
      elsif board.cursor_piece.color == current_player.color
        board.set_selected_pos
      end
    when " "
      board.add_to_move_seq(board.cursor_pos) if board.selected_piece
    when 'q'
      exit
    end

    false
  end
end

game = Game.new(HumanPlayer.new(:white), HumanPlayer.new(:black))
game.play
