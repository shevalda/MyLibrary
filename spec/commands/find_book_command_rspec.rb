require './app/commands/find_book_command'
require './app/models/library'

RSpec.describe FindBookCommand do
  before do
    Library.instance.build(2, 1, 3)
    @command = described_class.new
  end

  it "returns the book's location when it is present" do
    allow_any_instance_of(Library).to receive(:find_book).and_return({ shelf: 1, row: 1, column: 1 })
    input = 'find_book|9780807281918'
    expected_output = 'Found the book at 010101'
    expect(@command.execute(input)).to eq(expected_output)
  end

  it "returns the book's location when it is present" do
    allow_any_instance_of(Library).to receive(:find_book).and_return(nil)
    input = 'find_book|9780807281918'
    expected_output = 'Book not found!'
    expect(@command.execute(input)).to eq(expected_output)
  end

  it 'raises an error when arguments count is not 2' do
    input = 'find_book'
    expected_output = 'Expected 2 arguments, given 1'
    expect { @command.execute(input) }.to raise_error(expected_output)
  end
end
