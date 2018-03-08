class Table
  attr_reader :player, :dealer, :game

  def initialize(options)
    @player = options[:player]
    @dealer = options[:dealer]
    @bet = options[:bet]
    @deck = Deck.new
  end

  def play
    validate!
    @queue = [@player, @dealer]
    @deck.fill_deck
    @bank = 2 * @bet
    puts "Bank: #{@bank}"
    initialize_players
    @game = true
    @dealer_went = false
    check_player
  end

  def hit
    if @queue.first.hand.size > 2
      raise StandardError, "You can't take another card from the dealer!"
    end
    @queue.first.add_card(@deck.deal)
    stand
  end

  def stand
    @queue.first.show_cards if check_player < 21
    @queue << @queue.shift
    dealer_turn if @player.scores < 21 && @dealer_went == false
  end

  def show
    check_winner
  end

  def dealer_turn
    @dealer_went = true
    stand if @dealer.scores >= 17
    hit if @dealer.scores < 17
  end

  private

  def initialize_players
    initialize_player(@player)
    initialize_player(@dealer)
  end

  def initialize_player(player)
    player.subtract_bankroll(@bet)
    player.clean_cards
    2.times { player.add_card(@deck.deal) }
    player.show_cards
  end

  def check_winner
    draft_show if @deck.draw?(@player, @dealer)
    win_show(@player) if @deck.win?(@player, @dealer)
    win_show(@dealer) if @deck.win?(@dealer, @player)
  end

  def check_player
    win_show(@dealer) if @player.scores > 21
    win_show(@player) if @player.scores == 21 && @dealer.scores != 21
    @player.scores
  end

  def draft_show
    @game = false
    @player.add_bankroll(@bank / 2)
    @dealer.add_bankroll(@bank / 2)
    open_cards
    puts 'Draw!!!!'
  end

  def win_show(winner)
    @game = false
    winner.add_bankroll(@bank)
    open_cards
    puts "Win #{winner.name}!!!!"
  end

  def open_cards
    @player.show_cards
    @dealer.show_cards(false)
  end

  def bankroll_zero?
    @player.bankroll.zero? || @dealer.bankroll.zero?
  end

  def validate!
    raise StandardError, 'Not enough money!' if bankroll_zero?
    raise StandardError, 'You are in game!' if @game
  end
end
