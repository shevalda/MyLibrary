require './app/models/bookshelf'

class Library
  attr_reader :bookshelves

  def initialize(bookshelves_count, row, column)
    raise 'Invalid number of bookhelves' unless bookshelves_count.positive?

    @bookshelves = Array.new(bookshelves_count) { Bookshelf.new(row, column) }
    @bookshelves.each.with_index(1) do |bookshelf, index|
      puts "Shelf #{index} with #{bookshelf.rows_size} rows and #{bookshelf.columns_size} columns is added"
    end
  end

  def put_book(book)
    @bookshelves.each.with_index(1) do |bookshelf, shelf_position|
      row_column_position = bookshelf.put_book(book)
      return { shelf: shelf_position }.merge(row_column_position) if row_column_position
    end
    false
  end

  def take_book_from(shelf, row, column)
    raise ArgumentError unless shelf.positive? && shelf <= bookshelves_count

    @bookshelves[shelf - 1].take_book_from(row, column)
  end

  private

  def bookshelves_count
    @bookshelves.count
  end
end
