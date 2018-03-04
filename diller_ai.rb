class DillerAI
  def initialize(table)
    @diller = table.diller
    @table = table
  end

  def turn
    @table.stand if @diller.scores >= 17
    @table.hit if @diller.scores < 17
  end
end
