class User < ApplicationRecord
  has_secure_password

  before_save :format_username, :format_email, :set_slug

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true

  validates :email, presence: true,
    format: {with: /\S+@\S+/},
    uniqueness: {case_sensitive: false}

  validates :username, presence: true,
    format: {with: /\A\w+\z/},
    uniqueness: {case_sensitive: false}

  validate :check_password

  scope :non_admin_users, -> { by_name.where(admin: false) }
  scope :admin_users, -> { by_name.where(admin: true) }
  scope :by_name, -> { order(name: :asc) }

  def to_param
    slug
  end

  def check_password
    unless password.blank?
      if password_confirmation.blank?
        errors.add(:password_confirmation, "is blank")
      end
    end
  end

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end

  private

  def format_username
    self.username = username.downcase
  end

  def format_email
    self.email = email.downcase
  end

  def set_slug
    self.slug = username
  end
end
