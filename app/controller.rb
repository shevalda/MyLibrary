require './app/command_parser'
require './app/output_utility'
require './app/models/library'
require './app/models/book'

class Controller
  include CommandParser
  include OutputUtility

  def initialize
    @library = nil
  end

  def execute(input)
    command = parse_command(input)

    if command == 'build_library'
      build_library(input)
    elsif @library.nil?
      return 'Library is not built yet' if @library.nil?
    else
      case command
      when 'put_book'
        put_book(input)
      end
    end
  end

  private

  def build_library(input)
    check_command_length(input, 4)

    params = parse_build_library_command(input)
    @library = Library.new(params[:bookshelf_count], params[:row_size], params[:column_size])

    build_library_output(params[:bookshelf_count], params[:row_size], params[:column_size])
  rescue StandardError => e
    e.message
  end

  def put_book(input)
    check_command_length(input, 4)

    params = parse_put_book_command(input)
    book = Book.new(params[:title], params[:author], params[:isbn])
    result = @library.put_book(book)

    if result
      put_book_output(result[:shelf], result[:row], result[:column])
    else
      'All bookshelves are full'
    end
  rescue StandardError => e
    e.message
  end
end
