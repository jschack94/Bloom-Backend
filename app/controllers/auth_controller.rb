class AuthController < ApplicationController
  skip_before_action :authorized, only: %i[create]

  def create
    @user = User.find_by(email_address: user_login_params[:email_address])
    #User#authenticate comes from BCrypt
    if @user && @user.authenticate(user_login_params[:password])
      # encode token comes from ApplicationController
      token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), jwt: token },
             status: :accepted
    else
      render json: { message: 'Invalid username or password' },
             status: :unauthorized
    end
  end

  private

  def user_login_params
    params.require(:user).permit(:email_address, :password)
  end
end
