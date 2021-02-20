module OutputUtility
  def put_book_output(bookshelf_pos, row_pos, column_pos)
    "Allocated address: #{position_string(bookshelf_pos, row_pos, column_pos)}"
  end

  private

  def position_string(bookshelf_pos, row_pos, column_pos)
    leading_zero_number(bookshelf_pos, 2) + leading_zero_number(row_pos, 2) + leading_zero_number(column_pos, 2)
  end

  def leading_zero_number(number, length)
    "%0#{length}d" % number
  end
end
