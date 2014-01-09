require 'csv'

class Offers

	attr_accessor :pool

	def initialize
		@pool = []
	end

	def read_in_csv_data(csv_file_name)
		CSV.foreach(csv_file_name, headers: true) do |row| 
			@pool << [row["Rate"].to_f, row["Available"].to_f]
		end
	end

	def sorted_pool
		@pool.sort_by {|e| e[0]}
	end

	def system_total
		@pool.inject(0) {|sum, e| sum + e[1]}
	end
	
end
