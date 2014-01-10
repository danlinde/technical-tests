require 'loan'

describe Loan do
	let(:loan) {Loan.new(2000)}

	context "amounts" do
		it "should know its amount" do
			expect(loan.amount).to eq 2000
		end

		it "should notify the user if the requested amount is out of range" do
			loan = Loan.new(100)
			expect(loan.incorrect_amount?).to eq "Please re-enter your request using a loan amount between £1,000 and £15,000 in increments of £100."
		end

		it "should notify the user if the requested amount is not incremented in hundreds" do
			loan = Loan.new(1157)
			expect(loan.incorrect_amount?).to eq "Please re-enter your request using a loan amount between £1,000 and £15,000 in increments of £100."
		end

		it "should notify the user if there are not sufficient offers" do
			offers = double(:offers, {:system_total => 1000})
			expect(loan.market_has_sufficient?(offers)).to eq "It is not possible to provide a quote at this time"
		end

		it "should NOT notify the user if there are sufficient offers" do
			offers = double(:offers, {:system_total => 3000})
			expect(loan.market_has_sufficient?(offers)).to eq nil
		end
	end

	context "specs" do
		before(:each) do
			lender1 = double(:lender1, {:name => "Bob", :rate => 0.05, :amount_avail => 1000})
			lender2 = double(:lender2, {:name => "Pete", :rate => 0.07, :amount_avail => 300})
			lender3 = double(:lender3, {:name => "Jane", :rate => 0.1, :amount_avail => 800})
			offers = double(:offers, {:sorted_pool => [lender1, lender2, lender3]})
			loan.matched(offers)
			loan.rate
		end

		it "include lender1 and lender2 in the loan" do
			expect(loan.matched_pool.flatten.to_s).to include ":lender1" && ":lender2"
		end

		it "should not include lender3 in the loan" do
			expect(loan.matched_pool.flatten.to_s).not_to include ":lender3"
		end

		it "should include a new lender3 with only the amount needed" do
			expect(loan.matched_pool.flatten.to_s).to include "Jane" && "700"
		end

		it "should determine the rate of the loan" do
			expect((loan.rate).round(4)).to eq 0.0705
		end

		it "should determine the total repayment" do
			expect(loan.total_repayment).to eq 2453.52
		end

		it "should determine the monthly repayment" do
			loan.total_repayment
			expect(loan.monthly_repayment).to eq 68.15
		end
	end

end
