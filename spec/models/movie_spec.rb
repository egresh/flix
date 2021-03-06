require "rails_helper"

RSpec.describe Movie, type: :model do
  context "Associations" do
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:favorites).dependent(:destroy) }
    it { should have_many(:fans) }
    it { should have_many(:genres) }
    it { should have_many(:characterizations).dependent(:destroy)}
  end

  context "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:released_on) }
    it { should validate_presence_of(:duration) }

    it do
      should validate_numericality_of(:total_gross)
        .is_greater_than_or_equal_to(0)
    end

    it do
      should validate_length_of(:description)
        .is_at_least(25)
    end

    it do
      should validate_inclusion_of(:rating)
        .in_array(::Movie::RATINGS)
    end
  end

  context "Methods" do
    it "is a flop when the total_gross is blank or less than $225 thousand" do
      m = FactoryBot.create(:movie, total_gross: 224_999_999)
      expect(m.flop?).to be true
    end

    it "is a flop if the total_gross is blank" do
      m = FactoryBot.create(:movie)
      m.total_gross = ""

      expect(m.flop?).to be true
    end

    it "is not a flop is the total_gross is greater than $225 thousand" do
      m = FactoryBot.create(:movie, total_gross: 225_000_000)
      expect(m.flop?).to be false
    end
  end
end
