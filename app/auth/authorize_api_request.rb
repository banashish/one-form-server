class AuthorizeApiRequest
    def initialize(headers)
        @headers = headers
    end

    def call
        user
    end

    private

    attr_reader :headers
    
    def user
        token = get_token
        @user ||= ::User.find_by(email: token[:email]) if token
        return @user if @user

        raise UnauthorizedToken,'you are not authorized to view this resources'
    rescue UnauthorizedToken => e
        raise e
    rescue SignatureExpired => err
        raise err
    end

    def get_token
        @user_token ||= JsonWebToken.decode(auth_token) 
    end

    def auth_token
        return headers['Authorization'].split(' ').last unless headers['Authorization'].blank?

        raise UnauthorizedToken,'you are not authorized to view this resources'
    end
end