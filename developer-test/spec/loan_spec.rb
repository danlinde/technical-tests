require 'loan'

describe Loan do
	let(:loan) {Loan.new(2000)}

	context "amounts" do
		it "should know its amount" do
			expect(loan.amount).to eq 2000
		end

		it "should notify the user if the requested amount is incorrect" do
			loan = Loan.new(100)
			expect(loan.correct_amount?).to eq "Please re-enter your request using a loan amount between £1,000 and £15,000 in increments of £100."
		end

		it "should notify the user if the requested amount is incorrect" do
			loan = Loan.new(1157)
			expect(loan.correct_amount?).to eq "Please re-enter your request using a loan amount between £1,000 and £15,000 in increments of £100."
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
			offers = double(:offers, {:sorted_pool => [[0.069, 480], [0.071, 60], [0.071, 520], [0.074, 140], [0.075, 640], [0.081, 320], [0.104, 170]]})
			loan.matched(offers)
			loan.rate
		end

		it "should determine the best offers to include in the loan" do
			expect(loan.matched_pool).to eq [[0.069, 480], [0.071, 60], [0.071, 520], [0.074, 140], [0.075, 640], [0.081, 160]]
		end

		it "should determine the rate of the loan" do
			expect(loan.rate).to eq 0.07281
		end

		it "should determine the total repayment" do
			expect(loan.total_repayment).to eq 2469.44
		end

		it "should determine the monthly repayment" do
			loan.total_repayment
			expect(loan.monthly_repayment).to eq 68.60
		end
	end

end
