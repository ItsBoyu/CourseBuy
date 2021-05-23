module CourseApi
  module AuthenticationHelper
    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end

    def current_user
      @current_user ||= User.find_by_auth_token(auth_token)
    end

    def auth_token
      @auth_token ||= headers['Authorization']
    end
  end
end