class AnswerEntity < Grape::Entity
   expose :questions_answer, using: QuestionAnswerEntity
end