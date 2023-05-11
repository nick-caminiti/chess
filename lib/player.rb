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
    ask_count = 0
    loop do
      player_prompt(ask_count)
      move = verify_turn_input(player_input)
      return move if move

      ask_count += 1
    end
    player_input
  end

  def verify_turn_input(input)
    return input if input.match?(/^[a-h]{1}[1-8]{1}:[a-h]{1}[1-8]$/)
  end

  def player_prompt(ask_count)
    # puts ''
    if ask_count.zero?
      puts "#{@color.capitalize} you're up! Enter 's' to save and exit or enter a move to play."
      # puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
      # puts ""
    else
      puts 'Moves must be entered in the following format - a2:a3'
    end
  end

  def prompt_for_pawn_promotion
    puts "Your pawn is promoting! Enter 'q' for Queen, 'r' for Rook, 'k' for Knight, or 'b' for Bishop."
    loop do
      promo = verify_promo_input(player_input)
      return promo if promo
    end
  end

  def verify_promo_input(input)
    return input if input.match?(/^[qrkb]$/)
  end

  def player_input
    gets.chomp
  end
end