MODEL (
  -- The name of the final aggregated table
  name poc.daily_exports_summary,
  kind INCREMENTAL_BY_TIME_RANGE (
    time_column export_date -- Use the date column for incremental loads
  ),

  grain (export_date),


  owner 'Xtillion',
  description 'Summarizes total export quantity and value by day.',
  cron '@daily' -- Schedule this model to run once a day
);

SELECT
  export_date,
  SUM(quantity) AS total_quantity,
  SUM(total_value) AS total_revenue,
  COUNT(DISTINCT export_id) AS number_of_exports
FROM poc.stg_exports -- This creates the lineage link to the staging model
WHERE
  -- SQLMesh automatically fills in the dates for each run
  export_date BETWEEN @start_date AND @end_date

  -- Our logic change to only include sales with a value > 100
  AND total_value > 100

GROUP BY
  export_date;