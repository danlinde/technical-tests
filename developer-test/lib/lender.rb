class Lender

	attr_reader :name, :rate
	attr_accessor :amount_avail
	
	def initialize (name, rate, amount_avail)
		@name = name
		@rate = Float(rate)
		@amount_avail = Float(amount_avail)
	end
end
