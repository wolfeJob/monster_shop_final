require 'rails_helper'
describe "User has choices for an address at checkout" do
    before :each do
      @scott = User.create!(name: 'Scott', email: 'scott@email.com', password: 'mine')
      @scott_addy_1 = @scott.addresses.create!(street: '4942 willlow st', city: 'denver', state: 'co', zip: 88888, nickname: "home")
      @scott_addy_2 = @scott.addresses.create!(street: '728 norfolk way', city: 'aurora', state: 'fl', zip: 99999, nickname: "parents")
      @merchant = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @locness = @merchant.items.create!(name: 'locness', description: "I'm a Loch Monster!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    end

    it "logs in, adds items to cart,chooses address for checkout " do
    visit login_path

    fill_in 'Email', with: @scott.email
    fill_in 'Password', with: @scott.password
    click_button 'Log In'
    visit item_path(@locness)
    click_on "Add to Cart"
    visit cart_path

    expect(page).to have_content("choose your shipping address")
    expect(page).to have_content(@scott_addy_1.street)
    expect(page).to have_content(@scott_addy_1.city)
    expect(page).to have_content(@scott_addy_1.state)
    expect(page).to have_content(@scott_addy_1.zip)
    expect(page).to have_content(@scott_addy_2.street)
    expect(page).to have_content(@scott_addy_2.city)
    expect(page).to have_content(@scott_addy_2.state)
    expect(page).to have_content(@scott_addy_2.zip)
      save_and_open_page
      click_on "checkout"
      order = Order.last
      expect(current_path).to eq('/profile/orders')
      expect(order.address).to eq(@scott_addy_1)
      expect(order.address).to_not eq(@scott_addy_2)
    end
end
