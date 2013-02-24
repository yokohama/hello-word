class ApplicationController < ActionController::Base
   protect_from_forgery

=begin
  after_filter :add_flash_to_header

  def add_flash_to_header
    return unless request.xhr?

    response.headers['X-Flash-Error'] = flash[:error] unless flash[:error].blank?
    response.headers['X-Flash-Warning'] = flash[:warning] unless flash[:warning].blank?
    response.headers['X-Flash-Notice'] = flash[:notice] unless flash[:notice].blank?
    response.headers['X-Flash-Message'] = flash[:message] unless flash[:message].blank?

    flash.discard
  end
=end

end
