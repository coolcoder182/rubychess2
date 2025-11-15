require './pieces/piece'
class Pawn < Piece
  def symbol
    "♟"
  end

  def moves
    row, col = pos
    direction = (color == :white ? -1 : 1)
    [
      [row + direction, col],
      [row + 2 * direction, col]
    ]
  end
end
