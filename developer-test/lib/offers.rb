require 'csv'
require_relative './lender'

class Offers

	attr_accessor :pool

	def initialize
		@pool = []
	end

	def read_in_csv_data(csv_file_name)
		CSV.foreach(csv_file_name, headers: true) do |row| 
			@pool << Lender.new(row["Lender"], row["Rate"], row["Available"])
		end
		self
		rescue => e
			application_error
	end

	def sorted_pool
		@pool.sort_by {|lender| lender.rate}
	end

	def system_total
		@pool.inject(0) {|sum, lender| sum + lender.amount_avail}
	end

	def application_error
	  	puts "Error!"
		puts "Please enter your application in this format:  cmd> [application] [market_file] [loan_amount]"
		puts "For example: cmd> quote.exe market.csv 1500"
		abort
	end
	
end
