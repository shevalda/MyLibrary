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
end
