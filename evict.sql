create extension if not exists pg_buffercache;

select distinct pg_buffercache_evict(bufferid)
from pg_buffercache
where relfilenode in (
  pg_relation_filenode('index_application_submitter'),
  pg_relation_filenode('index_application_reviewer'),
  pg_relation_filenode('application')
);
