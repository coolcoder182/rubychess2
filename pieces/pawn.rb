require './pieces/piece'
class Pawn < Piece
  def symbol
    "♟"
  end

  def generate_moves(board)
    capture_vectors = color == :white ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
    moves = []
    row, col = pos
    dir = color == :white ? -1 : 1
    start_row = color == :white ? 6 : 1

    one_forward = [row + dir, col]
    if board.in_bounds?(one_forward) && board.piece_at?(one_forward).nil?
      moves << one_forward
      two_forward = [row + 2 * dir, col]
      moves << two_forward if row == start_row && board.piece_at?(two_forward).nil?
    end

    capture_vectors.each do |diag_row, diag_col|
      pos = [row + diag_row, col + diag_col]
      if board.in_bounds?(pos)
        target = board.piece_at?(pos)
        moves << pos if target && target.color != color
      end
    end

    moves.concat(en_pessant_moves(board))
    moves
  end

  def en_pessant_moves(board)
    row, col = pos
    dir = color == :white ? -1 : 1
    target = board.en_pessant_target
    return [] unless target

    target_r, target_c = target

    return [[target_r, target_c]] if target_r == row + dir && (target_c - col).abs == 1

    []
  end
end
