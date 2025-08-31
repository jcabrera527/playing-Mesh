MODEL (
  -- The name of the NEW table we want to create
  name poc.stg_exports,
  kind FULL,
  owner 'Xtillion',
  description 'Cleans and prepares export data, calculating total value.'
);

SELECT
  id AS export_id,
  export_date,
  quantity,
  hts AS hts_code,
  value_per_unit,
  -- Add a new calculated column for total value
  quantity * value_per_unit AS total_value
FROM alliance.raw.10k_exports_hackathon; -- This creates the lineage link to the source model