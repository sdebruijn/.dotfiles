#!/usr/bin/env zsh

# Place for custom scripts
function dumpeos() {
  echo 'Start database dump eos';

  pg_dump \
    --no-owner \
    --no-acl \
    --column-inserts \
    --data-only \
    --exclude-table='*_id_seq' \
    --exclude-table-data='*_id_seq' \
    --exclude-table=migrations \
    --exclude-table=api_clients \
    --exclude-table=failed_jobs \
    --exclude-table=ledgers \
    --exclude-table=msg_directions \
    "service=eos" \
     > eos-db-$(date +%Y-%m-%d-%H%M).sql  

    echo "Saved dump to eos-db-$(date +%Y-%m-%d-%H%M).sql";
}
