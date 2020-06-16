class Restaurant < ActiveRecord::Base 
    has_many :menu_items
    has_many :orders, through: :menu_items
    has_many :customers, through: :orders

    def menu_items
        MenuItem.all.select do |mi|
            mi.restaurant == self
        end
    end

    
end