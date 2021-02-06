require './app/models/book'
require './app/models/bookshelf'

RSpec.describe Bookshelf do
  context '#initialize' do
    context 'with input row = 2 and col = 3' do
      it 'returns Bookshelf with 2 rows and 3 columns' do
        input_row = 2
        input_col = 3
        bookshelf = described_class.new(input_row, input_col)
        expect(bookshelf.rows.length).to eq(input_row)
        expect(bookshelf.columns).to eq(input_col)
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
        @bookshelf = described_class.new(2, 1)
        @bookshelf.put_book(@book)
      end

      it 'returns [2, 1] when put another book' do
        result = @bookshelf.put_book(@book)
        expect(result).to eq([2, 1])
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
end
