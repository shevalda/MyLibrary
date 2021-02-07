class Bookshelf
  def initialize(num_of_row, num_of_columns)
    raise 'Invalid row number' unless num_of_row.positive?
    raise 'Invalid column number' unless num_of_columns.positive?

    @rows = Array.new(num_of_row) { Array.new(num_of_columns) }
    @last_position = [1, 0]
    @sparse_positions = []
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
    @rows[@last_position[0] - 1][@last_position[1] - 1] = book
    @last_position
  end

  def take_book_from(row, column)
    book = @rows[row - 1][column - 1]
    @rows[row - 1][column - 1] = nil
    update_positions(row, column)
    book
  end

  private

  def put_book_in_sparse_position(book)
    position = @sparse_positions.shift
    @rows[position[0]][position[1]] = book
    position
  end

  def full?
    @last_position == [rows_size, columns_size]
  end

  def increment_last_position
    if @last_position[1] < columns_size
      @last_position[1] += 1
    else
      @last_position[0] += 1
      @last_position[1] = 1
    end
  end

  def update_positions(row, column)
    if @last_position == [row, column]
      @last_position[1] -= 1
    else
      @sparse_positions << [row, column]
    end
  end
end
