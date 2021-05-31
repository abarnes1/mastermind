# prompts logic to start, setups, and stop game
require_relative 'computer_breaker'

$stdout.sync = true # allows use of print keep prompt and input on same line

class Game
  def initialize
    @mastermind = nil
    @breaker = nil
  end

  def print_instructions
    puts '                     _                      _           _ '
    puts ' _ __ ___   __ _ ___| |_ ___ _ __ _ __ ___ (_)_ __   __| |'
    puts "| '_ ` _ \\ / _` / __| __/ _ \\ '__| '_ ` _ \\| | '_ \\ / _` |"
    puts '| | | | | | (_| \__ \ ||  __/ |  | | | | | | | | | | (_| |'
    puts '|_| |_| |_|\__,_|___/\__\___|_|  |_| |_| |_|_|_| |_|\__,_|'
    puts ''
    puts 'Rules:'
    puts '  A 4 digit code will be chosen by the code maker where each digit is 1-6.'
    puts '  valid codes:  1234, 5566 | invalid codes: 142, 1237, 16AB'
    puts ''
    puts '  The code maker will set the secret code that the code breaker will attempt to solve.'
    puts '  Code breakers have 12 chances to correctly guess the code.'
    puts ''
    puts '  Each guess will get red and white circles (or nothing!) to help narrow down the secret code.'
    puts "    #{MastermindPrinter.exact_match_marker} - there is a correct digit in the right position."
    puts "    #{MastermindPrinter.not_exact_match_marker} - there is a correct digit, but it is not in the right position."
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
      guess = @breaker.guess(@mastermind.rounds[-1])
      puts "Computer's turn...thinking real hard about the remaining #{@breaker.remaining_code_count} code(s)..."

      # timer of false hope
      sleep(2)
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
                    Mastermind.new(player_code)
                  else
                    puts 'The computer has generated a secret code.'
                    Mastermind.new(Mastermind.generate_code)
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
