  --I am familiar with BigQuery so will be using this SQL dialect
  --indenting lines to make code readable
  --uppercasing all syntax to keep casing consistent
WITH
  most_recent_filing_id AS (
  SELECT
    filer_committee_id_number,
    coverage_from_date,
    coverage_through_date,
    MAX(fec_report_id) AS report_id,
  FROM
    f3x_fecfile
  WHERE
    filer_committee_id_number = 'C00401224'
    AND coverage_from_date BETWEEN '2020-01-01'
    AND '2020-03-31'
  GROUP BY 1, 2, 3),

  --naming this part of the query donations so it's easy to read and referenceable
  --naming must be done to prevent syntax error after limit 1600000
  donations AS (
  SELECT
    sa.fec_report_id,
    sa.date_report_received,
    sa.form_type,
    sa.filer_committee_id_number,
    sa.transaction_id,
    sa.entity_type,
    sa.contributor_last_name,
    sa.contributor_first_name,
    sa.contributor_street_1,
    sa.contributor_city,
    sa.contributor_state,
    sa.contributor_zip_code,
    sa.contribution_date,
    --changing syntax to cast instead of :: to align with GoogleSQL syntax
    CAST(sa.contribution_amount AS string) AS contribution_amount,
    CAST(sa.contribution_aggregate AS string) AS contribution_amount,
    sa.contribution_purpose_descrip,
    sa.contributor_employer,
    sa.contributor_occupation,
    sa.memo_text_description,
  FROM
    sa_fecfile sa
    --'lr' has no reference, report_id is from most_recent_filing_id so renamed most_recent_filing_id to lr
  JOIN most_recent_filing_id lr ON sa.fec_report_id = lr.report_id
  WHERE
    UPPER(sa.form_type)='SA11AI'
  ORDER BY random()
  LIMIT 1600000),

  FEC_Committee_Data_2020 AS (
  --what columns are we selecting? must know this in order to do future join
  --assumptions: FEC_Committee_Data_2020 is same dataset as 'bigquery-public-data.fec.committee_2020'
  SELECT
    *
  FROM
    fec_committees
  WHERE
    bg_cycle=2020 )

SELECT
  cmte_nm,
  SUM(CASE WHEN instate=TRUE THEN total END) AS instate,
  SUM(CASE WHEN instate=FALSE THEN total END) AS outofstate,
  --changing syntax to cast instead of :: to align with GoogleSQL syntax
  CAST(SUM(CASE WHEN instate=TRUE THEN total END) AS numeric) / CAST(SUM(total) AS numeric) AS instate_pct
FROM (
  SELECT
    c.cmte_nm,
    c.cmte_st,
    b.contributor_state,
    c.cmte_st = b.contributor_state AS instate,
    b.total,
  FROM (
    SELECT
      a.filer_committee_id_number,
      a.contributor_state,
      --putting 'as' in front of total to keep consistency of renaming variables when selecting
      SUM(a.contribution_aggregate) AS total
    FROM
      DS_technical_112221 a
    GROUP BY 1, 2) b
  --must indicate a join condition when combining data
  --assumed cmte_id name because that's the committee id column name from 'bigquery-public-data.fec.committee_2020'
  --joining on committee_id because that id because each committee has a unique id that I assume is same across all datasets
  JOIN FEC_Committee_Data_2020 c ON b.filer_committee_id_number = c.cmte_id )
GROUP BY 1
HAVING cmte_nm = 'ACTBLUE';
