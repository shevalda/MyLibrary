class Bookshelf
  attr_reader :rows, :columns

  def initialize(num_of_row, num_of_columns)
    @rows = Array.new(num_of_row) { [] }
    @columns = num_of_columns
  end
end