require 'rails_helper'

describe 'Creating a new address for a registered user' do
 before(:each) do
 @scott = User.create!(name: 'Scott', email: 'scotto@gmail.com', password: 'apple')
 # binding.pry
 @scott_addy = @scott.addresses.create!(street: '111 Willow St', city: 'Denver', state: 'CO', zip: 99999, nickname: "home")
 allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@scott)
  end

  it "A link on my profile page routes me to a new address form,
  where I can enter my new address information" do

  visit profile_path
  click_on "Add Address"

   street = "999 heaven way"
   city = "denver"
   state = "CO"
   zip = 90210

   fill_in "Street Address", with: street
   fill_in "City", with: city
   fill_in "State", with: state
   fill_in "Zip", with: zip

   click_on "Create Address"

   new_address = Address.last

   expect(current_path).to eq(profile_path)

 within "#address-#{new_address.id}" do
   expect(page).to have_content(street)
   expect(page).to have_content(city)
   expect(page).to have_content(state)
   expect(page).to have_content(zip)
  end
end
end
