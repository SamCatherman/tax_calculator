# Assume this application will be used by a 3rd party tax consultant who will have to run this for
# 100 clients.
# Write a program that is scalable.
# The program should take the $ income and return the tax amount.
class TaxBreakdown
  attr_accessor :income, :employee_name
  def initialize(income, employee_name)
    @income = income
    @employee_name = employee_name
    # a tax bracket has many rates
    # each rate has an amount, an upper and lower limit
    @tax_bracket_rates = {
      :top => { rate: 0.3, upper_limit: Float::INFINITY, lower_limit: 50000 },
      :mid => { rate: 0.2, upper_limit: 50000, lower_limit: 20000 },
      :low => { rate: 0.1, upper_limit: 20000, lower_limit: 10000 }
    } # while this map is hardcoded here, a scaleable solution would include an abstraction of this data, stored in a database with processes for updating bracket rates across years.

    # match income to appropriate bracket
    @tax_bracket_rates.each do |bracket|
      @current_bracket = @tax_bracket_rates[bracket[0]] if income.between?(bracket[1][:lower_limit], bracket[1][:upper_limit])
    end
  end

  # rate: { id: 1, bracket_id: 1, rate: 10% }
  # bracket: { id: 1, bracket_name: low, upper_limit: 10000, lower_limit: 0, rate_id: 1 }
  # @return tax-amount [Integer]
  def amount_due
    return unless income.positive?
    # for incomes greater than 50k, apply all rates to relevant sections
    tax_amount_due = taxable_at_current_bracket(@current_bracket[:lower_limit]) * @current_bracket[:rate]

    # for all brackets lower than current, add taxable income at appropriate rates
    brackets_lower_than_current = @tax_bracket_rates.values.select {|rate| income > rate[:upper_limit]}
    brackets_lower_than_current.each do |bracket|
      tax_amount_due += (bracket[:upper_limit] - bracket[:lower_limit]) * bracket[:rate]
    end
    tax_amount_due
  end

  # Difference between income and highest bracket's upper limit
  # @param upper limit for current bracket [Integer]
  # @return amount of taxable income above given bracket [Integer]
  def taxable_at_current_bracket(limit)
    income - limit
  end

  # Result of the calculation including original income and employee name
  # @ return result [Hash]
  def result
    { amount_due: amount_due, income: income, employee: employee_name }
  end
end

### Run the calculation ###
tax_breakdown = TaxBreakdown.new(115000, "Sam")
tax_breakdown2 = TaxBreakdown.new(45000, "Bob")
tax_breakdown3 = TaxBreakdown.new(15000, "Leslie")

puts "tax_breakdown: #{tax_breakdown.result}"
puts "tax_breakdown2: #{tax_breakdown2.result}"
puts "tax_breakdown3: #{tax_breakdown3.result}"
###############################################