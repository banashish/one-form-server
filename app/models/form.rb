class Form < ApplicationRecord
    include FriendlyId
    SLUG_PREFIX = 'frm'.freeze
    friendly_id :generate_slug
    
    belongs_to :user
    has_many :question, dependent: :destroy
    has_many :answer, dependent: :destroy
    validates_presence_of :title, :user
    validates :title, uniqueness: { scope: :user_id}
end
