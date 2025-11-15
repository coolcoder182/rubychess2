# frozen_string_literal: true

# module for player input
module PlayerHudThings
  def self.name_input
    player_input = gets.chomp
    check_for_quit(player_input)
    player_input
  end

  def self.check_for_quit(input)
    return unless input.downcase == 'quit' || input.downcase[0] == 'q'

    puts 'Thank you for playing.'
    puts 'Exiting now.'
    exit(0)
  end

  def self.show_banner(current_player)
    puts
    puts "================="
    puts "#{current_player.capitalize}'s turn"
    puts "================="
    puts
  end

  def self.valid_format?(input)
    !!input.match?(/^[a-h][1-8]/)
  end

  def self.parse_input(input)
    col = input[0].ord - 'a'.ord
    row = 8 - input[1].to_i
    [row, col]
  end
end
