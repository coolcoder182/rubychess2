class Knight < Piece
  MOVE_VECTORS = [
    [-2, -1], [-2, 1],
    [-1, -2], [-1, 2],
    [1, -2],  [1, 2],
    [2, -1],  [2, 1]
  ]
  def symbol
    "♞"
  end

  def move_vectors
    MOVE_VECTORS
  end
end
