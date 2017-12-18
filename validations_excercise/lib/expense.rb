class Expense
  def validates(attribute)
    raise ValidationError, 'Name cannot be nil' if attribute.nil?
    raise ValidationError, 'Name cannot be empty' if attribute.empty?
    raise ValidationError, 'Name cannot be blank' if attribute.strip.empty?
  end

  def initialize(name:, amount:)
    validates(name)
    if amount.nil?
      raise ValidationError, 'Amount cannot be nil'
    elsif amount < 0
      raise ValidationError, 'Amount cannot be less than zero'
    end
  end
end

class Expense::ValidationError < StandardError
end
