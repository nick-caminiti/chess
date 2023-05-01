# frozen_string_literal: true

require_relative 'piece'

class Board 
  attr_reader :draw_reason

  def initialize(white, black)
    @game_board = nil
    @white = white
    @black = black
    @draw_reason = nil
  end

  def build_board
    create_game_board_array
    set_pieces_on_board
  end

  def create_game_board_array
    @game_board = []
    # letters = [a..f]
    # numbers = [1..8]

    # a1 = Square.new('a1')
    # Square.new('h8')

    @game_board = [
      ['a1', 'a2'],
      ['b1', 'b2']
    ]

  end

  def set_pieces_on_board
    @a1.occupant = @white.rook1
  end

  def print_board
    # symbol = @a1.occupant.symbol.nil? ? @a1.occupant.symbol : ' '
  end

  def make_move; end

  def check_for_checkmate(king)
    # is king in check for any of it's movement options
  end

  def check_for_check(king); end

  def draw_conditions_met; end

  def update_draw_reason; end

  def check_for_legal_moves(player); end

  # edge cases like castling and en passant
end