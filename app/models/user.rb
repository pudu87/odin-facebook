class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

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
end