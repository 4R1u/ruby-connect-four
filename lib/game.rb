# frozen_string_literal: true

# represents the toy in which the discs go
class Game
  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def grid
    @grid.map { |row| row.map(&:itself) }
  end

  def display_grid
    @grid.each do |row|
      display_row(row)
      print "\n"
    end
  end

  def full?
    @grid.each { |row| row.each { |item| return false if item.nil? } }
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
    horizontal_winner?(player) ||
      vertical_winner?(player) ||
      diagonal_winner?(player)
  end

  private

  def display_row(row)
    row.each do |item|
      case item
      when nil
        print ' '
      when 'r'
        print "\e[0;31;49mr\e[0m"
      when 'y'
        print "\e[0;33;49my\e[0m"
      end
    end
  end

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

  def vertical_winner?(player)
    in_a_row = 0
    @grid.transpose.each do |col|
      col.each do |item|
        in_a_row += player == item ? 1 : -in_a_row
        return true if in_a_row == 4
      end
    end
    false
  end

  def diagonal_winner?(player)
    winner_in_a_bslash?(player) || winner_in_a_fslash?(player)
  end

  def winner_in_a_fslash?(player)
    3.times do |i|
      (3..7).each do |j|
        return true if @grid[i][j] == player && fslash?(i, j, player)
      end
    end
    false
  end

  def winner_in_a_bslash?(player)
    3.times do |i|
      4.times do |j|
        return true if @grid[i][j] == player && bslash?(i, j, player)
      end
    end
    false
  end

  def bslash?(pos_i, pos_j, player)
    4.times do |k|
      return false unless @grid[pos_i + k][pos_j + k] == player
    end
    true
  end

  def fslash?(pos_i, pos_j, player)
    4.times do |k|
      return false unless @grid[pos_i + k][pos_j - k] == player
    end
    true
  end
end
