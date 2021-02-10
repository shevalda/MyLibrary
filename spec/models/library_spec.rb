require './app/models/library'

RSpec.describe Library do
  context '#initialize' do
    context 'with input 2 bookshelves of 1 row and 3 columns' do
      it 'returns Library with 2 bookshelves of 1 row and 3 columns' do
        library = described_class.new(2, 1, 3)
        expect(library.bookshelves.length).to eq(2)
        expect(library.bookshelves[0].rows_size).to eq(1)
        expect(library.bookshelves[0].columns_size).to eq(3)
      end
    end
  end
end
