class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true,
                    format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }
end
