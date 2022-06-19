require "rails_helper"

RSpec.describe Favorite, type: :model do
  context "Associations" do
    it { should belong_to(:movie) }
    it { should belong_to(:user) }
    it { should have_db_index(:user_id) }
    it { should have_db_index(:movie_id) }
  end
end
