# drop database
docker run -i --rm --link clickhouse_ellx:clickhouse-server \
             yandex/clickhouse-client \
             --host clickhouse-server \
             --query "DROP DATABASE IF EXISTS mat_test"

# create database
docker run -i --rm --link clickhouse_ellx:clickhouse-server \
             yandex/clickhouse-client \
             --host clickhouse-server \
             --query "CREATE DATABASE mat_test"



# drop table
docker run -i --rm --link clickhouse_ellx:clickhouse-server \
           yandex/clickhouse-client \
           --host clickhouse-server \
           --query "DROP TABLE if EXISTS mat_test.download"

# create table
docker run -i --rm --link clickhouse_ellx:clickhouse-server \
            yandex/clickhouse-client \
            --host clickhouse-server \
            --query "
CREATE TABLE mat_test.download (
  when DateTime,
  userid UInt32,
  bytes Float32
) ENGINE=MergeTree
PARTITION BY toYYYYMM(when)
ORDER BY (userid, when)"

# insert data
docker run -i --rm --link clickhouse_ellx:clickhouse-server \
            yandex/clickhouse-client \
            --host clickhouse-server \
            --query "
INSERT INTO mat_test.download
  SELECT
    now() + number * 60 as when,
    25,
    rand() % 100000000
  FROM system.numbers
  LIMIT 5000"
