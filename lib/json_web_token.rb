class JsonWebToken
    class << self
        def encode(payload, exp = 24.hours.from_now)
            payload[:exp] =  exp.to_i
            JWT.encode(payload, Rails.application.secrets.secret_key_base)
        end

        def decode(token)
            body = JWT.decode(token, Rails.application.secrets.secret_key_base)
            HashWithIndifferentAccess.new body[0] if body
        rescue
            raise SignatureExpired,'Your auth token has expired please login again.'
        end
    end
end