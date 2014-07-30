class PagesController < ApplicationController
  before_filter :redirect_to_classroom
  def index
  end

  private
  def redirect_to_classroom
    redirect_to classroom_index_path if user_signed_in?
  end
end
