class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy

  validates :name, presence: true

  validates :email, presence: true,
    format: {with: /\S+@\S+/},
    uniqueness: {case_sensitive: false}

  validates :username, presence: true,
    format: {with: /\A\w+\z/},
    uniqueness: {case_sensitive: false}

  validate :check_password

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
end
