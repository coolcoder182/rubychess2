require './pieces/pawn'
require './pieces/rook'
require './pieces/knight'
require './pieces/queen'
require './pieces/king'
require './pieces/bishop'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) }
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

  def print_screen(highlighted_positions = [])
    puts
    @grid.each_with_index do |row, r|
      print "#{8 - r} "
      row.each_with_index do |peice, c|
        background = (r + c).even? ? "\e[47m" : "\e[100m"
        foreground = peice && peice.color == :white ? "\e[97m" : "\e[30m"
        symbol = peice ? peice.symbol : " "
        print "#{background} #{foreground}#{symbol} \e[0m"
      end
      puts
    end
    puts '   a  b  c  d  e  f  g  h'
  end

  def in_bounds?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end

  def legal_moves_for(piece)
    piece.moves.select { |pos| in_bounds?(pos) }
  end

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
