class ComputerBreaker
  def initialize
    @possible_codes = nil
  end

  def guess
    return codes.sample
  end


  private

  def codes
    generate_possible_codes if @possible_codes.nil?
    @possible_codes
  end

  def generate_possible_codes
    @possible_codes = 
      [
        [1, 1, 1, 1], [2, 2, 2, 2], [4, 1, 3, 4]
      ]
  end
end