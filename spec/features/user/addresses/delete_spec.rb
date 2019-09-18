require 'rails_helper'

describe 'destroy an address' do
 before(:each) do
 @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
 @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
 @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
 @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
 @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
 @scott = User.create!(name: 'Scott', email: 'scotto@gmail.com', password: 'apple')
 @scott_addy = @scott.addresses.create!(street: '111 Willow St', city: 'Denver', state: 'CO', zip: 99999, nickname: "home")
 @scott_addy_2 = @scott.addresses.create!(street: '123 hope St', city: 'arvada', state: 'CO', zip: 90210, nickname: "grandma")
 @scott_addy_3 = @scott.addresses.create!(street: '999 stop St', city: 'aspen', state: 'CO', zip: 82098, nickname: "code")
 @order1 = @scott.orders.create(status: "shipped", address: @scott_addy_2)
 allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@scott)
  end

  it "can delete an address from profile page" do

  visit profile_path
  within "#address-#{@scott_addy.id}" do
  expect(page).to have_content(@scott_addy.street)
  expect(page).to have_content(@scott_addy.city)
  expect(page).to have_content(@scott_addy.zip)
  click_link "delete address"
end
expect(current_path).to eq(profile_path)
  @scott.reload
  visit profile_path
  expect(page).to_not have_content(@scott_addy.street)
  expect(page).to_not have_content(@scott_addy.city)
  expect(page).to_not have_content(@scott_addy.zip)
end

  it "I cant delete an address that is apart of a shipped order" do
  end
end
