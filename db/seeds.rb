

# # let's make some users!
# 10.times do
#   User.create(name: Faker::Name.name)
# end

# # let's make some restaurants!
# 10.times do
#   Restaurant.create(name: Faker::Company.name) 
# end

# let's make some reviews!
19.times do
  Review.create(user_id: User.all.sample.id, restaurant_id: Restaurant.all.sample.id, content: Faker::Hacker.say_something_smart, stars: rand(5))
end