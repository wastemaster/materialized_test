# delete some data
docker run -i --rm --link clickhouse_ellx:clickhouse-server \
            yandex/clickhouse-client \
            --host clickhouse-server \
            --query "
ALTER TABLE mat_test.download DELETE WHERE userid = 22"
