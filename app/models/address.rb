class Address < ApplicationRecord
belongs_to :user
has_many :orders


validates_presence_of :street,
                      :city,
                      :state,
                      :zip,
                      :nickname


def orders_that_are_shipped_status
  self.orders.where(status: "shipped")
end

end 
