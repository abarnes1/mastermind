# frozen_string_literal: true

$stdout.sync = true # allows use of print keep prompt and input on same line

# Gathers input from a human code breaker
class HumanBreaker
  def initialize; end

  def guess
    guess = ''

    until GameMaster.valid_code?(guess)
      print 'Enter your guess: '
      guess = gets.chomp.split('')
      guess = guess.map(&:to_i)
    end

    guess
  end
end
