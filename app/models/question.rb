class Question < ApplicationRecord
    include FriendlyId
    SLUG_PREFIX = 'qns'.freeze
    friendly_id :generate_slug

    belongs_to :form

    validates :title, :kind, :form, presence: true
    enum kind: [:short_text, :long_text, :integer, :boolean]
end
