class Deck
  CARD_RANGE = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = {
    diamonds: "\u2662".encode('utf-8'),
    clubs: "\u2667".encode('utf-8'),
    hearts: "\u2661".encode('utf-8'),
    spades: "\u2664".encode('utf-8')
  }.freeze

  def initialize
    @deck = make_deck.shuffle
  end

  def deal
    @deck.pop
  end

  private

  def make_deck
    SUITS.map { |suit, view| initialize_suit(suit, view) }.flatten
  end

  def initialize_suit(suit, view)
    CARD_RANGE.map do |value|
      {
        value: value,
        suit: suit.to_s,
        view: value + view
      }
    end
  end
end
