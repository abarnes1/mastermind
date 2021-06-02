require_relative 'game_master'
require_relative 'mastermind'
require_relative 'mastermind_printer'

game = GameMaster.new

play_again = 'y'

while play_again == 'y'
  game.play_game

  play_again = game.play_again
end
