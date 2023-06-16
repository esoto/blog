class BlogPost < ApplicationRecord
  has_one_attached :cover_image
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_first) }
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

  # private

  # def set_slug
  #   self.slug = title.parameterize
  # end
end
