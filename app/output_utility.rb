module OutputUtility
  def build_library_output(bookshelf_count, row_size, column_size)
    output = bookshelf_count.times.map.with_index(1) do |_, bookshelf_position|
      "Shelf #{bookshelf_position} with #{row_size} rows and #{column_size} columns is added"
    end
    output.join("\n")
  end

  def put_book_output(bookshelf_pos, row_pos, column_pos)
    "Allocated address: #{position_string(bookshelf_pos, row_pos, column_pos)}"
  end

  def take_book_from_output(position)
    "Slot #{position} is free"
  end

  def find_book_output(bookshelf_pos, row_pos, column_pos)
    "Found the book at #{position_string(bookshelf_pos, row_pos, column_pos)}"
  end

  def list_books_output(list_books)
    output = []
    list_books.each do |shelf_info|
      shelf_info[:list_books].each do |book_info|
        output << <<~TEXT.split.join(' ')
          #{position_string(shelf_info[:shelf], book_info[:row], book_info[:column])}:
          #{book_info[:book].isbn} |
          #{book_info[:book].title} |
          #{book_info[:book].author}
        TEXT
      end
    end
    output.join("\n")
  end

  private

  def position_string(bookshelf_pos, row_pos, column_pos)
    leading_zero_number(bookshelf_pos, 2) + leading_zero_number(row_pos, 2) + leading_zero_number(column_pos, 2)
  end

  def leading_zero_number(number, length)
    "%0#{length}d" % number
  end
end
