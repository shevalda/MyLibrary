module CommandParser
  def parse_command(input)
    input.split('|').first
  end

  def parse_build_library_command(input)
    _, bookshelf_count, row_size, column_size = input.split('|')
    {
      bookshelf_count: Integer(bookshelf_count),
      row_size: Integer(row_size),
      column_size: Integer(column_size)
    }
  end
end
