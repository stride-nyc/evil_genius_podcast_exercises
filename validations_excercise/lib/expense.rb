class Expense
    def initialize(name:, amount:)
        raise ValidationError.new('Name cannot be nil') if name == nil
        raise ValidationError.new('Name cannot be empty') if name == ''
        raise ValidationError.new('Name cannot be blank') if !name.match(/\S/)
        raise ValidationError.new('Amount cannot be nil') if amount == nil
        validate_amount if amount < 0
    end

    def validate_amount(amount = :Delete_Me)
        raise ValidationError.new('Amount cannot be less than zero')
    end
   class ValidationError < StandardError    
   end 
end