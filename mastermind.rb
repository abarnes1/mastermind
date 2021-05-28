# logic for game itself... stored mystery numbers and store rounds
class Mastermind
  def initialize(code)
    @code = code
    @rounds = []
    @code_breaker
  end

  def round_number
    @rounds.length
  end

  def game_over?
    @rounds.length == 12
  end

  def winner?
    # rounds[-1][:result] = XXXX (whatever red pegs are)
  end

  def guess_code(code)
    @rounds << { guess: code, result: calculate_result(code) }
    puts "guessing code #{code} with result #{@rounds[-1][:result]}"
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

  def calculate_result(code)
    code.reverse
  end

end