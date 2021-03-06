module Sometimes

  def self.sometimes(numerator, denominator)
    do_it_this_time = rand(denominator) < numerator
    if block_given? and do_it_this_time
      yield
    else
      do_it_this_time
    end
  end

  # I'd rather use something like numbers_and_words gem. It has a lot functionality from getting the words based on numbers, but no so much the other way around, so it might require that we add functionality.
  WordsToFractionPieces = {
    half: [1,2],
    a_third: [1,3],
    two_thirds: [2,3],
    a_fourth: [1,4],
    three_fourths: [3,4],
    a_fifth: [1,5],
    four_fifths: [4,5]
  }

  def self.method_missing(sym, *args, &block)
    fraction_in_words, anchor, extra = sym.to_s.partition('_of_the_time')
    if extra.blank? and anchor == '_of_the_time' and not fraction_in_words.blank?
      if (fraction_pieces = WordsToFractionPieces[fraction_in_words.to_sym])
        sometimes(*fraction_pieces, &block)
      else
        super
      end
    else
      super
    end
  end
end
