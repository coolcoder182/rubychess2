# frozen_string_literal: true

require './game_class'
loop do
  puts 'Player 1 enter your name'
  # player_one = PlayerInput.name_input
  player_one = 'aaron'
  player_two = 'not arraon'
  puts 'Player 2 enter your name'
  # player_two = PlayerInput.name_input
  game = Game.new(player_one, player_two)
  game.play_loop
end
