class Location < ActiveRecord::Base
    has_many :meetings
    has_many :individuals ,through: :meetings





end