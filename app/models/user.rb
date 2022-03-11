class User < ApplicationRecord
  include Clearance::User

  enum user_type: {
    guardian: 0,
    vendor: 1,
    admin: 2,
  }

  with_options if: :guardian?, presence: true do
    # validates :something-specific-to-guardians
  end

  with_options if: :guardian?, allow_destroy: true do
    # accepts_nested_attributes_for :some-association-specific-to-guardians
  end
end
