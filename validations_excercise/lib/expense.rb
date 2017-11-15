class Expense
    def initialize(name:, amount:)
        validate_name(validatable: :name, value: name)
        validate_amount(validatable: :amount, value: amount)
    end

    def validate_amount(validatable:, value:)
        message = if value == nil
             'nil'
        elsif value == -1
            'less than zero'
        end
        raise ValidationError.new("#{validatable} cannot be #{message}".capitalize) if message
    end

    def validate_name(validatable:, value:)
        message = if value == nil
            'nil'
        elsif value == ''
            'empty'
        elsif !value.match(/\S/)
            'blank'
        end
        raise ValidationError.new("#{validatable} cannot be #{message}".capitalize) if message
    end

   class ValidationError < StandardError    
   end 
end