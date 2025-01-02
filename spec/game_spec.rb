# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }
  describe '#insert_disc' do
    context 'when the column is empty' do
      it 'returns 5' do
        expect(game.insert_disc('r', 0)).to eq(5)
      end
    end

    context 'when the column has one disc' do
      before do
        game.insert_disc('r', 0)
      end

      it 'returns 4' do
        expect(game.insert_disc('y', 0)).to eq(4)
      end
    end

    context 'when the column is full' do
      before do
        game.insert_disc('r', 0)
        game.insert_disc('y', 0)
        game.insert_disc('r', 0)
        game.insert_disc('y', 0)
        game.insert_disc('r', 0)
        game.insert_disc('y', 0)
      end

      it 'returns nil' do
        expect(game.insert_disc('r', 0)).to be_nil
      end
    end
  end
end
