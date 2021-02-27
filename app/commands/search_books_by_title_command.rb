require './app/commands/library_command'

class SearchBooksByTitleCommand < LibraryCommand
  def execute(arguments)
    check_command_length(arguments, 2)

    keyword = parse_command(arguments)
    book_list = @library.search_books_by_title(keyword)

    output_command(book_list)
  end

  private

  def parse_command(arguments)
    _, keyword = arguments.split('|')
    keyword
  end

  def output_command(book_list)
    return 'Book not found!' if book_list.empty?

    output = []
    book_list.each do |shelf_info|
      shelf_info[:list_books].each do |book_info|
        output << <<~TEXT.split.join(' ')
          #{position_string(shelf_info[:shelf], book_info[:row], book_info[:column])}:
          #{book_info[:book].isbn} |
          #{book_info[:book].title} |
          #{book_info[:book].author}
        TEXT
      end
    end
    output.join("\n")
  end
end
