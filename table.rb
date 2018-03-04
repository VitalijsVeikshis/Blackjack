class Table
  attr_reader :player, :diller, :game

  def initialize(options)
    @player = options[:player]
    @diller = options[:diller]
    @bet = options[:bet]
  end

  def play
    raise StandardError, 'Not enough money' if bankroll_zero?
    @queue = [@player, @diller]
    @active = @queue.shift
    @deck = Deck.new
    @bank = 2 * @bet
    puts "Bank: #{@bank}"
    initialize_player(@player)
    initialize_player(@diller)
    @game = true
    check_player
  end

  def hit
    @active.add_card(@deck.deal) if @active.cards.size == 2
    stand
  end

  def stand
    @active.show_cards if check_player < 21
    @queue << @active
    @active = @queue.shift
    @player.scores
  end

  def show
    check_winner
    @player.scores
  end

  private

  def initialize_player(player)
    player.subtract_bankroll(@bet)
    player.clean_cards
    2.times { player.add_card(@deck.deal) }
    player.show_cards
  end

  def check_winner
    draft_show if draw?
    win_show(@player) if win?(@player, @diller)
    win_show(@diller) if win?(@diller, @player)
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

  def draw?
    @player.scores == @diller.scores
  end

  def win?(winner, foe)
    winner.scores <= 21 && winner.scores > foe.scores || foe.scores > 21
  end

  def bankroll_zero?
    @player.bankroll.zero? || @player.bankroll.zero?
  end
end
