class EmbedsController < ApplicationController
  require 'oembed'
  protect_from_forgery

  OEmbed::Providers.register(OEmbed::Providers::Twitter)
  OEmbed::Providers::Twitter.endpoint += "?=omit_script=true"

  def create
    begin
      response = OEmbed::Providers.get(params[:url])
    rescue OEmbed::NotFound
      head 422 and return
    end

    if @embed == Embed.create(url: params[:url], raw_info: response.to_json)
      render :show, status: 201
    else
      render json: @embed.errors, status: 422
    end
  end
end
