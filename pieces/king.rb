class King < Piece
  def symbol
    "♚"
  end

  def move_vectors
    [
      [1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, 1], [-1, -1], [1, -1]
    ]
  end
end
