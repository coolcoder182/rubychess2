class Bishop < Piece
  def symbol
    "♝"
  end

  def sliding_vectors
    [[1, 1], [-1, 1], [-1, -1], [1, -1]]
  end
end
