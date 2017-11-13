class Expense
    def initialize(name:, amount:)
        raise ValidationError.new('Name cannot be nil') if name == nil
        raise ValidationError.new('Name cannot be empty') if name == ''
        raise ValidationError.new('Name cannot be blank') if !name.match(/\S/)
        validate_amount(amount)
    end

    def validate_amount(amount)
        if amount == nil
            raise ValidationError.new('Amount cannot be nil')
        elsif amount < 0
            raise ValidationError.new('Amount cannot be less than zero')
        end
    end

   class ValidationError < StandardError    
   end 
end