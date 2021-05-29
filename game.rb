# prompts logic to start, setups, and stop game

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

    # create secret code for mastermind constructor
    # test for now:
    test_code = Mastermind.generate_code
    p "test code: #{test_code}"

    @mastermind = Mastermind.new(test_code)

    until @mastermind.game_over?
      guess = player_guess

      @mastermind.guess_code(guess)
      @mastermind.print_rounds

      break if @mastermind.winner?
    end
  end

  def player_guess
    puts 'Enter your guess:'
    guess = gets.chomp.split('')
    guess = guess.map(&:to_i)

    p "the guess was: #{guess}"

    guess
  end

  def play_again
    puts 'play again?'
    # y / n with y = play_game
  end
end

# print instructions
# prompt to play as code breaker or code maker
  # easy/hard computer breaker
# loop until 12 rounds or game won
# play again