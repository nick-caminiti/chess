# frozen_string_literal: true

require_relative 'piece'
require_relative 'square'
require 'rainbow'

class Board 
  attr_reader :draw_reason

  def initialize(white, black)
    @game_board = nil
    @white = white
    @black = black
    @draw_reason = nil
  end

  def build_board
    create_game_board
    set_pieces_on_board
  end

  def create_game_board
    @game_board = Array.new(8) { [] }
    rows = (0..7).to_a
    columns = (0..7).to_a

    rows.each_with_index do |row, index|
      columns.each do |column|
        @game_board[index] << Square.new([column, row])
      end
    end
  end

  def find_square(coordinate)
    @game_board[coordinate[1]][coordinate[0]]
  end

  def set_pieces_on_board
    find_square([0, 0]).occupant = @white.rook1
    find_square([1, 0]).occupant = @white.knight1
    find_square([2, 0]).occupant = @white.bishop1
    find_square([3, 0]).occupant = @white.queen
    find_square([4, 0]).occupant = @white.king
    find_square([5, 0]).occupant = @white.bishop2
    find_square([6, 0]).occupant = @white.knight2
    find_square([7, 0]).occupant = @white.rook2
    find_square([0, 1]).occupant = @white.pawn1
    find_square([1, 1]).occupant = @white.pawn2
    find_square([2, 1]).occupant = @white.pawn3
    find_square([3, 1]).occupant = @white.pawn4
    find_square([4, 1]).occupant = @white.pawn5
    find_square([5, 1]).occupant = @white.pawn6
    find_square([6, 1]).occupant = @white.pawn7
    find_square([7, 1]).occupant = @white.pawn8

    find_square([0, 7]).occupant = @black.rook1
    find_square([1, 7]).occupant = @black.knight1
    find_square([2, 7]).occupant = @black.bishop1
    find_square([3, 7]).occupant = @black.queen
    find_square([4, 7]).occupant = @black.king
    find_square([5, 7]).occupant = @black.bishop2
    find_square([6, 7]).occupant = @black.knight2
    find_square([7, 7]).occupant = @black.rook2
    find_square([0, 6]).occupant = @black.pawn1
    find_square([1, 6]).occupant = @black.pawn2
    find_square([2, 6]).occupant = @black.pawn3
    find_square([3, 6]).occupant = @black.pawn4
    find_square([4, 6]).occupant = @black.pawn5
    find_square([5, 6]).occupant = @black.pawn6
    find_square([6, 6]).occupant = @black.pawn7
    find_square([7, 6]).occupant = @black.pawn8
  end

  def print_board(current_player)
    # could be optimized
    current_player == @white ? print_for_white : print_for_black
  end

  def print_for_white
    puts Rainbow('   a b c d e f g h  ').color('000000').bg('e6e6e6')
    row_num = 8
    @game_board.reverse_each do |row|
      symbols = []
      row.each do |square|
        is_a_piece = square.occupant.is_a? Piece
        symbol = is_a_piece ? square.occupant.instance_variable_get(:@symbol) : ' '
        symbols << symbol
      end
      portion1 = " #{row_num} #{symbols[0]} #{symbols[1]} #{symbols[2]} #{symbols[3]} #{symbols[4]}"
      portion2 = "#{symbols[5]} #{symbols[6]} #{symbols[7]} #{row_num} "

      puts Rainbow("#{portion1}#{portion2}").color('000000').bg('dbc3a3')
      row_num -= 1
    end
    puts Rainbow('    a b c d e f g h ').bg('815e32')
  end

  def print_for_black
    puts '     h   g   f   e   d   c   b   a  '
    puts '   |---+---+---+---+---+---+---+---|'
    row_num = 1
    @game_board.each do |row|
      symbols = []
      row.each do |square|
        is_a_piece = square.occupant.is_a? Piece
        symbol = is_a_piece ? square.occupant.instance_variable_get(:@symbol) : ' '
        symbols << symbol
      end

      puts " #{row_num} | #{symbols[0]} | #{symbols[1]} | #{symbols[2]} | #{symbols[3]} | #{symbols[4]} | #{symbols[5]} | #{symbols[6]} | #{symbols[7]} |  #{row_num}"
      puts '   |---+---+---+---+---+---+---+---|'
      row_num += 1
    end
    puts '     h   g   f   e   d   c   b   a  '
  end

  def make_move
    # update both piece and square with location/occupant
  end

  def check_for_checkmate(king)
    # is king in check for any of it's movement options
  end

  def check_for_check(king); end

  def draw_conditions_met; end

  def update_draw_reason; end

  def check_for_legal_moves(player); end

  # edge cases like castling and en passant
end