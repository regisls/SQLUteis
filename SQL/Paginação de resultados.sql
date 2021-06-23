/*
Consulta SQL para fazer pagina��o dos resultados
*/

declare @pageIndex smallint = 2
declare @pageSize smallint = 10

select *
from tag
order by tagid
offset((@pageIndex-1)*@pageSize) rows
fetch next @pageSize rows only;