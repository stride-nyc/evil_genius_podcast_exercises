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
        validatable = :amount
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