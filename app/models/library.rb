require './app/models/bookshelf'

class Library
  attr_reader :bookshelves

  def initialize(bookshelves_count, row, column)
    raise 'Invalid number of bookhelves' if bookshelves_count.zero?

    @bookshelves = Array.new(bookshelves_count) { Bookshelf.new(row, column) }
    @bookshelves.each.with_index(1) do |bookshelf, index|
      puts "Shelf #{index} with #{bookshelf.rows_size} rows and #{bookshelf.columns_size} columns is added"
    end
  end
end