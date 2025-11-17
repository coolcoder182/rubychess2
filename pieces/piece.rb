class Piece
  attr_accessor :pos, :color, :has_moved

  MOVE_VECTORS = []
  def initialize(color, pos)
    @pos = pos
    @color = color
    @has_moved = false
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

  def generate_single_moves(board, move_vectors)
    moves = []
    start_pos = pos
    move_vectors.each do |dir_row, dir_col|
      new_pos = [start_pos[0] + dir_row, start_pos[1] + dir_col]
      next unless board.in_bounds?(new_pos)

      target = board.piece_at(new_pos)

      moves << new_pos if target.nil? || target.color != color
    end
    moves
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

        target = board.piece_at(new_pos)

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
