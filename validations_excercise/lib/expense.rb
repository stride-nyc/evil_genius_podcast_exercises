class Expense
  def initialize(options = {})
    if options[:name].nil?
      raise Expense::ValidationError, 'Name cannot be nil'
    elsif options[:name].empty?
      raise Expense::ValidationError, 'Name cannot be empty'
    elsif options[:name].strip.empty?
      raise Expense::ValidationError, 'Name cannot be blank'
    elsif options[:amount].nil?
      raise Expense::ValidationError, 'Amount cannot be nil'
    elsif options[:amount] < 0
      raise Expense::ValidationError, 'Amount cannot be less than zero'
    end
  end
end

class Expense::ValidationError < StandardError
end
