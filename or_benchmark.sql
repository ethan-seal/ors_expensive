select count(*)
from application a
where a.reviewer_id = 10
or a.submitter_id = 10;
