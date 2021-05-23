module CourseApi
  class Base < Grape::API
    version 'v1', using: :path

    mount Ping
  end
end