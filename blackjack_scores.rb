module BlackjackScores
    def scores
      @cards.reduce(0) { |scores, card| scores + score_get(card, scores) }
    end

    def score_get(card, scores)
      return card[:value].to_i if (2..10).to_a.include?(card[:value].to_i)
      return 10 if %w[J Q K].include?(card[:value])
      return 1 if card[:value].eql?('A') && scores + 11 > 21
      return 11 if card[:value].eql?('A') && scores + 11 <= 21
    end
end
