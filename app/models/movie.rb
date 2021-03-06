class Movie < ApplicationRecord
  before_save :generate_slug

  has_many :reviews, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  has_one_attached :main_image

  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true

  validates :description, length: {minimum: 25}

  validates :total_gross, numericality: {greater_than_or_equal_to: 0}

  RATINGS = %w[G PG PG-13 R NC-17]

  validates :rating, inclusion: {in: RATINGS}

  validate :acceptable_image

  FLOP_AMOUNT = 225_000_000
  HIT_AMOUNT = 300_000_000

  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }
  scope :recent, ->(how_many = 3) { released.limit(how_many) }
  scope :flops, -> { released.where("total_gross < ?", FLOP_AMOUNT) }
  scope :hits, -> { released.where("total_gross >= ?", HIT_AMOUNT).order(total_gross: :desc) }
  scope :grossed_less_than, ->(amount) { where("total_gross < ?", amount) }
  scope :grossed_greater_than, ->(amount) { where("total_gross > ?", amount) }

  def acceptable_image
    return unless main_image.attached?

    if main_image.blob.byte_size >= 1.megabyte
      errors.add(:main_image, "Image too large, max 1 megabyte")
    end

    acceptable_types = %w[image/jpeg image/png]

    unless acceptable_types.include? main_image.content_type
      errors.add(:main_image, "must be a JPEG or PNG")
    end
  end

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
