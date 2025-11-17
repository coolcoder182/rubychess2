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

  def generate_moves(board)
    moves = []
    start_pos = pos
    MOVE_VECTORS.each do |dir_row, dir_col|
      new_pos = [start_pos[0] + dir_row, start_pos[1] + dir_col]
      next unless board.in_bounds?(new_pos)

      target = board.piece_at?(new_pos)

      moves << new_pos if target.nil? || target.color != color
    end
    moves
  end
end
