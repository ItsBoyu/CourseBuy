module Entities
  class RecordEntity < Entities::Base
    expose :title
    expose :description
    expose :category, merge: true, using: CategoryEntity
    expose :slug
    expose :orders, using: OrderEntity, if: lambda { |course, options| options[:user] } do |course, options|
      course.purchased_records.select { |order| order.user_id == options[:user].id }
    end
  end
end