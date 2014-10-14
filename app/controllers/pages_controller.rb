class PagesController < ApplicationController

  def index

    @panel_elements = [

      {
        image: 'https://farm3.staticflickr.com/2833/8865586006_c5ce2a79e6_n.jpg',
        title: 'Tasks',
        content: ['Grouped by projects and lists. Just the way you like \'em'],
      },

      {
        image: 'https://farm4.staticflickr.com/3832/8865584540_b5307795be_n.jpg',
        title: 'Documents',
        content: ['Upload', 'Comment', 'Revise']
      },

      {
        image: 'https://farm4.staticflickr.com/3821/9232183203_859067da50_n.jpg',
        title: 'Comments',
        content: ['Comment on tasks and documents', 'Get email notifications']
      }

    ]

    @quotes = [
      [
      "\"Failure is not an option. Everyon has to Succeed\"",
      "- Arnold Schwarzenegger",
      ],

      [
      "\"Your time is limited, so don't waste it living someone else's life.\"",
      "- Steve Jobs",
      ],

      [
      "\"Better Ingredients, Better Pizza\"",
      "- Papa John",
      ],
    ]

  end

end
