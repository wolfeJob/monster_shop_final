class Address < ApplicationRecord
belongs_to :user
has_many :orders


validates :street,
          :city,
          :state,
          :zip,
          :nickname
end
