class ComputerBreaker
  def initialize
    @possible_codes = [1, 2, 3, 4, 5, 6].repeated_permutation(4).to_a
  end

  def guess(previous_round)
    # else remove losing codes and resample
    remove_losing_codes(previous_round[:guess], previous_round[:result]) unless previous_round.nil?
    @possible_codes.sample
  end

  def remaining_code_count
    @possible_codes.size
  end

  private

  def remove_losing_codes(guess, result)
    # puts "guess: #{guess}"
    # puts "result: #{result}"
    
    @possible_codes.delete(guess)

    remove_by_exact_match(guess, result)
  end

  def remove_by_exact_match(guess, result)
    exact_matches = result.select{ |e| e == Mastermind::EXACT_MATCH }.size
    guess_with_index = guess.each_with_index.to_a

    to_keep = @possible_codes.map do |code|
      # returns only codes where a number is at the same index n (exact_matches) times
      (code.each_with_index.to_a & guess_with_index).size == exact_matches ? code : nil
    end

    @possible_codes = @possible_codes & to_keep
  end

  # def rule_out_by_not_exact_match(guess, result)
  #   # remove possible codes based on not exact matches
  # end
end