class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  after_create :init_profile

  validates :first_name, :last_name, presence: true

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  
  has_many :posts
  has_many :comments
  has_many :likes
  has_one  :profile

  def confirmed_friends
    (friendships.map{ |fs| fs.friend if fs.accepted? } + 
      inverse_friendships.map{ |fs| fs.user if fs.accepted? }).compact
  end

  # users that have SENT a request
  def pending_friends
    inverse_friendships.map{ |fs| fs.user unless fs.accepted? }.compact
  end

  # no friend and no request
  def possible_friends
    ids = (friendships.map{ |fs| fs.friend_id } +
      inverse_friendships.map{ |fs| fs.user_id }).compact
    User.where.not(id: ids) - [self]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def init_profile
    self.create_profile
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split[0]
      user.last_name = auth.info.name.split[1..-1].join(' ')
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end