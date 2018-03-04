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
  end

  def game_menu
    @menu_items[:game].show
  end

  def exit_menu
    @menu_items[:exit].show
  end
end
