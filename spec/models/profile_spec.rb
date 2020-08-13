require 'rails_helper'

RSpec.describe Profile, type: :model do

  context 'validation tests' do
    before do
      user = User.create(first_name: 'Rocky', last_name: 'Peeters', email: 'rocky@internet.com', password: 'rocky')
    end

    it 'saves if all necessary data are present' do
      profile = user.profile.new(birth_date: Date.parse('18-08-1979'))
      expect(profile.save).to eq(true)
    end

    it 'ensures birth_date presence' do
      profile = user.profile.new(location: 'Antwerpen')
      expect(profile.save).to eq(false)
    end

    it 'ensures birth_date conditions' do
      profile = user.profile.new(birth_date: Date.parse('18-08-2019'))
      expect(profile.save).to eq(false)
    end
  end
end
