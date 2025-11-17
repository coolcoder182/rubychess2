class Piece
  attr_accessor :pos, :color

  MOVE_VECTORS = []
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

  def generate_moves(_board)
    puts "this is in piece parent class"
    []
  end

  def generate_sliding_moves(board, move_vectors)
    moves = []
    start_pos = pos

    move_vectors.each do |dr, dc|
      r, c = start_pos

      loop do
        r += dr
        c += dc
        new_pos = [r, c]

        break unless board.in_bounds?(new_pos)

        target = board.piece_at?(new_pos)

        if target.nil?
          moves << new_pos
        elsif target.color != color
          moves << new_pos   # capture
          break
        else
          break              # blocked by same color
        end
      end
    end

    moves
  end

  def sliding_vectors
    []
  end

  def move_vectors
    []
  end
end
