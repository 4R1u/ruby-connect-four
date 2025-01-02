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

  describe '#grid' do
    context 'when the board is empty' do
      it 'expected output' do
        expect(game.grid).to eq(Array.new(6) { Array.new(7) })
      end
    end

    context 'when the board has discs' do
      before do
        game.insert_disc('r', 0)
        game.insert_disc('y', 0)
        game.insert_disc('r', 1)
      end

      it 'expected output' do
        expected = Array.new(6) { Array.new(7) }
        expected[5][0] = expected[5][1] = 'r'
        expected[4][0] = 'y'
        expect(game.grid).to eq(expected)
      end
    end
  end
end
