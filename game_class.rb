# frozen_string_literal: true

require './modules/player_hud_things'
require './board'
require 'pry-byebug'

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
    loop do
      system('clear')
      @board.print_screen

      PlayerHudThings.show_banner(@current_player)
      start_pos = ask_for_starting_square
      if start_pos == 'end'
        puts "Exiting now"
        exit(0)
      end
      # player_turn to implement later
      selected_piece = @board[start_pos]
      moves = @board.possible_moves(selected_piece)
      if moves.empty?
        puts "That piece has no valid moves. Press Enter and choose again"
        gets
        next
      end

      system('clear')
      @board.print_screen(moves)

      move = { type: :not_selected }
      if move[:type] == :quit
        puts "exiting"
        exit(0)
      end
      until move[:type] == :move
        if move[:type] == :invalid
          puts move[:message]
          gets
          selected_piece = piece

        elsif move[:type] == :reselect
          selected_piece = move[:selected_piece]
        end
        moves = @board.possible_moves(selected_piece)
        move = ask_for_move(moves)
        if move[:type] == :quit
          puts "exiting"
          exit(0)
        end
      end

      @board.move_piece(selected_piece.pos, move[:selected_move])
      swap_turns
    end
  end

  # TODO: implent this later, i currently the first call is doing the same thing, no need to twice
  # def player_turn
  #
  # if player selects piece
  #   return selected piece and show board with possible moves
  #   if no moves print no valid moves
  # if player selectes move, a selected piece must be present
  #   return the selected move and process move
  # if invalid
  #   return :invalid type and print message
  #
  # end
  def swap_turns
    @current_player = @current_player == :white ? :black : :white
  end

  def ask_for_move(moves)
    loop do
      system('clear')
      @board.print_screen(moves)
      puts "Please select a move or select a different piece"
      puts "Or quit/q to exit"
      input = gets.chomp.downcase
      return { type: :quit } if input == 'quit' || input[0] == 'q'

      unless PlayerHudThings.valid_format?(input)
        puts "Invalid square. Example: 'e2'"
        next
      end
      pos = PlayerHudThings.parse_input(input)
      piece = @board[pos]
      return { type: :move, selected_move: pos } if moves.include?(pos)

      if piece && piece.color == @current_player # also need to check if can move this piece if in check
        return { type: :reselect, selected_piece: piece }
      end

      if piece && piece.color != @current_color
        return { type: :invalid, message: "Thats not your piece. Press enter to try again" }
      end
    end
  end

  # delete from here down

  def ask_for_starting_square
    loop do
      print "select a piece (e.g. 'e2' or 'q' to quit):"
      input = gets.chomp.downcase
      return 'end' if input == 'q'

      unless PlayerHudThings.valid_format?(input)
        puts "Invalid square. Example: 'e2'"
        next
      end
      pos = PlayerHudThings.parse_input(input)
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
