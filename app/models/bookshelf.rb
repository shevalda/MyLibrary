class Bookshelf
  attr_reader :rows, :columns

  def initialize(num_of_row, num_of_columns)
    raise 'Invalid row number' unless num_of_row.positive?
    raise 'Invalid column number' unless num_of_columns.positive?

    @rows = Array.new(num_of_row) { [] }
    @columns = num_of_columns
    @last_position = [1, 0]
    @sparse_positions = []
  end

  def put_book(book)
    return put_book_in_sparse_position(book) if @sparse_positions.any?

    @last_position[1] += 1
    if @last_position[1] > @columns
      return false if @last_position[0] + 1 > @rows.length

      @last_position[0] += 1
      @last_position[1] = 1
    end
    @rows[@last_position[0] - 1] << book
    @last_position
  end

  def take_book_from(row, column)
    book = @rows[row - 1][column - 1]
    @rows[row - 1][column - 1] = nil
    if @last_position == [row, column]
      @last_position[1] -= 1
    else
      @sparse_positions << [row, column]
    end
    book
  end

  private

  def put_book_in_sparse_position(book)
    position = @sparse_positions.shift
    @rows[position[0]][position[1]] = book
    position
  end
end
