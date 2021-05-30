module MastermindPrinter
  def MastermindPrinter.print_rounds(rounds)
    full_display = MastermindPrinter.header
    rounds.each { |round| full_display += print_round(round)}
    full_display += MastermindPrinter.footer

    puts full_display
  end

  private

  MATCH_PEG_CODE = "\u26AC".freeze

  def MastermindPrinter.exact_match_marker
    "\e[31m#{MATCH_PEG_CODE}\e[0m"
  end

  def MastermindPrinter.not_exact_match_marker
    MATCH_PEG_CODE
  end

  def MastermindPrinter.number_marker(number)
    case number
    when 1
      "\e[31m\u2776\e[0m"
    when 2
      "\e[32m\u2777\e[0m"
    when 3
      "\e[34m\u2778\e[0m"
    when 4
      "\e[35m\u2779\e[0m"
    when 5
      "\e[37m\u277a\e[0m"
    when 6
      "\e[36m\u277b\e[0m"
    end
  end

  def MastermindPrinter.print_round(round)
    round_display = "| " + " #{round[:number]}  | ".chars.last(6).join
    round_display += guess_column(round[:guess]) + ' |'
    round_display += result_column(round[:result])
    round_display += " |\n"

    round_display
  end

  def MastermindPrinter.header
    "========================\n"
  end

  def MastermindPrinter.footer
    "========================"
  end

  def MastermindPrinter.guess_column(guess)
    guess_display = ''
    guess.each { |num| guess_display += number_marker(num) + ' ' }

    guess_display
  end

  def MastermindPrinter.result_column(result)
    result_display = ''

    result.each { |peg| result_display += (peg == Mastermind::EXACT_MATCH) ? exact_match_marker : not_exact_match_marker }
    result_display += ' ' * (4 - result.length) 
    result_display
  end

end