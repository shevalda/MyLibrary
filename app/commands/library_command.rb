require './app/models/library'

class LibraryCommand
  def initialize
    @library = Library.instance
  end

  def execute(arguments)
    raise NotImplementedError, 'execute not defined'
  end

  protected

  def check_command_length(input, expected_count)
    arguements_length = input.split('|').length
    raise "Expected #{expected_count} arguments, given #{arguements_length}" unless arguements_length == expected_count
  end

  def position_string(bookshelf_pos, row_pos, column_pos)
    leading_zero_number(bookshelf_pos, 2) + leading_zero_number(row_pos, 2) + leading_zero_number(column_pos, 2)
  end

  def leading_zero_number(number, length)
    "%0#{length}d" % number
  end
end
