class RequestValidator
  attr_accessor :result

  def initialize(options = {})
    @options = options
    @token = options[:token]
    @result = OpenStruct.new(response: nil, valid: false, errors: [])
  end

  def run!
    validate_request
    @result.valid = true # for now
    @result
  end

  private

  def validate_request
    # should send http request to main microservice
    # should let the request continue if token is valid
    # should halt the request if token is invalid
  end
end