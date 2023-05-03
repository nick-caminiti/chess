# frozen_string_literal: true

require 'constants'

class Piece
  include Constants
  attr_reader :type

  def initialize(type, color)
    # move hashes into Module
    @type = type
    @color = color
    @current_square = nil
    @moved = false
    @symbol = symbol_look_up(type, color)
    @attack_style = attack_look_up(type)
    @move_style = move_look_up(type, @moved)
    @attack_squares = nil
    @move_squares = nil
    @can_jump = type == 'knight'
  end

end