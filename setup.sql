select setseed(0.5);

drop table application;

create table application (
  application_id serial primary key,
  submitter_id int4 not null,
  reviewer_id int4 not null
);

insert into application (submitter_id, reviewer_id)
select (random()*999)::int + 1, (random()*999)::int + 1
from generate_series(1, 1_000_000);

create index index_application_submitter on application (submitter_id);
create index index_application_reviewer on application (reviewer_id);

vacuum analyze;

CHECKPOINT;
