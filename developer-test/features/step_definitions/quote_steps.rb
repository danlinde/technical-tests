When /^I run "(.*)"$/ do |cmd|
  run_simple(unescape(cmd), false)
end

Then /^the output should contain: "(.*?)"$/ do |expected|
  assert_partial_output(expected, all_output)
end