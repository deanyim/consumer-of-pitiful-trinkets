class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save { email.downcase! }

  validates :first_name, presence: true, length: { maximum: 32 }
  validates :last_name,  presence: true, length: { maximum: 32 }
  validates :email,      presence: true, length: { maximum: 255 },
                         format: { with: VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 10 }

  has_secure_password
end