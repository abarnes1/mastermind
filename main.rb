require_relative 'mastermind'
require_relative 'game'

p Mastermind::DEFAULT_GAME_LENGTH

game = Game.new
game.play_game
