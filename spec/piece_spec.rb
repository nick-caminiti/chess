# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/board'
require_relative '../lib/player'

describe Piece do
  context '#initialize a king' do
    subject(:new_king) { described_class.new('king') }

    xit 'has instance variable symbol of K' do
      symbol = new_king.instance_variable_get(:@symbol)
      expected_symbol = 'K'

      expect(symbol).to eq(expected_symbol)
    end

    xit 'cant jump' do
      can_jump = new_king.instance_variable_get(:@can_jump)
      expected_result = false

      expect(can_jump).to eq(expected_result)
    end
  end

  context '#initialize a knight' do
    subject(:new_king) { described_class.new('knight') }

    xit 'has instance variable symbol of N' do
      symbol = new_king.instance_variable_get(:@symbol)
      expected_symbol = 'N'

      expect(symbol).to eq(expected_symbol)
    end

    xit 'can jump' do
      can_jump = new_king.instance_variable_get(:@can_jump)
      expected_result = true

      expect(can_jump).to eq(expected_result)
    end
  end

  context 'moves and attacks' do
    context 'new white pawn' do
      subject(:white_pawn) { described_class.new('pawn', 'white') }
      subject(:black_pawn) { described_class.new('pawn', 'black') }
      subject(:white_rook) { described_class.new('rook', 'white') }
      subject(:white_knight) { described_class.new('knight', 'white') }
      subject(:white_bishop) { described_class.new('bishop', 'white') }
      subject(:game_board) { Board.new(white, black) }
      let(:white) { double('white') }
      let(:black) { double('black') }

      before do
        # game_board.instance_variable_set(:@white, Player.new('white'))
        # game_board.instance_variable_set(:@black, Player.new('black'))
        game_board.create_game_board
      end

      it 'adds first moves to a pawn' do
        white_pawn.instance_variable_set(:@current_square, [0, 1])
        pawn_start_square = game_board.find_square([0, 1])
        pawn_start_square.occupant = white_pawn

        expected_move_squares = [[0, 2], [0, 3]]
        # p game_board
        white_pawn.update_movements_and_attacks(game_board)
        expect(white_pawn.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'pawn cant move at all if blocked in first square' do
        white_pawn.instance_variable_set(:@current_square, [0, 1])
        pawn_start_square = game_board.find_square([0, 1])
        pawn_start_square.occupant = white_pawn

        black_pawn.instance_variable_set(:@current_square, [0, 2])
        black_pawn.instance_variable_set(:@moved, true)
        black_pawn_start_square = game_board.find_square([0, 2])
        black_pawn_start_square.occupant = black_pawn

        expected_move_squares = []
        # p game_board
        white_pawn.update_movements_and_attacks(game_board)
        expect(white_pawn.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'adds only one move to pawn that has moved' do
        white_pawn.instance_variable_set(:@current_square, [0, 2])
        white_pawn.instance_variable_set(:@moved, true)
        pawn_start_square = game_board.find_square([0, 2])
        pawn_start_square.occupant = white_pawn

        expected_move_squares = [[0, 3]]
        # p game_board
        white_pawn.update_movements_and_attacks(game_board)
        expect(white_pawn.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'cant move at all if another piece is in front of it' do
        white_pawn.instance_variable_set(:@current_square, [0, 2])
        white_pawn.instance_variable_set(:@moved, true)
        pawn_start_square = game_board.find_square([0, 2])
        pawn_start_square.occupant = white_pawn

        black_pawn.instance_variable_set(:@current_square, [0, 3])
        black_pawn.instance_variable_set(:@moved, true)
        black_pawn_start_square = game_board.find_square([0, 3])
        black_pawn_start_square.occupant = black_pawn

        expected_move_squares = []
        # p game_board
        white_pawn.update_movements_and_attacks(game_board)
        expect(white_pawn.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'adds no moves to new rook that is blocked by pawn and knight' do
        white_pawn.instance_variable_set(:@current_square, [0, 1])
        white_pawn.instance_variable_set(:@moved, true)
        pawn_start_square = game_board.find_square([0, 1])
        pawn_start_square.occupant = white_pawn

        white_rook.instance_variable_set(:@current_square, [0, 0])
        white_rook.instance_variable_set(:@moved, true)
        rook_start_square = game_board.find_square([0, 0])
        rook_start_square.occupant = white_rook

        white_knight.instance_variable_set(:@current_square, [1, 0])
        white_knight.instance_variable_set(:@moved, true)
        white_start_square = game_board.find_square([1, 0])
        white_start_square.occupant = white_knight

        expected_move_squares = []
        # p game_board
        white_rook.update_movements_and_attacks(game_board)
        expect(white_rook.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'adds moves to a rook that isnt blocked' do
        white_rook.instance_variable_set(:@current_square, [0, 0])
        white_rook.instance_variable_set(:@moved, true)
        rook_start_square = game_board.find_square([0, 0])
        rook_start_square.occupant = white_rook

        expected_move_squares = [
          [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
          [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]
        ]
        # p game_board
        white_rook.update_movements_and_attacks(game_board)
        expect(white_rook.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'adds moves to a bishop that isnt blocked' do
        white_pawn.instance_variable_set(:@current_square, [0, 1])
        white_pawn.instance_variable_set(:@moved, true)
        pawn_start_square = game_board.find_square([0, 1])
        pawn_start_square.occupant = white_pawn

        white_rook.instance_variable_set(:@current_square, [0, 0])
        white_rook.instance_variable_set(:@moved, true)
        rook_start_square = game_board.find_square([0, 0])
        rook_start_square.occupant = white_rook

        white_knight.instance_variable_set(:@current_square, [1, 0])
        white_knight.instance_variable_set(:@moved, true)
        knight_start_square = game_board.find_square([1, 0])
        knight_start_square.occupant = white_knight

        white_bishop.instance_variable_set(:@current_square, [2, 0])
        white_bishop.instance_variable_set(:@moved, true)
        bishop_start_square = game_board.find_square([2, 0])
        bishop_start_square.occupant = white_bishop

        expected_move_squares = [[3, 1], [4, 2], [5, 3], [6, 4], [7, 5], [1, 1], [0, 2]]
        # p game_board
        white_bishop.update_movements_and_attacks(game_board)
        expect(white_bishop.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'adds moves to a knight with pieces in front of it' do
        white_pawn.instance_variable_set(:@current_square, [1, 1])
        white_pawn.instance_variable_set(:@moved, true)
        pawn_start_square = game_board.find_square([1, 1])
        pawn_start_square.occupant = white_pawn

        white_rook.instance_variable_set(:@current_square, [3, 1])
        white_rook.instance_variable_set(:@moved, true)
        rook_start_square = game_board.find_square([0, 0])
        rook_start_square.occupant = white_rook

        white_knight.instance_variable_set(:@current_square, [1, 0])
        white_knight.instance_variable_set(:@moved, true)
        knight_start_square = game_board.find_square([1, 0])
        knight_start_square.occupant = white_knight

        white_bishop.instance_variable_set(:@current_square, [2, 1])
        white_bishop.instance_variable_set(:@moved, true)
        bishop_start_square = game_board.find_square([2, 0])
        bishop_start_square.occupant = white_bishop

        expected_move_squares = [[2, 2], [0, 2], [3, 1]]
        # p game_board
        white_knight.update_movements_and_attacks(game_board)
        expect(white_knight.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'adds moves to a bishop when space is occupied by opponent' do
        white_pawn.instance_variable_set(:@current_square, [0, 1])
        white_pawn.instance_variable_set(:@moved, true)
        pawn_start_square = game_board.find_square([0, 1])
        pawn_start_square.occupant = white_pawn

        white_rook.instance_variable_set(:@current_square, [0, 0])
        white_rook.instance_variable_set(:@moved, true)
        rook_start_square = game_board.find_square([0, 0])
        rook_start_square.occupant = white_rook

        black_pawn.instance_variable_set(:@current_square, [6, 4])
        black_pawn.instance_variable_set(:@moved, true)
        black_pawn_start_square = game_board.find_square([6, 4])
        black_pawn_start_square.occupant = black_pawn

        white_knight.instance_variable_set(:@current_square, [1, 0])
        white_knight.instance_variable_set(:@moved, true)
        knight_start_square = game_board.find_square([1, 0])
        knight_start_square.occupant = white_knight

        white_bishop.instance_variable_set(:@current_square, [2, 0])
        white_bishop.instance_variable_set(:@moved, true)
        bishop_start_square = game_board.find_square([2, 0])
        bishop_start_square.occupant = white_bishop

        expected_move_squares = [[3, 1], [4, 2], [5, 3], [6, 4], [1, 1], [0, 2]]
        # p game_board
        white_bishop.update_movements_and_attacks(game_board)
        expect(white_bishop.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'adds moves to a rook when opponents piece is in destination' do
        white_rook.instance_variable_set(:@current_square, [0, 0])
        white_rook.instance_variable_set(:@moved, true)
        rook_start_square = game_board.find_square([0, 0])
        rook_start_square.occupant = white_rook

        black_pawn.instance_variable_set(:@current_square, [0, 5])
        black_pawn.instance_variable_set(:@moved, true)
        black_pawn_start_square = game_board.find_square([0, 5])
        black_pawn_start_square.occupant = black_pawn

        expected_move_squares = [
          [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
          [0, 1], [0, 2], [0, 3], [0, 4], [0, 5]
        ]
        # p game_board
        white_rook.update_movements_and_attacks(game_board)
        expect(white_rook.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'adds moves to a knight when opponents piece is in destination' do
        white_pawn.instance_variable_set(:@current_square, [1, 1])
        white_pawn.instance_variable_set(:@moved, true)
        pawn_start_square = game_board.find_square([1, 1])
        pawn_start_square.occupant = white_pawn

        white_rook.instance_variable_set(:@current_square, [3, 1])
        white_rook.instance_variable_set(:@moved, true)
        rook_start_square = game_board.find_square([0, 0])
        rook_start_square.occupant = white_rook

        black_pawn.instance_variable_set(:@current_square, [3, 1])
        black_pawn.instance_variable_set(:@moved, true)
        black_pawn_start_square = game_board.find_square([3, 1])
        black_pawn_start_square.occupant = black_pawn

        white_knight.instance_variable_set(:@current_square, [1, 0])
        white_knight.instance_variable_set(:@moved, true)
        knight_start_square = game_board.find_square([1, 0])
        knight_start_square.occupant = white_knight

        white_bishop.instance_variable_set(:@current_square, [2, 1])
        white_bishop.instance_variable_set(:@moved, true)
        bishop_start_square = game_board.find_square([2, 0])
        bishop_start_square.occupant = white_bishop

        expected_move_squares = [[2, 2], [0, 2], [3, 1]]
        # p game_board
        white_knight.update_movements_and_attacks(game_board)
        expect(white_knight.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end

      it 'adds attack square to pawn when opponent in range' do
        white_pawn.instance_variable_set(:@current_square, [0, 1])
        pawn_start_square = game_board.find_square([0, 1])
        pawn_start_square.occupant = white_pawn

        black_pawn.instance_variable_set(:@current_square, [1, 2])
        black_pawn.instance_variable_set(:@moved, true)
        black_pawn_start_square = game_board.find_square([1, 2])
        black_pawn_start_square.occupant = black_pawn

        expected_move_squares = [[0, 2], [0, 3], [1, 2]]
        # p game_board
        white_pawn.update_movements_and_attacks(game_board)
        expect(white_pawn.instance_variable_get(:@move_squares)).to eq(expected_move_squares)
      end
    end
  end

end