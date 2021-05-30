require_relative 'mastermind'
require_relative 'game'
require_relative 'mastermind_printer'

# puts MastermindPrinter.exact_match_marker
# puts MastermindPrinter.not_exact_match_marker
# puts MastermindPrinter.number_marker(1)
# puts MastermindPrinter.number_marker(2)
# puts MastermindPrinter.number_marker(3)
# puts MastermindPrinter.number_marker(4)
# puts MastermindPrinter.number_marker(5)
# puts MastermindPrinter.number_marker(6)

# p Mastermind::DEFAULT_GAME_LENGTH

game = Game.new

play_again = 'y'
while play_again == 'y'
  game.play_game

  play_again = game.play_again
end
