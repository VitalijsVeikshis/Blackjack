class Diller < Player
  def show_cards(back_of_card = true)
    cards = @cards
    sc = scores
    if back_of_card
      cards = @cards.map { { view: '*' } }
      sc = '?'
    end
    print "#{@name} cards: "
    cards.each { |card| print "#{card[:view]} " }
    puts " Scores: #{sc} Bankroll: #{@bankroll}"
  end
end
