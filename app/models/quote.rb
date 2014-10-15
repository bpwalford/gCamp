class Quote

  # attr_accessor :quote, :author

  def initialize(quote, author)
    @quote = quote
    @author = author
  end

  def getQuote
    @quote
  end

  def getAuthor
    @author
  end

end
