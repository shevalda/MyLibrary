require './app/controller'

RSpec.describe Controller do
  context '#execute' do
    let(:controller) { Controller.new }
    let(:book) { double(title: 'Title', author: 'Author', isbn: '1234567890') }

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

      it 'returns warning if arguments count is not 2' do
        input = 'take_book_from'
        expected_output = 'Expected 2 arguments, given 1'
        expect(@controller.execute(input)).to eq(expected_output)
      end
    end

    context "with 'find_book' command" do
      before do
        @controller = described_class.new
        @controller.execute('build_library|2|1|3')
      end

      it "returns the book's location when it is present" do
        allow_any_instance_of(Library).to receive(:find_book).and_return({ shelf: 1, row: 1, column: 1 })
        input = 'find_book|9780807281918'
        expected_output = 'Found the book at 010101'
        expect(@controller.execute(input)).to eq(expected_output)
      end

      it "returns the book's location when it is present" do
        allow_any_instance_of(Library).to receive(:find_book).and_return(nil)
        input = 'find_book|9780807281918'
        expected_output = 'Book not found!'
        expect(@controller.execute(input)).to eq(expected_output)
      end

      it 'returns warning when arguments count is not 2' do
        input = 'find_book'
        expected_output = 'Expected 2 arguments, given 1'
        expect(@controller.execute(input)).to eq(expected_output)
      end
    end

    context "with 'list_books' command" do
      before do
        @controller = described_class.new
        @controller.execute('build_library|2|1|1')
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
        expect(@controller.execute('list_books')).to eq(expected_output)
      end

      it 'returns warning when the library is empty' do
        allow_any_instance_of(Library).to receive(:list_books).and_return([])
        expected_output = 'Library is empty'
        expect(@controller.execute('list_books')).to eq(expected_output)
      end
    end
  end
end
