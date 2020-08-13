require 'rails_helper'

RSpec.describe Comment, type: :model do

  before do
    user = User.create(first_name: 'Rocky', last_name: 'Peeters', email: 'rocky@internet.com', password: 'rocky')
    post = user.posts.create(content: 'This is a post')
  end

  context 'validation tests' do
    it 'saves if all necessary data are present' do
      comment = post.comments.new(content: 'This is a post')
      expect(comment.save).to eq(true)
    end

    it 'ensures content presence' do
      comment = post.comments.new()
      expect(comment.save).to eq(false)
    end
  end
end
