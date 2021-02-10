require './app/models/bookshelf'

class Library
  attr_reader :bookshelves

  def initialize(bookshelves_count, row, column)
    @bookshelves = Array.new(bookshelves_count) { Bookshelf.new(row, column) }
  end
end
