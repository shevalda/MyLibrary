require './app/models/book'

RSpec.describe Book do
  before do
    @title = "Harry Potter and the Sorcerer's Stone"
    @author = 'J. K. Rowling'
    @isbn = '9780747532743'
    @book = described_class.new(@title, @author, @isbn)
  end

  context '#initialize' do
    it 'returns Book with title, author, and isbn attributes' do
      expect(@book.title).to eq(@title)
      expect(@book.author).to eq(@author)
      expect(@book.isbn).to eq(@isbn)
    end
  end

  context '#title_include?' do
    context "with \"Harry Potter and the Sorcerer's Stone\" as the book's title" do
      it "returns true if title keyword is 'Harry'" do
        keyword = 'Harry'
        expect(@book.title_include?(keyword)).to eq(true)
      end

      it "returns true if title keyword is 'harry'" do
        keyword = 'harry'
        expect(@book.title_include?(keyword)).to eq(true)
      end

      it "returns false if title keyword is 'Hermione'" do
        keyword = 'Hermione'
        expect(@book.title_include?(keyword)).to eq(false)
      end
    end
  end

  context '#author_include?' do
    context "with \"J. K. Rowling\" as the book's author" do
      it "returns true if author keyword is 'Rowling'" do
        keyword = 'Rowling'
        expect(@book.author_include?(keyword)).to eq(true)
      end

      it "returns true if author keyword is 'rowling'" do
        keyword = 'rowling'
        expect(@book.author_include?(keyword)).to eq(true)
      end

      it "returns false if author keyword is 'Joanne'" do
        keyword = 'Joanne'
        expect(@book.author_include?(keyword)).to eq(false)
      end
    end
  end
end
