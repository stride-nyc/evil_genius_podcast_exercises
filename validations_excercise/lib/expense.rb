class Expense
  def self.validates(attribute)
    raise ValidationError, 'Name cannot be nil' if attribute.nil?
  end

  validates :name

  def initialize(options = {})
    if options[:name].empty?
      raise ValidationError, 'Name cannot be empty'
    elsif options[:name].strip.empty?
      raise ValidationError, 'Name cannot be blank'
    elsif options[:amount].nil?
      raise ValidationError, 'Amount cannot be nil'
    elsif options[:amount] < 0
      raise ValidationError, 'Amount cannot be less than zero'
    end
  end
end

class ValidationError < StandardError
end
