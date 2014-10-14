class PagesController < ApplicationController

  def index

    @panel_elements = [

      {
        image: 'tasksImage.jpg',
        title: 'Tasks',
        content: ['Grouped by projects and lists. Just the way you like \'em'],
      },

      {
        image: 'documentsImage.jpg',
        title: 'Documents',
        content: ['Upload', 'Comment', 'Revise']
      },

      {
        image: 'commentsImage.jpg',
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
