require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_site_title

 # Include a module for sessions
  include SessionsHelper


  def get_site_title
    @site_title = Setting.site_title
  end

  def access_denied(exception)
    redirect_to root_path, notice: exception.message
  end
end
