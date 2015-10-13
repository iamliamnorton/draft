class CreditController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def create
    if current_user.update(credit_params)
      redirect_to lobby_path, notice: 'Credit successfully added.'
    else
      render :show
    end
  end

  def credit_params
    params.require(:user).permit(:credit)
  end
end
