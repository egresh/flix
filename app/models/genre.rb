class Genre < ApplicationRecord
  has_many :characterizations, dependent: :destroy
  has_many :movies, through: :characterizations

  before_save :generate_slug
  validates :name, presence: true, uniqueness: true

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
