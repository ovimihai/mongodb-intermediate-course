Sources
https://github.com/JaimeRC/mongodb-university-courses


## Mongod

- memory is important: agg, index traversing, write ops, query engine (retrival), connections (1MB)
- cpu important: storage engine, concurrency model
    - eg: update same doc can't be done in paralel
- operations that require CPU: page compression, data calculation, agg, map reduce
- storage
    - iops are important
    - write on different disks can increase perf
    - raid10
- network - switches, lb, firewall, distance, latency, badwith

### Indexes
- Collection scan - O(N)
- Indexes: B-tree to reference docs (photo)
- overhead
    - decrease write speed
    - rebalance after update or remove
- dbpath
    - can be split in multiple folders - mount to different disks
    - compression - less IO
- data is written on disk
    - write concern (eg: w:3)
    - checkpoint

### Journalling
- jurnal of operations (j:true) flushed with group commits in compressed format
    - ensure consistency
    - atomic, idempotent



Concepts:
- changestreams - https://github.com/LinkedInLearning/advanced-mongodb-2476236/blob/main/change-streams/change_stream.py
- clustered collections - https://www.mongodb.com/docs/manual/core/clustered-collections/
- gridfs
- views and materialized views
- timeseries

## PMM details
https://www.youtube.com/watch?v=qar99Ky2UQw

Cluster summary
- shards, chunks details
- amout and size of collections in shards
- QPS per service: config/mongos; per shard
- chunks in shards - yes/no
- number of chunks in each shard
- amout and size of indexes in shards
- per shard: connections, cursors, operations

ReplSet Summary
- node status
- repl lag
elections
- oplog window
...

Instance Summary
- op/sec
- queued operations
- connections
- average latency

Instances Overview
- top5
- Instances compare

By engine 
- inMemory
- MMAPv1 - old engine
    - global lock
    - page faults
    jurnal activity
- wiredTiger
    - cache stats
    - eviction
    - queing - if exists - flow controll issue
    - concurrency tickets (should not go to 0)

Query Analytics
- profiler needs to be enabled
- eg: rec-ro - query, average seems to be to high

Collection level stats in PMM with `--enable-all-collectors`
- default max 200 collections
- size
- compression ratio, average object size, extents (allocate to next 2 power)
- collStats
    - document count
    - average object size
    - number of indexes
    - storage size

https://infra-pmm2-all-prod.emag.network/graph/d/pmm-qan/pmm-query-analytics?var-database=rec_ro&var-environment=All&var-cluster=All&var-replication_set=All&var-schema=All&var-node_name=All&var-service_name=All&var-client_host=All&var-username=All&var-service_type=All&var-node_type=All&var-city=All&var-az=All&var-interval=auto&columns=%5B%22load%22,%22num_queries%22,%22query_time%22%5D&group_by=queryid&selected_query_database=rec_ro&filter_by=0be107cfe566ace99a65c1fcdd2ec1f9&order_by=-load&from=now-12h&to=now&totals=false&query_selected&details_tab=examples


## WiredTiger

--storageEngine wiredTiger
--wiredTigerCacheSizeGB 8
--wiredTigerDirectoryForIndexes /data/indexes
--wiredTigerCollectionBlockCompressor zlib
--dbpath /data/datafiles

compression
- snappy - average compression, med cpu
- zlib - more compressed. more cpu used

wiredTigerEngineConfigString
- cache_size, eviction, chceckpoint
- block_compressor=zlib
- type=lsm  - different than btree, better for inserts

db.createCollection("test2", {storageEngine: {wiredTiger:{configString: "type=lsm,block_compressor=zlib"}}});
https://www.mongodb.com/docs/manual/reference/method/db.createCollection/
https://source.wiredtiger.com/mongodb-3.4/struct_w_t___s_e_s_s_i_o_n.html

WiredTiget ideas (wti) - https://www.youtube.com/watch?v=SMjSjcAePLI 

LSM tree explained - high write rate
https://www.youtube.com/watch?v=I6jB0nM9SKU
-- Memtables -> SSTables (level0) -> merge+compaction (level1) -> merge+compaction(level2)
- tiering compaction - write optimized (Cassandra)
- leveling - read-optimized (RocksDB)

LSM optimizations
- summary tables - min/max of each disk block of every level
- for keys that don't exist 
    - bloom filter for each level - space efficent data structure that returns a firm NO if the key doesn't exist or probably yes if it might exist

DB optimizations (wti - 29:00)
- workingset fit in ram -> cache_size = 80%
- fit the working set to OS Disk Cache -> os disk cache = 90% & cache_size = 10%
    - this will use more cpu for decompressing
- SSD disk + compression - snappy impact is very small
- SSD disk + no compression

compression benchmarks (old, 2015 with photos, mongo3)
https://www.mongodb.com/blog/post/new-compression-options-mongodb-30



