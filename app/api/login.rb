class Login < Grape::API
  version 'v1', using: :path

  helpers do
    def valid_user?
      @user = User.find_by(email: params[:email])
      return false if @user.blank?

      @user.valid_password?(params[:password])
    end
  end

  desc 'To get auth token'
  params do
    requires :email, type: String, desc: 'Your email.'
    requires :password, type: String, desc: 'Your password.'
  end
  post :sign_in do
    valid_user? ? { auth_token: @user.renew_token! } : error!('Access Denied', 401)
  end
end
