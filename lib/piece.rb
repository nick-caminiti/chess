# frozen_string_literal: true

class Piece
  def initialize(type)
    @type = type
    @symbol = @symbol_hash[type]
    @current_square = nil
    @attack_hash = {}
    @move_hash = {}
    @symbol_hash = {}
    @attack_style = @attack_hash[type]
    @move_style = @move_hash[type]
    @attack_squares = nil
    @move_squares = nil
  end

end