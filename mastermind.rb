# logic for game itself... stored mystery numbers and store rounds
class Mastermind
  DEFAULT_GAME_LENGTH = 12
  EXACT_MATCH = 'X'.freeze
  ANY_MATCH = 'O'.freeze

  def initialize(code)
    @code = code
    @rounds = []
    @code_breaker
  end

  def round_number
    @rounds.length
  end

  def game_over?
    @rounds.length == DEFAULT_GAME_LENGTH
  end

  def winner?
    @rounds[-1][:result] == %w[X X X X]
  end

  def guess_code(code)
    puts "guessing code #{code}"
    @rounds << { guess: code, result: calculate_result(code) }
    puts "with result #{@rounds[-1][:result]}"
    # private func to decide what the pegs (result) are
  end

  def self.generate_code
    code = []
    4.times { code << rand(1..6) }

    code
  end

  def print_rounds
    puts @rounds.to_a
  end

  private

  def calculate_result(guess)
    remaining_code = @code.map { |i| i }
    remaining_guess = guess.map { |i| i }
    result = []

    p "remaining guess before index match #{remaining_guess}"
    result += exact_matches(remaining_guess, remaining_code)
    result += any_matches(remaining_guess.compact, remaining_code.compact)

    result
  end

  def exact_matches(guess, code)
    result = []

    @code.each_index do |i|
      next if guess[i] != @code[i]

      code[i] = nil
      guess[i] = nil
      result << EXACT_MATCH
    end

    result
  end

  def any_matches(guess, code)
    result = []
    guess.compact.each_index do |i|
      next if code.index(guess[i]).nil?

      code[code.index(guess[i])] = nil
      guess[i] = nil
      result << ANY_MATCH
    end

    result
  end
end
