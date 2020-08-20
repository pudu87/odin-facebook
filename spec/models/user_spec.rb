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
      @user_1 = User.create(first_name: 'Rocky', last_name: 'Peeters', email: 'rocky@internet.com', password: 'password', password_confirmation: 'password')
      user_2 = User.create(first_name: 'Ivan', last_name: 'Perisic', email: 'ivan@internet.com', password: 'password', password_confirmation: 'password')
      @user_3 = User.create(first_name: 'Wagneau', last_name: 'Eloi', email: 'wagneau@internet.com', password: 'password', password_confirmation: 'password')
      user_4 = User.create(first_name: 'Damir', last_name: 'Mirvic', email: 'damir@internet.com', password: 'password', password_confirmation: 'password')
      user_5 = User.create(first_name: 'Mama', last_name: 'Dissa', email: 'mama@internet.com', password: 'password', password_confirmation: 'password')
      user_6 = User.create(first_name: 'Jurgen', last_name: 'Sierens', email: 'jurgen@internet.com', password: 'password', password_confirmation: 'password')
      @user_1.friendships.create(friend_id: user_2.id, accepted: true)
      @user_1.friendships.create(friend_id: @user_3.id, accepted: false)
      @user_1.friendships.create(friend_id: user_4.id)
    end

    describe 'confirmed friends' do
      it 'filters friends of which friendship has been confirmed' do
        confirmed = @user_1.confirmed_friends
        expect(confirmed.count).to eq(1)
      end
    end

    describe 'pending friends' do
      it 'filters users that have sent a friendship request' do
        pending = @user_3.pending_friends
        expect(pending.count).to eq(1)
      end
    end

    describe 'possible friends' do
      it 'filters users that are no friend and did not have a request' do
        possible = @user_1.possible_friends
        expect(possible.count).to eq(2)
      end
    end

    describe 'full name' do
      it 'returns the full name of a user' do
        expect(@user_1.full_name).to eq('Rocky Peeters')
      end
    end
  end
end