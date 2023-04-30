# frozen_string_literal: true

require_relative 'piece'

class Player
  attr_reader :color

  def initialize(color)
    @color = color
    @king = Piece.new('king')
    @queen = Piece.new('queen')
    @bishop1 = Piece.new('bishop')
    @bishop2 = Piece.new('bishop')
  end

  def prompt_for_draw(player, draw_reason); end

  def get_turn_input
    # prompt for move
    # make sure move is legal - can't move into check,
    # if move is illegal, say why
  end
end