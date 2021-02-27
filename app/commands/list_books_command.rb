require './app/commands/library_command'

class ListBooksCommand < LibraryCommand
  def execute(_arguments)
    book_list = @library.list_books

    output_command(book_list)
  end

  private

  def output_command(book_list)
    return 'Library is empty' if book_list.empty?

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
