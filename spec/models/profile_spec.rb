require 'rails_helper'

RSpec.describe Profile, type: :model do

  context 'validation tests' do
    before do
      @user = User.create(first_name: 'Rocky', last_name: 'Peeters', email: 'rocky@internet.com', password: 'rocky')
    end

    it 'ensures birth_date conditions' do
      prof = @user.build_profile(birthdate: Date.parse('18-08-2019'))
      expect(prof.save).to eq(false)
    end
  end
end
