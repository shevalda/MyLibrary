require './app/commands/library_command'
require './app/models/book'

class PutBookCommand < LibraryCommand
  def execute(arguments)
    check_command_length(arguments, 4)

    params = parse_command(arguments)
    book = Book.new(params[:title], params[:author], params[:isbn])
    result = @library.put_book(book)

    output_command(result)
  end

  private

  def parse_command(arguments)
    _, isbn, title, author = arguments.split('|')
    { isbn: isbn, title: title, author: author }
  end

  def output_command(arguments)
    if arguments
      "Allocated address: #{position_string(arguments[:shelf], arguments[:row], arguments[:column])}"
    else
      'All bookshelves are full'
    end
  end
end
