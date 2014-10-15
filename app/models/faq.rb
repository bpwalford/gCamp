class Faq
  
  def self.all
    ObjectSpace.each_object(self).to_a
  end

  attr_accessor :question, :answer

  def initialize(question, answer)
    self.question = question
    self.answer = answer
  end

  # def getQuestion
  #   @question
  # end
  #
  # def getAnswer
  #   @answer
  # end


end
