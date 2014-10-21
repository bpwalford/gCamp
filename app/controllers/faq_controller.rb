class FaqController < ApplicationController

  def faq

    @questions = Faq.all

  end

end
