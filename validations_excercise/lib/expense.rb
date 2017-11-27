class Expense
  def initialize(options = {})
    if options[:name].nil?
      raise ValidationError, 'Name cannot be nil'
    elsif options[:name].empty?
      raise ValidationError, 'Name cannot be empty'
    elsif options[:name].strip.empty?
      raise ValidationError, 'Name cannot be blank'
    elsif options[:amount].nil?
      raise ValidationError, 'Amount cannot be nil'
    elsif options[:amount] < 0
      raise ValidationError, 'Amount cannot be less than zero'
    end
  end

  class ValidationError < StandardError
  end
end
