require './app/models/book'

RSpec.describe Book do
  let(:title) { "Harry Potter and the Sorcerer's Stone" }
  let(:author) { 'J. K. Rowling' }
  let(:isbn) { '9780747532743' }

  context '#initialize' do
    it 'returns Book with title, author, and isbn attributes' do
      book = described_class.new(title, author, isbn)
      expect(book.title).to eq(title)
      expect(book.author).to eq(author)
      expect(book.isbn).to eq(isbn)
    end
  end

  context '#title_include?' do
    context "with \"Harry Potter and the Sorcerer's Stone\" as the book's title" do
      it "returns true if title keyword is 'Harry'" do
        book = described_class.new(title, author, isbn)
        keyword = 'Harry'
        expect(book.title_include?(keyword)).to eq(true)
      end

      it "returns true if title keyword is 'harry'" do
        book = described_class.new(title, author, isbn)
        keyword = 'harry'
        expect(book.title_include?(keyword)).to eq(true)
      end
    end
  end
end
