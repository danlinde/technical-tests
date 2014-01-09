require 'offers'

describe 'Offers' do
	let(:offers)	{Offers.new}

	before(:all) do
		offers.read_in_csv_data(File.dirname(__FILE__) + '/../market.csv')
	end

	context "read in CSV data"do
		it "should import loan information from a file" do	
	    	expect(offers.pool.size).to eq 7
		end

		it "should give an array of arrays containing all offers" do
			expect(offers.pool).to eq [[0.075, 640], [0.069, 480], [0.071, 520], [0.104, 170], [0.081, 320], [0.074, 140], [0.071, 60]]
		end
	end

	it "should sort the offers by rate in ascending order" do
		expect(offers.sorted_pool).to eq [[0.069, 480], [0.071, 60], [0.071, 520], [0.074, 140], [0.075, 640], [0.081, 320], [0.104, 170]]
	end

	it "should give the total of all the offers in the system" do
		expect(offers.system_total).to eq 2330
	end
	
end