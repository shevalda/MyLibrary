require './app/controller'

RSpec.describe Controller do
  context '#execute' do
    context 'no library is built yet' do
      it "returns the warning when not executing command 'build_library'" do
        input = 'put_book|9780747532743|Harry Potter 1|J. K. Rowling'
        expected_output = 'Library not build yet'
        expect(described_class.execute(input)).to eq(expected_output)
      end
    end

    context 'with invalid command type' do
      it "returns 'Command not recognised'" do
        input = 'random_command'
        expect(described_class.execute(input)).to eq('Command not recognised')
      end
    end

    context 'with valid command type' do
      it "recognises 'build_library' command" do
        input = 'build_library|1|1|1'
        expect(described_class.execute(input)).not_to eq('Command not recognised')
      end

      it "recognises 'put_book' command" do
        input = 'put_book|9780747532743|Harry Potter 1|J. K. Rowling'
        expect(described_class.execute(input)).not_to eq('Command not recognised')
      end

      it "recognises 'take_book_from' command" do
        input = 'take_book_from|020102'
        expect(described_class.execute(input)).not_to eq('Command not recognised')
      end

      it "recognises 'find_book' command" do
        input = 'find_book|020102'
        expect(described_class.execute(input)).not_to eq('Command not recognised')
      end

      it "recognises 'list_books' command" do
        input = 'list_books'
        expect(described_class.execute(input)).not_to eq('Command not recognised')
      end

      it "recognises 'search_books_by_title' command" do
        input = 'search_books_by_title|title'
        expect(described_class.execute(input)).not_to eq('Command not recognised')
      end

      it "recognises 'search_books_by_author' command" do
        input = 'search_books_by_author|author'
        expect(described_class.execute(input)).not_to eq('Command not recognised')
      end

      it "recognises 'exit' command" do
        input = 'exit'
        expect(described_class.execute(input)).not_to eq('Command not recognised')
      end

      it "returns false with 'exit' command" do
        input = 'exit'
        expect(described_class.execute(input)).to be(false)
      end
    end
  end
end
