class Expense
    def initialize(name:, amount:)
        validate_name(name)
        validate_amount(validatable: :amount, value: amount)
    end

    def validate_amount(validatable:, value:)
        message = if value == nil
             'nil'
        elsif value < 0
            'less than zero'
        end
        raise ValidationError.new("#{validatable} cannot be #{message}".capitalize) if message
    end

    def validate_name(name)
        message = if name == nil
            'nil'
        elsif name == ''
            'empty'
        elsif !name.match(/\S/)
            'blank'
        end
        validatable = :name
        raise ValidationError.new("#{validatable} cannot be #{message}".capitalize) if message
    end

   class ValidationError < StandardError    
   end 
end