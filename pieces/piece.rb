class Piece
  attr_accessor :pos, :color

  def initialize(color, pos)
    @pos = pos
    @color = color
  end

  def moves(board)
    raise NotImplementedError, "Subclasses must implement #moves"
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end

  def to_s
    symbol
  end

  def sliding_vectors
    []
  end

  def move_vectors
    []
  end
end
