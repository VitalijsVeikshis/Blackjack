require_relative 'deck'
require_relative 'table'
require_relative 'player'
require_relative 'diller'

TAB1 = 3
GAME = [
  'hit - Take another card from the dealer.',
  'stand - Take no more cards.',
  'show - Open cards.'
].freeze
EXIT = [
  'play - Continue game.',
  'exit - Quite game.'
].freeze

class Menu
  class SubMenu
    def initialize(options)
      @head = options[:head]
      @indent = options[:indent]
      @items = options[:items]
    end

    def make(string, indent, indent_string = '')
      indent_string.rjust(indent) + string
    end

    def show
      puts '--------------------------------------------'
      puts make(@items.first, @indent, @head)
      @items[1..-1].each { |item| puts make(item, @indent) }
      puts '--------------------------------------------'
    end
  end

  def initialize
    @menu_items = {
      game: SubMenu.new(head: '', indent: TAB1, items: GAME),
      exit: SubMenu.new(head: '', indent: TAB1, items: EXIT)
    }
    @table = Table.new(player: Player.new(name: 'Stranger', bankroll: 100),
                       diller: Diller.new(name: 'Diller', bankroll: 100),
                       bet: 10)
    @task = ''
  end

  def run
    game_header
    process_task
  end

  private

  def process_task
    loop do
      begin
        break if exit?(receive_task)
        call_task(@task)
      rescue StandardError => e
        puts e.message unless e.is_a?(NoMethodError)
      ensure
        show_menu unless exit?(@task)
      end
    end
  end

  def show_menu
    if @table.game
      game_menu
    else
      exit_menu
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
    @task = gets.chomp.downcase
  end

  def call_task(task)
    @table.public_send(task.to_sym)
  end

  def game_menu
    @menu_items[:game].show
  end

  def exit_menu
    @menu_items[:exit].show
  end
end
