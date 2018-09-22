# frozen_string_literal: true

class ShortUrl::Creator
  attr_accessor :result

  def initialize(options = {})
    @options = options
    @user_id = options[:user_id]
    @original_url = options[:original_url]
    @result = OpenStruct.new(response: nil, status: 400, success: false, errors: [])
  end

  def run!
    generate_url
    @result
  end

  private

  def generate_url
    # should validate original url is a valid url
    raise StandardError, 'Invalid url!' unless validate_url

    # should generate a random string
    random_string = generate_random_string
    # should generate short_url
    short_url = generate_short_url(random_string)
    # should create a url record
    record = create_record(random_string, short_url)
    # should generate a response and update result object
    @result.response = record
    @result.status = 200
    @result.success = true
  rescue StandardError => ex
    @result.errors << ex.message
  end

  def validate_url
    @original_url =~ URI::DEFAULT_PARSER.make_regexp
  end

  def generate_random_string
    Nanoid.generate(size: 10)
  end

  def generate_short_url(random_string)
    base_url + "/#{random_string}"
  end

  def create_record(random_string, short_url)
    Url.create(
      user_id: @user_id, original_url: @original_url,
      short_url: short_url, random_string: random_string
    )
  end

  def base_url
    ENV['APP_URL'] || 'localhost:3000'
  end
end
