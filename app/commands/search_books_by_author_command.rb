require './app/commands/library_command'

class SearchBooksByAuthorCommand < LibraryCommand
  def execute(arguments)
    check_command_length(arguments, 2)
  end
end
