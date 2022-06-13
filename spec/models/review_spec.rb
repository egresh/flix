require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'Associations' do
    it { should belong_to(:movie)}
    it { should belong_to(:user)}
  end

  context 'Validations' do
    it do
      should validate_inclusion_of(:stars).
        in_array(::Review::STARS).
        with_message("must be between 1 and 5")
    end
  end

  context 'Methods' do
    it '#stars_as_percent returns a percentage' do
      r = Review.new
      r.stars = 5
      expect(r.stars_as_percent).to eq(100)
      r.stars = 4
      expect(r.stars_as_percent).to eq(80)
      r.stars = 3
      expect(r.stars_as_percent).to eq(60)
      r.stars = 2
      expect(r.stars_as_percent).to eq(40)
      r.stars = 1
      expect(r.stars_as_percent).to eq(20)
    end
  end
end
