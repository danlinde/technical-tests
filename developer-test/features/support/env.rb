require 'aruba/cucumber'

Before do
  @dirs = [File.expand_path("../..", File.dirname(__FILE__))]
end