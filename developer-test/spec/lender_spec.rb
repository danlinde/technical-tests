require 'lender'

describe Lender do
	let(:lender)	{Lender.new("Bob", "0.1", "500")}

	it "should be initialized with a name" do
		expect(lender.name).to	eq "Bob"
	end

	it "should be initialized with a rate" do
		expect(lender.rate).to	eq 0.1
	end

	it "should be initialized with an available amount to lend" do
		expect(lender.amount_avail).to	eq 500
	end

end