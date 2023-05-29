every 1.month, at: 'beginning_of_month', roles: [:app] do
  rake 'analysis:send_monthly_analysis'
end