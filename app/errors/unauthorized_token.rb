class UnauthorizedToken < StandardError
    attr_reader :extra
    def initialize(message, extra='')
        super(message)
        @extra = extra
    end
end