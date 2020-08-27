class Post < ApplicationRecord
  validate :content_or_photo

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :photo

  def content_or_photo
    unless content.present? || photo.attached?
      errors.add(:content, "post can't be blank")
    end
  end
end
