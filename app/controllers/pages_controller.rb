class PagesController < ApplicationController

  def index
    if user_signed_in? == true
      redirect_to classroom_index_path
    end
  end
end
