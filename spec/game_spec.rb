# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  context 'declares winner correctly' do
    subject(:win_declare) { described_class.new }

    xit 'declares black the winner if white is in checkmate' do
      # win_declare.instance_variable_set(@checkmate, )
    end
  end

end