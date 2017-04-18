class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :package ]

  def home
  end

  def package
    @categories = Category.all
    @items = Item.all
  end

  def package_main
    @categories = Category.all
    @items = Item.all
  end

  def category_params
    params.require(:category).permit(:item_type)
  end
end
