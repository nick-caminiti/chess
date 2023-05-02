# frozen_string_literal: true

require_relative '../lib/piece'

describe Piece do
  context '#initialize a king' do
    subject(:new_king) { described_class.new('king') }

    it 'has instance variable symbol of K' do
      symbol = new_king.instance_variable_get(:@symbol)
      expected_symbol = 'K'

      expect(symbol).to eq(expected_symbol)
    end

    it 'cant jump' do
      can_jump = new_king.instance_variable_get(:@can_jump)
      expected_result = false

      expect(can_jump).to eq(expected_result)
    end
  end

  context '#initialize a knight' do
    subject(:new_king) { described_class.new('knight') }

    it 'has instance variable symbol of N' do
      symbol = new_king.instance_variable_get(:@symbol)
      expected_symbol = 'N'

      expect(symbol).to eq(expected_symbol)
    end

    it 'can jump' do
      can_jump = new_king.instance_variable_get(:@can_jump)
      expected_result = true

      expect(can_jump).to eq(expected_result)
    end

  end

end