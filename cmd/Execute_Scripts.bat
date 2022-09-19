for /l %i in (1, 1, 318) do sqlcmd -S localhost\sqlexpress -d DB_NAME -E -i SQL_SCRIPT-%i.sql
