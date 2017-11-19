class Expense
    def initialize(name:, amount:)
        validate_parameter(validatable: :amount, value: amount, checks:[:nil, :less_than_zero])
        validate_parameter(validatable: :name, value: name, checks: [:nil, :empty, :blank])
    end

    def validate_parameter(validatable:, value:, checks:)
        message = checks.reduce(nil) do |msg, check|
            if msg == nil
                msg = send("check_for_#{check}", value)
            end
            msg
        end

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