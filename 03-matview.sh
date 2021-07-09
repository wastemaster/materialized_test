# insert data
docker run -i --rm --link clickhouse_ellx:clickhouse-server \
            yandex/clickhouse-client \
            --host clickhouse-server \
            --query "
CREATE MATERIALIZED VIEW mat_test.download_daily_mv
ENGINE = SummingMergeTree
PARTITION BY toYYYYMM(day) ORDER BY (userid, day)
POPULATE
AS SELECT
  toStartOfDay(when) AS day,
  userid,
  count() as downloads,
  sum(bytes) AS bytes
FROM mat_test.download
GROUP BY userid, day"
