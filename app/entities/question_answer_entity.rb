class QuestionAnswerEntity < Grape::Entity
    expose :value, as: :answer
    expose :question, using: QuestionEntity
end