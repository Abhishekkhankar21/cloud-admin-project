resource "aws_budgets_budget" "monthly" {

  name = "MonthlyBudget"

  budget_type = "COST"

  limit_amount = "100"

  limit_unit = "USD"

  time_unit = "MONTHLY"
}