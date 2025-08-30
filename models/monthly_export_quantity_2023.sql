MODEL (
  name alliance.sqlmesh_example.monthly_export_quantity_2023,
  kind FULL,
  dialect databricks,
  owner jcabrera527,
  description "Calculates the total export quantity per month for the year 2023."
);

/*
To determine the monthly export quantity for the year 2023, we'll analyze 
the quantity column from the alliance.raw.10k_exports_hackathon table, 
ensuring we filter records based on the export_date that falls within the year 2023. 
By aggregating these quantities by month, we can provide a clear view of the 
export quantities on a month-by-month basis for the given year.
*/
SELECT 
    MONTH(export_date) AS month, 
    SUM(quantity) AS monthly_export_quantity
FROM 
    alliance.raw.10k_exports_hackathon
WHERE 
    YEAR(export_date) = 2023
GROUP BY 
    MONTH(export_date)
ORDER BY 
    month