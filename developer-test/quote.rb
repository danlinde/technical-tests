#!/usr/bin/env ruby

class Quote

require './lib/loan'

	def run
		market_file, loan_amount_string = ARGV

		offers = Offers.new
		offers.read_in_csv_data(market_file)
		offers.system_total

		loan = Loan.new(loan_amount_string)
		abort(loan.correct_amount?) if loan.correct_amount? 
		abort(loan.market_has_sufficient?(offers)) if loan.market_has_sufficient?(offers) 

		offers.sorted_pool
		loan.matched(offers)
		loan.total_repayment

		puts "Requested amount: £#{ARGV[1]}"
		puts "Rate: #{(loan.rate).round(2)}%"
		puts "Monthly repayment: #{sprintf("£%5.2f", loan.monthly_repayment)}"
		puts "Total repayment: #{sprintf("£%5.2f", loan.total_repayment)}"
	end

end

Quote.new.run