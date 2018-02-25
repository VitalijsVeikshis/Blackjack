class Player
  attr_reader :name, :bankroll, :cards

  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
    @cards = []
  end
end
