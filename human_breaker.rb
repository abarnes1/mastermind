$stdout.sync = true # allows use of print keep prompt and input on same line

class HumanBreaker
  def initialize; end

  def guess
    guess = ''

    until Game.valid_code?(guess)
      print 'Enter your guess: '
      guess = gets.chomp.split('')
      guess = guess.map(&:to_i)
    end

    guess
  end
end
