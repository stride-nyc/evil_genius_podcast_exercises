class Expense
    def initialize(name:, amount:)
        validate_name(validatable: :name, value: name)
        validate_amount(validatable: :amount, value: amount)
    end

    def validate_amount(validatable:, value:)
        message =  validation_message(value) || if value < 0
            'less than zero'
        end
        raise ValidationError.new("#{validatable} cannot be #{message}".capitalize) if message
    end

    def validate_name(validatable:, value:)
        message = validation_message(value) || case value
        when  ''
            'empty'
        when /^\s*$/
            'blank'
        end

        raise ValidationError.new("#{validatable} cannot be #{message}".capitalize) if message
    end

    def validation_message(value)
        if value == nil
            'nil'
        end
    end

   class ValidationError < StandardError    
   end 
end