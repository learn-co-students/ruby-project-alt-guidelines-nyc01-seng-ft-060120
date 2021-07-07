class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews


  def pp_reviews
    puts "This Fine Establishment has #{reviews.count} reviews."

    reviews.each do |r|
      sleep 0.3
      puts "-" * 30
      puts "#{r.stars} stars"
      puts r.content
      puts r.user.name
    end
  end

  def show_review_header
    puts "\n" * 3
    puts "-" * 30
    puts "***** Reviews for #{name} *****"
    puts "\n" * 3
  end
  
  


  def show_reviews
    system("clear")
    sleep 1
    show_review_header
    sleep 1
    if reviews.any?
      pp_reviews
    else
      puts "Sorry, there are now reviews for this restaurant."
    end
  end
  

end