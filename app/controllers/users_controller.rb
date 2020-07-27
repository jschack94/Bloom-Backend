class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[index create update]

  def index
    @users = User.all
    render json: @users
  end

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), jwt: @token },
             status: :created
    else
      if params[:user][:email_address] == ''
        render json: { errors: 'Email address field must not be blank' },
               status: :not_acceptable
      elsif params[:user][:password] == ''
        render json: { errors: 'Password field must not be blank' },
               status: :not_acceptable
      elsif params[:user][:first_name] == ''
        render json: { errors: 'First name field must not be blank' },
               status: :not_acceptable
      elsif params[:user][:last_name] == ''
        render json: { errors: 'Last Name field must not be blank' },
               status: :not_acceptable
      else
        render json: {
                 errors:
                   'This email address has already been used to create an account'
               },
               status: :not_acceptable
      end
    end
  end

  def update
    @user = User.find_by(id: user_params[:id])
    @user.update(user_params)
    if @user.valid?
      render json: @user, status: :accepted
    else
      render json: { error: 'failed to update user' }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :id,
      :email_address,
      :password,
      :first_name,
      :last_name,
      :profile_pic,
      :job_title,
      :expertiseArray,
      :bio,
      :linkedin,
      :github,
      :personal_website,
      :mentor_status,
      :will_buy_coffee
    )
  end
end
