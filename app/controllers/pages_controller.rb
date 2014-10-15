class PagesController < ApplicationController

  def index

    # @panel_elements = [
    #
    #   {
    #     image: 'tasksImage.jpg',
    #     title: 'Tasks',
    #     content: ['Grouped by projects and lists. Just the way you like \'em'],
    #   },
    #
    #   {
    #     image: 'documentsImage.jpg',
    #     title: 'Documents',
    #     content: ['Upload', 'Comment', 'Revise']
    #   },
    #
    #   {
    #     image: 'commentsImage.jpg',
    #     title: 'Comments',
    #     content: ['Comment on tasks and documents', 'Get email notifications', ]
    #   }
    #
    # ]

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

    # @quotes = [
    #   [
    #   "\"Failure is not an option. Everyon has to Succeed\"",
    #   "- Arnold Schwarzenegger",
    #   ],
    #
    #   [
    #   "\"Your time is limited, so don't waste it living someone else's life.\"",
    #   "- Steve Jobs",
    #   ],
    #
    #   [
    #   "\"Better Ingredients, Better Pizza\"",
    #   "- Papa John",
    #   ],
    # ]


    # arnoldQuote = Quote.new
    # arnoldQuote.quote = "\"Failure is not an option. Everyon has to Succeed\""
    # arnoldQuote.author = "- Arnold Schwarzenegger"


    # steveQuote = Quote.new
    # steveQuote.quote = "\"Your time is limited, so don't waste it living someone else's life.\""
    # steveQuote.author = "- Steve Jobs"


    # papaQuote = Quote.new
    # papaQuote.quote = "\"Better Ingredients, Better Pizza\""
    # papaQuote.author = "- Papa John"


    # @quotes = [
    #   [
    #   arnoldQuote.quote,
    #   arnoldQuote.author,
    #   ],
    #
    #   [
    #   steveQuote.quote,
    #   steveQuote.author,
    #   ],
    #
    #   [
    #   papaQuote.quote,
    #   papaQuote.author,
    #   ],
    # ]

    arnoldQuote = Quote.new("\"Failure is not an option. Everyon has to Succeed\"","- Arnold Schwarzenegger")
    steveQuote = Quote.new("\"Your time is limited, so don't waste it living someone else's life.\"","- Steve Jobs")
    papaQuote = Quote.new("\"Better Ingredients, Better Pizza\"","- Papa John")
    
    @quotes = [
      [
      arnoldQuote.getQuote,
      arnoldQuote.getAuthor,
      ],

      [
      steveQuote.getQuote,
      steveQuote.getAuthor,
      ],

      [
      papaQuote.getQuote,
      papaQuote.getAuthor,
      ],
    ]

  end

end
