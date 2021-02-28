require './app/commands/library_command'

class TakeBookFromCommand < LibraryCommand
  def execute(arguments)
    check_command_length(arguments, 2)

    params = parse_command(arguments)
    book = @library.take_book_from(params[:shelf], params[:row], params[:column])

    book ? output_command(params) : 'Book cannot be taken'
  end

  private

  def parse_command(arguments)
    _, position = arguments.split('|')
    {
      shelf: position[0..1].to_i,
      row: position[2..3].to_i,
      column: position[4..5].to_i
    }
  end

  def output_command(arguments)
    "Slot #{position_string(arguments[:shelf], arguments[:row], arguments[:column])} is free"
  end
end
