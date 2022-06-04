class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  # validates :password_confirmation, presence: true
  validates :email, presence: true,
    format: {with: /\S+@\S+/},
    uniqueness: {case_sensitive: false}

  validate :check_password

  def check_password
    unless password.blank?
      if password_confirmation.blank?
        errors.add(:password_confirmation, "password provided but no confirmation given")
      end
    end
  end
end
