class Bookshelf
  def initialize(num_of_row, num_of_columns)
    raise 'Invalid row number' unless num_of_row.positive?
    raise 'Invalid column number' unless num_of_columns.positive?

    @rows = Array.new(num_of_row) { Array.new(num_of_columns) }
    @last_position = { row: 1, column: 0 }
    @sparse_positions = {}
  end

  def rows_size
    @rows.length
  end

  def columns_size
    @rows[0].length
  end

  def put_book(book)
    return put_book_in_sparse_position(book) if @sparse_positions.any?
    return false if full?

    increment_last_position
    @rows[@last_position[:row] - 1][@last_position[:column] - 1] = book
    @last_position
  end

  def take_book_from(row, column)
    return false if row > rows_size || row <= 0
    return false if column > columns_size || column <= 0

    book = @rows[row - 1][column - 1]
    @rows[row - 1][column - 1] = nil
    update_positions(row, column)
    book
  end

  def find_book(isbn)
    @rows.each_with_index do |row, row_index|
      row.each_with_index do |book, column_index|
        return { row: row_index + 1, column: column_index + 1 } if book&.isbn == isbn
      end
    end
    nil
  end

  def list_books
    position_books = []
    @rows.each_with_index do |row, row_index|
      row.each_with_index do |book, column_index|
        position_books << { row: row_index + 1, column: column_index + 1, book: book } unless book.nil?
      end
    end
    position_books
  end

  def search_books_by_title(keyword)
    matching_position_books = []
    @rows.each_with_index do |row, row_index|
      row.each_with_index do |book, column_index|
        next unless book&.title_include? keyword

        matching_position_books << {
          row: row_index + 1,
          column: column_index + 1,
          book: book
        }
      end
    end
    matching_position_books
  end

  def search_books_by_author(keyword)
    matching_position_books = []
    @rows.each_with_index do |row, row_index|
      row.each_with_index do |book, column_index|
        matching_position_books << [row_index + 1, column_index + 1, book] if book&.author_include? keyword
      end
    end
    matching_position_books
  end

  private

  def put_book_in_sparse_position(book)
    position = pop_sparse_position
    @rows[position[:row]][position[:column]] = book
    position
  end

  def full?
    @last_position == { row: rows_size, column: columns_size }
  end

  def increment_last_position
    if @last_position[:column] < columns_size
      @last_position[:column] += 1
    else
      @last_position[:row] += 1
      @last_position[:column] = 1
    end
  end

  def update_positions(row, column)
    if @last_position == { row: row, column: column }
      @last_position[:column] -= 1
    else
      push_sparse_position(row, column)
    end
  end

  def push_sparse_position(row, column)
    if @sparse_positions[row].nil?
      @sparse_positions[row] = [column]
    else
      @sparse_positions[row] << column
      @sparse_positions[row].sort!
    end
  end

  def pop_sparse_position
    row = @sparse_positions.keys.min
    column = @sparse_positions[row].shift
    @sparse_positions.delete(row) if @sparse_positions[row].length.zero?
    { row: row, column: column }
  end
end
