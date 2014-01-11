require_relative './offers'

class Loan

	attr_accessor :amount
	attr_reader	:matched_pool 

	PERIOD = 36
	LOAN_RANGE = (1000...15000)

	def initialize amount
		@amount = amount.to_f
		@matched_pool = []
	end

	def incorrect_amount?
		if  self.out_of_range || self.not_in_hundreds
			return "Please re-enter your request using a loan amount between £1,000 and £15,000 in increments of £100."
		end
	end

	def market_has_sufficient? offers
		if @amount > offers.system_total
			return "It is not possible to provide a quote at this time"
		end
	end

	def matched offers
		test_balance = @amount
		offers.sorted_pool.each do |lender|
			if test_balance >= lender.amount_avail
				@matched_pool << lender
			else
				@matched_pool << Lender.new(lender.name, lender.rate, test_balance)
				return
			end
			test_balance -= lender.amount_avail
		end
	end

	def rate
		@matched_pool.inject(0) {|sum, lender| sum + (lender.rate * (lender.amount_avail / self.amount))}
	end

	def total_repayment
		(@amount * ( 1 + self.rate / 12 ) ** PERIOD).round(2)
	end

	def monthly_repayment
		(self.total_repayment / PERIOD).round(2)
	end

	def out_of_range
		!LOAN_RANGE.cover?(@amount)
	end

	def not_in_hundreds
		@amount % 100 != 0
	end

end



