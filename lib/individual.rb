class Individual < ActiveRecord::Base
    has_many :meetings
    has_many :locations, through: :meetings
end