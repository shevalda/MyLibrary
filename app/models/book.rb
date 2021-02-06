class Book
  attr_reader :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def title_include?(keyword)
    @title.include?(keyword)
  end
end
