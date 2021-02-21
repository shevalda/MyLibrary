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
      when 'take_book_from'
        take_book_from(input)
      end
    end
  rescue StandardError => e
    e.message
  end

  private

  def build_library(input)
    check_command_length(input, 4)

    params = parse_build_library_command(input)
    @library = Library.new(params[:bookshelf_count], params[:row_size], params[:column_size])

    build_library_output(params[:bookshelf_count], params[:row_size], params[:column_size])
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
  end

  def take_book_from(input)
    check_command_length(input, 2)

    params = parse_take_book_from(input)
    book = @library.take_book_from(params[:shelf], params[:row], params[:column])

    if book
      take_book_from_output(params[:original_position])
    else
      'Book cannot be taken'
    end
  end
end
