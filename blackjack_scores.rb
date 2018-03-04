module BlackjackScores
  def scores
    @cards.reduce(0) { |scores, card| scores + score_get(card, scores) }
  end

  private

  def score_get(card, scores)
    return card[:value].to_i if number_cards?(card)
    return 10 if face_cards?(card)
    return 1 if ace_less?(card, scores)
    return 11 if ace_more?(card, scores)
  end

  def number_cards?(card)
    (2..10).to_a.include?(card[:value].to_i)
  end

  def face_cards?(card)
    %w[J Q K].include?(card[:value])
  end

  def ace_less?(card, scores)
    card[:value].eql?('A') && scores + 11 > 21
  end

  def ace_more?(card, scores)
    card[:value].eql?('A') && scores + 11 <= 21
  end
end
