class EmptySquare
  def empty?
    true
  end

  def to_s
    "    "
  end

  def valid_move?(end_pos)
    false
  end
end
