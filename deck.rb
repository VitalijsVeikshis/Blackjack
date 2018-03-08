class Deck
  CARD_RANGE = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = {
    diamonds: "\u2662".encode('utf-8'),
    clubs: "\u2667".encode('utf-8'),
    hearts: "\u2661".encode('utf-8'),
    spades: "\u2664".encode('utf-8')
  }.freeze

  attr_reader :deck

  def initialize
    @deck = []
  end

  def fill_deck
    @deck = SUITS.map { |suit, view| initialize_suit(suit, view) }
                 .flatten
                 .shuffle
  end

  def deal
    @deck.pop
  end

  def add_card(card)
    @deck << card
  end

  def clean_deck
    @deck = []
  end

  def scores(cards = @deck)
    cards.reduce(0) { |scores, card| scores + score_get(card, scores) }
  end

  def draw?(winner, foe)
    scores(winner.hand) == scores(foe.hand)
  end

  def win?(winner, foe)
    winner?(winner, foe) || scores(foe.hand) > 21
  end

  def winner?(winner, foe)
    scores(winner.hand) <= 21 && scores(winner.hand) > scores(foe.hand)
  end

  private

  def initialize_suit(suit, view)
    CARD_RANGE.map do |value|
      {
        value: value,
        suit: suit.to_s,
        view: value + view
      }
    end
  end

  def score_get(card, scores)
    return card[:value].to_i if number_card?(card)
    return 10 if face_card?(card)
    return 1 if ace_less?(card, scores)
    return 11 if ace_more?(card, scores)
  end

  def number_card?(card)
    (2..10).to_a.include?(card[:value].to_i)
  end

  def face_card?(card)
    %w[J Q K].include?(card[:value])
  end

  def ace_less?(card, scores)
    card[:value].eql?('A') && scores + 11 > 21
  end

  def ace_more?(card, scores)
    card[:value].eql?('A') && scores + 11 <= 21
  end
end
