# logic for game itself... stored mystery numbers and store rounds


class Mastermind
  DEFAULT_GAME_LENGTH = 12
  EXACT_MATCH = 'X'.freeze
  NOT_EXACT_MATCH = 'O'.freeze

  attr_reader :rounds

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
    @rounds << { number: @rounds.length + 1, guess: code, result: calculate_result(code) }
  end

  def self.generate_code
    code = []
    4.times { code << rand(1..6) }

    code
  end

  def end_game
    code = @code
    @code = nil

    code
  end

  private

  def calculate_result(guess)
    code_copy = @code.map { |i| i }
    guess_copy = guess.map { |i| i }
    result = []

    result += exact_matches(guess_copy, code_copy)
    result += not_exact_matches(guess_copy, code_copy)

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

  def not_exact_matches(guess, code)
    result = []

    guess.each_index do |i|
      next if guess[i].nil? || code.index(guess[i]).nil?

      code[code.index(guess[i])] = nil
      guess[i] = nil
      result << NOT_EXACT_MATCH
    end

    result
  end
end
