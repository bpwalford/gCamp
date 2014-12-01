class PagesController < PublicController

  def index

    columnOne = HomepageColumn.new('tasksImage.jpg', 'Tasks', ['Grouped by projects and lists. Just the way you like \'em'])
    columnTwo = HomepageColumn.new('documentsImage.jpg', 'Documents', ['Upload', 'Comment', 'Revise'])
    columnThree = HomepageColumn.new('commentsImage.jpg', 'Comments', ['Comment on tasks and documents', 'Get email notifications', ])

    @panel_elements = [
      [
        columnOne.getImage,
        columnOne.getTitle,
        columnOne.getContent,
      ],
      [
        columnTwo.getImage,
        columnTwo.getTitle,
        columnTwo.getContent,
      ],
      [
        columnThree.getImage,
        columnThree.getTitle,
        columnThree.getContent,
      ],
    ]

    arnoldQuote = Quote.new(quote: "\"Failure is not an option. Everyon has to Succeed\"",author:"- Arnold Schwarzenegger")
    steveQuote = Quote.new(quote:"\"Your time is limited, so don't waste it living someone else's life.\"",author:"- Steve Jobs")
    papaQuote = Quote.new(quote:"\"Better Ingredients, Better Pizza\"",author:"- Papa John")

    @quotes = [
      [
      arnoldQuote.quote,
      arnoldQuote.author,
      ],

      [
      steveQuote.quote,
      steveQuote.author,
      ],

      [
      papaQuote.quote,
      papaQuote.author,
      ],
    ]

  end

end
