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
  end
end
