class Book
  attr_reader :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def title_include?(keyword)
    @title.downcase.include?(keyword.downcase)
  end

  def author_include?(keyword)
    @author.downcase.include?(keyword.downcase)
  end

  def info
    "#{@isbn} | #{@title} | #{@author}"
  end
end
