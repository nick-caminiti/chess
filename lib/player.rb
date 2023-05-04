# frozen_string_literal: true

require_relative 'piece'

class Player
  attr_reader :color, :king, :queen, :rook1, :rook2, :bishop1, :bishop2,
              :knight1, :knight2, :pawn1, :pawn2, :pawn3, :pawn4, :pawn5, :pawn6,
              :pawn7, :pawn8

  def initialize(color)
    @color = color
    @king = Piece.new('king', color)
    @queen = Piece.new('queen', color)
    @rook1 = Piece.new('rook', color)
    @rook2 = Piece.new('rook', color)
    @bishop1 = Piece.new('bishop', color)
    @bishop2 = Piece.new('bishop', color)
    @knight1 = Piece.new('knight', color)
    @knight2 = Piece.new('knight', color)
    @pawn1 = Piece.new('pawn', color)
    @pawn2 = Piece.new('pawn', color)
    @pawn3 = Piece.new('pawn', color)
    @pawn4 = Piece.new('pawn', color)
    @pawn5 = Piece.new('pawn', color)
    @pawn6 = Piece.new('pawn', color)
    @pawn7 = Piece.new('pawn', color)
    @pawn8 = Piece.new('pawn', color)
  end

  def prompt_for_draw(player, draw_reason); end

  # def get_turn_input
    # prompt for move
    # make sure move is legal - can't move into check, can't be players in the way
    # if move is illegal, say why
  # end

  def get_turn_input
    # loop do
    #   move = verify_input(player_input)
    #   return move if move
    # end
    player_input
  end

  def verify_input(input)
    return input if input.match?(/^[a-h]{1}[1-8]{1}:[a-h]{1}[1-8]$/)
  end

  def player_input
    puts "#{@color} you're up! Enter S to save and exit or enter a move to play"
    puts 'Enter your move like a2:c3'
    gets.chomp
  end
end