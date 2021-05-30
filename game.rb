# prompts logic to start, setups, and stop game

$stdout.sync = true # allows use of print keep prompt and input on same line

class Game
  def initialize
    @mastermind = nil
    @breaker = nil # @breaker.next_guess
  end

  def print_instructions
    puts 'Welcome to Mastermind!'
    puts ''
    puts '  Rules:'
    puts '    A 4 digit code will be chosen by the code maker where each digit is 1-6.'
    puts '    valid codes:  1234, 5566 | invalid codes: 142, 1237, 16AB'
    puts ''
    puts '  The code maker will set the secrete code that the code breaker will attempt to solve.'
    puts '  Code breakers have 12 chances to correctly guess the code.'
    puts ''
    puts '  Each guess will get red and white pegs (or nothing!) to help narrow down the secret code.'
    puts "    #{MastermindPrinter.exact_match_marker} mean there is a correct digit in the right position."
    puts "    #{MastermindPrinter.not_exact_match_marker} mean there is a correct digit, but it is not in the right position."
    puts ''
  end

  def choose_role
    
    answer = ''
    until %w[1 2].include? answer
      print 'Choose your role, 1 for code breaker and 2 for code maker: '
      answer = gets.chomp
    end
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