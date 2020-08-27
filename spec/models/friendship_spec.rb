require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'scope tests' do

    before do
      @user_1 = User.create(first_name: 'Rocky', last_name: 'Peeters', email: 'rocky@internet.com', password: 'password', password_confirmation: 'password')
      user_2 = User.create(first_name: 'Ivan', last_name: 'Perisic', email: 'ivan@internet.com', password: 'password', password_confirmation: 'password')
      user_3 = User.create(first_name: 'Wagneau', last_name: 'Eloi', email: 'wagneau@internet.com', password: 'password', password_confirmation: 'password')
      user_4 = User.create(first_name: 'Damir', last_name: 'Mirvic', email: 'damir@internet.com', password: 'password', password_confirmation: 'password')
      user_5 = User.create(first_name: 'Jurgen', last_name: 'Sierens', email: 'jurgen@internet.com', password: 'password', password_confirmation: 'password')
      user_6 = User.create(first_name: 'Mama', last_name: 'Dissa', email: 'mama@internet.com', password: 'password', password_confirmation: 'password')
      Friendship.create(user_id: @user_1.id, friend_id: user_2.id)
      Friendship.create(user_id: user_3.id, friend_id: @user_1.id)
      Friendship.create(user_id: user_4.id, friend_id: @user_1.id)
      Friendship.create(user_id: user_3.id, friend_id: user_4.id)
      Friendship.create(user_id: user_5.id, friend_id: user_6.id)
    end

    describe 'belonging to' do
      it 'filters all the friendships of the concerning user' do
        friendships = Friendship.belonging_to(@user_1.id)
        expect(friendships.count).to eq(3)
      end
    end
  end
end
