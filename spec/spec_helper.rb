require "rspec"
require "faker"

RSpec::Expectations.configuration.warn_about_potential_false_positives = false

def leap_year
  range = [(2001...2100), (2501...2600), (3301...3400)].sample
  range.to_a.select { |y| y%4 == 0 }.sample
end

def not_leap_year
  [
    100, 200, 300, 500,
    600, 700, 900, 1000,
    1100, 1300, 1400, 1500,
    1700, 1800, 1900, 2100,
    2200, 2300, 2500, 2600,
    2700, 2900, 3000, 3100,
    3300, 3400, 3500, 3700,
    3800, 3900
  ].sample
end
