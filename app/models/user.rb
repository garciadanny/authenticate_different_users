class User < ApplicationRecord
  include Clearance::User

  TYPES = %w(admin guardian vendor)
end
