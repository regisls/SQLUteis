declare @databaseName nvarchar(128) = null

declare @objectName nvarchar(max)
declare @tableName nvarchar(max) --= N'dbo.HistoricoManutencao'
declare @tableSchema nvarchar(128)

declare @result table (
	index_id int,
	IndexName sysname,
	object_id int,
	TableName nvarchar(128),
	avg_fragmentation_in_percent float,
	Comando varchar(500)
)

if (@databaseName is null)
begin
	raiserror('Variable @databaseName is required', 16, 1);
	return
end

declare curIndices cursor fast_forward for
	select TABLE_SCHEMA, TABLE_NAME from INFORMATION_SCHEMA.TABLES

open curIndices

fetch next from curIndices
into @tableSchema, @tableName

while @@FETCH_STATUS = 0
begin
	select @objectName = '[' + @tableSchema + '].[' + @tableName + ']'
	
	insert into @result
	SELECT
		 a.index_id
		,name AS IndedxName
		,a.object_id
		,object_name(a.object_id) AS TableName
		,avg_fragmentation_in_percent
		,case when avg_fragmentation_in_percent > 5 and avg_fragmentation_in_percent <= 30 then 
			'ALTER INDEX ' + name + ' ON ' + object_name(a.object_id) + ' REORGANIZE;'
		 else
			case when avg_fragmentation_in_percent > 30 then
				'ALTER INDEX ' + name + ' ON ' + object_name(a.object_id) + ' REBUILD;'
			else
				''
			end
		 end as Comando
	FROM sys.dm_db_index_physical_stats
		(DB_ID (@databaseName)
			, OBJECT_ID(@objectName)
			, NULL
			, NULL
			, NULL) AS a
	INNER JOIN sys.indexes AS b
		ON a.object_id = b.object_id
		AND a.index_id = b.index_id;

	fetch next from curIndices
	into @tableSchema, @tableName
end

close curIndices
deallocate curIndices

select * from @result where Comando <> ''
