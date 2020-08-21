class Profile < ApplicationRecord
  validate :validate_age

  belongs_to :user
  has_one_attached :photo

  def validate_age
    if birthdate && birthdate > 18.years.ago
      errors.add(:birthdate, 'You should be over 18 years old.')
    end
  end

  #TODO declare (image) storage service for production (see Railsguide Active Storage)
end
