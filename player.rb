class Player
  attr_accessor :name, :deck
  attr_reader :bankroll, :cards

  def initialize(options)
    @name = options[:name]
    @bankroll = options[:bankroll]
    @cards = []
  end

  def add_bankroll(amount)
    @bankroll += amount
  end

  def subtract_bankroll(amount)
    @bankroll -= amount
  end

  def add_card
    @cards << @deck.deal
  end

  def clean_cards
    @cards = []
  end

  def scores
    @deck.scores(@cards)
  end

  def show_cards(back_of_card = false)
    cards = @cards
    sc = @deck.scores(cards)
    if back_of_card
      cards = @cards.map { |card| card[:view] = '*' }
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
