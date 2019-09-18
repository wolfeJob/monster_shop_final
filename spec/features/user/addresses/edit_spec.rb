require 'rails_helper'

describe 'Addresses edit page' do
 before(:each) do
 @scott = User.create!(name: 'Scott', email: 'scotto@gmail.com', password: 'apple')
 @scott_addy = @scott.addresses.create!(street: '111 Willow St', city: 'Denver', state: 'CO', zip: 99999, nickname: "home")
 @scott_addy_2 = @scott.addresses.create!(street: '123 hope St', city: 'Denver', state: 'CO', zip: 90210, nickname: "grandma")
 allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@scott)
  end

  it "A link on my profile page routes me to an edit address form,
  where I can edit my address information" do

  visit profile_path
  within "#address-#{@scott_addy.id}" do
  expect(page).to have_link("edit address")
  click_link ("edit address")
  expect(current_path).to eq("/users/:user_id/addresses/:id/edit")
  #new information to fill in test with
  type = "new type"
  street = "new street"
  city = "new city"
  state = "new state"
  zip = "00002"
#then fill
  fill_in "Type", with: type
  fill_in "Street Address", with: street
  fill_in "City", with: city
  fill_in "State", with: state
  fill_in "Zip", with: zip


  end

   fill_in "Type", with: type
   fill_in "Street Address", with: street
   fill_in "City", with: city
   fill_in "State", with: state
   fill_in "Zip", with: zip

   click_on "Create Address"

   new_address = Address.last

   expect(current_path).to eq(profile_path)

 # within "#address-#{new_address.id}" do
   # save_and_open_page
   expect(page).to have_content(street)
   expect(page).to have_content(city)
   expect(page).to have_content(state)
   expect(page).to have_content(zip)
  # end
  # save_and_open_page
end
end
