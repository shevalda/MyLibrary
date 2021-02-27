require './app/commands/library_command'

class ListBooksCommand < LibraryCommand
  def execute(_arguments)
    book_list = @library.list_books

    output_command(book_list)
  end

  private

  def output_command(book_list)
    return 'Library is empty' if book_list.empty?

    book_list_output(book_list)
  end
end
