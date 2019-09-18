class AddressesController < ApplicationController

def new

end

def create
@user = current_user
@user = @user.addresses.new(address_params)
redirect_to profile_path
end

def edit

end 



private
def address_params
params.permit(:nickname, :street, :city, :state, :zip, :user_id)
end
end
