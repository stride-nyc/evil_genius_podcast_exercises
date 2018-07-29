# Ruby Refactoring A first example
class Movie
  CHILDRENS = 2
  REGULAR = 0
  NEW_RELEASE = 1
  
  attr_reader :title
  attr_accessor :price_code
  
  def initialize(title, price_code)
    @title, @price_code = title, price_code
  end
end


class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end
end

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{@name}\n"
    @rentals.each do |rental|
      this_amount = 0

      # determine amounts for each line
      this_amount += base_cost_of_rental(rental)
      case rental.movie.price_code
        when Movie::REGULAR
          this_amount += (rental.days_rented - 2) * 1.5 if rental.days_rented > 2
        when Movie::NEW_RELEASE
        when Movie::CHILDRENS
          this_amount += (rental.days_rented - 3) * 1.5 if rental.days_rented > 3
      end

      # add frequent renter points
      frequent_renter_points += 1
      # add bonus for a two day new release rental
      frequent_renter_points += 1 if rental.movie.price_code == Movie::NEW_RELEASE && rental.days_rented > 1

      # show figures for this rental
      result += "\t" + rental.movie.title + "\t" + this_amount.to_s + "\n"
      total_amount += this_amount
    end
    # add footer lines
    result += "Amount owed is #{total_amount.to_s}\n"
    result += "You earned #{frequent_renter_points.to_s} frequent renter points"
    result
  end

  def base_cost_of_rental(rental)
    case rental.movie.price_code
    when Movie::REGULAR
      2
    when Movie::NEW_RELEASE
      rental.days_rented * 3
    when Movie::CHILDRENS
      1.5
    end
  end
end