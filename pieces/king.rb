class King < Piece
  MOVE_VECTORS =
    [
      [1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, 1], [-1, -1], [1, -1]
    ]
  def symbol
    "♚"
  end

  def generate_moves(board)
    moves = generate_single_moves(board, MOVE_VECTORS)
    moves.concat(castle_moves(board))
  end

  def castle_moves(board)
    return [] if has_moved

    moves = []

    moves << kingside_castle if can_castle_kingside?(board)
    moves << queenside_castle if can_castle_queenside?(board)
    moves.compact
  end

  def kingside_castle
    row, col = pos
    [row, col + 2]
  end

  def queenside_castle
    row, col = pos
    [row, col - 2]
  end

  def can_castle_kingside?(board)
    row, col = pos
    rook_pos = [row, 7]
    rook = board.piece_at(rook_pos)

    return false unless rook.is_a?(Rook)
    return false if rook.has_moved

    return false unless board.empty?([row, col + 1])
    return false unless board.empty?([row, col + 2])

    return false if board.square_attacked?(pos, color)
    return false if board.square_attacked?([row, col + 1], color)
    return false if board.square_attacked?([row, col + 2], color)

    true
  end

  def can_castle_queenside?(board)
    row, col = pos
    rook_pos = [row, 0]
    rook = board.piece_at(rook_pos)

    return false unless rook.is_a?(Rook)
    return false if rook.has_moved

    return false unless board.empty?([row, col - 1])
    return false unless board.empty?([row, col - 2])
    return false unless board.empty?([row, col - 3])

    return false if board.square_attacked?(pos, color)
    return false if board.square_attacked?([row, col - 1], color)
    return false if board.square_attacked?([row, col - 2], color)

    true
  end
end
