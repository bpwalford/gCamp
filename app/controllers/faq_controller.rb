class FaqController < ApplicationController

  @@loaded = false

  def faq

    if @@loaded == false
      @firstQuestion = Faq.new(
        'What is gCamp',
        'gCamp is an awesome tool that is going to change your life. gCamp is your one stop shop to organize all your tasks and documents. You\'ll also be able to track comments that you and others make. gCamp may eventually replace all need for paper and pens in the entire world. Wel, maybe not, but it\'s going to be pretty cool'
      )


      @secondQuestion = Faq.new(
        'How do I join gCamp?',
        'Right now, gCamp is still in production. So, there is not a sign up page open to the public yet! Your best option is to become super best friends with a gCamp developer. They can be found hanging around gSchool during the day and hitting the hottest clubs at night.'
      )

      @thirdQuestion = Faq.new(
        'When will gCamp be finished?',
        'gCamp is a work in progress. That being said, it should be fully functional by December 2014. Functional, but our developers are going to continue to improve the site for the foreseeable future. Check in daily for new features and awesome functionality. It’s going to blow your mind. Organization is only (well, will only) be a click away. Amazing!'
      )

      @@loaded = true
    end

    # @questions = [
    #   [
    #     firstQuestion.getQuestion,
    #     firstQuestion.getAnswer,
    #   ],
    #   [
    #     secondQuestion.getQuestion,
    #     secondQuestion.getAnswer,
    #   ],
    #   [
    #     thirdQuestion.getQuestion,
    #     thirdQuestion.getAnswer,
    #   ],
    # ]

    @questions = Faq.all

  end

end
