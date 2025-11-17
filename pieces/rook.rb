class Rook < Piece
  def symbol
    "♜"
  end

  def sliding_vectors
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end
