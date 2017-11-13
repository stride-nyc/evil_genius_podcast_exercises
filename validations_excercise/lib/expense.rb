class Expense
    def initialize(name:, amount:)
        validate_name(name)
        validate_amount(amount)
    end

    def validate_amount(amount)
        message = if amount == nil
             'nil'
        elsif amount < 0
            'less than zero'
        end
        raise ValidationError.new("Amount cannot be #{message}") if message
    end

    def validate_name(name)
        if name == nil
            raise ValidationError.new('Name cannot be nil')
        elsif name == ''
            raise ValidationError.new('Name cannot be empty')
        elsif !name.match(/\S/)
            raise ValidationError.new('Name cannot be blank')
        end
    end

   class ValidationError < StandardError    
   end 
end