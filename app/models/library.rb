require './app/models/bookshelf'

class Library
  attr_reader :bookshelves

  @@instance = Library.new

  def self.instance
    @@instance
  end

  private_class_method :new
  def initialize
    @bookshelves = nil
  end

  def build(bookshelves_count, row, column)
    raise 'Invalid number of bookhelves' unless bookshelves_count.positive?

    @bookshelves = Array.new(bookshelves_count) { Bookshelf.new(row, column) }
  end

  def put_book(book)
    library_already_built?

    @bookshelves.each.with_index(1) do |bookshelf, shelf_position|
      row_column_position = bookshelf.put_book(book)
      return { shelf: shelf_position }.merge(row_column_position) if row_column_position
    end
    false
  end

  def take_book_from(shelf, row, column)
    library_already_built?

    raise ArgumentError unless shelf.positive? && shelf <= bookshelves_count

    @bookshelves[shelf - 1].take_book_from(row, column)
  end

  def find_book(isbn)
    library_already_built?

    @bookshelves.each.with_index(1) do |bookshelf, shelf_position|
      row_column_position = bookshelf.find_book(isbn)
      return { shelf: shelf_position }.merge(row_column_position) if row_column_position
    end
    nil
  end

  def list_books
    library_already_built?

    list = []
    @bookshelves.each.with_index(1) do |bookshelf, shelf_position|
      shelf_list_books = bookshelf.list_books
      next if shelf_list_books.empty?

      list << { shelf: shelf_position, list_books: shelf_list_books }
    end
    list
  end

  def search_books_by_title(title)
    list = []
    @bookshelves.each.with_index(1) do |bookshelf, shelf_position|
      shelf_list_books = bookshelf.search_books_by_title(title)
      next if shelf_list_books.empty?

      list << { shelf: shelf_position, list_books: shelf_list_books }
    end
    list
  end

  def search_books_by_author(author)
    list = []
    @bookshelves.each.with_index(1) do |bookshelf, shelf_position|
      shelf_list_books = bookshelf.search_books_by_author(author)
      next if shelf_list_books.empty?

      list << { shelf: shelf_position, list_books: shelf_list_books }
    end
    list
  end

  private

  def library_already_built?
    raise 'Library not build yet' if @bookshelves.nil?
  end

  def bookshelves_count
    @bookshelves.count
  end
end
