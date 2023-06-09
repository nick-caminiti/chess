# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/player'

describe Board do
  context '#build_board' do
    subject(:build_board) { described_class.new(white, black) }
    let(:white) { double('white') }
    let(:black) { double('black') }

    it 'stores an array in @game_board' do
      build_board.create_game_board
      game_board = build_board.instance_variable_get(:@game_board)
      expect(game_board).to be_an Array
    end

    it 'creates an array containing 8 arrays' do
      build_board.create_game_board
      game_board = build_board.instance_variable_get(:@game_board)

      expect(game_board[0]).to be_an Array
      expect(game_board[1]).to be_an Array
      expect(game_board[2]).to be_an Array
      expect(game_board[3]).to be_an Array
      expect(game_board[4]).to be_an Array
      expect(game_board[5]).to be_an Array
      expect(game_board[6]).to be_an Array
      expect(game_board[7]).to be_an Array
    end

    it 'each subarray contains a Square' do
      build_board.create_game_board
      game_board = build_board.instance_variable_get(:@game_board)

      expect(game_board[0][0]).to be_a Square
      expect(game_board[1][1]).to be_a Square
      expect(game_board[2][2]).to be_a Square
      expect(game_board[3][3]).to be_a Square
      expect(game_board[4][4]).to be_a Square
      expect(game_board[5][5]).to be_a Square
      expect(game_board[6][6]).to be_a Square
      expect(game_board[7][7]).to be_a Square
    end

    it "the Square's coordinate corresponds to its position in Array" do
      build_board.create_game_board
      game_board = build_board.instance_variable_get(:@game_board)
      test_square_coordinate = game_board[3][1].instance_variable_get(:@coordinate)

      expect(test_square_coordinate).to eq([1, 3])
    end

    it '#find_square returns node' do
      build_board.create_game_board
      coordinate = [1, 2]

      square_object = build_board.find_square(coordinate)
      square_coordinate = square_object.instance_variable_get(:@coordinate)
      expect(square_object).to be_a Square
      expect(square_coordinate).to eq(coordinate)
    end

    context '#set_pieces_on_board' do
      before do
        build_board.instance_variable_set(:@white, Player.new('white'))
        build_board.instance_variable_set(:@black, Player.new('black'))
      end

      it 'adds a white rook to [0, 0]' do
        coordinate = [0, 0]

        build_board.create_game_board
        build_board.set_pieces_on_board

        square_object = build_board.find_square(coordinate)
        square_occupant = square_object.instance_variable_get(:@occupant)
        occupant_symbol = square_occupant.instance_variable_get(:@symbol)
        occupant_color = square_occupant.instance_variable_get(:@color)
        expected_color = 'white'

        expect(square_occupant).to be_a Piece
        expect(occupant_symbol).to eq("\u{2656}")
        expect(occupant_color).to eq(expected_color)
      end

      it 'adds a white queen to [3, 0]' do
        coordinate = [3, 0]

        build_board.create_game_board
        build_board.set_pieces_on_board

        square_object = build_board.find_square(coordinate)
        square_occupant = square_object.instance_variable_get(:@occupant)
        occupant_symbol = square_occupant.instance_variable_get(:@symbol)
        occupant_color = square_occupant.instance_variable_get(:@color)
        expected_color = 'white'

        # build_board.print_board(build_board.instance_variable_get(:@black))
        expect(square_occupant).to be_a Piece
        expect(occupant_symbol).to eq("\u{2655}")
        expect(occupant_color).to eq(expected_color)
      end

      it 'adds a black pawn to [0, 6]' do
        coordinate = [0, 6]

        build_board.create_game_board
        build_board.set_pieces_on_board

        square_object = build_board.find_square(coordinate)
        square_occupant = square_object.instance_variable_get(:@occupant)
        occupant_symbol = square_occupant.instance_variable_get(:@symbol)
        occupant_color = square_occupant.instance_variable_get(:@color)
        expected_color = 'black'

        expect(square_occupant).to be_a Piece
        expect(occupant_symbol).to eq("\u{265F}")
        expect(occupant_color).to eq(expected_color)
      end

      it 'adds a black king to [4, 7]' do
        coordinate = [4, 7]

        build_board.create_game_board
        build_board.set_pieces_on_board

        square_object = build_board.find_square(coordinate)
        square_occupant = square_object.instance_variable_get(:@occupant)
        occupant_symbol = square_occupant.instance_variable_get(:@symbol)
        occupant_color = square_occupant.instance_variable_get(:@color)
        expected_color = 'black'

        # build_board.print_board(build_board.instance_variable_get(:@black))
        expect(square_occupant).to be_a Piece
        expect(occupant_symbol).to eq("\u{265A}")
        expect(occupant_color).to eq(expected_color)
      end
    end
  end

  context '#make_move' do
    subject(:move_board) { described_class.new(white, black) }
    let(:white) { double('white') }
    let(:black) { double('black') }

    before do
      move_board.instance_variable_set(:@white, Player.new('white'))
      move_board.instance_variable_set(:@black, Player.new('black'))
      move_board.create_game_board
      move_board.set_pieces_on_board
      move_board.update_pieces_instance_variables
    end

    it 'moves pawn from a2 to a4' do
      origin = [0, 1]
      destination = [0, 3]
      game_board = move_board.instance_variable_get(:@game_board)
      piece = game_board[1][0].occupant
      move_board.make_move(origin, destination)

      expect(game_board[1][0].occupant).to be(nil)
      expect(game_board[3][0].occupant).to be(piece)
      expect(piece.instance_variable_get(:@current_coordinate)).to eq([0, 3])
      # move_board.print_board(move_board.instance_variable_get(:@white))
    end
  end

  context 'movements and attack squares for pieces' do
    subject(:piece_board) { described_class.new(white, black) }
    let(:white) { double('white') }
    let(:black) { double('black') }

    before do
      piece_board.instance_variable_set(:@white, Player.new('white'))
      piece_board.instance_variable_set(:@black, Player.new('black'))
      piece_board.create_game_board
      piece_board.set_pieces_on_board
      piece_board.update_pieces_instance_variables
    end

    xit 'adds movement coordinates to a2 pawn' do
    end
  end

  context 'check' do
    subject(:check_board) { described_class.new(white, black) }
    subject(:black_pawn) { Piece.new('pawn', 'black') }
    subject(:black_king) { Piece.new('king', 'black') }
    subject(:white_pawn) { Piece.new('pawn', 'white') }
    subject(:white_rook) { Piece.new('rook', 'white') }
    subject(:white_rook2) { Piece.new('rook', 'white') }
    subject(:white_knight) { Piece.new('knight', 'white') }
    subject(:white_bishop) { Piece.new('bishop', 'white') }
    let(:white) { double('white') }
    let(:black) { double('black') }

    before do
      check_board.instance_variable_set(:@white, Player.new('white'))
      check_board.instance_variable_set(:@black, Player.new('black'))
      check_board.create_game_board
    end

    it 'check returns true if black king in check' do
      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king

      white_rook.instance_variable_set(:@current_coordinate, [5, 0])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([5, 0])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      king_color = 'black'
      king_location = black_king.instance_variable_get(:@current_coordinate)
      expect(check_board.check_for_check(king_color, king_location)).to eq(true)
    end

    it 'check returns true if black king in check by white pawn' do
      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king

      white_pawn.instance_variable_set(:@current_coordinate, [4, 6])
      white_pawn.instance_variable_set(:@game_board, check_board)
      white_pawn_square = check_board.find_square([4, 6])
      white_pawn_square.occupant = white_pawn
      white_pawn.update_movements_and_attacks

      king_color = 'black'
      king_location = black_king.instance_variable_get(:@current_coordinate)
      # check_board.print_board(check_board.instance_variable_get(:@white))
      expect(check_board.check_for_check(king_color, king_location)).to eq(true)
    end

    it 'check returns false if black king is not in check' do
      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king

      white_rook.instance_variable_set(:@current_coordinate, [4, 0])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([4, 0])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      king_color = 'black'
      king_location = black_king.instance_variable_get(:@current_coordinate)
      expect(check_board.check_for_check(king_color, king_location)).to eq(false)
    end

    it 'checkmate returns false if black king is not in check' do
      check_board.instance_variable_get(:@black).instance_variable_set(:@king, black_king)

      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king
      black_king.update_movements_and_attacks

      white_rook.instance_variable_set(:@current_coordinate, [4, 0])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([4, 0])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      king_color = 'black'
      expect(check_board.check_for_checkmate(king_color)).to eq(false)
    end

    it 'checkmate returns false if black king is in check, but not mate' do
      check_board.instance_variable_get(:@black).instance_variable_set(:@king, black_king)

      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king
      black_king.update_movements_and_attacks

      white_rook.instance_variable_set(:@current_coordinate, [5, 0])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([5, 0])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      king_color = 'black'
      expect(check_board.check_for_checkmate(king_color)).to eq(false)
    end

    it 'checkmate returns true if black king is in checkmate' do
      check_board.instance_variable_get(:@black).instance_variable_set(:@king, black_king)

      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king
      black_king.update_movements_and_attacks

      white_rook.instance_variable_set(:@current_coordinate, [0, 7])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([0, 7])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      white_rook2.instance_variable_set(:@current_coordinate, [0, 6])
      white_rook2.instance_variable_set(:@game_board, check_board)
      white_rook2_square = check_board.find_square([0, 6])
      white_rook2_square.occupant = white_rook2
      white_rook2.update_movements_and_attacks

      king_color = 'black'
      expect(check_board.check_for_checkmate(king_color)).to eq(true)
    end

    it 'checkmate returns false if king can capture a piece that has it in check' do
      check_board.instance_variable_get(:@black).instance_variable_set(:@king, black_king)

      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king
      black_king.update_movements_and_attacks

      white_rook.instance_variable_set(:@current_coordinate, [4, 7])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([4, 7])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      white_rook2.instance_variable_set(:@current_coordinate, [0, 6])
      white_rook2.instance_variable_set(:@game_board, check_board)
      white_rook2_square = check_board.find_square([0, 6])
      white_rook2_square.occupant = white_rook2
      white_rook2.update_movements_and_attacks

      king_color = 'black'
      expect(check_board.check_for_checkmate(king_color)).to eq(false)
    end

    it '#legal_move? returns false if king would be in check after move' do
      black_player = check_board.instance_variable_get(:@black)
      check_board.instance_variable_get(:@black).instance_variable_set(:@king, black_king)

      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king
      black_king.update_movements_and_attacks

      white_rook.instance_variable_set(:@current_coordinate, [2, 7])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([2, 7])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      black_pawn.instance_variable_set(:@current_coordinate, [4, 7])
      black_pawn.instance_variable_set(:@game_board, check_board)
      black_pawn_square = check_board.find_square([4, 7])
      black_pawn_square.occupant = black_pawn
      black_pawn.update_movements_and_attacks

      expect(check_board.legal_move?(black_player, [4, 7], [4, 6])).to eq(false)
    end

    it '#legal_move? returns true if king would not be in check after move' do
      black_player = check_board.instance_variable_get(:@black)
      check_board.instance_variable_get(:@black).instance_variable_set(:@king, black_king)

      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king
      black_king.update_movements_and_attacks

      white_rook.instance_variable_set(:@current_coordinate, [2, 7])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([2, 7])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      white_bishop.instance_variable_set(:@current_coordinate, [3, 7])
      white_bishop.instance_variable_set(:@game_board, check_board)
      white_bishop_square = check_board.find_square([3, 7])
      white_bishop_square.occupant = white_bishop
      white_bishop.update_movements_and_attacks

      black_pawn.instance_variable_set(:@current_coordinate, [4, 7])
      black_pawn.instance_variable_set(:@game_board, check_board)
      black_pawn_square = check_board.find_square([4, 7])
      black_pawn_square.occupant = black_pawn
      black_pawn.update_movements_and_attacks

      expect(check_board.legal_move?(black_player, [4, 7], [4, 6])).to eq(true)
    end

    it '#king_in_check_after_move? returns board to original state after moving one piece' do
      black_player = check_board.instance_variable_get(:@black)
      check_board.instance_variable_get(:@black).instance_variable_set(:@king, black_king)

      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king
      black_king.update_movements_and_attacks

      white_bishop.instance_variable_set(:@current_coordinate, [3, 7])
      white_bishop.instance_variable_set(:@game_board, check_board)
      white_bishop_square = check_board.find_square([3, 7])
      white_bishop_square.occupant = white_bishop
      white_bishop.update_movements_and_attacks

      expect(check_board.legal_move?(black_player, [5, 7], [4, 7])).to eq(true)
      check_board.king_in_check_after_move?(black_player, [5, 7], [4, 7])
      square_occupant = check_board.find_square([4, 7]).instance_variable_get(:@occupant)
      expect(square_occupant).to eq(nil)
    end

    it '#king_in_check_after_move? returns board to original state after moving two pieces' do
      black_player = check_board.instance_variable_get(:@black)
      check_board.instance_variable_get(:@black).instance_variable_set(:@king, black_king)

      black_king.instance_variable_set(:@current_coordinate, [5, 7])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 7])
      black_king_square.occupant = black_king
      black_king.update_movements_and_attacks

      white_rook.instance_variable_set(:@current_coordinate, [4, 7])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([4, 7])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      white_bishop.instance_variable_set(:@current_coordinate, [3, 7])
      white_bishop.instance_variable_set(:@game_board, check_board)
      white_bishop_square = check_board.find_square([3, 7])
      white_bishop_square.occupant = white_bishop
      white_bishop.update_movements_and_attacks

      # black_pawn.instance_variable_set(:@current_coordinate, [4, 7])
      # black_pawn.instance_variable_set(:@game_board, check_board)
      # black_pawn_square = check_board.find_square([4, 7])
      # black_pawn_square.occupant = black_pawn
      # black_pawn.update_movements_and_attacks

      expect(check_board.legal_move?(black_player, [5, 7], [4, 7])).to eq(true)
      check_board.king_in_check_after_move?(black_player, [5, 7], [4, 7])
      square_occupant = check_board.find_square([4, 7]).instance_variable_get(:@occupant)
      expect(square_occupant.instance_variable_get(:@type)).to eq('rook')
    end

    it '#non_king_can_remove_check returns true if pawn can capture rook' do
      black_player = check_board.instance_variable_get(:@black)
      check_board.instance_variable_get(:@black).instance_variable_set(:@king, black_king)

      black_king.instance_variable_set(:@current_coordinate, [5, 4])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 4])
      black_king_square.occupant = black_king
      black_king.update_movements_and_attacks

      white_rook.instance_variable_set(:@current_coordinate, [2, 4])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([2, 4])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      # white_bishop.instance_variable_set(:@current_coordinate, [3, 7])
      # white_bishop.instance_variable_set(:@game_board, check_board)
      # white_bishop_square = check_board.find_square([3, 7])
      # white_bishop_square.occupant = white_bishop
      # white_bishop.update_movements_and_attacks

      black_pawn.instance_variable_set(:@current_coordinate, [3, 5])
      black_pawn.instance_variable_set(:@game_board, check_board)
      black_pawn_square = check_board.find_square([3, 5])
      black_pawn_square.occupant = black_pawn
      black_pawn.update_movements_and_attacks

      expect(check_board.non_king_can_remove_check?('black', [5, 4])).to eq(true)
      # check_board.king_in_check_after_move?(black_player, [5, 7], [4, 7])
      # square_occupant = check_board.find_square([4, 7]).instance_variable_get(:@occupant)
      # expect(square_occupant.instance_variable_get(:@type)).to eq('rook')
    end

    it '#non_king_can_remove_check returns true if pawn can get between rook and kin' do
      black_player = check_board.instance_variable_get(:@black)
      check_board.instance_variable_get(:@black).instance_variable_set(:@king, black_king)

      black_king.instance_variable_set(:@current_coordinate, [5, 4])
      black_king.instance_variable_set(:@game_board, check_board)
      black_king_square = check_board.find_square([5, 4])
      black_king_square.occupant = black_king
      black_king.update_movements_and_attacks

      white_rook.instance_variable_set(:@current_coordinate, [2, 4])
      white_rook.instance_variable_set(:@game_board, check_board)
      white_rook_square = check_board.find_square([2, 4])
      white_rook_square.occupant = white_rook
      white_rook.update_movements_and_attacks

      # white_bishop.instance_variable_set(:@current_coordinate, [3, 7])
      # white_bishop.instance_variable_set(:@game_board, check_board)
      # white_bishop_square = check_board.find_square([3, 7])
      # white_bishop_square.occupant = white_bishop
      # white_bishop.update_movements_and_attacks

      black_pawn.instance_variable_set(:@current_coordinate, [4, 5])
      black_pawn.instance_variable_set(:@game_board, check_board)
      black_pawn_square = check_board.find_square([4, 5])
      black_pawn_square.occupant = black_pawn
      black_pawn.update_movements_and_attacks

      expect(check_board.non_king_can_remove_check?('black', [5, 4])).to eq(true)
      # check_board.king_in_check_after_move?(black_player, [5, 7], [4, 7])
      # square_occupant = check_board.find_square([4, 7]).instance_variable_get(:@occupant)
      # expect(square_occupant.instance_variable_get(:@type)).to eq('rook')
    end
  end

  context 'draw' do
    subject(:draw_board) { described_class.new(white, black) }
    subject(:black_pawn) { Piece.new('pawn', 'black') }
    subject(:black_king) { Piece.new('king', 'black') }
    subject(:white_pawn) { Piece.new('pawn', 'white') }
    subject(:white_rook) { Piece.new('rook', 'white') }
    subject(:white_rook2) { Piece.new('rook', 'white') }
    subject(:white_knight) { Piece.new('knight', 'white') }
    subject(:white_bishop) { Piece.new('bishop', 'white') }
    subject(:white_queen) { Piece.new('queen', 'white') }
    let(:white) { double('white') }
    let(:black) { double('black') }

    before do
      draw_board.instance_variable_set(:@white, Player.new('white'))
      draw_board.instance_variable_set(:@black, Player.new('black'))
      draw_board.create_game_board
    end

    it '#check_for_legal_moves returns false if king is stalemated' do
      black_king.instance_variable_set(:@current_coordinate, [7, 7])
      black_king.instance_variable_set(:@game_board, draw_board)
      black_king_square = draw_board.find_square([7, 7])
      black_king_square.occupant = black_king

      black_pawn.instance_variable_set(:@current_coordinate, [0, 1])
      black_pawn.instance_variable_set(:@game_board, draw_board)
      black_pawn_square = draw_board.find_square([0, 1])
      black_pawn_square.occupant = black_pawn

      white_pawn.instance_variable_set(:@current_coordinate, [0, 0])
      white_pawn.instance_variable_set(:@game_board, draw_board)
      white_pawn_square = draw_board.find_square([0, 0])
      white_pawn_square.occupant = white_pawn

      white_queen.instance_variable_set(:@current_coordinate, [6, 5])
      white_queen.instance_variable_set(:@game_board, draw_board)
      white_queen_square = draw_board.find_square([6, 5])
      white_queen_square.occupant = white_queen

      black_king.update_movements_and_attacks
      black_king.update_movements_and_attacks
      white_pawn.update_movements_and_attacks
      black_pawn.update_movements_and_attacks
      white_queen.update_movements_and_attacks

      black_player = draw_board.instance_variable_get(:@black)

      expect(draw_board.check_for_legal_moves(black_player)).to eq(false)
    end
  end

  context 'pawn promotion' do
    subject(:promo_board) { described_class.new(white, black) }
    subject(:black_pawn) { Piece.new('pawn', 'black') }
    subject(:black_king) { Piece.new('king', 'black') }
    subject(:white_pawn) { Piece.new('pawn', 'white') }
    subject(:white_rook) { Piece.new('rook', 'white') }
    subject(:white_rook2) { Piece.new('rook', 'white') }
    subject(:white_knight) { Piece.new('knight', 'white') }
    subject(:white_bishop) { Piece.new('bishop', 'white') }
    subject(:white_queen) { Piece.new('queen', 'white') }
    let(:white) { double('white') }
    let(:black) { double('black') }

    before do
      promo_board.instance_variable_set(:@white, Player.new('white'))
      promo_board.instance_variable_set(:@black, Player.new('black'))
      promo_board.create_game_board
    end

    it "#pawn_promotion? returns false if white pawn isn't promoting" do
      white_pawn.instance_variable_set(:@current_coordinate, [0, 0])
      white_pawn.instance_variable_set(:@game_board, promo_board)
      white_pawn_square = promo_board.find_square([0, 0])
      white_pawn_square.occupant = white_pawn

      white_player = promo_board.instance_variable_get(:@white)

      expect(promo_board.pawn_promotion?(white_player, [0, 0])).to eq(false)
    end

    it "#pawn_promotion? returns true if white pawn is promoting" do
      white_pawn.instance_variable_set(:@current_coordinate, [6, 7])
      white_pawn.instance_variable_set(:@game_board, promo_board)
      white_pawn_square = promo_board.find_square([6, 7])
      white_pawn_square.occupant = white_pawn

      white_player = promo_board.instance_variable_get(:@white)

      expect(promo_board.pawn_promotion?(white_player, [6, 7])).to eq(true)
    end

    it "#pawn_promotion? returns false if black pawn isn't promoting" do
      black_pawn.instance_variable_set(:@current_coordinate, [6, 6])
      black_pawn.instance_variable_set(:@game_board, promo_board)
      black_pawn_square = promo_board.find_square([6, 6])
      black_pawn_square.occupant = black_pawn

      black_player = promo_board.instance_variable_get(:@black)

      expect(promo_board.pawn_promotion?(black_player, [6, 6])).to eq(false)
    end

    it '#pawn_promotion? returns true if black pawn is promoting' do
      black_pawn.instance_variable_set(:@current_coordinate, [0, 0])
      black_pawn.instance_variable_set(:@game_board, promo_board)
      black_pawn_square = promo_board.find_square([0, 0])
      black_pawn_square.occupant = black_pawn

      black_player = promo_board.instance_variable_get(:@black)

      expect(promo_board.pawn_promotion?(black_player, [0, 0])).to eq(true)
    end

  end
end