require './app/controller'

RSpec.describe Controller do
  context '#execute' do
    let(:controller) { Controller.new }

    context 'no library is built yet' do
      it "returns the warning when not executing command 'build_library'" do
        input = 'put_book|9780747532743|Harry Potter 1|J. K. Rowling'
        expected_output = 'Library is not built yet'
        expect(controller.execute(input)).to eq(expected_output)
      end
    end

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

    context "with 'put_book' command" do
      before do
        @controller = described_class.new
        @controller.execute('build_library|2|1|3')
      end

      it "returns the book's location information" do
        input = 'put_book|9780747532743|Harry Potter 1|J. K. Rowling'
        expected_output = 'Allocated address: 010101'
        expect(@controller.execute(input)).to eq(expected_output)
      end
    end
  end
end
