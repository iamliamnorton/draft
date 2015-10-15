module DeviseSupport
  include Warden::Test::Helpers

  def sign_in(user = nil)
    user = user || create(:user)

    login_as user, scope: :user
    user
  end
end
