require './app/commands/library_command'

class FindBookCommand < LibraryCommand
  def execute(arguments)
    check_command_length(arguments, 2)

    isbn = parse_command(arguments)
    position = @library.find_book(isbn)

    output_command(position)
  end

  private

  def parse_command(arguments)
    _, isbn = arguments.split('|')
    isbn
  end

  def output_command(arguments)
    if arguments.nil?
      BOOK_NOT_FOUND
    else
      "Found the book at #{position_string(arguments[:shelf], arguments[:row], arguments[:column])}"
    end
  end
end
