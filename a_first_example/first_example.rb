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

  def base_charge
    case movie.price_code
    when Movie::REGULAR
      2
    when Movie::CHILDRENS
      1.5
    when Movie::NEW_RELEASE
      days_rented * 3
    end
  end

  def extra_charge
    if days_rented > base_period
      (days_rented - base_period) * 1.5
    else
      0
    end
  end

  def base_period
    case movie.price_code
    when Movie::REGULAR
      2
    when Movie::CHILDRENS
      3
    when Movie::NEW_RELEASE
      Float::INFINITY
    end
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

      this_amount += charge_for_rental(rental)

      frequent_renter_points += points_for_rental(rental)

      # show figures for this rental
      result += "\t" + rental.movie.title + "\t" + this_amount.to_s + "\n"
      total_amount += this_amount
    end
    # add footer lines
    result += "Amount owed is #{total_amount.to_s}\n"
    result += "You earned #{frequent_renter_points.to_s} frequent renter points"
    result
  end

  def charge_for_rental(rental)
    case rental.movie.price_code
    when Movie::REGULAR
      rental.base_charge + rental.extra_charge
    when Movie::NEW_RELEASE
      rental.base_charge + rental.extra_charge
    when Movie::CHILDRENS
      rental.base_charge + rental.extra_charge
    end
  end

  def points_for_rental(rental)
    case rental.movie.price_code
    when Movie::CHILDRENS, Movie::REGULAR
      1
    when Movie::NEW_RELEASE
      if rental.days_rented > 1
        2
      else
        1
      end
    end
  end
end