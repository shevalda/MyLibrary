require './app/commands/library_command'

class BuildLibraryCommand < LibraryCommand
  def execute(arguments)
    check_command_length(arguments, 4)

    params = parse_command(arguments)
    @library.build(params[:bookshelf_count], params[:row_size], params[:column_size])

    output_command(params)
  end

  private

  def parse_command(arguments)
    _, bookshelf_count, row_size, column_size = arguments.split('|')
    {
      bookshelf_count: Integer(bookshelf_count),
      row_size: Integer(row_size),
      column_size: Integer(column_size)
    }
  end

  def output_command(arguments)
    output = arguments[:bookshelf_count].times.map.with_index(1) do |_, bookshelf_position|
      "Shelf #{bookshelf_position} with #{arguments[:row_size]} rows and #{arguments[:column_size]} columns is added"
    end
    output.join("\n")
  end
end
