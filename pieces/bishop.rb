class Bishop < Piece
  MOVE_VECTORS = [[1, 1], [-1, 1], [-1, -1], [1, -1]].freeze
  def symbol
    "♝"
  end

  def generate_moves(board)
    generate_sliding_moves(board, MOVE_VECTORS)
  end
end
