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
        message = if name == nil
            'nil'
        elsif name == ''
            'empty'
        elsif !name.match(/\S/)
            'blank'
        end
        raise ValidationError.new("Name cannot be #{message}") if message
    end

   class ValidationError < StandardError    
   end 
end