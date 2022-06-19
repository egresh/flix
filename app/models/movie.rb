class Movie < ApplicationRecord
  before_save :generate_slug

  has_many :reviews, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true

  validates :description, length: {minimum: 25}

  validates :total_gross, numericality: {greater_than_or_equal_to: 0}

  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }

  RATINGS = %w[G PG PG-13 R NC-17]

  validates :rating, inclusion: {in: RATINGS}

  FLOP_AMOUNT = 225_000_000
  HIT_AMOUNT = 300_000_000

  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }
  scope :recent, ->(how_many = 3) { released.limit(how_many) }
  scope :flops, -> { released.where("total_gross < ?", FLOP_AMOUNT) }
  scope :hits, -> { released.where("total_gross >= ?", HIT_AMOUNT).order(total_gross: :desc) }
  scope :grossed_less_than, ->(amount) { where("total_gross < ?", amount) }
  scope :grossed_greater_than, ->(amount) { where("total_gross > ?", amount) }

  def to_param
    slug
  end

  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
