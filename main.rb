# frozen_string_literal: true

require_relative 'lib/game'

loop do
  game = Game.new
  players = %w[r y]
  current_player = 'r'
  until game.winner?(players.difference([current_player])[0]) || game.full?
    game.display_grid
    puts "current player: #{current_player}.\nWhich column would you like to insert a disc in? (0..6)"
    inp = 8
    inp = gets.to_i until game.insert_disc(current_player, inp)
    current_player = players.difference([current_player])[0]
  end
  current_player = players.difference([current_player])[0]
  puts "#{current_player} won" if game.winner?(current_player)
  puts 'would you like to quit? [y]'
  break if gets.chomp == 'y'
end
