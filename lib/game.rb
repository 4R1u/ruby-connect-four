# frozen_string_literal: true

# represents the toy in which the discs go
class Game
  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def grid
    @grid.map { |row| row.map(&:itself) }
  end

  def full?
    @grid.each { |row| row.each { |item| return false unless item.nil? } }
    true
  end

  def insert_disc(player, column)
    return nil unless (0..6).cover?(column) && %w[r y].include?(player)

    (0..5).reverse_each do |row|
      if @grid[row][column].nil?
        @grid[row][column] = player
        return row
      end
    end
    nil
  end

  def winner?(player)
    horizontal_winner?(player) # ||
    # vertical_winner?(player) # ||
    # diagonal_winner?(player)
  end

  private

  def horizontal_winner?(player)
    in_a_row = 0
    @grid.each do |row|
      row.each do |item|
        in_a_row += player == item ? 1 : -in_a_row
        return true if in_a_row == 4
      end
    end
    false
  end
end
