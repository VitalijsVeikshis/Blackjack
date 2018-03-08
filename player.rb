class Player
  attr_accessor :name
  attr_reader :bankroll

  def initialize(options)
    @name = options[:name]
    @bankroll = options[:bankroll]
    @deck = Deck.new
  end

  def add_bankroll(amount)
    @bankroll += amount
  end

  def subtract_bankroll(amount)
    @bankroll -= amount
  end

  def add_card(card)
    @deck.add_card(card)
  end

  def clean_cards
    @deck.clean_deck
  end

  def scores
    @deck.scores
  end

  def hand
    @deck.deck
  end

  def show_cards(back_of_card = false)
    cards = hand
    sc = scores
    if back_of_card
      cards = hand.map { { view: '*' } }
      sc = '?'
    end
    print_cards(cards, sc)
  end

  private

  def print_cards(cards, sc)
    print "#{@name} cards: "
    cards.each { |card| print "#{card[:view]} " }
    puts " Scores: #{sc} Bankroll: #{@bankroll}"
  end
end
