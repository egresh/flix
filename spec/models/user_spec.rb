require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with email, name, password, and password_confirmation attributes" do
    u = FactoryBot.build(:user)
    u.valid?
    expect(u.errors.any?).to be false
  end

  it "is invalid without a name" do
    u = FactoryBot.build(:user, name: "")
    u.valid?
    expect(u.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    u = FactoryBot.build(:user, email: "")
    u.valid?
    expect(u.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a properly formatted email" do
    ["example@", "@example", "  @"].each do |invalid|
      u = FactoryBot.build(:user, email: invalid)
      u.valid?
      expect(u.errors[:email]).to include("is invalid")
    end
  end

  it "is invalid without a password confirmation" do
    u = FactoryBot.build(:user, password_confirmation: "")
    u.valid?
    expect(u.errors[:password_confirmation]).to eq("can't be blank")
  end

  it "requires the password and password_confirmation to match" do
    u = FactoryBot.build(:user, password: "secret", password_confirmation: "not_secret")
    u.valid?

    expect(u.errors[:password_confirmation]).to include("doesn't match Password")
  end
end
