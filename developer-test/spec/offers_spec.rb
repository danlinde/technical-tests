require 'offers'

describe 'Offers' do
	let(:offers) do
		offers = Offers.new.read_in_csv_data(path_to_csv_fixture)
	end

	it "should import offer information from a CSV file" do	
    	expect(offers.pool.size).to eq 7
	end

	it "should sort the offers by rate in ascending order" do
		expect(offers.sorted_pool[0].rate).to eq 0.069
		expect(offers.sorted_pool[6].rate).to eq 0.104
	end

	it "should give the total of all the offers in the system" do
		expect(offers.system_total).to eq 2330
	end
	
end

def path_to_csv_fixture
	File.dirname(__FILE__) + '/../fixtures/market.csv'
end