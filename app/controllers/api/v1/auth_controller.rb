class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]
  
    def create
      @user = User.find_by(email_address: user_login_params[:email_address])
      #User#authenticate comes from BCrypt
      if @user && @user.authenticate(user_login_params[:password])
        # encode token comes from ApplicationController
        token = encode_token({ user_id: @user.id })
        render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
      else
        render json: { message: 'Invalid username or password' }, status: :unauthorized
      end
    end
  
    def show
      if current_user
        render json: {user: current_user}
      else
        render json: {error: "Please log in"}, status: 422
      end
    end
  
    private
  
    def user_login_params
      # byebug
      params.require(:auth).permit(:email_address, :password)
    end
  end