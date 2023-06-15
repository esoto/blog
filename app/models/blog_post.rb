class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  scope :sorted, -> { order(published_at: :desc) }
  scope :drafts, -> { where(published_at: nil) }
  scope :scheduled, -> { where('published_at > ?', Time.current) }
  scope :published, -> { where('published_at <= ?', Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

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
