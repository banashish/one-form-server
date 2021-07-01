class QuestionEntity < Grape::Entity
    expose :title, as: :text
    expose :kind, :order
    expose :mandatory, as: :required
    expose :slug, if: ->(object, _options) { object.slug.present?}
end