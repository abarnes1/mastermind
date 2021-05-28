#prompts logic to start, setups, and stop game

class Game
  def initialize
    @mastermind = nil
    @breaker = nil # @breaker.next_guess
  end

  def print_instructions
    puts 'these are the instructions'
  end

  def choose_role
    puts 'choose breaker or maker (and difficulty for breaker cpu)'
  end

  def play_game
    print_instructions
    choose_role

    # create secret cide for mastermind constructor

    @mastermind = Mastermind.new([1,2,3,4])

    until @mastermind.game_over? do
      guess = [1,1,3,3]

      @mastermind.guess_code(guess)
      @mastermind.print_rounds

      break if @mastermind.winner?
    end
  end
  
  def play again
    puts 'play again?'
    # y / n with y = play_game
  end
end

# print instructions
# prompt to play as code breaker or code maker
  # easy/hard computer breaker
# loop until 12 rounds or game won
# play again