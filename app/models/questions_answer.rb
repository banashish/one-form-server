class QuestionsAnswer < ApplicationRecord
  belongs_to :answer
  belongs_to :question

  validates_presence_of :question, :answer
end
