class Faq

  include Comparable

  @@sortedQuestions = nil

  attr_accessor :question, :answer, :identity

  def initialize(question, answer)
    self.question = question
    self.answer = answer
    self.identity = identity
  end

  def self.all
    # pulls data from yaml file and make it an array
    @questions = YAML.load_file("#{Rails.root}/config/questions.yml").to_a
    # sorts data by question in downcase alphabetical order
    @questions.sort! {|x,y| x <=> y}

    # used to put each object in an array
    # ObjectSpace.each_object(self).to_a
  end

  # defines the <=> operator
  def <=>(obj)
    question.downcase <=> obj.question.downcase
  end

end
