MODEL (
  name poc.exports_source,
  kind VIEW,
  owner 'rvo_team',
  description 'Passthrough to alliance.raw.10k_exports_hackathon for downstream models.'
);

SELECT
  id,
  export_date,
  quantity,
  hts,
  value_per_unit
FROM alliance.raw.`10k_exports_hackathon`;