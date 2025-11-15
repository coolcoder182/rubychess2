# frozen_string_literal: true

require './modules/player_hud_things'
require './board'

# game class
class Game
  attr_reader :player_one, :player_two

  def initialize(player_one, player_two)
    @board = Board.new
    @player_one = player_one
    @player_two = player_two
    @current_player = :white
  end

  def play_loop
    system('clear')
    @board.print_screen

    PlayerHudThings.show_banner(@current_player)
    start_pos = get_source_square
    # PlayerHudThings.show_status_message()

    gets
  end

  def get_source_square
    loop do
      print "Select a piece:"
      input = gets.chomp.downcase

      unless PlayerHudThings.valid_format?(input)
        puts "Invalid square. Example: 'e2'"
        next
      end
      pos = PlayerHudThings.parse_input(input)

      unless @board.in_bounds?(pos)
        puts "Out of bounds"
        next
      end

      piece = @board[pos]
      if piece.nil?
        puts "No piece at that square"
        next
      end
      unless piece.color == @current_player
        puts "Thats not your piece."
        next
      end
      return pos
    end
  end
end
