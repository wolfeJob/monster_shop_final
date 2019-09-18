class AddressesController < ApplicationController

def new
@user = current_user
@address = Address.new
end

def create
@user = current_user
@address = @user.addresses.create(address_params)
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

def destroy
@address = Address.find(params[:id])
if @address.user_id == current_user.id
@address.destroy
redirect_to profile_path
end
end


private
def address_params
params.permit(:nickname, :street, :city, :state, :zip, :user_id)
end
end
