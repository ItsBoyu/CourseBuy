# frozen_string_literal: true

class Admin::CoursesController < Admin::BaseController
  before_action :set_course, only: %i[edit update show destroy]
  before_action :set_url, except: :index

  def index
    @courses = Course.includes(:category)
  end

  def show
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_courses_path, notice: t('flash.create.notice')
    else
      flash[:alert] = t('flash.create.alert')
      render :new
    end
  end

  def edit; end

  def update
    if @course.update(course_params)
      redirect_to admin_courses_path, notice: t('flash.update.notice')
    else
      flash[:alert] = t('flash.update.alert')
      render :edit
    end
  end

  def destroy
    redirect_to admin_courses_path, notice: t('flash.destroy.notice') if @course.destroy
  end

  private
  
  def set_course
    @course = Course.find params[:id]
  end

  def set_url
    @base_url = request.base_url.to_s
  end

  def course_params
    params.require(:course).permit(:title, :status, :period, :slug, :category_id,
                                   :description, :price, :price_currency)
  end
end