require './app/commands/put_book_command'
require './app/models/library'

RSpec.describe PutBookCommand do
  before do
    Library.instance.build(2, 1, 3)
    @command = described_class.new
  end

  it "returns the book's location information" do
    input = 'put_book|9780747532743|Harry Potter 1|J. K. Rowling'
    expected_output = 'Allocated address: 010101'
    expect(@command.execute(input)).to eq(expected_output)
  end

  it 'raise error if all bookshelves are full' do
    allow_any_instance_of(Library).to receive(:put_book).and_return(false)
    input = 'put_book|9780747532743|Harry Potter 1|J. K. Rowling'
    expected_output = 'All bookshelves are full'
    expect(@command.execute(input)).to eq(expected_output)
  end

  it 'raise error if arguments count is not 4' do
    input = 'put_book|9780747532743|Harry Potter 1'
    expected_output = 'Expected 4 arguments, given 3'
    expect { @command.execute(input) }.to raise_error(expected_output)
  end
end
