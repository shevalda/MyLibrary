require './app/models/book'
require './app/models/bookshelf'

RSpec.describe Bookshelf do
  context '#initialize' do
    context 'with input row = 2 and col = 3' do
      it 'returns Bookshelf with 2 rows and 3 columns' do
        input_row = 2
        input_col = 3
        bookshelf = described_class.new(input_row, input_col)
        expect(bookshelf.rows_size).to eq(input_row)
        expect(bookshelf.columns_size).to eq(input_col)
      end
    end

    it 'raises an Error if input row is 0' do
      input_row = 0
      input_col = 3
      expect { described_class.new(input_row, input_col) }.to raise_error('Invalid row number')
    end

    it 'raises an Error if input row is -1' do
      input_row = -1
      input_col = 3
      expect { described_class.new(input_row, input_col) }.to raise_error('Invalid row number')
    end

    it 'raises an Error if input row is 0' do
      input_row = 1
      input_col = 0
      expect { described_class.new(input_row, input_col) }.to raise_error('Invalid column number')
    end

    it 'raises an Error if input row is -1' do
      input_row = 1
      input_col = -1
      expect { described_class.new(input_row, input_col) }.to raise_error('Invalid column number')
    end
  end

  context '#put_book' do
    before do
      @book = Book.new('title', 'author', '123456789')
    end

    context 'with empty bookshelf' do
      it 'returns [1, 1] when put a book' do
        bookshelf = described_class.new(1, 1)
        result = bookshelf.put_book(@book)
        expect(result).to eq({ row: 1, column: 1 })
      end
    end

    context 'with one book in the bookshelf' do
      before do
        @bookshelf = described_class.new(1, 2)
        @bookshelf.put_book(@book)
      end

      it 'returns [1, 2] when put another book' do
        result = @bookshelf.put_book(@book)
        expect(result).to eq({ row: 1, column: 2 })
      end
    end

    context 'with first row is full' do
      before do
        @bookshelf = described_class.new(2, 2)
        2.times do
          @bookshelf.put_book(@book)
        end
      end

      it 'returns [2, 1] when put another book' do
        result = @bookshelf.put_book(@book)
        expect(result).to eq({ row: 2, column: 1 })
      end

      it 'returns [1, 2] when the last book put in bookshelf is taken' do
        @bookshelf.take_book_from(1, 2)
        result = @bookshelf.put_book(@book)
        expect(result).to eq({ row: 1, column: 2 })
      end

      it 'returns [1, 1] when the first book put in bookshelf is taken' do
        @bookshelf.take_book_from(1, 1)
        result = @bookshelf.put_book(@book)
        expect(result).to eq({ row: 1, column: 1 })
      end
    end

    context 'with some rows full' do
      before do
        @bookshelf = described_class.new(3, 2)
        5.times do
          @bookshelf.put_book(@book)
        end
      end

      context 'when some books are taken with no order' do
        it 'returns [1, 1] when taken books includes row 1, column 1' do
          @bookshelf.take_book_from(2, 1)
          @bookshelf.take_book_from(1, 1)
          @bookshelf.take_book_from(2, 2)
          result = @bookshelf.put_book(@book)
          expect(result).to eq({ row: 1, column: 1 })
        end
      end

      context 'and books from the last rows are taken' do
        before do
          @bookshelf.take_book_from(3, 1)
        end

        it 'returns [2, 1] when the last two book from the last full row is taken' do
          @bookshelf.take_book_from(2, 2)
          @bookshelf.take_book_from(2, 1)
          result = @bookshelf.put_book(@book)
          expect(result).to eq({ row: 2, column: 1 })
        end
      end
    end

    context 'with all rows full' do
      before do
        @bookshelf = described_class.new(1, 1)
        @bookshelf.put_book(@book)
      end

      it 'returns false when put another book' do
        result = @bookshelf.put_book(@book)
        expect(result).to eq(false)
      end
    end
  end

  context '#take_book_from' do
    before do
      @book = Book.new('title', 'author', '123456789')
      @book_two = Book.new('title 2', 'author name', '123456789')
    end

    it 'returns nil if no book is placed at the selected location' do
      @bookshelf = described_class.new(1, 1)
      result = @bookshelf.take_book_from(1, 1)
      expect(result).to be_nil
    end

    context 'with invalid selected location' do
      it "returns false if the selected row is larger than shelf's row size" do
        @bookshelf = described_class.new(1, 1)
        result = @bookshelf.take_book_from(2, 1)
        expect(result).to eq(false)
      end

      it 'returns false if the selected row is less than 1' do
        @bookshelf = described_class.new(1, 1)
        result = @bookshelf.take_book_from(0, 1)
        expect(result).to eq(false)
      end

      it "returns false if the selected column is larger than shelf's column size" do
        @bookshelf = described_class.new(1, 1)
        result = @bookshelf.take_book_from(1, 2)
        expect(result).to eq(false)
      end

      it 'returns false if the selected column is less than 1' do
        @bookshelf = described_class.new(1, 1)
        result = @bookshelf.take_book_from(1, 0)
        expect(result).to eq(false)
      end
    end

    context 'with only one book in bookshelf' do
      before do
        @bookshelf = described_class.new(1, 1)
        @bookshelf.put_book(@book)
      end

      it 'returns the book in row 1, column 1 when it is taken' do
        result = @bookshelf.take_book_from(1, 1)
        expect(result).to eq(@book)
      end
    end

    context 'with two books in bookshelf' do
      before do
        @bookshelf = described_class.new(1, 2)
        @bookshelf.put_book(@book)
        @bookshelf.put_book(@book_two)
      end

      it 'returns the book in row 1, column 1 when it is taken' do
        result = @bookshelf.take_book_from(1, 1)
        expect(result).to eq(@book)
      end
    end
  end

  context '#find_book' do
    before do
      @book = Book.new('title', 'author', '123456789')
      @bookshelf = described_class.new(2, 1)
      @bookshelf.put_book(@book)
    end

    it 'returns [1, 1] for book with ISBN 123456789' do
      result = @bookshelf.find_book('123456789')
      expect(result).to eq({ row: 1, column: 1 })
    end

    it 'returns nil for a book that is not present in Bookshelf' do
      result = @bookshelf.find_book('1')
      expect(result).to be_nil
    end

    context 'more than one book with ISBN 123456789' do
      before do
        @bookshelf.put_book(@book)
      end

      it 'returns [1, 1] for book with ISBN 123456789' do
        result = @bookshelf.find_book('123456789')
        expect(result).to eq({ row: 1, column: 1 })
      end
    end
  end

  context '#list_books' do
    before do
      @bookshelf = described_class.new(1, 1)
      @book = Book.new('title', 'author', '123456789')
    end

    it 'returns [] if no book is present' do
      result = @bookshelf.list_books
      expect(result).to eq([])
    end

    it 'returns list of [row, column, book] when there is at least one book' do
      @bookshelf.put_book(@book)
      result = @bookshelf.list_books
      expect(result).to eq([{ row: 1, column: 1, book: @book }])
    end
  end

  context '#search_books_by_title' do
    before do
      @bookshelf = described_class.new(1, 1)
      @book = Book.new('title', 'author', '123456789')
    end

    it 'returns [] if no book in Bookshelf match the keyword' do
      result = @bookshelf.search_books_by_title('judul')
      expect(result).to eq([])
    end

    it 'returns list of [row, column, book] if there is at least one book title matches' do
      @bookshelf.put_book(@book)
      result = @bookshelf.search_books_by_title('ti')
      expect(result).to eq([[1, 1, @book]])
    end
  end

  context '#search_books_by_author' do
    before do
      @bookshelf = described_class.new(1, 1)
      @book = Book.new('title', 'author', '123456789')
    end

    it 'returns [] if no book in Bookshelf match the keyword' do
      result = @bookshelf.search_books_by_author('penulis')
      expect(result).to eq([])
    end

    it 'returns list of [row, column, book] if there is at least one book author matches' do
      @bookshelf.put_book(@book)
      result = @bookshelf.search_books_by_author('thor')
      expect(result).to eq([[1, 1, @book]])
    end
  end
end
