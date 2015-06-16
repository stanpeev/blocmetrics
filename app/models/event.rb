class Event < ActiveRecord::Base
  belongs_to :registered_applications

  default_scope { order('created_at DESC') }
end
