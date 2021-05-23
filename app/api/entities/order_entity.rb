module Entities
  class OrderEntity < Entities::Base
    expose :amount, format_with: :price
    expose :amount_currency
    expose :created_at, format_with: :iso8601
    expose :expired_at, format_with: :iso8601
    expose :paid_at, format_with: :iso8601
    expose :state
  end
end