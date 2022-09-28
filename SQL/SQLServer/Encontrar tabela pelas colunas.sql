/*
Encontrar uma tabela que tenha N colunas em comum pelo nome das colunas
*/

select *
from information_schema.COLUMNS c
where c.COLUMN_NAME = 'COLUMN_NAME_1'
  and exists (select 1 from INFORMATION_SCHEMA.COLUMNS c2 where c2.COLUMN_NAME = 'COLUMN_NAME_2' and c2.TABLE_NAME = c.TABLE_NAME)
  and exists (select 1 from INFORMATION_SCHEMA.COLUMNS c3 where c3.COLUMN_NAME = 'COLUMN_NAME_3' and c3.TABLE_NAME = c.TABLE_NAME)
