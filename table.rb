class Table
  attr_reader :player, :diller, :game

  def initialize(options)
    @player = options[:player]
    @diller = options[:diller]
    @bet = options[:bet]
    @deck = Deck.new
  end

  def play
    validate!
    @queue = [@player, @diller]
    @active = @queue.shift
    @deck.fill_deck
    @bank = 2 * @bet
    puts "Bank: #{@bank}"
    initialize_players
    @game = true
    @diller_went = false
    check_player
  end

  def hit
    if @active.hand.size > 2
      raise StandardError, "You can't take another card from the dealer!"
    end
    @active.add_card(@deck.deal)
    stand
  end

  def stand
    @active.show_cards if check_player < 21
    @queue << @active
    @active = @queue.shift
    diller_turn if @player.scores < 21 && @diller_went == false
  end

  def show
    check_winner
  end

  def diller_turn
    @diller_went = true
    stand if @diller.scores >= 17
    hit if @diller.scores < 17
  end

  private

  def initialize_players
    initialize_player(@player)
    initialize_player(@diller)
  end

  def initialize_player(player)
    player.subtract_bankroll(@bet)
    player.clean_cards
    2.times { player.add_card(@deck.deal) }
    player.show_cards
  end

  def check_winner
    draft_show if @deck.draw?(@player, @diller)
    win_show(@player) if @deck.win?(@player, @diller)
    win_show(@diller) if @deck.win?(@diller, @player)
  end

  def check_player
    win_show(@diller) if @player.scores > 21
    win_show(@player) if @player.scores == 21 && @diller.scores != 21
    @player.scores
  end

  def draft_show
    @game = false
    @player.add_bankroll(@bank / 2)
    @diller.add_bankroll(@bank / 2)
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
    @diller.show_cards(false)
  end

  def bankroll_zero?
    @player.bankroll.zero? || @diller.bankroll.zero?
  end

  def validate!
    raise StandardError, 'Not enough money!' if bankroll_zero?
    raise StandardError, 'You are in game!' if @game
  end
end
