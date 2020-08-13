require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validation tests' do
    it 'saves if all necessary data are present' do
      user = User.new(first_name: 'Rocky', last_name: 'Peeters', email: 'rocky@internet.com', password: 'password', password_confirmation: 'password')
      expect(user.save).to eq(true)
    end

    it 'ensures first_name presence' do
      user = User.new(last_name: 'Peeters', email: 'rocky@internet.com', password: 'password', password_confirmation: 'password')
      expect(user.save).to eq(false)
    end

    it 'ensures last_name presence' do
      user = User.new(first_name: 'Rocky', email: 'rocky@internet.com', password: 'password', password_confirmation: 'password')
      expect(user.save).to eq(false)
    end

    it 'ensures email presence' do
      user = User.new(first_name: 'Rocky', last_name: 'Peeters', password: 'password', password_confirmation: 'password')
      expect(user.save).to eq(false)
    end

    it 'ensures email is unique' do
      user_1 = User.new(first_name: 'Rocky', last_name: 'Peeters', email: 'ksvr@internet.com', password: 'password', password_confirmation: 'password').save
      user_2 = User.new(first_name: 'Ivan', last_name: 'Perisic', email: 'ksvr@internet.com', password: 'password', password_confirmation: 'password')
      expect(user_2.save).to eq(false)
    end

    it 'ensures email has correct format' do
      user = User.new(first_name: 'Rocky', last_name: 'Peeters', email: 'email', password: 'password', password_confirmation: 'password')
      expect(user.save).to eq(false)
    end
  end

  context 'scope tests' do
    before do
      user_1 = User.create(first_name: 'Rocky', last_name: 'Peeters', email: 'rocky@internet.com', password: 'password', password_confirmation: 'password')
      user_2 = User.create(first_name: 'Ivan', last_name: 'Perisic', email: 'ivan@internet.com', password: 'password', password_confirmation: 'password')
      user_3 = User.create(first_name: 'Wagneau', last_name: 'Eloi', email: 'wagneau@internet.com', password: 'password', password_confirmation: 'password')
      user_4 = User.create(first_name: 'Damir', last_name: 'Mirvic', email: 'damir@internet.com', password: 'password', password_confirmation: 'password')
      user_5 = User.create(first_name: 'Mama', last_name: 'Dissa', email: 'mama@internet.com', password: 'password', password_confirmation: 'password')
      user_6 = User.create(first_name: 'Jurgen', last_name: 'Sierens', email: 'jurgen@internet.com', password: 'password', password_confirmation: 'password')
      user_1.friendships.create(friend_id: user_2.id, accepted: true)
      user_1.friendships.create(friend_id: user_3.id, accepted: false)
      user_1.friendships.create(friend_id: user_4.id)
    end

    describe 'confirmed' do
      it 'filters friends of which friendship has been confirmed' do
        confirmed_friends = user_1.friends.confirmed
        expect(confirmed_friends.count).to eq(1)
      end
    end

    describe 'pending' do
      it 'filters friends of which friendship has not been confirmed yet' do
        pending_friends = user_1.friends.pending
        expect(pending_friends.count).to eq(2)
      end
    end

    describe 'not requested' do
      it 'filters users that are no friend and did not have a request' do
        not_requested_friends = User.not_requested(user_1.id)
        expect(not_requested_friends.count).to eq(3) # =2+1, because Rocky cannot be a friend of himself
      end
    end
  end
end
