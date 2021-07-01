class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private
  
  def generate_slug
    if self.has_attribute?(:slug)
      loop do
        random_slug = "#{self.class::SLUG_PREFIX}-#{SecureRandom.hex(5)}"
        break random_slug unless self.class.exists?(slug: random_slug)
      end
    end
  end
end
