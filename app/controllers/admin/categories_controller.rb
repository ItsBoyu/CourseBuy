# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('flash.create.notice')
    else
      flash[:alert] = t('flash.create.alert')
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('flash.update.notice')
    else
      flash[:alert] = t('flash.update.alert')
      render :edit
    end
  end

  def destroy
    redirect_to admin_categories_path, notice: t('flash.destroy.notice') if @category.destroy
  end

  private
  
  def set_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit(:name)
  end
end