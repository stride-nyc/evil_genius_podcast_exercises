require 'minitest/autorun'
require_relative '../lib/expense'


describe 'Expense' do
    it 'initializes with parameters' do
        expense = Expense.new(name: 'Rent')
        expense.wont_be_nil
    end

    describe 'validations' do
        describe 'name is nil' do
            it 'has error message that name must not be nil' do
                error = -> { Expense.new(name:nil) }.must_raise Expense::ValidationError
                error.message.must_equal 'Name cannot be nil'
            end
        end

        describe 'name is empty string' do
            it 'has error message that name must empty' do
                error = -> { Expense.new(name:'') }.must_raise Expense::ValidationError
                error.message.must_equal 'Name cannot be empty'
            end
        end

        describe 'name is blank string' do
            it 'has error message that name must not be blank' do
                error = -> { Expense.new(name:'  ') }.must_raise Expense::ValidationError
                error.message.must_equal 'Name cannot be blank'
            end
        end
    end
end