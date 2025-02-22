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

    context 'when the column does not exist' do
      it 'returns nil' do
        expect(game.insert_disc('r', 8)).to be_nil
      end
    end

    context 'when disc color is not r or y' do
      it 'returns nil' do
        expect(game.insert_disc('g', 0)).to be_nil
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

  describe '#full?' do
    context 'when the grid is full' do
      before do
        7.times do |col|
          3.times do
            game.insert_disc('r', col)
            game.insert_disc('y', col)
          end
        end
      end

      it 'returns true' do
        expect(game.full?).to be(true)
      end
    end

    context 'when the board is neither full nor empty' do
      before do
        game.insert_disc('r', 0)
        game.insert_disc('y', 6)
      end
      it 'returns false' do
        expect(game.full?).to be(false)
      end
    end

    context 'when the board is empty' do
      it 'returns false' do
        expect(game.full?).to be(false)
      end
    end
  end

  describe '#winner?' do
    context 'when red wins horizontally' do
      before do
        4.times { |col| game.insert_disc('r', col) }
      end

      it 'returns true' do
        expect(game.winner?('r')).to eq(true)
      end
    end

    context 'when red only has three discs in a horizontal line' do
      before do
        3.times { |col| game.insert_disc('r', col) }
      end

      it 'returns false' do
        expect(game.winner?('r')).to eq(false)
      end
    end

    context 'when red wins vertically' do
      before do
        4.times { game.insert_disc('r', 0) }
      end

      it 'returns true' do
        expect(game.winner?('r')).to eq(true)
      end
    end

    context 'when red only has three discs in a vertical line' do
      before do
        3.times { game.insert_disc('r', 0) }
      end

      it 'returns false' do
        expect(game.winner?('r')).to eq(false)
      end
    end

    context 'red wins in a forward slash' do
      before do
        game.insert_disc('r', 0)
        game.insert_disc('y', 1)
        game.insert_disc('r', 2)
        game.insert_disc('y', 3)
        game.insert_disc('r', 1)
        game.insert_disc('y', 2)
        game.insert_disc('r', 2)
        game.insert_disc('y', 3)
        game.insert_disc('r', 4)
        game.insert_disc('y', 3)
        game.insert_disc('r', 3)
      end

      it 'returns true' do
        expect(game.winner?('r')).to eq(true)
      end
    end

    context 'red only has three in a forward slash' do
      before do
        game.insert_disc('r', 0)
        game.insert_disc('y', 1)
        game.insert_disc('r', 2)
        game.insert_disc('y', 3)
        game.insert_disc('r', 1)
        game.insert_disc('y', 2)
        game.insert_disc('r', 2)
        game.insert_disc('y', 3)
        game.insert_disc('r', 4)
      end

      it 'returns false' do
        expect(game.winner?('r')).to eq(false)
      end
    end

    context 'red wins in a backward slash' do
      before do
        game.insert_disc('r', 3)
        game.insert_disc('y', 2)
        game.insert_disc('r', 2)
        game.insert_disc('y', 2)
        game.insert_disc('r', 1)
        game.insert_disc('y', 1)
        game.insert_disc('r', 1)
        game.insert_disc('y', 0)
        game.insert_disc('r', 0)
        game.insert_disc('y', 0)
        game.insert_disc('r', 0)
      end

      it 'returns true' do
        expect(game.winner?('r')).to eq(true)
      end
    end

    context 'red only has three in a backward slash' do
      before do
        game.insert_disc('r', 3)
        game.insert_disc('y', 2)
        game.insert_disc('r', 2)
        game.insert_disc('y', 2)
        game.insert_disc('r', 1)
        game.insert_disc('y', 1)
        game.insert_disc('r', 1)
        game.insert_disc('y', 0)
        game.insert_disc('r', 0)
      end

      it 'returns false' do
        expect(game.winner?('r')).to eq(false)
      end
    end
  end
end
