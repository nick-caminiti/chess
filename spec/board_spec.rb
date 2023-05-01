# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  context '#build_board' do
    subject(:build_board) { described_class.new(white, black) }
    let(:white) { double('white')}
    let(:black) { double('black')}

    it 'stores an array in @game_board' do
      build_board.create_game_board_array
      game_board = build_board.instance_variable_get(:@game_board)
      expect(game_board).to be_an Array
    end

    it 'creates an array containing arrays of coordinates' do
      expected_board = [['a1', 'a2'],['b1', 'b2']]

      build_board.create_game_board_array
      game_board = build_board.instance_variable_get(:@game_board)
      expect(game_board).to eq(expected_board)
    end
  end
end