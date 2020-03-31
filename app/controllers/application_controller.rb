class ApplicationController < ActionController::API
    before_action :authorized
  
    def encode_token(payload)
      # returns jwt string
      JWT.encode(payload, ENV["jwt_secret"])
    end
  
    def auth_header
      # { 'Authorization': 'Bearer <token>' }
      request.headers['Authorization']
    end
  
    def decoded_token
      # returns the payload
      if auth_header
        token = auth_header.split(' ')[1]
        # headers: { 'Authorization': 'Bearer <token>' }
        # returns '<token>'
        begin
          JWT.decode(token, ENV["jwt_secret"], true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end
    end
  
    def current_user
      if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
      end
    end
  
    def logged_in?
      !!current_user
    end
  
    def authorized
        if !logged_in?
          # byebug
          render json: { message: 'Please log in'},
          status: :unauthorized
        end
      end
    end