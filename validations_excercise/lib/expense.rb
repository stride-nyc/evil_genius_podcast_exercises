class Expense
  def validates(value, attribute)
    if value.class == NilClass
      raise ValidationError, "#{attribute.capitalize} cannot be nil" if value.nil?
    elsif value.class == String
      raise ValidationError, 'Name cannot be empty' if value.empty?
      raise ValidationError, 'Name cannot be blank' if value.strip.empty?
    elsif value.class == Integer
      raise ValidationError, 'Amount cannot be less than zero' if value < 0
    end
  end

  def initialize(name:, amount:)
    validates(name, :name)
    validates(amount, :amount)
  end
end

class Expense::ValidationError < StandardError
end
