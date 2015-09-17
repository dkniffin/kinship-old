class StaticPagesController < ApplicationController
  def home
    @blurb_content = Setting.homepage_blurb
  end
end
