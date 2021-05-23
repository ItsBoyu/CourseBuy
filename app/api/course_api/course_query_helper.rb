module CourseApi
  module CourseQueryHelper
    def course_query(user, params)
      courses = params[:only_available] ? user.available_courses : user.purchased_courses
      params[:category].present? ? courses.filter_by_category(params[:category]) : courses 
    end
  end
end