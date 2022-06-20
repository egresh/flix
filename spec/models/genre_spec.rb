require "rails_helper"

RSpec.describe Genre, type: :model do
  context "Associations" do
    it { should have_many(:movies) }
    it { should have_many(:characterizations).dependent(:destroy) }
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
    # it { should validate_uniqueness_of(:name) }
    it "should validate uniqueness of :name" do
      Genre.create!(name: "adventure")
      expect {Genre.create!(name: "adventure")}.to raise_error(/Name has already been taken/)
    end
  end
end
