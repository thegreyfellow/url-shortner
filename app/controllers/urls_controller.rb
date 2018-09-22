# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    @urls = Url.where(user_id: current_user_id)
  end

  def create
    result = ShortUrl::Creator.new(
      user_id: current_user_id,
      original_url: url_create_params[:original_url]
    ).run!

    response = result.success ? result.response : { errors: result.errors }
    render status: result.status, json: response
  end

  def destroy
    Url.find_by(id: params[:id], user_id: current_user_id).destroy
  end

  def redirect
    url = Url.find_by(random_string: params[:random_string])

    redirect_to url.original_url
  end

  private

  def url_create_params
    params.require(:url).permit(:original_url)
  end
end
