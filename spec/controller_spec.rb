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

      it 'returns warning when arguements count is not 4' do
        input = 'build_library|2|1'
        expected_output = 'Expected 4 arguments, given 3'
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

      it 'returns warning if all bookshelves are full' do
        allow_any_instance_of(Library).to receive(:put_book).and_return(false)
        input = 'put_book|9780747532743|Harry Potter 1|J. K. Rowling'
        expected_output = 'All bookshelves are full'
        expect(@controller.execute(input)).to eq(expected_output)
      end

      it 'returns warning when arguements count is not 4' do
        input = 'put_book|9780747532743|Harry Potter 1'
        expected_output = 'Expected 4 arguments, given 3'
        expect(@controller.execute(input)).to eq(expected_output)
      end
    end

    context "with 'take_book_from' command" do
      let(:book) { double }

      before do
        @controller = described_class.new
        @controller.execute('build_library|2|1|3')
      end

      it 'returns the free position from a previously filled postion' do
        allow_any_instance_of(Library).to receive(:take_book_from).and_return(book)
        input = 'take_book_from|020102'
        expected_output = 'Slot 020102 is free'
        expect(@controller.execute(input)).to eq(expected_output)
      end

      it 'returns warning if position is invalid' do
        allow_any_instance_of(Library).to receive(:take_book_from).and_return(false)
        input = 'take_book_from|020102'
        expected_output = 'Book cannot be taken'
        expect(@controller.execute(input)).to eq(expected_output)
      end
    end
  end
end
