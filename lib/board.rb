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
    update_pieces_instance_variables
    update_piece_movements_and_attacks
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
    if coordinate[0] > 7 || coordinate[0].negative? || coordinate[1] > 7 || coordinate[1].negative?
      false
    else
      @game_board[coordinate[1]][coordinate[0]]
    end
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

  def update_pieces_instance_variables
    @game_board.each do |row|
      row.each do |square|
        next unless square.occupant.is_a? Piece

        square.occupant.instance_variable_set(:@current_coordinate, square.instance_variable_get(:@coordinate))
        square.occupant.instance_variable_set(:@game_board, self)
      end
    end
  end

  def update_piece_movements_and_attacks
    @game_board.each do |row|
      row.each do |square|
        square.occupant.update_movements_and_attacks if square.occupant.is_a? Piece
      end
    end
  end

  def print_board(current_player)
    light_color = 'dbc3a3'
    dark_color = '815e32'
    border = '333333'

    current_player == @white ? print_border_row_white(border) : print_border_row_black(border)
    if current_player == @white
      print_board_rows_white(light_color, dark_color, border)
    else
      print_board_rows_black(light_color, dark_color, border)
    end
    current_player == @white ? print_border_row_white(border) : print_border_row_black(border)
  end

  def print_border_row_white(border)
    puts Rainbow('    a  b  c  d  e  f  g  h    ').bg(border)
  end

  def print_border_row_black(border)
    puts Rainbow('    h  g  f  e  d  c  b  a    ').bg(border)
  end

  def print_board_rows_white(light_color, dark_color, border)
    row_num = 8
    @game_board.reverse_each do |row|
      symbols = create_symbols_array(row)
      color_one = row_num.even? ? dark_color : light_color
      color_two = row_num.even? ? light_color : dark_color

      print_board_row(row_num, border, color_one, color_two, symbols)
      row_num -= 1
    end
  end

  def print_board_rows_black(light_color, dark_color, border)
    row_num = 1
    @game_board.each do |row|
      symbols = create_symbols_array(row).reverse
      color_one = row_num.even? ? light_color : dark_color
      color_two = row_num.even? ? dark_color : light_color

      print_board_row(row_num, border, color_one, color_two, symbols)
      row_num += 1
    end
  end

  def print_board_row(row_num, border, color_one, color_two, symbols)
    puts Rainbow(" #{row_num} ").bg(border) + Rainbow(" #{symbols[0]} ").black.bg(color_two) + Rainbow(" #{symbols[1]} ").black.bg(color_one) + Rainbow(" #{symbols[2]} ").black.bg(color_two) + Rainbow(" #{symbols[3]} ").black.bg(color_one) + Rainbow(" #{symbols[4]} ").black.bg(color_two) + Rainbow(" #{symbols[5]} ").black.bg(color_one) + Rainbow(" #{symbols[6]} ").black.bg(color_two) + Rainbow(" #{symbols[7]} ").black.bg(color_one) + Rainbow(" #{row_num} ").bg(border)
  end

  def create_symbols_array(row)
    symbols = []
    row.each do |square|
      is_a_piece = square.occupant.is_a? Piece
      symbol = is_a_piece ? square.occupant.instance_variable_get(:@symbol) : ' '
      symbols << symbol
    end
    symbols
  end

  def make_move(current_coordinate, new_coordinate)
    starting_square = find_square(current_coordinate)
    moving_piece = starting_square.occupant
    new_square = find_square(new_coordinate)

    new_square.occupant.instance_variable_set(:@current_coordinate, nil) if new_square.occupant.is_a? Piece

    moving_piece.instance_variable_set(:@current_coordinate, new_coordinate)
    moving_piece.instance_variable_set(:@moved, true)

    new_square.occupant = moving_piece
    starting_square.occupant = nil
  end

  def convert_alphanum_to_num(alphanum)
    column_to_num_hash = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }

    column = column_to_num_hash[alphanum[0].to_sym]
    row = alphanum[1].to_i - 1
    [column, row]
  end

  def legal_move?(player, origin, destination)
    moving_piece = find_square(origin).instance_variable_get(:@occupant)
    color = player.instance_variable_get(:@color)
    move_squares = moving_piece.instance_variable_get(:@move_squares)

    return false if moving_piece.nil?
    return false unless moving_piece.instance_variable_get(:@color) == color
    return false unless move_squares.include?(destination)
    return false if moving_piece.type == 'king' && check_for_check(color, destination)
    return false if moving_piece.type != 'king' && king_in_check_after_move?(player, origin, destination)

    true
  end

  def illegal_move_feedback(player, origin, destination)
    moving_piece = find_square(origin).instance_variable_get(:@occupant)
    color = player.instance_variable_get(:@color)
    move_squares = moving_piece.instance_variable_get(:@move_squares)

    if moving_piece.nil?
      puts "There's no piece there!"
      return
    end
    puts "That's not your piece!" unless moving_piece.instance_variable_get(:@color) == color
    puts "That piece can't move there!" unless move_squares.include?(destination)
    puts "You can't move into check!" if moving_piece.type == 'king' && check_for_check(color, destination)
    return unless moving_piece.type != 'king' && king_in_check_after_move?(player, origin, destination)

    puts 'Your move would leave your king in check!'
  end

  def king_in_check_after_move?(player, origin, destination)
    origin_square = find_square(origin)
    destination_square = find_square(destination)
    moving_piece = find_square(origin).instance_variable_get(:@occupant)

    king_coord = player.instance_variable_get(:@king).instance_variable_get(:@current_coordinate)
    adjust_square_occupant_update_movements(origin_square, nil)

    original_occupant = destination_square.instance_variable_get(:@occupant)
    adjust_square_occupant_update_movements(destination_square, moving_piece)

    check = check_for_check(player, king_coord)
    adjust_square_occupant_update_movements(origin_square, moving_piece)
    adjust_square_occupant_update_movements(destination_square, original_occupant)
    check
  end

  def adjust_square_occupant_update_movements(square, new_occupant)
    square.instance_variable_set(:@occupant, new_occupant)
    update_piece_movements_and_attacks
  end

  def check_for_checkmate(color)
    player = color == 'white' ? @white : @black
    checkmate = true

    king = player.king
    kings_current_square = find_square(king.instance_variable_get(:@current_coordinate))
    kings_current_square.instance_variable_set(:@occupant, nil)
    update_piece_movements_and_attacks

    checkmate = false if non_king_can_remove_check?(color, kings_current_square.instance_variable_get(:@coordinate))
    move_squares = king.instance_variable_get(:@move_squares)
    move_squares.each do |coordinate|
      checkmate = false unless check_for_check(color, coordinate)
      checkmate = false if non_king_can_remove_check?(color, coordinate)
    end

    kings_current_square.instance_variable_set(:@occupant, king)
    update_piece_movements_and_attacks
    checkmate
  end

  def non_king_can_remove_check?(color, check_coordinate)
    # opponent_attack_positions = build_opponent_attack_positions(color, check_coordinate)
    opponent_attack_paths = build_opponent_attack_paths(color, check_coordinate)

    potential_check_savers = build_potential_check_savers(color, opponent_attack_paths)
    # potential_check savers subarrays stored as [current_coord, destination_coord]

    return false if potential_check_savers.empty?

    check_can_be_saved?(color, check_coordinate, potential_check_savers)
  end

  def check_can_be_saved?(color, check_coordinate, potential_check_savers)
    can_be_saved = false
    potential_check_savers.each do |combo|
      origin_square = find_square(combo[0])

      destination_square = find_square(combo[1])

      defending_piece = origin_square.instance_variable_get(:@occupant)
      destination_occupant = destination_square.instance_variable_get(:@occupant)

      adjust_square_occupant_update_movements(origin_square, nil)
      adjust_square_occupant_update_movements(destination_square, defending_piece)
      can_be_saved = true unless check_for_check(color, check_coordinate)
      adjust_square_occupant_update_movements(origin_square, defending_piece)
      adjust_square_occupant_update_movements(destination_square, destination_occupant)
    end
    can_be_saved
  end

  def build_potential_check_savers(color, opponent_attack_positions)
    potential_check_savers = [] # stored as [current_coord, destination_coord]
    @game_board.each do |row|
      row.each do |square|
        next unless square.occupant.is_a? Piece

        piece = square.occupant
        next unless piece.instance_variable_get(:@color) == color

        attack_squares = piece.instance_variable_get(:@attack_squares)
        next if attack_squares.nil?

        possible_attack_squares = (opponent_attack_positions & attack_squares)

        next if possible_attack_squares.empty?

        current_coord = square.instance_variable_get(:@coordinate)

        possible_attack_squares.each do |destination_coordinate|
          potential_check_savers << [current_coord, destination_coordinate]
        end
      end
    end
    potential_check_savers
  end

  def build_opponent_attack_paths(color, check_coordinate)
    attacking_color = color == 'white' ? 'black' : 'white'
    opponent_attack_paths = []

    @game_board.each do |row|
      row.each do |square|
        next unless square.occupant.is_a? Piece

        piece = square.occupant
        next unless piece.instance_variable_get(:@color) == attacking_color

        attack_squares = piece.instance_variable_get(:@attack_squares)
        next if attack_squares.nil?

        if attack_squares.include?(check_coordinate)
          attack_sqaures_array = piece.instance_variable_get(:@attack_squares)
          attack_sqaures_array.each do |attack_square_coord|
            opponent_attack_paths << attack_square_coord
          end
          opponent_attack_paths << piece.instance_variable_get(:@current_coordinate)
        end
      end
    end
    # p opponent_attack_paths
    opponent_attack_paths
    # p opponent_attack_paths
  end

  def check_for_check(color, coordinate)
    attacking_color = color == 'white' ? 'black' : 'white'
    in_check = false

    @game_board.each do |row|
      row.each do |square|
        next unless square.occupant.is_a? Piece

        piece = square.occupant
        next unless piece.instance_variable_get(:@color) == attacking_color

        attack_squares = piece.instance_variable_get(:@attack_squares)
        next if attack_squares.nil?

        in_check = true if attack_squares.include?(coordinate)
      end
    end
    in_check
  end

  def pawn_promotion?(player, coordinate)
    player_color = player.instance_variable_get(:@color)
    row = coordinate[1]
    piece_type = find_square(coordinate).instance_variable_get(:@occupant).instance_variable_get(:@type)
    return false unless piece_type == 'pawn'

    if player_color == 'white' && row == 7
      return true
    elsif player_color == 'black' && row.zero?
      return true
    end

    false
  end

  def promote_pawn(player, choice, coordinate)
    square = find_square(coordinate)
    promo_choices = { q: 'queen', r: 'rook', b: 'bishop', k: 'knight' }
    promo_choice = promo_choices[choice.to_sym]

    new_piece = Piece.new(promo_choice, player.instance_variable_get(:@color))

    square.instance_variable_set(:@occupant, new_piece)
    new_piece.instance_variable_set(:@current_coordinate, coordinate)
    new_piece.instance_variable_set(:@game_board, self)
  end

  def draw_conditions_met; end

  def update_draw_reason; end

  def check_for_legal_moves(player)
    color = player.instance_variable_get(:@color)
    legal_move = false

    @game_board.each do |row|
      row.each do |square|
        next unless square.occupant.is_a? Piece

        piece = square.occupant
        piece_origin = piece.instance_variable_get(:@current_coordinate)
        next unless piece.instance_variable_get(:@color) == color

        move_squares = piece.instance_variable_get(:@move_squares)
        next if move_squares.nil?

        move_squares.each do |coordinate|
          return true if legal_move?(player, piece_origin, coordinate)
        end
      end
    end
    legal_move
  end
end