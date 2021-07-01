class Answer < ApplicationRecord
    belongs_to :form
    has_many :questions_answer, dependent: :destroy
    accepts_nested_attributes_for :questions_answer

    validates :form, presence: true

    def self.create_with_question_answer(form,questions_answer)
        answer = nil
        ActiveRecord::Base.transaction do
            answer = Answer.create(form: form)
            questions_answer.each do | question_answer |
                question = Question.find_by(slug: question_answer[:id])
                answer.questions_answer.create(value: question_answer[:value], question: question)
            end
        end
        answer
    end
end
