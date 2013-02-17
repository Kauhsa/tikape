dropdb kirjasto
createdb kirjasto
psql -d kirjasto -a -f create_tables.sql
psql -d kirjasto -a -f initial_data.sql
