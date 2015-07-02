class EmptySquare
  attr_accessor :board

  def initialize
    @board = nil
  end

  def empty?
    true
  end

  def to_s
    "    "
  end

  def valid_move?(end_pos)
    false
  end

  def color
    nil
  end

  def dup
    self.class.new
  end
end
