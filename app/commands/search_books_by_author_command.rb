require './app/commands/library_command'

class SearchBooksByAuthorCommand < LibraryCommand
  def execute(arguments)
    check_command_length(arguments, 2)

    keyword = parse_command(arguments)
    book_list = @library.search_books_by_author(keyword)

    book_list_output(book_list)
  end

  private

  def parse_command(arguments)
    _, keyword = arguments.split('|')
    keyword
  end
end
