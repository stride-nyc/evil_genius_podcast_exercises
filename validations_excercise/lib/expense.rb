class Expense
    def initialize(name:, amount:)
        raise ValidationError.new('Name cannot be nil') if name == nil
        raise ValidationError.new('Name cannot be empty') if name == ''
        raise ValidationError.new('Name cannot be blank') if !name.match(/\S/)
        raise ValidationError.new('Amount cannot be nil') if amount == nil
        raise ValidationError.new('Amount cannot be less than zero') if amount < 0
    end
   class ValidationError < StandardError    
   end 
end