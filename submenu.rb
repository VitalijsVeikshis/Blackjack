class SubMenu
  def initialize(options)
    @head = options[:head]
    @indent = options[:indent]
    @items = options[:items]
  end

  def show
    puts '--------------------------------------------'
    puts make(@items.first, @indent, @head)
    @items[1..-1].each { |item| puts make(item, @indent) }
    puts '--------------------------------------------'
  end

  private

  def make(string, indent, indent_string = '')
    indent_string.rjust(indent) + string
  end
end
