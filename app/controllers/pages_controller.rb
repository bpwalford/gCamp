class PagesController < ApplicationController

  def index6

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

  end

  def index5

    @panel_elements = [

      [
        'https://farm3.staticflickr.com/2833/8865586006_c5ce2a79e6_n.jpg',
        'Tasks',
        ['Grouped by projects and lists. Just the way you like \'em']
      ],

      [
        'https://farm4.staticflickr.com/3832/8865584540_b5307795be_n.jpg',
        'Documents',
        ['Upload', 'Comment', 'Revise']
      ],

      [
        'https://farm4.staticflickr.com/3821/9232183203_859067da50_n.jpg',
        'Comments',
        ['Comment on tasks and documents', 'Get email notifications']
      ]
    ]

  end

  def index3

    @panel_elements = [

      [
        'https://farm3.staticflickr.com/2833/8865586006_c5ce2a79e6_n.jpg',
        'Tasks',
        ['Grouped by projects and lists. Just the way you like \'em']
      ],

      [
        'https://farm4.staticflickr.com/3832/8865584540_b5307795be_n.jpg',
        'Documents',
        ['Upload', 'Comment', 'Revise']
      ],

      [
        'https://farm4.staticflickr.com/3821/9232183203_859067da50_n.jpg',
        'Comments',
        ['Comment on tasks and documents', 'Get email notifications']
      ]
    ]

  end

end
