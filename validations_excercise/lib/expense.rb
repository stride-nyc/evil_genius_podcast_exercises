class Expense
    def initialize(name:)
        raise ValidationError.new('Name cannot be nil') if name == nil
        raise ValidationError.new('Name cannot be empty') if name == ''
        raise ValidationError.new('Name cannot be blank') if name.strip == ''
    end

   class ValidationError < StandardError    
   end 
end