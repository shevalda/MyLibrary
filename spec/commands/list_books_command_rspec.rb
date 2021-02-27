require './app/commands/list_books_command'
require './app/models/library'

RSpec.describe ListBooksCommand do
  let(:book) { double(title: 'Title', author: 'Author', isbn: '1234567890') }

  before do
    Library.instance.build(2, 1, 1)
    @command = described_class.new
  end

  it 'returns all books available in the library' do
    list_books = [
      { shelf: 1, list_books: [{ row: 1, column: 1, book: book }] },
      { shelf: 2, list_books: [{ row: 1, column: 1, book: book }] }
    ]
    allow_any_instance_of(Library).to receive(:list_books).and_return(list_books)

    expected_output = <<~TEXT.chomp
      010101: 1234567890 | Title | Author
      020101: 1234567890 | Title | Author
    TEXT
    expect(@command.execute('list_books')).to eq(expected_output)
  end

  it 'returns warning when the library is empty' do
    allow_any_instance_of(Library).to receive(:list_books).and_return([])
    expected_output = 'Library is empty'
    expect(@command.execute('list_books')).to eq(expected_output)
  end
end
