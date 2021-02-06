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
end
