module Admin
  class UsersController < AdminController
    def index
      @users = User.page(params[:page])
    end
  end
end
