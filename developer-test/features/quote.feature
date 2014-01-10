Feature: Creating a Loan Quote
	As a borrower
	I want to generate a quote
	So that I can get loan information

	Scenario: Get a quote using proper arguments
		When I run `./quote market.csv 2000`
		Then the output should contain "Requested amount: "

	Scenario: Enter bad information for market_file CSV
		When I run `./quote mark`
		Then the output should contain "Error!"

	Scenario: Enter correct app and market_file but no loan amount
		When I run `./quote market.csv`
		Then the output should contain "Please re-enter your request"