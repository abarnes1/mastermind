class ComputerBreaker
  def initialize
    @possible_codes = [1, 2, 3, 4, 5, 6].repeated_permutation(4).to_a
    @last_result = nil
  end

  def guess
    remove_losing_codes(@last_result[:guess], @last_result[:result]) unless @last_result.nil?
    puts "\nComputer is thinking real hard about the remaining #{@possible_codes.size} code(s)..."

    # slowdown to keep from immediately running through the entire game
    sleep(2)
    @possible_codes.sample
  end

  def remember_result(round_result)
    @last_result = round_result
  end

  private

  def remove_losing_codes(guess, result)
    @possible_codes.delete(guess)

    remove_by_exact_match(guess, result)

    # computer always wins already, remove_by_not_exact_match function doesn't seem necessary
  end

  def remove_by_exact_match(guess, result)
    exact_matches = result.select { |e| e == Mastermind::EXACT_MATCH }.size
    guess_with_index = guess.each_with_index.to_a

    to_keep = @possible_codes.map do |code|
      # returns only codes where a number is at the same index n (n = exact_matches) times
      (code.each_with_index.to_a & guess_with_index).size == exact_matches ? code : nil
    end

    @possible_codes &= to_keep
  end
end
