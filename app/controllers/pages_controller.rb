class PagesController < ApplicationController
  def index
    redirect_to categories_path unless current_user.nil?
  end
end
