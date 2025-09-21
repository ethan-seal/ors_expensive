select (
  select count(*)
  from application a
  where a.reviewer_id = 10
) + (
  select count(*)
  from application a
  where a.submitter_id = 10
) - (
  select count(*)
  from application a
  where a.submitter_id = 10
  and a.reviewer_id = 10
);
