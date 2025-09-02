-- models/weekly_exports_summary.sql
MODEL (
  -- The name of our new, 4th model
  name poc.weekly_exports_summary,
  kind INCREMENTAL_BY_TIME_RANGE (
    time_column week_start_date
  ),
  owner 'Xtillion',
  description 'Summarizes total export value to a weekly level.'
);

SELECT
  -- Truncate the daily date to the start of the week
  DATE_TRUNC('week', export_date) AS week_start_date,
  SUM(total_quantity) AS total_weekly_quantity,
  SUM(total_revenue) AS total_weekly_revenue,
  SUM(number_of_exports) AS total_weekly_exports
FROM poc.daily_exports_summary -- This creates the lineage link to our 3rd model
WHERE
  -- SQLMesh needs the time column for incremental loads to be in the WHERE clause
  DATE_TRUNC('week', export_date) BETWEEN @start_date AND @end_date
GROUP BY
  DATE_TRUNC('week', export_date);
