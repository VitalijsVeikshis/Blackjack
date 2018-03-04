require_relative 'deck'
require_relative 'menu'
require_relative 'table'
require_relative 'player'
require_relative 'diller'
require_relative 'diller_ai'

class Gameplay
  def initialize
    @table = Table.new(player: Player.new(name: 'Stranger', bankroll: 100),
                       diller: Diller.new(name: 'Diller', bankroll: 100),
                       bet: 10)
    @menu = Menu.new
    @ai = DillerAI.new(@table)
  end

  def go
    game_header
    loop do
      begin
        task = receive_task
        break if exit?(task)
        process_task(task)
      rescue StandardError => e
        puts e.message
      end
    end
  end

  private

  def process_task(task)
    case task
    when 'play' then play(task)
    when 'hit' then hit(task)
    when 'stand' then stand(task)
    when 'show' then show(task)
    end
    show_menu
  end

  def play(task)
    call_task(task) unless @table.game
  end

  def hit(task)
    @ai.turn if call_task(task) < 21
  end

  def stand(task)
    call_task(task)
    @ai.turn
  end

  def show(task)
    call_task(task)
  end

  def show_menu
    if @table.game
      @menu.game_menu
    else
      @menu.exit_menu
    end
  end

  def game_header
    @table.player.name = receive_name
    show_menu
  end

  def exit?(task)
    task.casecmp('exit').zero? ? true : false
  end

  def receive_name
    print "Hello stranger! What's your name? "
    gets.chomp
  end

  def receive_task
    print 'Blackjack > '
    gets.chomp.downcase
  end

  def call_task(action)
    @table.public_send(action.to_sym)
  end
end
