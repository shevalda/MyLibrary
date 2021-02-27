require './app/commands/find_book_command'
require './app/models/library'

RSpec.describe FindBookCommand do
  let(:book) { double(title: 'Title', author: 'Author', isbn: '1234567890') }

  before do
    Library.instance.build(2, 1, 3)
    @command = described_class.new
  end

  it 'raises an error when arguments count is not 2' do
    input = 'search_books_by_title'
    expected_output = 'Expected 2 arguments, given 1'
    expect { @command.execute(input) }.to raise_error(expected_output)
  end

  it 'returns warning if no book matches the keyword' do
    allow_any_instance_of(Library).to receive(:search_books_by_title).and_return([])
    input = 'search_books_by_title|judul'
    expected_output = 'Book not found!'
    expect(@command.execute(input)).to eq(expected_output)
  end
end
