class ApplicationController < ActionController::API
    # protect_from_forgery with: :null_session

    def authorize_request
        authorize_user_request
    end

    private

    def authorize_user_request
        @current_user = AuthorizeApiRequest.new(request.headers).call
        render json: { message: 'Not able to authorize request' },status: :unauthorized if @current_user.nil?
    rescue Exception => err
        render json: { message: err.message }, status: :unauthorized
    end
end