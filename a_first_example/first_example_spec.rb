require "minitest/autorun"
require_relative 'first_example.rb'

class TestFirstExample < Minitest::Test
  def setup
    @joe = Customer.new('Joe')
    @child_movie = Movie.new('Cars', Movie::CHILDRENS)
    @reg_movie = Movie.new('Jaws', Movie::REGULAR)
    @new_movie = Movie.new('Tag', Movie::NEW_RELEASE)
  end

  def test_3day_child
    @joe.add_rental(Rental.new(@child_movie, 3))

    assert_equal(@joe.statement,
      "Rental Record for Joe\n\t" +
      "Cars\t1.5\nAmount owed is 1.5\n" +
      "You earned 1 frequent renter points")
  end

  def test_5day_child
    @joe.add_rental(Rental.new(@child_movie, 5))

    assert_equal(@joe.statement,
      "Rental Record for Joe\n\t" +
      "Cars\t4.5\n" +
      "Amount owed is 4.5\n" +
      "You earned 1 frequent renter points")
  end

  def test_1day_new
    @joe.add_rental(Rental.new(@new_movie, 1))

    assert_equal(@joe.statement,
      "Rental Record for Joe\n\t" +
      "Tag\t3\n" +
      "Amount owed is 3\n" +
      "You earned 1 frequent renter points")
  end

  def test_2day_new
    @joe.add_rental(Rental.new(@new_movie, 2))

    assert_equal(@joe.statement,
      "Rental Record for Joe\n\t" +
      "Tag\t6\n" +
      "Amount owed is 6\n" +
      "You earned 2 frequent renter points")
  end

  def test_2day_reg
    @joe.add_rental(Rental.new(@reg_movie, 2))

    assert_equal(@joe.statement, 
      "Rental Record for Joe\n\t" + 
      "Jaws\t2\n" + 
      "Amount owed is 2\n" +
      "You earned 1 frequent renter points")
  end

  def test_3day_reg
    @joe.add_rental(Rental.new(@reg_movie, 3))

    assert_equal(@joe.statement,
      "Rental Record for Joe\n\t" +
      "Jaws\t3.5\n" +
      "Amount owed is 3.5\n" +
      "You earned 1 frequent renter points")
  end

  def test_3day_reg_3day_new
    @joe.add_rental(Rental.new(@reg_movie, 3))
    @joe.add_rental(Rental.new(@new_movie, 3))

    assert_equal(@joe.statement,
      "Rental Record for Joe\n\t" +
      "Jaws\t3.5\n\t" +
      "Tag\t9\n" +
      "Amount owed is 12.5\n" +
      "You earned 3 frequent renter points")
  end

  def test_3day_reg_4day_child
    @joe.add_rental(Rental.new(@reg_movie, 3))
    @joe.add_rental(Rental.new(@child_movie, 4))

    assert_equal(@joe.statement,
      "Rental Record for Joe\n\t" +
      "Jaws\t3.5\n\t" +
      "Cars\t3.0\n" +
      "Amount owed is 6.5\n" +
      "You earned 2 frequent renter points")
  end

  def test_2day_new_4day_child
    @joe.add_rental(Rental.new(@new_movie, 2))
    @joe.add_rental(Rental.new(@child_movie, 4))

    assert_equal(@joe.statement,
      "Rental Record for Joe\n\t" +
      "Tag\t6\n\t" +
      "Cars\t3.0\n" +
      "Amount owed is 9.0\n" +
      "You earned 3 frequent renter points")
  end

  def test_2day_new_4day_child_3day_reg
    @joe.add_rental(Rental.new(@new_movie, 2))
    @joe.add_rental(Rental.new(@child_movie, 4))
    @joe.add_rental(Rental.new(@reg_movie, 3))

    assert_equal(@joe.statement,
      "Rental Record for Joe\n\t" +
      "Tag\t6\n\t" +
      "Cars\t3.0\n\t" +
      "Jaws\t3.5\n" +
      "Amount owed is 12.5\n" +
      "You earned 4 frequent renter points")
  end

end



