class Queen < Piece
  MOVE_VECTORS =
    [
      [1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, 1], [-1, -1], [1, -1]
    ]
  def symbol
    "♛"
  end

  def generate_moves(board)
    generate_sliding_moves(board, MOVE_VECTORS)
  end
end
