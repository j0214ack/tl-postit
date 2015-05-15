class CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :edit, :update]

  def show
    @posts = @category.posts
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "New category added."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category updated"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
