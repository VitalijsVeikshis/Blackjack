require_relative 'blackjack_scores'
class Player
  include BlackjackScores

  attr_reader :name, :bankroll, :cards

  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
    @cards = []
  end

  def add_bankroll(amount)
    @bankroll += amount
  end

  def subtract_bankroll(amount)
    @bankroll -= amount
  end

  def receive_card(card)
    @cards << card
  end
end
