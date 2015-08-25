class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_site_header

 # Include a module for sessions
  include SessionsHelper


  def get_site_header
    @site_header = Setting.site_header
  end
end
