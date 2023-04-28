# frozen_string_literal: true

require_relative 'piece'

class Board 
  def initialize(white, black)
    @game_board = nil
    @white = white
    @black = black
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

  def check_for_draw; end

  # edge cases like castling and en passant
end