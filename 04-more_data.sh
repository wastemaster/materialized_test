# insert data
docker run -i --rm --link clickhouse_ellx:clickhouse-server \
            yandex/clickhouse-client \
            --host clickhouse-server \
            --query "
INSERT INTO mat_test.download
  SELECT
    now() + number * 60 as when,
    22,
    rand() % 100000000
  FROM system.numbers
  LIMIT 5000"
