class CategoryItemsController < ApplicationController

  def index
    @category = Category.all
  end


end
