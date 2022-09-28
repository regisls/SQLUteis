select
  table_name, 
  column_name, 
  data_type, 
  data_length,
  data_precision,
  data_scale,
  nullable
from user_tab_columns
where table_name = 'TABLE_NAME'
and column_name IN('COLUMN_NAME_1', 'COLUMN_NAME_2', 'COLUMN_NAME_3');
