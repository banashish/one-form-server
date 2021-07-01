class FormEntity < Grape::Entity
    expose :slug, :description, :created_at
    expose :title, as: :name
    expose :enable, as: :status
    expose :primary_color, as: :color
    expose :question, using: QuestionEntity
end