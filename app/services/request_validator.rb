# frozen_string_literal: true

class RequestValidator
  attr_accessor :result

  def initialize(options = {})
    @options = options
    @token = options[:token]
    @result = OpenStruct.new(valid: false, errors: [])
  end

  def run!
    # validate_request
    @result.valid = true # for now
    @result
  end

  private

  def validate_request
    # should send http request to main microservice
    # should let the request continue if token is valid
    # should halt the request if token is invalid
    response = HTTP.auth(@token).headers(
      accept: 'application/json',
      content_type: 'application/json'
    ).get("#{ENV['MAIN_SERVICE_URL']}/validate")
    @result.valid = true if response.body['valid']
  rescue HTTP::ResponseError => ex
    @result.errors << ex.response
  end
end
