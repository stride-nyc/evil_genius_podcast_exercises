class Expense
    def initialize(name:, amount:)
        validate_name(validatable: :name, value: name)
        validate_amount(validatable: :amount, value: amount)
    end

    def validate_amount(validatable:, value:)
        message =  check_for_nil(value) || check_for_less_than_zero(value)

        raise ValidationError.new("#{validatable} cannot be #{message}".capitalize) if message
    end

    def validate_name(validatable:, value:)
        message = check_for_nil(value) || check_for_empty(value) || check_for_blank(value)

        raise ValidationError.new("#{validatable} cannot be #{message}".capitalize) if message
    end

    def check_for_nil(value)
        if value == nil
            'nil'
        end
    end

    def check_for_less_than_zero(value)
        if value < 0
            'less than zero'
        end 
    end

    def check_for_empty(value)
        if value == ''
            'empty'
        end
    end

    def check_for_blank(value)
        if  /^\s*$/ === value
            'blank'
        end
    end

   class ValidationError < StandardError    
   end 
end