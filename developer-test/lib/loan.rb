require_relative './offers'

class Loan

	attr_accessor :amount
	attr_reader	:matched_pool 

	PERIOD = 36

	def initialize amount
		@amount = amount.to_f
		@matched_pool = []
	end

	def correct_amount?
		if @amount < 1000 || @amount > 15000 || @amount % 100 != 0
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
		offers.sorted_pool.each do |offer|
			if test_balance > 0
				if test_balance >= offer[1]
					@matched_pool << offer
				else
					@matched_pool <<[offer[0], test_balance]
				end
				test_balance -= offer[1]
			end
		end
	end

	def rate
		@matched_pool.inject(0) {|sum, offer| sum + (offer[0] * (offer[1] / self.amount))}
	end

	def total_repayment
		(@amount * ( 1 + self.rate ) ** ( PERIOD / 12 )).round(2)
	end

	def monthly_repayment
		(self.total_repayment / PERIOD).round(2)
	end

end



