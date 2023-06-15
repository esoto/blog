class BlogPost < ApplicationRecord
  validates :title, presence: true

  # has_many :comments, dependent: :destroy

  # before_validation :set_slug

  # scope :published, -> { where.not(published_at: nil) }

  # def published?
  #   published_at.present?
  # end

  # private

  # def set_slug
  #   self.slug = title.parameterize
  # end
end
