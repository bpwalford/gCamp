class FaqController < PublicController

  def faq

    @questions = Faq.all

  end

end
