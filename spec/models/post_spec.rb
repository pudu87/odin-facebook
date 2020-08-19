require 'rails_helper'

RSpec.describe Post, type: :model do

  before do
    @user = User.create(first_name: 'Rocky', last_name: 'Peeters', email: 'rocky@internet.com', password: 'password', password_confirmation: 'password')
  end

  context 'validation tests' do
    it 'saves if all necessary data are present' do
      post = @user.posts.build(content: 'This is a post')
      expect(post.save).to eq(true)
    end

    it 'ensures content presence' do
      post = @user.posts.build()
      expect(post.save).to eq(false)
    end
  end
end
