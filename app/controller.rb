require './app/command_parser'
require './app/models/library'

class Controller
  include CommandParser

  def execute(input)
    command = parse_command(input)

    case command
    when 'build_library'
      build_library(input)
    end
  end

  private

  def build_library(input)
    params = parse_build_library_command(input)

    @library = Library.new(params[:bookshelf_count], params[:row_size], params[:column_size])

    output = params[:bookshelf_count].times.map.with_index(1) do |_, bookshelf_position|
      "Shelf #{bookshelf_position} with #{params[:row_size]} rows and #{params[:column_size]} columns is added"
    end
    output.join("\n")
  rescue StandardError => e
    e.message
  end
end
