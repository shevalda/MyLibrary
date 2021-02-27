require './app/commands/library_command'

class SearchBookByTitleCommand < LibraryCommand
  def execute(arguments)
    check_command_length(arguments, 2)

    'Book not found!'
  end
end
