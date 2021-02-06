class Bookshelf
  attr_reader :rows, :columns

  def initialize(num_of_row, num_of_columns)
    @rows = Array.new(num_of_row) { [] }
    @columns = num_of_columns
    @last_position = [1, 0]
  end

  def put_book(book)
    @last_position[1] += 1
    if @last_position[1] > @columns
      return false if @last_position[0] + 1 > @rows.length

      @last_position[0] += 1
      @last_position[1] = 1
    end
    @rows[@last_position[0] - 1] << book
    @last_position
  end
end
