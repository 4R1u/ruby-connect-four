# frozen_string_literal: true

# represents the toy in which the discs go
class Game
  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def grid
    @grid.map { |row| row.map(&:itself) }
  end

  def insert_disc(player, column)
    (0..5).reverse_each do |row|
      if @grid[row][column].nil?
        @grid[row][column] = player
        return row
      end
    end
    nil
  end
end
