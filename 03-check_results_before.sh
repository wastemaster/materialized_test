# raw query
echo "===== Aggregated using raw query"
docker run -i --rm --link clickhouse_ellx:clickhouse-server \
            yandex/clickhouse-client \
            --host clickhouse-server \
            --query "
SELECT
  toStartOfDay(when) AS day,
  userid,
  count() as downloads,
  sum(bytes) AS bytes
FROM mat_test.download
GROUP BY userid, day
ORDER BY userid asc, downloads desc, bytes desc"

# materialized query
echo "===== Aggregated using materialized view"
docker run -i --rm --link clickhouse_ellx:clickhouse-server \
            yandex/clickhouse-client \
            --host clickhouse-server \
            --query "
SELECT *
FROM mat_test.download_daily_mv ddm
ORDER BY
	userid ASC,
	downloads DESC,
	bytes DESC"
