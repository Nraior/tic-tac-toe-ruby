class Field
  attr_accessor :current

  DEFAULT_SYMBOL = '-'

  def initialize
    @current = DEFAULT_SYMBOL
  end

  def reset
    self.current = DEFAULT_SYMBOL
  end

  def occupy(symbol)
    self.current = symbol
  end

  def occupied?
    @current != DEFAULT_SYMBOL
  end

  def to_s
    @current
  end
end
