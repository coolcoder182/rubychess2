require './pieces/piece'
class Pawn < Piece
  def symbol
    "♟"
  end

  def capture_vectors
    color == :white ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
  end
end
