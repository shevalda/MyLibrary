require './app/models/library'

RSpec.describe Library do
  context '#initialize' do
    it 'raises an Error if number of bookshelves is zero' do
      expect { described_class.new(0, 1, 3) }.to raise_error('Invalid number of bookhelves')
    end

    context 'with input 2 bookshelves of 1 row and 3 columns' do
      it 'returns Library with 2 bookshelves of 1 row and 3 columns' do
        library = described_class.new(2, 1, 3)
        expect(library.bookshelves.length).to eq(2)
        expect(library.bookshelves[0].rows_size).to eq(1)
        expect(library.bookshelves[0].columns_size).to eq(3)
      end

      it "prints 'Shelf N with 1 rows and 3 columns is added' twice" do
        expected_output = <<~TEXT
          Shelf 1 with 1 rows and 3 columns is added
          Shelf 2 with 1 rows and 3 columns is added
        TEXT
        expect { described_class.new(2, 1, 3) }.to output(expected_output).to_stdout
      end
    end
  end
end
