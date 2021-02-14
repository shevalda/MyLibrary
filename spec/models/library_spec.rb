require './app/models/library'

RSpec.describe Library do
  let(:book) { double }
  let(:library) { described_class.new(2, 1, 3) }

  context '#initialize' do
    it 'raises an error is number of row is invalid' do
      expect { described_class.new(2, 0, 3) }.to raise_error('Invalid row number')
    end

    it 'raises an error is number of column is invalid' do
      expect { described_class.new(2, 1, 0) }.to raise_error('Invalid column number')
    end

    context 'with invalid number of bookshelves' do
      it 'raises an Error if number of bookshelves is zero' do
        expect { described_class.new(0, 1, 3) }.to raise_error('Invalid number of bookhelves')
      end

      it 'raises an Error if number of bookshelves is negative' do
        expect { described_class.new(-1, 1, 3) }.to raise_error('Invalid number of bookhelves')
      end
    end

    context 'with input 2 bookshelves of 1 row and 3 columns' do
      it 'returns Library with 2 bookshelves of 1 row and 3 columns' do
        expect(library.bookshelves.length).to eq(2)
        expect(library.bookshelves[0].rows_size).to eq(1)
        expect(library.bookshelves[0].columns_size).to eq(3)
      end

      it "prints 'Shelf N with 1 rows and 3 columns is added' twice" do
        expected_output = <<~TEXT
          Shelf 1 with 1 rows and 3 columns is added
          Shelf 2 with 1 rows and 3 columns is added
        TEXT
        expect { library }.to output(expected_output).to_stdout
      end
    end
  end

  context '#put_book' do
    context 'with empty bookshelves' do
      it 'returns book location on the first avaiable space on first shelf' do
        result = library.put_book(book)
        expect(result).to eq({ shelf: 1, row: 1, column: 1 })
      end
    end

    context 'with some unavailable spaces on the first bookshelf' do
      it 'returns book location of the first available space' do
        allow_any_instance_of(Bookshelf).to receive(:put_book).and_return({ row: 2, column: 2 })
        result = library.put_book(book)
        expect(result).to eq({ shelf: 1, row: 2, column: 2 })
      end
    end

    context 'when some bookshelves already full' do
      before do
        @library = described_class.new(2, 1, 3)
        3.times do
          @library.put_book(book)
        end
      end

      it 'return book location of the next bookshelf with available space' do
        result = @library.put_book(book)
        expect(result).to eq({ shelf: 2, row: 1, column: 1 })
      end
    end

    context 'when all bookshelves are full' do
      it 'returns false' do
        allow_any_instance_of(Bookshelf).to receive(:put_book).and_return(false)
        result = library.put_book(book)
        expect(result).to eq(false)
      end
    end
  end

  context '#take_book_from' do
    it 'returns Book when the selected positon has a book' do
      allow_any_instance_of(Bookshelf).to receive(:take_book_from).and_return(book)
      result = library.take_book_from(1, 1, 1)
      expect(result).to eq(book)
    end

    context 'with invalid position' do
      it 'raises ArgumentError if shelf position is less than 1' do
        expect { library.take_book_from(0, 1, 1) }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError if shelf position is larger than the number of shelves' do
        expect { library.take_book_from(3, 1, 1) }.to raise_error(ArgumentError)
      end

      it 'returns false if row position is invalid' do
        expect(library.take_book_from(1, 5, 1)).to be(false)
      end
    end
  end
end
