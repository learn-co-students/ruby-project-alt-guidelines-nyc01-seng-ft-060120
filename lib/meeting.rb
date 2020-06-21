class Meeting < ActiveRecord::Base
    belongs_to :individual
    belongs_to :location
end