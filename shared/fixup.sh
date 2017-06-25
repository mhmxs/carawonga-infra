sed -i 's/carawonga.com/readynas:9999/g' /docker-entrypoint-initdb.d/b_dump.sql
sed -i '1 s/^.*$/USE carawonga;/' /docker-entrypoint-initdb.d/b_dump.sql