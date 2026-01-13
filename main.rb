require_relative './lib/game'

play_again = true
while play_again
  game = Game.new
  game.play_game

  print "\nWould you like to play again? (Y or N): "
  play_again = gets.chomp.upcase == 'Y'
end
puts 'Good Bye!'
