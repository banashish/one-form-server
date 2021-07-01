class Api::V1::UsersController < ApplicationController
    # include JsonWebToken
    before_action :set_user, only: %i[login]

    def signup
        new_user = User.create!(build_user_payload)
        token = JsonWebToken.encode({email: new_user.email})
        render json: { status: 'success', message: 'you have successfully registered',token: token}, status: :ok
    rescue ActiveRecord::RecordInvalid => e
        render json: { status: 'failed', message: e.message }, status: 424
    rescue StandardError => err
        render json:{ status: 'failed', message: err.message }, status: 500
    end

    def login
        unless @user
            render json: { status: 'failed', message: 'No user found with such email,please register yourself'}, status: :ok
            return
        end
        if @user.authenticate(set_login_params[:password])
            token = JsonWebToken.encode({email: @user.email})
            render json: { status: 'success', message: 'login successful',token: token}, status: :ok
        else
            render json: { status: 'failed', message: 'password incorrect'}, status: 424
        end
    rescue StandardError => err
        render json:{ status: 'failed', message: err.message }, status: 500
    end

    private

    def set_user
        @user = User.find_by_email(set_login_params[:email].downcase)
    end

    def set_login_params
        params.permit(:email,:password)
    end

    def build_user_payload
        {
            email: set_params[:email].downcase,
            password: set_params[:password],
            password_confirmation: set_params[:password_confirmation]
        }
    end

    def set_params
        params.permit(:email,:password,:password_confirmation)
    end
end
