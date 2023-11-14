class User < ApplicationRecord
  # Adds password encryption functionality to the User model
  has_secure_password
end