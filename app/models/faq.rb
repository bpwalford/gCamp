class Faq

  def self.all
    @@foo = YAML.load_file("#{Rails.root}/config/questions.yml").to_a
    # ObjectSpace.each_object(self).to_a
  end

  attr_accessor :question, :answer

  def initialize(question, answer)
    self.question = question
    self.answer = answer
  end

end
