class AddressesController < ApplicationController

def new
@user = current_user
@address = Address.new
end

def create
@user = current_user
@user = @user.addresses.new(address_params)
redirect_to profile_path
end

def edit
@user = current_user
@address = Address.find(params[:id])
end

def update
@user = current_user
@address = Address.find(params[:id])
@address.update(address_params)
redirect_to profile_path
end



private
def address_params
params.permit(:nickname, :street, :city, :state, :zip, :user_id)
end
end
