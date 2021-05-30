# prompts logic to start, setups, and stop game

$stdout.sync = true # allows use of print keep prompt and input on same line

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

    @mastermind = Mastermind.new(Mastermind.generate_code)

    game_loop

    puts "The code was: #{@mastermind.end_game.join}"
    puts @mastermind.winner? ? 'Code breaker wins!' : 'Code maker wins!'
  end

  def game_loop
    until @mastermind.game_over?
      guess = player_guess

      @mastermind.guess_code(guess)
      MastermindPrinter.print_rounds(@mastermind.rounds)

      break if @mastermind.winner?
    end
  end

  def player_guess
    guess = ''

    until valid_input?(guess)
      print 'Enter your guess: '
      guess = gets.chomp.split('')
      guess = guess.map(&:to_i)
    end

    guess
  end

  def play_again
    answer = ''
    until %w[y n].include?(answer)
      puts 'Play again? Y / N'
      answer = gets.chomp.downcase
    end

    answer
  end

  def valid_input?(guess)
    guess.length == 4 && guess.all? { |i| i.is_a?(Integer) }
  end
end

# print instructions
# prompt to play as code breaker or code maker
  # easy/hard computer breaker
# loop until 12 rounds or game won
# play again