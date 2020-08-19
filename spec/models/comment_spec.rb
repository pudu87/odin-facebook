require 'rails_helper'

RSpec.describe Comment, type: :model do

  before do
    user_1 = User.create(first_name: 'Rocky', last_name: 'Peeters', email: 'rocky@internet.com', password: 'password', password_confirmation: 'password')
    @user_2 = User.create(first_name: 'Ivan', last_name: 'Perisic', email: 'ivan@internet.com', password: 'password', password_confirmation: 'password')
    @post = user_1.posts.create(content: 'This is a post')
  end

  context 'validation tests' do
    it 'saves if all necessary data are present' do
      comment = @post.comments.build(content: 'This is a comment', user_id: @user_2.id)
      expect(comment.save).to eq(true)
    end

    it 'ensures content presence' do
      comment = @post.comments.build(user_id: @user_2.id)
      expect(comment.save).to eq(false)
    end
  end
end
