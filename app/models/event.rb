class Event < ActiveRecord::Base
  belongs_to :registered_application

  default_scope { order('created_at DESC') }
end
