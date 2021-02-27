require './app/commands/take_book_from_command'
require './app/models/library'

RSpec.describe TakeBookFromCommand do
  let(:book) { double }

  before do
    Library.instance.build(2, 1, 3)
    @command = described_class.new
  end

  it 'returns the free position from a previously filled postion' do
    allow_any_instance_of(Library).to receive(:take_book_from).and_return(book)
    input = 'take_book_from|020102'
    expected_output = 'Slot 020102 is free'
    expect(@command.execute(input)).to eq(expected_output)
  end

  it 'returns warning if position is invalid' do
    allow_any_instance_of(Library).to receive(:take_book_from).and_return(false)
    input = 'take_book_from|020102'
    expected_output = 'Book cannot be taken'
    expect(@command.execute(input)).to eq(expected_output)
  end

  it 'raise an error if arguments count is not 2' do
    input = 'take_book_from'
    expected_output = 'Expected 2 arguments, given 1'
    expect { @command.execute(input) }.to raise_error(expected_output)
  end
end
