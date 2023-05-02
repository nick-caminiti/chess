# frozen_string_literal: true

require_relative 'piece'

class Player
  attr_reader :color, :king, :queen, :rook1, :rook2, :bishop1, :bishop2,
              :knight1, :knight2, :pawn1, :pawn2, :pawn3, :pawn4, :pawn5, :pawn6,
              :pawn7, :pawn8

  def initialize(color)
    @color = color
    @king = Piece.new('king')
    @queen = Piece.new('queen')
    @rook1 = Piece.new('rook')
    @rook2 = Piece.new('rook')
    @bishop1 = Piece.new('bishop')
    @bishop2 = Piece.new('bishop')
    @knight1 = Piece.new('knight')
    @knight2 = Piece.new('knight')
    @pawn1 = Piece.new('pawn')
    @pawn2 = Piece.new('pawn')
    @pawn3 = Piece.new('pawn')
    @pawn4 = Piece.new('pawn')
    @pawn5 = Piece.new('pawn')
    @pawn6 = Piece.new('pawn')
    @pawn7 = Piece.new('pawn')
    @pawn8 = Piece.new('pawn')
  end

  def prompt_for_draw(player, draw_reason); end

  def get_turn_input
    # prompt for move
    # make sure move is legal - can't move into check, can't be players in the way
    # if move is illegal, say why
  end
end