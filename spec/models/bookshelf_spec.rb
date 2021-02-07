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
        expect(result).to eq([1, 1])
      end
    end

    context 'with one book in the bookshelf' do
      before do
        @bookshelf = described_class.new(1, 2)
        @bookshelf.put_book(@book)
      end

      it 'returns [1, 2] when put another book' do
        result = @bookshelf.put_book(@book)
        expect(result).to eq([1, 2])
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
        expect(result).to eq([2, 1])
      end

      it 'returns [1, 2] when the last book put in bookshelf is taken' do
        @bookshelf.take_book_from(1, 2)
        result = @bookshelf.put_book(@book)
        expect(result).to eq([1, 2])
      end

      it 'returns [1, 1] when the first book put in bookshelf is taken' do
        @bookshelf.take_book_from(1, 1)
        result = @bookshelf.put_book(@book)
        expect(result).to eq([1, 1])
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
          expect(result).to eq([1, 1])
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
          expect(result).to eq([2, 1])
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

    context 'with only one book in bookshelf' do
      before do
        @bookshelf = described_class.new(1, 1)
        @bookshelf.put_book(@book)
      end

      it 'returns the book in row 1, column 1 when it is taken' do
        result = @bookshelf.take_book_from(1, 1)
        expect(result).to eq(@book)
      end

      it 'no book is placed in row 1, column 1 when it was taken' do
        @bookshelf.take_book_from(1, 1)
        rows = @bookshelf.instance_variable_get :@rows
        expect(rows[0][0]).to eq(nil)
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
end
