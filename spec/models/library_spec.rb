require './app/models/library'

RSpec.describe Library do
  let(:book) { double }

  before(:all) { @library = described_class.instance }

  context 'when library is not built yet' do
    let(:error_message) { 'Library not build yet' }

    it 'raises an error when calling put_book' do
      expect { @library.put_book(book) }.to raise_error(error_message)
    end

    it 'raises an error when calling take_book_from' do
      expect { @library.take_book_from(1, 1, 1) }.to raise_error(error_message)
    end

    it 'raises an error when calling find_book' do
      expect { @library.find_book(book) }.to raise_error(error_message)
    end

    it 'raises an error when calling list_books' do
      expect { @library.list_books }.to raise_error(error_message)
    end

    it 'raises an error when calling search_books_by_title' do
      expect { @library.search_books_by_title('title') }.to raise_error(error_message)
    end

    it 'raises an error when calling search_books_by_author' do
      expect { @library.search_books_by_author('author') }.to raise_error(error_message)
    end
  end

  context '#build' do
    it 'raises an error is number of row is invalid' do
      expect { @library.build(2, 0, 3) }.to raise_error('Invalid row number')
    end

    it 'raises an error is number of column is invalid' do
      expect { @library.build(2, 1, 0) }.to raise_error('Invalid column number')
    end

    context 'with invalid number of bookshelves' do
      it 'raises an Error if number of bookshelves is zero' do
        expect { @library.build(0, 1, 3) }.to raise_error('Invalid number of bookhelves')
      end

      it 'raises an Error if number of bookshelves is negative' do
        expect { @library.build(-1, 1, 3) }.to raise_error('Invalid number of bookhelves')
      end
    end

    context 'with input 2 bookshelves of 1 row and 3 columns' do
      before { @library.build(2, 1, 3) }

      it 'returns Library with 2 bookshelves of 1 row and 3 columns' do
        expect(@library.bookshelves.length).to eq(2)
        expect(@library.bookshelves[0].rows_size).to eq(1)
        expect(@library.bookshelves[0].columns_size).to eq(3)
      end
    end
  end

  context '#put_book' do
    before { @library.build(2, 1, 3) }

    context 'with empty bookshelves' do
      it 'returns book location on the first avaiable space on first shelf' do
        result = @library.put_book(book)
        expect(result).to eq({ shelf: 1, row: 1, column: 1 })
      end
    end

    context 'with some unavailable spaces on the first bookshelf' do
      it 'returns book location of the first available space' do
        allow_any_instance_of(Bookshelf).to receive(:put_book).and_return({ row: 2, column: 2 })
        result = @library.put_book(book)
        expect(result).to eq({ shelf: 1, row: 2, column: 2 })
      end
    end

    context 'when some bookshelves already full' do
      before do
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
        result = @library.put_book(book)
        expect(result).to eq(false)
      end
    end
  end

  context '#take_book_from' do
    before { @library.build(2, 1, 3) }

    it 'returns Book when the selected positon has a book' do
      allow_any_instance_of(Bookshelf).to receive(:take_book_from).and_return(book)
      result = @library.take_book_from(1, 1, 1)
      expect(result).to eq(book)
    end

    context 'with invalid position' do
      it 'raises ArgumentError if shelf position is less than 1' do
        expect { @library.take_book_from(0, 1, 1) }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError if shelf position is larger than the number of shelves' do
        expect { @library.take_book_from(3, 1, 1) }.to raise_error(ArgumentError)
      end

      it 'returns false if row position is invalid' do
        expect(@library.take_book_from(1, 5, 1)).to be(false)
      end

      it 'returns false if column position is invalid' do
        expect(@library.take_book_from(1, 1, 5)).to be(false)
      end
    end
  end

  context '#find_book' do
    before { @library.build(2, 1, 3) }

    it 'returns shelf, row, and, column position if the book is found' do
      allow_any_instance_of(Bookshelf).to receive(:find_book).and_return({ row: 1, column: 1 })
      result = @library.find_book('1234567890')
      expect(result).to eq({ shelf: 1, row: 1, column: 1 })
    end

    it 'returns nil if the book is not found' do
      allow_any_instance_of(Bookshelf).to receive(:find_book).and_return(nil)
      result = @library.find_book('1234567890')
      expect(result).to be_nil
    end
  end

  context '#list_books' do
    before { @library.build(2, 1, 1) }

    it 'returns [] when all bookshelves are empty' do
      expect(@library.list_books).to eq([])
    end

    context 'when there are books on the bookshelves' do
      before do
        allow_any_instance_of(Bookshelf).to(receive(:list_books).and_return([{ row: 1, column: 1, book: book }]))
      end

      it 'returns list of books and their shelf, row, and column position' do
        expected_output = [
          { shelf: 1, list_books: [{ row: 1, column: 1, book: book }] },
          { shelf: 2, list_books: [{ row: 1, column: 1, book: book }] }
        ]
        expect(@library.list_books).to eq(expected_output)
      end
    end
  end

  context '#search_books_by_title' do
    before { @library.build(2, 1, 1) }

    it 'returns [] if no book is found with the title keyword' do
      result = @library.search_books_by_title('title')
      expect(result).to eq([])
    end

    context 'when there are books that matches with the title' do
      before do
        @library.build(2, 1, 1)
        allow_any_instance_of(Bookshelf).to(
          receive(:search_books_by_title).and_return([{ row: 1, column: 1, book: book }])
        )
      end

      it 'returns list of books and their shelf, row, and column position' do
        expected_output = [
          { shelf: 1, list_books: [{ row: 1, column: 1, book: book }] },
          { shelf: 2, list_books: [{ row: 1, column: 1, book: book }] }
        ]
        expect(@library.search_books_by_title('title')).to eq(expected_output)
      end
    end
  end

  context '#search_books_by_author' do
    before { @library.build(2, 1, 1) }

    it 'returns [] if no book is found with the author keyword' do
      result = @library.search_books_by_author('author')
      expect(result).to eq([])
    end

    context 'when there are books that matches with the title' do
      before do
        @library.build(2, 1, 1)
        allow_any_instance_of(Bookshelf).to(
          receive(:search_books_by_author).and_return([{ row: 1, column: 1, book: book }])
        )
      end

      it 'returns list of books and their shelf, row, and column position' do
        expected_output = [
          { shelf: 1, list_books: [{ row: 1, column: 1, book: book }] },
          { shelf: 2, list_books: [{ row: 1, column: 1, book: book }] }
        ]
        expect(@library.search_books_by_author('title')).to eq(expected_output)
      end
    end
  end
end
