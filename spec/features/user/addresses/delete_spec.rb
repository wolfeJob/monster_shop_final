require 'rails_helper'

describe 'destroy an address' do
 before(:each) do
 @scott = User.create!(name: 'Scott', email: 'scotto@gmail.com', password: 'apple')
 @scott_addy = @scott.addresses.create!(street: '111 Willow St', city: 'Denver', state: 'CO', zip: 99999, nickname: "home")
 @scott_addy_2 = @scott.addresses.create!(street: '123 hope St', city: 'Denver', state: 'CO', zip: 90210, nickname: "grandma")
 @scott_addy_3 = @scott.addresses.create!(street: '999 stop St', city: 'Denver', state: 'CO', zip: 82098, nickname: "code")
 allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@scott)
  end

  xit "can delete an address from profile page" do

  visit profile_path
  within "#address-#{@scott_addy.id}" do
  expect(page).to have_content(@scott_addy.street)
  expect(page).to have_content(@scott_addy.city)
  expect(page).to have_content(@scott_addy.zip)
  click_link "delete address"
end
  expect(current_path).to eq(profile_path)
  expect(page).to_not have_content(@scott_addy.street)
  expect(page).to_not have_content(@scott_addy.city)
  expect(page).to_not have_content(@scott_addy.zip)
end
end
