# frozen_string_literal: true

require_relative 'piece'

class Board 
  attr_reader :draw_reason

  def initialize(white, black)
    @game_board = create_board
    @white = white
    @black = black
    @draw_reason = nil
  end

  def create_board
    @game_board = [
      [@a1, @a2],
      [@b1, @b2]
    ]
    @a1 = Square.new('a1')
    Square.new('h8')
  end

  def set_board
    @a1.occupant = @white.rook1
  end

  def print_board
    # symbol = @a1.occupant.symbol.nil? ? @a1.occupant.symbol : ' '
  end

  def check_for_checkmate(king)
    # is king in check for any of it's movement options
  end

  def check_for_check(king); end

  def draw_conditions_met; end

  # edge cases like castling and en passant
end