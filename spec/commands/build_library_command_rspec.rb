require './app/commands/build_library_command'

RSpec.describe BuildLibraryCommand do
  let(:command) { described_class.new }

  it 'returns shelf information with valid shelf, row, and column params' do
    input = 'build_library|2|1|3'
    expected_output = <<~TEXT.chomp
      Shelf 1 with 1 rows and 3 columns is added
      Shelf 2 with 1 rows and 3 columns is added
    TEXT
    expect(command.execute(input)).to eq(expected_output)
  end

  it 'raises an error with invalid param' do
    input = 'build_library|0|1|3'
    expected_output = 'Invalid number of bookhelves'
    expect { command.execute(input) }.to raise_error(expected_output)
  end

  it 'raises an error warning when arguements count is not 4' do
    input = 'build_library|2|1'
    expected_output = 'Expected 4 arguments, given 3'
    expect { command.execute(input) }.to raise_error(expected_output)
  end
end
