require './app/commands/build_library_command'
require './app/commands/put_book_command'
require './app/commands/take_book_from_command'
require './app/commands/find_book_command'
require './app/commands/list_books_command'
require './app/commands/search_books_by_title_command'
require './app/commands/search_books_by_author_command'

class Controller
  @@commands = {
    'build_library' => BuildLibraryCommand.new,
    'put_book' => PutBookCommand.new,
    'take_book_from' => TakeBookFromCommand.new,
    'find_book' => FindBookCommand.new,
    'list_books' => ListBooksCommand.new,
    'search_books_by_title' => SearchBooksByTitleCommand.new,
    'search_books_by_author' => SearchBooksByAuthorCommand.new,
    'exit' => false
  }

  def self.execute(input)
    command_type = input.split('|').first
    command = @@commands[command_type]

    if command.nil?
      'Command not recognised'
    else
      command.execute(input)
    end
  rescue StandardError => e
    e.message
  end
end
