require 'minitest/autorun'
require_relative '../lib/expense'


describe 'Expense' do
    it 'initializes with parameters' do
        expense = Expense.new(name: 'Rent', amount: 1650)
        expense.wont_be_nil
    end

    describe 'validations' do
        describe 'name is nil' do
            it 'has error message that name must not be nil' do
                skip
                error = -> { Expense.new(name:nil, amount: 1650) }.must_raise Expense::ValidationError
                error.message.must_equal 'Name cannot be nil'
            end
        end

        describe 'name is empty string' do
            it 'has error message that name must empty' do
                skip
                error = -> { Expense.new(name:'', amount: 1650) }.must_raise Expense::ValidationError
                error.message.must_equal 'Name cannot be empty'
            end
        end

        describe 'name is blank string' do
            it 'has error message that name must not be blank' do
                skip
                error = -> { Expense.new(name:'  ', amount: 1650) }.must_raise Expense::ValidationError
                error.message.must_equal 'Name cannot be blank'
            end
        end

        describe 'amount is nil' do
            it 'has error message that amount must not be nil' do
                skip
                error = -> { Expense.new(name:'Rent', amount: nil) }.must_raise Expense::ValidationError
                error.message.must_equal 'Amount cannot be nil'
            end
        end

        describe 'amount is less than zero' do
            it 'has error message that amount must not be less than zero' do
                skip
                error = -> { Expense.new(name:'Rent', amount: -1) }.must_raise Expense::ValidationError
                error.message.must_equal 'Amount cannot be less than zero'
            end
        end
    end
end