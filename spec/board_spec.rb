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

        build_board.build_board

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

        build_board.build_board

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

        build_board.build_board

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

        build_board.build_board

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
      move_board.build_board
    end

    it 'moves pawn from a2 to a4' do
      input = 'a2:a4'
      game_board = move_board.instance_variable_get(:@game_board)
      piece = game_board[1][0].occupant
      move_board.make_move(input)

      expect(game_board[1][0].occupant).to be(nil)
      expect(game_board[3][0].occupant).to be(piece)
      expect(piece.instance_variable_get(:@current_square)).to eq([0, 3])
      move_board.print_board(move_board.instance_variable_get(:@white))
    end
  end
end