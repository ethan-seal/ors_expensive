#!/bin/sh

DATABASE_URL="postgresql://ethans:Danksvand98*@localhost:5432/postgres"

psql $DATABASE_URL -f setup.sql &> /dev/null

pagefile=$(
        psql $DATABASE_URL -t \
        -c "SELECT current_setting('data_directory') || '/' || pg_relation_filepath('application');" \
        | tr -d '[:space:]'
)

echo "Evicting OS cache"
sudo dd oflag=nocache conv=notrunc,fdatasync count=0 of="$pagefile" &> /dev/null

echo "Evicting Postgres shared cache"
psql $DATABASE_URL -f evict.sql &> /dev/null

echo "Running ors"
psql $DATABASE_URL -c '\timing' -f or_benchmark.sql

echo "Running ors"
psql $DATABASE_URL -c '\timing' -f or_benchmark.sql

echo "Evicting OS cache"
sudo dd oflag=nocache conv=notrunc,fdatasync count=0 of="$pagefile" &> /dev/null

echo "Evicting Postgres shared cache"
psql $DATABASE_URL -f evict.sql &> /dev/null

echo "Running ands"
psql $DATABASE_URL -c '\timing' -f and_benchmark.sql
echo "Running ands"
psql $DATABASE_URL -c '\timing' -f and_benchmark.sql
