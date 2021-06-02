# frozen_string_literal: true

require_relative 'computer_breaker'
require_relative 'human_breaker'

$stdout.sync = true # allows use of print keep prompt and input on same line

# logic for setting up, starting, and stopping the mastermind game
class GameMaster
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

  def play_game
    print_instructions
    choose_breaker
    create_mastermind

    game_loop

    puts "The code was: #{@mastermind.end_game.join}"
    puts @mastermind.winner? ? 'Code breaker wins!' : 'Code maker wins!'
  end

  def choose_breaker
    answer = ''

    until %w[1 2].include?(answer)
      print 'Choose your role - 1 for code breaker or 2 for code maker: '
      answer = gets.chomp
    end

    @breaker = answer == '1' ? HumanBreaker.new : ComputerBreaker.new
  end

  def play_again
    answer = ''

    until %w[y n].include?(answer)
      puts 'Play again? Y / N'
      answer = gets.chomp.downcase
    end

    answer
  end

  def self.valid_code?(guess)
    guess.length == 4 && guess.all? { |i| i.is_a?(Integer) }
  end

  private

  def game_loop
    until @mastermind.game_over?
      @mastermind.guess_code(@breaker.guess)
      @breaker.remember_result(@mastermind.rounds[-1]) if @breaker.instance_of?(ComputerBreaker)
      MastermindPrinter.print_rounds(@mastermind.rounds)

      break if @mastermind.winner?
    end
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

    until self.class.valid_code?(code)
      print 'Enter a code for the computer to break: '
      code = gets.chomp.split('')
      code = code.map(&:to_i)
    end

    code
  end
end
