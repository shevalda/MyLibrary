require './app/controller'

RSpec.describe Controller do
  subject(:controller) { Controller.new }

  context '#execute' do
    context "with 'build_library' command" do
      it 'returns shelf information with valid shelf, row, and column params' do
        input = 'build_library|2|1|3'
        expected_output = <<~TEXT.chomp
          Shelf 1 with 1 rows and 3 columns is added
          Shelf 2 with 1 rows and 3 columns is added
        TEXT
        expect(controller.execute(input)).to eq(expected_output)
      end

      it 'returns error with invalid param' do
        input = 'build_library|0|1|3'
        expected_output = 'Invalid number of bookhelves'
        expect(controller.execute(input)).to eq(expected_output)
      end
    end
  end
end
