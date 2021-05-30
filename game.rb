# prompts logic to start, setups, and stop game
require_relative 'computer_breaker'

$stdout.sync = true # allows use of print keep prompt and input on same line

class Game
  def initialize
    @mastermind = nil
    @breaker = nil
  end

  def print_instructions
    puts 'Welcome to Mastermind!'
    puts ''
    puts '  Rules:'
    puts '    A 4 digit code will be chosen by the code maker where each digit is 1-6.'
    puts '    valid codes:  1234, 5566 | invalid codes: 142, 1237, 16AB'
    puts ''
    puts '  The code maker will set the secret code that the code breaker will attempt to solve.'
    puts '  Code breakers have 12 chances to correctly guess the code.'
    puts ''
    puts '  Each guess will get red and white pegs (or nothing!) to help narrow down the secret code.'
    puts "    #{MastermindPrinter.exact_match_marker}: there is a correct digit in the right position."
    puts "    #{MastermindPrinter.not_exact_match_marker}: there is a correct digit, but it is not in the right position."
    puts ''
  end

  def choose_role
    answer = ''

    until %w[1 2].include?(answer)
      print 'Choose your role - 1 for code breaker and 2 for code maker: '
      answer = gets.chomp
    end

    @breaker = ComputerBreaker.new unless answer == '1'
  end

  def play_game
    print_instructions
    choose_role
    create_mastermind

    game_loop

    puts "The code was: #{@mastermind.end_game.join}"
    puts @mastermind.winner? ? 'Code breaker wins!' : 'Code maker wins!'
  end

  def play_again
    answer = ''
    until %w[y n].include?(answer)
      puts 'Play again? Y / N'
      answer = gets.chomp.downcase
    end

    answer
  end

  private

  def game_loop
    until @mastermind.game_over?
      @mastermind.guess_code(next_guess)
      MastermindPrinter.print_rounds(@mastermind.rounds)

      break if @mastermind.winner?
    end
  end

  def next_guess
    guess = ''

    if @breaker.instance_of?(ComputerBreaker)
      guess = @breaker.guess
    else
      until valid_input?(guess)
        print 'Enter your guess: '
        guess = gets.chomp.split('')
        guess = guess.map(&:to_i)
      end
    end

    guess
  end

  def create_mastermind
    @mastermind = if @breaker.instance_of?(ComputerBreaker)
                    Mastermind.new(Mastermind.generate_code)
                  else
                    Mastermind.new(player_code)
                  end
  end

  def player_code
    code = ''

    until valid_input?(code)
      print 'Enter a code for the computer to break: '
      code = gets.chomp.split('')
      code = code.map(&:to_i)
    end

    code
  end

  def valid_input?(guess)
    guess.length == 4 && guess.all? { |i| i.is_a?(Integer) }
  end
end
