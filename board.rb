require './pieces/pawn'
require './pieces/rook'
require './pieces/knight'
require './pieces/queen'
require './pieces/king'
require './pieces/bishop'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @en_pessant_target = nil
    setup_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def piece_at(pos)
    row, col = pos
    return nil unless (...8).include?(row) && (0...8).include?(col)

    @grid[row][col]
  end

  def move_piece(start_pos, end_pos)
    # check for casteling , en pessant etc
    start_row, start_col = start_pos
    end_row, end_col = end_pos
    piece = @grid[start_row][start_col]

    if piece.is_a?(Pawn) && @en_pessant_target == end_pos
      captured_pawn_row = piece.color == :white ? end_pos[0] + 1 : end_pos[0] - 1
      captured_pawn_col = end_pos[1]
      @grid[captured_pawn_row][captured_pawn_col] = nil
    end

    # en_pessant
    @en_pessant_target = nil
    if piece.is_a?(Pawn) && ((start_row - end_row).abs == 2)
      col = start_col
      mid_row = (start_row + end_row) / 2
      @en_pessant_target = [mid_row, col]
    end

    @grid[start_row][start_col] = nil
    @grid[end_row][end_col] = piece
    piece.pos = [end_row, end_col]
    nil
  end

  def possible_moves(piece)
    return [] if piece.nil?
    return pawn_moves(piece) if piece.is_a?(Pawn)

    generic_piece_moves(piece)
  end

  def generic_piece_moves(piece)
    if !piece.move_vectors.empty?
      return generate_single_moves(piece)
    elsif !piece.sliding_vectors.empty?
      return generate_sliding_moves(piece)
    end

    puts "something went wrong, not moves were generated"
    puts "press enter to continue"
    gets
    []
  end

  def generate_sliding_moves(piece)
    moves = []
    start_pos = piece.pos

    piece.sliding_vectors.each do |dr, dc|
      r, c = start_pos

      loop do
        r += dr
        c += dc
        new_pos = [r, c]

        break unless in_bounds?(new_pos)

        target = piece_at(new_pos)

        if target.nil?
          moves << new_pos
        elsif target.color != piece.color
          moves << new_pos   # capture
          break
        else
          break              # blocked by same color
        end
      end
    end

    moves
  end

  def generate_single_moves(piece)
    moves = []
    start_pos = piece.pos
    piece.move_vectors.each do |dir_row, dir_col|
      new_pos = [start_pos[0] + dir_row, start_pos[1] + dir_col]
      next unless in_bounds?(new_pos)

      target = piece_at(new_pos)

      moves << new_pos if target.nil? || target.color != piece.color
    end
    moves
  end

  def pawn_moves(piece)
    moves = []
    row, col = piece.pos
    dir = piece.color == :white ? -1 : 1
    start_row = piece.color == :white ? 6 : 1

    one_forward = [row + dir, col]
    if in_bounds?(one_forward) && piece_at(one_forward).nil?
      moves << one_forward
      two_forward = [row + 2 * dir, col]
      moves << two_forward if row == start_row && piece_at(two_forward).nil?
    end

    piece.capture_vectors.each do |diag_row, diag_col|
      pos = [row + diag_row, col + diag_col]
      if in_bounds?(pos)
        target = piece_at(pos)
        moves << pos if target && target.color != piece.color
      end
    end

    moves.concat(en_pessant_moves(piece))
    moves
  end

  def en_pessant_moves(piece)
    row, col = piece.pos
    dir = piece.color == :white ? -1 : 1
    target = @en_pessant_target
    return [] unless target

    target_r, target_c = target

    return [[target_r, target_c]] if target_r == row + dir && (target_c - col).abs == 1

    []
  end

  def print_screen(highlighted_positions = [])
    puts
    @grid.each_with_index do |row, r|
      print "#{8 - r} "
      row.each_with_index do |piece, c|
        highlight = highlighted_positions.include?([r, c])
        color = square_color(r, c)
        print render_square(piece, highlight, color)
      end
      puts
    end
    puts '   a  b  c  d  e  f  g  h'
  end

  def render_square(piece, highlight, color)
    background = if highlight
                   "\e[42m"
                 else
                   color == :dark ? "\e[100m" : "\e[47m"
                 end

    foregroung = piece && piece.color == :white ? "\e[97m" : "\e[30m"
    text = piece ? piece.symbol : " "
    "#{background} #{foregroung}#{text} \e[0m"
  end

  def square_color(row, col)
    (row + col).odd? ? :dark : :light
  end

  def in_bounds?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end

  # def legal_moves_for(piece)
  #   piece.moves.select { |pos| in_bounds?(pos) }
  # end

  def setup_board
    # black pieces
    @grid[0][0] = Rook.new(:black, [0, 0])
    @grid[0][1] = Knight.new(:black, [0, 1])
    @grid[0][2] = Bishop.new(:black, [0, 2])
    @grid[0][3] = Queen.new(:black, [0, 3])
    @grid[0][4] = King.new(:black, [0, 4])
    @grid[0][5] = Bishop.new(:black, [0, 5])
    @grid[0][6] = Knight.new(:black, [0, 6])
    @grid[0][7] = Rook.new(:black, [0, 7])
    @grid[1][0] = Pawn.new(:black, [1, 0])
    @grid[1][1] = Pawn.new(:black, [1, 1])
    @grid[1][2] = Pawn.new(:black, [1, 2])
    @grid[1][3] = Pawn.new(:black, [1, 3])
    @grid[1][4] = Pawn.new(:black, [1, 4])
    @grid[1][5] = Pawn.new(:black, [1, 5])
    @grid[1][6] = Pawn.new(:black, [1, 6])
    @grid[1][7] = Pawn.new(:black, [1, 7])

    # white pieces
    @grid[6][0] = Pawn.new(:white, [6, 0])
    @grid[6][1] = Pawn.new(:white, [6, 1])
    @grid[6][2] = Pawn.new(:white, [6, 2])
    @grid[6][3] = Pawn.new(:white, [6, 3])
    @grid[6][4] = Pawn.new(:white, [6, 4])
    @grid[6][5] = Pawn.new(:white, [6, 5])
    @grid[6][6] = Pawn.new(:white, [6, 6])
    @grid[6][7] = Pawn.new(:white, [6, 7])
    @grid[7][0] = Rook.new(:white, [7, 0])
    @grid[7][1] = Knight.new(:white, [7, 1])
    @grid[7][2] = Bishop.new(:white, [7, 2])
    @grid[7][3] = Queen.new(:white, [7, 3])
    @grid[7][4] = King.new(:white, [7, 4])
    @grid[7][5] = Bishop.new(:white, [7, 5])
    @grid[7][6] = Knight.new(:white, [7, 6])
    @grid[7][7] = Rook.new(:white, [7, 7])
  end
end
